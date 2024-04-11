/**
 * 
 */
package com.cafe24.goott351.admin.order.service;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Base64.Encoder;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.admin.order.persistence.OrderAdminDAO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.domain.OrderCsDTO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.CancelUtilDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.PaymentVO;
import com.cafe24.goott351.domain.RefundReceiveAccountDTO;
import com.cafe24.goott351.domain.RegisterPointLog;
import com.cafe24.goott351.util.Failure;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author : su hyeok kim
 * @date : 2024. 3. 26.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 3. 26.
 */
@Service
public class OrderCancelServiceImpl implements OrderCancelService {
	
	private String secretKey = "test_sk_Wd46qopOB896vjREWvK3ZmM75y0v:";
	
	@Inject
	private AdminOrderService aos;
	
	@Inject
	private OrderAdminDAO dao; 
	

	/**
	 * @Method : updateOrders
	 * @PackageName : com.cafe24.goott351.admin.order.service
	 * @Description : 
	 * ===========================================================
	 * DATE	 		AUTHOR 			Memo
	 * -----------------------------------------------------------
	 * 2024.03.26 	su hyeok kim
	 */
	@Override
	public Map<String, String> cancelOrders(OrderCsDTO orderCs, RefundReceiveAccountDTO account) throws Exception {
		boolean isSuccess = false;
		Map<String, String> resultMap = new HashMap<>();
		
		// 주문번호로 주문한 사용자 정보 가져오기
		LoginCustomerVO customer = dao.selectCustomerInfo(orderCs.getOrderNo());
		
		// orderNo로 orderBillingVO 가져오기 
		OrderBillingVO orderBillingVO = dao.selectOrderBilling(orderCs.getOrderNo());
		
		String paymentKey = dao.selectPaymentkey(orderCs.getOrderNo());
		
		if(paymentKey != null) {
			// 취소 api 호출
			PaymentVO payment = callCancelPaymentAPI(orderCs, account, paymentKey, orderBillingVO.getOrderCost());

			System.out.println("api result jsonObject : " + payment.toString());
			
			if(payment.getFail() == null) { // 취소객체가 null 일 경우 성공
				isSuccess = true;
				
			} else { // 취소객체가 null 이 아닌 경우 실패
				isSuccess = false;
				resultMap.put("code", payment.getFail().getCode());
				resultMap.put("message", payment.getFail().getMessage());
			}
			
		} else { // 포인트로 결제해서 api를 거치지않은 경우(포인트로 결제한 경우)
			isSuccess = true;
		}
		
		resultMap.put("type", "cancel");
		
		if (isSuccess) {
			
			if(dao.updateOrderStatus(orderCs.getOrderNo(), "주문취소")==1) {
				if(dao.updateCanceledOrderBilling(orderCs.getOrderNo())==1) {
					List<OrderProductVO> productList = dao.selectOrderProductList(orderCs.getOrderNo());
					if(productList != null) {
						int temp = 0;
						for(OrderProductVO product : productList) {
							// orderCancel = "Y" 로 변경하기
							temp += dao.updateOrderCancel(orderCs.getOrderNo(), product.getProductNo());
							
							orderCs.setProductNo(product.getProductNo());
							orderCs.setProductQuantity(product.getQuantity());
							orderCs.setCsProcessed("Y");
							
							dao.insertCs(orderCs);
						}					
						if(temp==productList.size()) {
							// 적립포인트 환수 및 사용 포인트 환급
							if(customer != null) {
								if(dao.updateCustomerOfOrderBilling(orderBillingVO) == 1) {
									if(orderBillingVO.getPointDiscount() > 0) dao.insertPointLog(new RegisterPointLog("주문시 사용포인트 환불", customer.getUuid(), orderBillingVO.getPointDiscount()));					
									if(orderBillingVO.getOrderPoint() > 0) dao.insertPointLog(new RegisterPointLog("주문시 적립포인트 환수", customer.getUuid(), orderBillingVO.getOrderPoint() * -1));
									
								resultMap.put("result", "success");
								} else {
									resultMap.put("result", "fail");
								}
							} else {
								resultMap.put("result", "fail");
							}
						}
					}					
				}
			}
		}
		
		return resultMap;
	}
	
	/**
	 * @Method : updateOrders
	 * @PackageName : com.cafe24.goott351.admin.order.service
	 * @Description : 취소 api 호출
	 * ===========================================================
	 * DATE	 		AUTHOR 			Memo
	 * -----------------------------------------------------------
	 * 2024.03.26 	su hyeok kim
	 */
	@Transactional(rollbackFor = Exception.class)
	public PaymentVO callCancelPaymentAPI(OrderCsDTO orderCs, RefundReceiveAccountDTO account, String paymentKey, int orderCost) throws Exception {
		Encoder encoder = Base64.getEncoder();
		byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
		String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);

		URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");

		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("Authorization", authorizations);
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setRequestMethod("POST");
		connection.setDoOutput(true);

		JSONObject obj = new JSONObject();
		
		obj.put("cancelReason", orderCs.getReason());
		obj.put("cancelAmount", orderCost + "");

		if(account != null) {
			JSONObject refundReceiveAccount = new JSONObject();
			
			refundReceiveAccount.put("bank", account.getBank().replaceAll("은행", "").replaceAll("뱅크", ""));
			refundReceiveAccount.put("accountNumber", account.getAccountNumber().replaceAll("-", ""));
			refundReceiveAccount.put("holderName", account.getHolderName());
			
			obj.put("refundReceiveAccount", refundReceiveAccount);
		}

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

		responseStream.close();

		return payment;
	}

}
