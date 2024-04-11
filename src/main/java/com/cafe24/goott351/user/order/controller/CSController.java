package com.cafe24.goott351.user.order.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.admin.order.service.AdminOrderService;
import com.cafe24.goott351.admin.order.service.OrderCancelService;
import com.cafe24.goott351.domain.CancelProductDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.domain.OrderCSVO;
import com.cafe24.goott351.domain.OrderCsDTO;
import com.cafe24.goott351.domain.CancelUtilDTO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.PaymentVO;
import com.cafe24.goott351.domain.RefundReceiveAccountDTO;
import com.cafe24.goott351.user.order.service.CSService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/order/cs*")
public class CSController {

	@Inject
	private AdminOrderService aos;
	
	@Inject
	private OrderCancelService ocs;
	
	@Inject
	private CSService css;

	@RequestMapping(value = "/exchange", method = RequestMethod.GET)
	public String exchange(Model model, @RequestParam(value = "orderNo") String orderNo) throws Exception {
		
		List<OrderProductVO> productList = aos.selectOrderProductList(orderNo, "N");
		
		model.addAttribute("csType", "교환");
		model.addAttribute("list", productList);
		model.addAttribute("orderNo", orderNo);

		return "mypage/orderCS";
	}

	@RequestMapping(value = "/return", method = RequestMethod.GET)
	public String refund(Model model, @RequestParam(value = "orderNo") String orderNo) throws Exception {
		
		List<OrderProductVO> productList = aos.selectOrderProductList(orderNo, "N");

		model.addAttribute("csType", "반품");
		model.addAttribute("list", productList);
		model.addAttribute("orderNo", orderNo);

		return "mypage/orderCS";
	}
	
	@RequestMapping(value = "/applyCS", method = RequestMethod.POST)
	public String applyCS(@RequestParam("orderNo") String orderNo, @RequestParam("csType") String csType,
	                      @RequestParam(value = "selectedProducts", required = false) String[] selectedProducts,
	                      @RequestParam("reasonType") String reasonType, @RequestParam("reason") String reason,
	                      @RequestParam("uploadFile") List<MultipartFile> uploadFile,HttpServletRequest request) throws Exception {

	    ObjectMapper mapper = new ObjectMapper();
	    List<CancelProductDTO> cancelProducts = new ArrayList<>();

	    if (selectedProducts != null) {
	        for (String index : selectedProducts) {
	            String jsonString = request.getParameter("selectedProduct" + index);
	            CancelProductDTO product = mapper.readValue(jsonString, CancelProductDTO.class);
	            cancelProducts.add(product);
	        }
	    }

	    System.out.println(cancelProducts);
	    System.out.println("orderNo : " + orderNo + ", reasonType : " + reasonType + ", reason: " + reason);

	    css.applyCS(orderNo, csType, cancelProducts, reasonType, reason, uploadFile);

	    return "redirect:/mypage/csList";
	}
	
//	@RequestMapping("/cancel")
//	public ResponseEntity cancelOrder(@RequestParam String orderNo, HttpSession session) throws Exception{
//		String uuid = ((LoginCustomerVO)session.getAttribute("loginCustomer")).getUuid();
//		System.out.println("주문취소하기 "+orderNo+"uuid : "+uuid);
//		System.out.println(css.validationCancelOrder(orderNo, uuid));
//		if(css.validationCancelOrder(orderNo, uuid)) {
//			System.out.println("주문자 유효성 확인 완료");
//			
//			List<OrderProductVO> productList = aos.selectOrderProductList(orderNo, "N");
//			if(css.cancelOrder(orderNo, productList)) {
//				return ResponseEntity.ok().body("cancel success");
//			}
//		}
//		
//		return ResponseEntity.badRequest().body("fail");
//	}
	
	@RequestMapping(value="/cancel", method = RequestMethod.POST)
	public ResponseEntity cancelOrder(@RequestBody Map<String, String> map, HttpSession session) throws Exception{
		String uuid = ((LoginCustomerVO)session.getAttribute("loginCustomer")).getUuid();
		System.out.println("주문취소하기 "+map.get("orderNo") +"uuid : "+uuid);
		System.out.println(map);
		RefundReceiveAccountDTO account = new RefundReceiveAccountDTO(map.get("bank"), map.get("accountNumber"), map.get("holderName"));
		System.out.println("환불계좌 : "+ account.toString());
		
		OrderCsDTO orderCs = new OrderCsDTO();
		orderCs.setOrderNo(map.get("orderNo"));
		orderCs.setReason("주문취소");
		orderCs.setCsType("취소");
		orderCs.setAdminYn("N");
		
		if(css.validationCancelOrder(map.get("orderNo"), uuid)) {
			Map<String, String> result = ocs.cancelOrders(orderCs, account);
			if(result.get("result").equals("success")) {
				return ResponseEntity.ok("success");
			} else {
				return ResponseEntity.badRequest().body("fail");
			}
		} else {
			return ResponseEntity.badRequest().body("not vaild");
		}
	}
}
