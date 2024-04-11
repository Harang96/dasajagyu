package com.cafe24.goott351.user.order.controller;

import java.nio.charset.Charset;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.cafe24.goott351.domain.OrderProductDTO;
import com.cafe24.goott351.domain.OrderInfoDTO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.DeliveryVO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingDTO;
import com.cafe24.goott351.domain.OrderDTO;
import com.cafe24.goott351.domain.OrderProductDTO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.user.order.service.CartService;
import com.cafe24.goott351.user.order.service.OrderService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/order*")
public class OrderController {

	@Inject
	private OrderService oService;

	@Inject
	private CartService cService;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping("")
	public String doOrder(HttpSession session, Model model, @RequestParam String products, RedirectAttributes rttr)
			throws Exception {
		String orderId = System.currentTimeMillis() + "";
		System.out.println("orderId ::::: " + orderId);
		ObjectMapper objectMapper = new ObjectMapper();
		List<OrderProductDTO> cartList = objectMapper.readValue(products, new TypeReference<List<OrderProductDTO>>() {
		});
		System.out.println(cartList.toString());

		LoginCustomerVO customer = (LoginCustomerVO) (session.getAttribute("loginCustomer"));
		System.out.println(customer);
		DeliveryVO delivery = null;

		model.addAttribute("orderId", orderId);
		OrderInfoDTO orderInfo = oService.getOrderInfo(cartList);

		if (customer != null) { // 회원 주문
//			   List<DeliveryVO> deliveryList = oService.getDeliveryList(customer.getUuid());
			delivery = oService.getDefaultDelivery(customer.getUuid());
			model.addAttribute("delivery", delivery);
			session.setAttribute("loginCustomer", oService.getOrderCustomer(customer.getUuid()));
		} else { // 비회원 주문
			orderInfo.setSessionId(cartList.get(0).getSessionId());
		}

		session.setAttribute("order_" + orderId, orderInfo);

//		   model.addAttribute("productList", (List<OrderProductDTO>) map.get("orderProductList"));
//		   model.addAttribute("productListJson", objectMapper.writeValueAsString((List<OrderProductDTO>) map.get("orderProductList")));
//		   model.addAttribute("orderBillJson", objectMapper.writeValueAsString((OrderBillingDTO) map.get("orderBill")));
//		   model.addAttribute("orderBill", (OrderBillingDTO) map.get("orderBill"));
		return "order/checkout";
	}

//	   @RequestMapping("/checkout")
//	   public void openOrder() {
//		   System.out.println("order/checkout 컨트롤러 왓다요");
//	   }

	@RequestMapping(value = "/request", method = RequestMethod.POST)
	public ResponseEntity<String> requestPayment(@RequestBody OrderShippingDTO shipping, HttpSession session)
			throws Exception {
		if (!shipping.getReciever().isEmpty() && !shipping.getAddress().isEmpty() && !shipping.getPhone().isEmpty()
				&& !shipping.getZipCode().isEmpty()) {
			OrderInfoDTO orderInfo = (OrderInfoDTO) session.getAttribute("order_" + shipping.getOrderId());
			orderInfo.setShipping(shipping);
			int orderCost = orderInfo.getBill().getOrderCost();

			session.setAttribute("order_" + shipping.getOrderId(), orderInfo);

			return ResponseEntity.ok().body(orderCost+ "");				
			
		} else {
			return ResponseEntity.badRequest().body("shippingNull");
		}
	}

	@RequestMapping(value = "/confirm", method = RequestMethod.POST)
	public ResponseEntity<Object> confirmPayment(@RequestBody OrderDTO reqOrder, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("결제 승인하러옴");
		OrderInfoDTO orderInfo = (OrderInfoDTO) session.getAttribute("order_" + reqOrder.getOrderId());
		System.out.println(orderInfo);
		String uuid = null;
		int code = 0;
		if(session.getAttribute("loginCustomer")!=null) {
			uuid = ((LoginCustomerVO)session.getAttribute("loginCustomer")).getUuid();
			reqOrder.setUuid(uuid);
		}

		Map<String, Object> compareQty = oService.compareProductQty(orderInfo.getProducts());
		if ((boolean) compareQty.get("result")) {  // 승인 전 상품 재고 확인
			
			if (reqOrder.getAmount() == orderInfo.getBill().getOrderCost()) { // 요청된 결제 금액과 미리 계산해둔 금액이 일치한 지 확인
				System.out.println("금액 일치 !!");
				
				if(orderInfo.getBill().getOrderCost() == 0) { // 결제 금액 0원일 경우
					code = 200;
					orderInfo.setOrder(reqOrder);
				} else {
					Map<String, Object> map = oService.confirmPayment(reqOrder); // 결제 승인 api 호출 및 응답 받은 객체 Map으로 받기
					OrderDTO order = (OrderDTO) map.get("order");
					code = (Integer) map.get("code");
					if(uuid != null) {
						order.setUuid(uuid);						
					}
					orderInfo.setOrder(order);
				}
				
				if (code == 200) { // 결제 승인 성공 	시 
					System.out.println(orderInfo.toString());
					if (oService.placeOrder(orderInfo)) { // 주문 관련 DB 작업
						// 주문한 상품 장바구니에서 삭제
						oService.removeCartItems(uuid, orderInfo.getSessionId(), orderInfo.getProducts());
						
						// 쿠키 - 카트 수량 변경
						updateCartCntCookie(uuid, orderInfo.getSessionId(), request, response);
						
						// 주문 완료 페이지에서 사용할 orderInfo 객체 세션에 덮어쓰기
						session.setAttribute("order_"+orderInfo.getOrder().getOrderId(), orderInfo);
						if(uuid != null) {
							session.setAttribute("loginCustomer", oService.getOrderCustomer(uuid));
						}
						System.out.println("orderId : "+orderInfo.getOrder().getOrderId());
						return ResponseEntity.ok(orderInfo.getOrder().getOrderId());
					} else {
						return ResponseEntity.badRequest().body("DBError");
					}
				} else {
					return ResponseEntity.badRequest().body("ConfirmError");
				}
			} else {
				return ResponseEntity.badRequest().body("AmountError");
			}
		} else { // 재고 없을 경우 카트 수량 1로 업데이트
			oService.changeCartQty(uuid, orderInfo.getSessionId(), (List<Integer>) compareQty.get("qtyError"), 1);
			return ResponseEntity.badRequest().body("QtyError");
		}
	}

	@RequestMapping("/usePoint")
	public ResponseEntity<Object> usePoint(@RequestParam("orderId") String orderId, @RequestParam("point") int point,
			HttpSession session, Model model) {
        
		OrderInfoDTO orderInfo = (OrderInfoDTO) session.getAttribute("order_" + orderId);
		OrderBillingDTO bill = (OrderBillingDTO) orderInfo.getBill();

		HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("text", "plain", Charset.forName("UTF-8")));
        
        // 요청받은 포인트가 주문 금액보다 크지 않은지 검사
		if (point<=(bill.getProductAmount()-bill.getProductDiscount()+bill.getShippingCost()) 
				&& ((LoginCustomerVO) session.getAttribute("loginCustomer")).getUserPoint() >= point) {
			bill.setPointDiscount(point);
			orderInfo.setBill(bill);
			
			// 포인트 적용된 금액을 다시 세션에 저장
			session.setAttribute("order_" + orderId, orderInfo);
			return ResponseEntity.ok().body(bill);
		} else if(point>bill.getOrderCost()) {
			return ResponseEntity.badRequest().headers(headers).body("결제 금액");
		} else {
			return ResponseEntity.badRequest().headers(headers).body("보유 포인트");
		}
	}

	@RequestMapping(value = "/success", method = RequestMethod.GET)
	public void paymentRequest(HttpSession session, Model model, @ModelAttribute OrderDTO order) throws Exception {
		System.out.println("결제 성공");
	}
	
	@RequestMapping(value="/sendEmail", method= RequestMethod.GET)
	public ResponseEntity<String> emailAuth(@RequestParam("orderId") String orderId, @RequestParam("email") String email,
			HttpSession session) {
		
		OrderInfoDTO orderInfo = (OrderInfoDTO) session.getAttribute("order_" + orderId);
		System.out.println("전달 받은 이메일 주소 : " + email);
		
		Email sendEmail = new SimpleEmail(); 
			
		
		try {
			sendEmail.setHostName("smtp.naver.com");
			sendEmail.setSmtpPort(465);
			sendEmail.setCharset("euc-kr"); // 인코딩 설정(utf-8, euc-kr)
			sendEmail.setAuthenticator(new DefaultAuthenticator("qofhdzz@naver.com", "gustjd1!2@"));
			sendEmail.setFrom("qofhdzz@naver.com", "다사자규"); // 보내는 사람
			sendEmail.setSubject("[다사자규] ["+ orderInfo.getOrder().getOrderName() +"] 주문이 정상적으로 접수되었습니다.");
			sendEmail.setMsg("주문번호 : "+ orderInfo.getOrder().getOrderId()+"\n"
					+"결제 금액: " + orderInfo.getBill().getOrderCost()+"\n"
					+"================= 배송지 정보 =====================\n"
					+"배송 받는 분: " + orderInfo.getShipping().getReciever()+"\n"
					+"전화번호: " + orderInfo.getShipping().getPhone()+"\n"
					+"주소: " + orderInfo.getShipping().getAddress()+"\n"
					+"비회원 주문의 경우 주문번호와 배송 정보의 전화번호 입력 후 주문 조회가 가능합니다.\n"
					+"쇼핑몰 바로가기 : http://goott351.cafe24.com");
			sendEmail.setSSL(true);
			sendEmail.addTo(email); // 받는 사람
			sendEmail.send();
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return ResponseEntity.ok().body("success");
	
	}

//	@RequestMapping(value = "/fail", method = RequestMethod.GET)
//	public void failPayment(HttpServletRequest request, Model model, @RequestParam("error") String error ) throws Exception {
//		String errorMessage = "";
//		
//		return "redirect:cart/viewCart";
//		
//
//	}

	private void updateCartCntCookie(String uuid, String sessionId, HttpServletRequest request, 
			HttpServletResponse response) {
		String member = "member";
		String id = uuid;
		if(uuid == null) {
			member = "nonMember";
			id = sessionId;
		}
		Cookie cartCnt = WebUtils.getCookie(request, "cartCnt");
		if(id!=null) {
			int cartListCnt = cService.getCartListCnt(id, member);
			cartCnt.setValue(cartListCnt + "");
			cartCnt.setPath("/");
			cartCnt.setMaxAge(24 * 60 * 60);
			response.addCookie(cartCnt);			
		}
	}
	
	
	
	
	

}
