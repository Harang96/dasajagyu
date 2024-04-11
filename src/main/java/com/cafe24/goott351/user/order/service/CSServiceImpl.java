package com.cafe24.goott351.user.order.service;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Base64.Encoder;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.admin.order.persistence.OrderAdminDAO;
import com.cafe24.goott351.domain.Base64ImgDTO;
import com.cafe24.goott351.domain.CancelProductDTO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.domain.CancelUtilDTO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.PaymentVO;
import com.cafe24.goott351.domain.ProductReviewDTO;
import com.cafe24.goott351.user.order.persistence.CSDAO;
import com.cafe24.goott351.util.Failure;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class CSServiceImpl implements CSService {

	@Inject
	private CSDAO csDao;
	
	@Inject
	private OrderAdminDAO oaDao;
	
	private String secretKey = "test_sk_Wd46qopOB896vjREWvK3ZmM75y0v:";
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean applyCS(String orderNo, String CSType, List<CancelProductDTO> products, String reasonType, String reason,
			List<MultipartFile> uploadFile) throws Exception {
		int result = 0;
		if(reasonType.equals("simple")) {
			reasonType = "단순변심/주문실수";
		} else if(reasonType.equals("damage")) {
			reasonType = "상품파손/오배송";
		}
		for(CancelProductDTO product : products) {
			result += csDao.insertOrderCS(orderNo, CSType, product.getNo(), product.getQuantity(), reasonType, reason, "N");
		}
		if(result == products.size()) {
			if(uploadImages(uploadFile, orderNo)) {			
				return true;
			}
		}
		return false;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean cancelOrder(String orderNo, List<OrderProductVO> productList) throws Exception {
		int result = 0;
		boolean payResult = false;
		String paymentKey = oaDao.selectPaymentkey(orderNo);
		
		if(oaDao.updateOrderStatus(orderNo, "주문취소")==1) {
			for(OrderProductVO product : productList) {
				result += oaDao.updateOrderCancel(orderNo, product.getProductNo());				
			}
		}
		
		if(paymentKey==null) { // 결제금액 0일때
			// 결제 포인트 반환
			payResult = true;
			
		}else { 
			if(cancelPaymentAPI(paymentKey)) {	
				 payResult = true;
			}
		}
		
		if(result == productList.size() && payResult) {
			return true;
		}else {
			return false;
		}
	}


	@Override
	public boolean uploadImages(List<MultipartFile> uploadFile, String orderNo) throws Exception{
		if(uploadFile!=null || (uploadFile.get(0).getOriginalFilename()).equals("")) {
			List<Base64ImgDTO> list = fileToBase64(uploadFile, orderNo);
			if(list.size()>0) {
				if(csDao.insertCSImages(list)==list.size()) {
					return true;
				} else {
					return false;
				}
			} else {
				System.out.println("업로드할 이미지가 없음");
				return true;
			}
		} else {
			return true;
		}
		
	}
	
	private boolean cancelPaymentAPI(String paymentKey) throws Exception {
		JSONObject obj = new JSONObject();
		
		Encoder encoder = Base64.getEncoder();
		byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
		String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);

		URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
		
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("Authorization", authorizations);
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setRequestMethod("POST");
		connection.setDoOutput(true);
		
		obj.put("cancelReason", "주문취소");

		OutputStream outputStream = connection.getOutputStream();

		outputStream.write(obj.toString().getBytes("UTF-8"));

		int code = connection.getResponseCode();
		boolean isSuccess = code == 200 ? true : false;

		InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

		Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser.parse(reader);
		ObjectMapper objectMapper = new ObjectMapper();
		PaymentVO payment = objectMapper.readValue(jsonObject.toJSONString(), PaymentVO.class);

		if (code > 200)
			payment.setFail(objectMapper.readValue(jsonObject.toJSONString(), Failure.class));

		System.out.println("api result jsonObject : " + payment.toString());

		responseStream.close();
		
		if(code==200) {
			return true;
		} else {
			return false;
		}
	}
	
	
	private List<Base64ImgDTO> fileToBase64(List<MultipartFile> uploadFile, String orderNo) throws Exception{
		List<Base64ImgDTO> list = new ArrayList<Base64ImgDTO>();
		for(MultipartFile file : uploadFile) {
			if(file.getSize()!=0) {
				Base64ImgDTO img = new Base64ImgDTO();
				String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
				img.setOrderNo(orderNo);
				img.setBase64("data:image/"+ext+";base64,"+Base64.getEncoder().encodeToString(file.getBytes()));
				img.setImgSize(file.getSize());
				list.add(img);
			}
		}
		System.out.println(list);
		return list;
	}

	@Override
	public boolean validationCancelOrder(String orderNo, String uuid) {
		String orderUUID = csDao.selectOrderUUID(orderNo);
		System.out.println("주문자 검사 : "+ orderUUID);
		if(uuid.equals(orderUUID)) {
			return true;
		} else {
			return false;
		}
	}
	
}
