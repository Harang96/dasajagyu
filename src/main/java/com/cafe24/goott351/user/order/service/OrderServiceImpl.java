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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.domain.OrderProductDTO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.OrderDTO;
import com.cafe24.goott351.domain.OrderInfoDTO;
import com.cafe24.goott351.domain.DeliveryVO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingDTO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.user.order.persistence.OrderDAO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	private OrderDAO oDao;

	/**
	 * @Method : getOrderInfo
	 * @PackageName : com.cafe24.goott351.user.order.service
	 * @Description : 주문하려는 상품과 주문자의 배송지 리스트를 가져온다
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.02.28 Hayeong Noh
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public OrderInfoDTO getOrderInfo(List<OrderProductDTO> cartList) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
//		List<ProductVO> productList = new ArrayList<ProductVO>();
		List<OrderProductDTO> opList = new ArrayList<OrderProductDTO>();

		int amount = 0;
		int discount = 0;

		for (OrderProductDTO cart : cartList) {
			int productNo = cart.getProductNo();
			int qty = cart.getQty();
			ProductVO product = oDao.selectProductInfo(productNo);

			cart.setSalesCost(product.getSalesCost());
			cart.setDiscountCost((int) (product.getDiscountRate() * 0.01 * product.getSalesCost()));
			cart.setOrderPrice();
			cart.setOriginalName(product.getOriginalName());
			cart.setThumbImg(product.getThumbnailImg());
			cart.setProductName(product.getProductName());
			cart.setCurrentQty(product.getCurrentQty());

//			productList.add(product);
			opList.add(cart);

			System.out.println(cart.toString());

			amount += cart.getSalesCost() * qty;
			discount += cart.getDiscountCost() * qty;
		}
		
//		resultMap.put("productList", productList);
		resultMap.put("orderProductList", opList);
		resultMap.put("orderBill", new OrderBillingDTO(amount, discount));

		return new OrderInfoDTO(opList, new OrderBillingDTO(amount, discount), null, null, null);
	}

	@Override
	public List<DeliveryVO> getDeliveryList(String uuid) throws Exception {
		List<DeliveryVO> deliveryList = oDao.selectDeliveryList(uuid);
		System.out.println(deliveryList.toString());
		return deliveryList;
	}

	@Override
	public DeliveryVO getDefaultDelivery(String uuid) throws Exception {
		DeliveryVO delivery = oDao.selectDefaultDelivery(uuid);
		System.out.println(delivery.toString());
		return delivery;
	}

	// 결제 승인

	/**
	 * @Method : confirmPayment
	 * @PackageName : com.cafe24.goott351.user.order.service
	 * @Description : 결제 요청이 성공됐을 때 호출되는 결제 승인 메소드
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.02.27 Hayeong Noh
	 */
	@Override
	public Map<String, Object> confirmPayment(OrderDTO orderConfirm) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		JSONParser parser = new JSONParser();

		JSONObject obj = new JSONObject();
		obj.put("orderId", orderConfirm.getOrderId());
		obj.put("amount", orderConfirm.getAmount());
		obj.put("paymentKey", orderConfirm.getPaymentKey());

		String widgetSecretKey = "test_sk_Wd46qopOB896vjREWvK3ZmM75y0v";

		Base64.Encoder encoder = Base64.getEncoder();
		byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes("UTF-8"));
		String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);

		URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("Authorization", authorizations);
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setRequestMethod("POST");
		connection.setDoOutput(true);

		OutputStream outputStream = connection.getOutputStream();
		outputStream.write(obj.toString().getBytes("UTF-8"));

		int code = connection.getResponseCode();
		boolean isSuccess = code == 200 ? true : false;

		InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

		// TODO: 결제 성공 및 실패 비즈니스 로직을 구현하세요.
		Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);

		JSONObject payment = (JSONObject) parser.parse(reader);
		System.out.println(payment.toJSONString());
		System.out.println("메서드 테스트~~~~~~~~~!!!!!!!!!!!"+payment.get("method"));

		responseStream.close();

		ObjectMapper objectMapper = new ObjectMapper();
		OrderDTO order = objectMapper.readValue(payment.toJSONString(), OrderDTO.class);
		
		order.setNumber(getPaymentNumber(payment, payment.get("method"))); 
		if(payment.get("method").equals("간편결제")) {
			order.setMethod((String)((JSONObject)payment.get("easyPay")).get("provider"));
		}

		resultMap.put("code", code);
		resultMap.put("order", order);

		return resultMap;
	}

	public String getPaymentNumber(JSONObject payment, Object method) {
		String result = null;
		
		if(method.equals("카드")) {
			result = (String)((JSONObject) payment.get("card")).get("number");
		} else if(method.equals("간편결제")) {
			if(payment.get("card")!=null) {
				result = (String)((JSONObject) payment.get("card")).get("number");				
			}
		} else if(method.equals("도서문화상품권")) {
			result = (String)((JSONObject) payment.get("giftCertificate")).get("approveNo");
		}
		
		if(result != null) {
			result = result.substring(result.length() - 4);
		}
    
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean placeOrder(OrderInfoDTO orderInfo) throws Exception {
		OrderDTO order = orderInfo.getOrder();
		List<OrderProductDTO> productList = orderInfo.getProducts();
		OrderBillingDTO bill = orderInfo.getBill();
		OrderShippingDTO shipping = orderInfo.getShipping();
		if (order.getStatus().equals("WAITING_FOR_DEPOSIT")) {
			order.setOrderStatus("입금대기");
			order.setStatus("입금대기");
		} else if (order.getStatus().equals("DONE")) {
			order.setOrderStatus("결제완료");
			order.setStatus("결제완료");
		}
		shipping.setOrderId(order.getOrderId());
		bill.setOrderId(order.getOrderId());

		if(oDao.insertOrder(order)==1) {
			if(oDao.insertOrderBilling(bill)==1) {
				if(oDao.insertShipping(shipping)==1) {
					int productResult = 0;
					int qtyResult = 0;
					for (OrderProductDTO product : productList) {
						product.setOrderId(order.getOrderId());
						productResult += oDao.insertOrderProduct(product);
						qtyResult += oDao.updateProductQty(product.getProductNo(), product.getQty());
					}
					if(productResult == productList.size() && qtyResult == productList.size()) {
						if(order.getUuid() != null) { // 회원 주문
							int point = bill.getOrderPoint() - bill.getPointDiscount(); // 적립 포인트 - 사용 포인트
							if(order.getMethod().equals("가상계좌")) {
								point = (-1) * bill.getPointDiscount();
							}
							
							if(oDao.updateCustomersPoint(order.getUuid(), point)==1) { // 회원 포인트 업데이
								if(order.getMethod().equals("가상계좌")) { // 가상계좌 결제 시 포인트 사용 로그만 업데이트
									if(bill.getPointDiscount()!=0) {
										if(oDao.insertPontLog("결제 시 사용", order.getUuid(), (-1)*bill.getPointDiscount())==1) {
											System.out.println("(회원주문) 트랜잭션 끝");
											return true;
										} else { // 결제시 실패
											System.out.println("사용 포인트 로그 추가 실패");
											return false;
										}
									} else { // 사용 포인트 == 0 : 로그 추가 x 트랜잭션 끝
										System.out.println("(회원주문) 트랜잭션 끝");
										return true;
									}
								} else {
									int temp = 0;
									if(bill.getOrderPoint()==0) {
										temp = 1;
									} else {
										temp = oDao.insertPontLog("구매적립", order.getUuid(), bill.getOrderPoint());
									}
									if(temp == 1) {
										if(bill.getPointDiscount()!=0) {
											if(oDao.insertPontLog("결제 시 사용", order.getUuid(), (-1)*bill.getPointDiscount())==1) {
												System.out.println("(회원주문) 트랜잭션 끝");
												return true;
											} else { // 결제시 실패
												System.out.println("사용 포인트 로그 추가 실패");
												return false;
											}
										} else { // 사용 포인트 == 0 : 로그 추가 x 트랜잭션 끝
											System.out.println("(회원주문) 트랜잭션 끝");
											return true;
										}
									} else { // 구매적립 로그 실패
										System.out.println("구매적립 로그 추가 실패");
										return false;
									}
								}
							} else {
								System.out.println("회원 포인트 업데이트 실패");
								return false;
							}
						} else { // 비회원 주문 (트랜잭션 끝)
							System.out.println("(비회원주문) 트랜잭션 끝");
							return true;
						}
					} else { // orderProducts or qty 실패
						System.out.println("주문 상품 추가 / 상품재고 업데이트 실패");
						return false;						
					}
				} else { // shipping 실패
					System.out.println("배송지 실패");
					return false;
				}
			} else { // billing 실패
				System.out.println("주문서 추가 실패");
				return false;				
			}
		} else { // order 실패
			System.out.println("주문 추가 실패");
			return false;
		}
	}

	@Override
	public void removeCartItems(String uuid, String sessionId, List<OrderProductDTO> productList) {
		
		for(OrderProductDTO product : productList) {
			int cartNo = 0 ;
			if(uuid != null) {
				cartNo = oDao.hasCartProductByUUID(uuid, product.getProductNo());
			} else {
				cartNo = oDao.hasCartProductBySessionId(sessionId, product.getProductNo());
			}
			
			if(cartNo != 0){
				oDao.deleteCartProduct(cartNo);
			}
		}
	}
	
	@Override
	public Map<String, Object> compareProductQty(List<OrderProductDTO> productList) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result = true;
		List<Integer> qtyErrorList = null;
		
		for(OrderProductDTO product : productList) {
			if(oDao.getProductCurrentQty(product.getProductNo())<product.getQty()) {
				if(qtyErrorList == null) {
					qtyErrorList = new ArrayList<Integer>();
					qtyErrorList.add(product.getProductNo());					
				} else {
					qtyErrorList.add(product.getProductNo());										
				}
				result = false;
			} 
		}
		map.put("result", result);
		map.put("qtyError", qtyErrorList);
		return map;
	}
	
	@Override
	public void changeCartQty(String uuid, String sessionId, List<Integer> productNoList, int qty) {
		for(int productNo : productNoList) {
			int cartNo = 0 ;
			if(uuid != null) {
				cartNo = oDao.hasCartProductByUUID(uuid, productNo);
			} else {
				cartNo = oDao.hasCartProductBySessionId(sessionId, productNo);
			}
			
			if(cartNo != 0) {
				oDao.updateCartQty(cartNo, qty);
			}
			
		}	
	}
	
	@Override
	public LoginCustomerVO getOrderCustomer(String uuid) {
		return oDao.selectOrderCustomer(uuid);
	}
	
	@Override
	public Map<String, Integer> getOrderSummary() throws Exception{
		
		Map<String, Integer> map = new HashMap<>();
		map.put("pending", oDao.selectCountByOrderStatus("입금대기"));
		map.put("completed", oDao.selectCountByOrderStatus("결제완료"));
		map.put("confirmed", oDao.selectCountByOrderStatus("구매확정"));
		map.put("refund", oDao.selectCountByOrderStatus("주문취소"));
		System.out.println(map);
		return map;
		
	}
	
	

}