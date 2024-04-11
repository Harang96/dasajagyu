package com.cafe24.goott351.admin.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafe24.goott351.admin.order.service.AdminOrderService;
import com.cafe24.goott351.admin.order.service.DepositConfigurationServiceImpl;
import com.cafe24.goott351.admin.order.service.OrderCancelService;
import com.cafe24.goott351.domain.CancelUtilDTO;
import com.cafe24.goott351.domain.FilterDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.domain.OrderCSVO;
import com.cafe24.goott351.domain.OrderCsDTO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.OrderVO;
import com.cafe24.goott351.domain.PaymentVO;
import com.cafe24.goott351.domain.RefundReceiveAccountDTO;
import com.cafe24.goott351.user.order.service.OrderService;
import com.cafe24.goott351.util.PagingInfo;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author : su hyeok kim
 * @date : 2024. 2. 28.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 2. 28.
 */
@Controller
@RequestMapping("/admin/order/*")
public class AdminOrderController {
	private static final Logger logger = LoggerFactory.getLogger(AdminOrderController.class);

	@Inject
	private AdminOrderService aos;
	@Inject
	private DepositConfigurationServiceImpl dcs;
	@Inject
	private OrderCancelService ocs;
	@Inject
	private OrderService oService;

	/**
	 * @Method : selectList
	 * @PackageName : com.cafe24.goott351.admin.order.controller
	 * @Return : String
	 * @Description : �ֹ���������Ʈ ȣ��
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024. 2. 28. su hyeok kim
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	private String selectList(Model model, @ModelAttribute FilterDTO filter) throws Exception {
		List<OrderVO> lst = null;

		Map<String, Object> map = aos.selectOrderList(filter);
		Map<String, Integer> summaryMap = oService.getOrderSummary();

		model.addAttribute("summary", summaryMap);
		model.addAttribute("orderList", (List<Map>) map.get("orderList"));
		model.addAttribute("pagingInfo", (PagingInfo) map.get("pagingInfo"));
		model.addAttribute("viewCountPerPage", filter.getViewCountPerPage());

		return "order/orderList";
	}

	/**
	 * @Method : selectFilterList
	 * @PackageName : com.cafe24.goott351.admin.order.controller
	 * @Return : String
	 * @Description : ���͸��� �ֹ����� ����Ʈ ȣ��
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024. 2. 28. su hyeok kim
	 */
	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String selectFilterList(Model model, @ModelAttribute FilterDTO filter) {
		List<OrderVO> lst = null;

		try {
			lst = aos.selectFilteredOrderList(filter);

			model.addAttribute("orderList", lst);
			model.addAttribute("orderType", filter.getOrderType());
			model.addAttribute("viewCountPerPage", filter.getViewCountPerPage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "order/orderList";
	}

	@RequestMapping(value = "detail", method = RequestMethod.GET)
	public String selectDetailOrder(Model model, @RequestParam(value = "no") String orderNo) {
		ObjectMapper objectMapper = new ObjectMapper();

		try {
			// 주문번호로 paymentKey 가져오기
			String paymentKey = aos.selectPaymentkey(orderNo);

			// 주문번호로 주문상품 리스트 가져오기
			List<OrderProductVO> orderProductList = aos.selectOrderProductList(orderNo, "both");

			// 주문번호로 주문상품 리스트 가져올 때 취소가 되지 않은 상품들만 자겨오기
			List<OrderProductVO> orderNotCanceledProductList = aos.selectOrderProductList(orderNo, "N");

			// 주문번호로 주문객체 가져오기
			OrderVO orderRow = aos.selectOrderRow(orderNo);

			// 주문번호로 주문상품 가격, 할인금액, 총결제금액 가져오기
			OrderBillingVO orderBilling = aos.selectOrderBilling(orderNo);

			// 주문번호로 주문한 사용자 정보 가져오기
			LoginCustomerVO customerInfo = aos.selectCustomerInfo(orderNo);

			// 토스페이먼츠api를 사용하여 orderId로 결제내역조회하기. PaymentVO를 리턴함. orderNo 는 orderId와 같다.
			PaymentVO payment = aos.selectPaymentObjectByOrderNo(orderNo);

			// orderNo로 사용자가 cs신청한 것이 있는지 정보 가져오기
			List<OrderCSVO> csLst = aos.selectOrderCs(new OrderCSVO(orderNo));

			// orderNo 로 base64 가져오기
			List<String> listOfbase64 = aos.selectBase64(orderNo);

			// 해당 주문건의 배송정보 가져오기
			OrderShippingDTO shippingInfo = aos.selectOrderShippingInfo(orderNo);

			String csProcessed = "";

			if (csLst != null && csLst.size() > 0) {
				csProcessed = csLst == null ? null : csLst.get(0).getCsProcessed();

				// csLst 에 productName 세팅하기
				for (OrderCSVO cs : csLst) {
					OrderProductVO orderProductVO = new OrderProductVO(cs.getOrderNo(), cs.getProductNo());
					cs.setProductName(aos.selectOrderProduct(orderProductVO).get(0).getProductName());
					cs.setSalesCost(aos.selectOrderProduct(orderProductVO).get(0).getSalesCost());
				}
			}

			model.addAttribute("paymentKey", paymentKey);
			model.addAttribute("orderProductList", orderProductList);
			model.addAttribute("orderNotCanceledProductList", objectMapper
					.writeValueAsString(orderNotCanceledProductList));
			model.addAttribute("order", orderRow);
			model.addAttribute("orderBilling", orderBilling);
			model.addAttribute("customerInfo", customerInfo);
			model.addAttribute("shippingInfo", shippingInfo);
			model.addAttribute("payment", objectMapper.writeValueAsString(payment));
			model.addAttribute("csLst", csLst);
			model.addAttribute("strCs", objectMapper.writeValueAsString(csLst));
			model.addAttribute("csStatus", csProcessed);
			model.addAttribute("image", listOfbase64);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "order/orderDetail";
	}

	@RequestMapping(value = "cancel", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>> cancelProduct(@RequestBody CancelUtilDTO cancelUtil) throws Exception {

		// 주문번호로 주문상품 가격, 할인금액, 총결제금액 가져오기
		OrderBillingVO orderBilling = aos.selectOrderBilling(cancelUtil.getOrderNo());

		// 주문번호로 사용자 정보 가져오기
		LoginCustomerVO customer = aos.selectCustomerInfo(cancelUtil.getOrderNo());

		// 주문번호로 사용자가 결제한 주문 정보 가져오기
		OrderVO order = aos.selectOrderRow(cancelUtil.getOrderNo());

		cancelUtil.setCsType("취소");
		cancelUtil.setAdminYn("Y");

		if (cancelUtil.getCustomer() == null) {
			cancelUtil.setCustomer(customer);
		}

		// 취소 프로세스
		return aos.cancelByAdminProcess(cancelUtil, orderBilling);
	}

	@RequestMapping(value = "orderCancel", method = RequestMethod.POST)
	public String cancelOrder(@ModelAttribute OrderCsDTO orderCs, @ModelAttribute RefundReceiveAccountDTO account,
			RedirectAttributes rttr) throws Exception {
		String redirect = "";

		// 취소 프로세스 OrderCsDTO orderCs, RefundReceiveAccountDTO account
		Map<String, String> apiResult = ocs.cancelOrders(orderCs, account);

		if (apiResult.get("result").equals("success")) {
			redirect = "detail?no=" + orderCs.getOrderNo();
			rttr.addFlashAttribute("cancelResult", "success");
		} else {
			redirect = "detail?no=" + orderCs.getOrderNo();
			rttr.addFlashAttribute("cancelResult", "fail");
		}

		return "redirect:" + redirect;
	}

	@RequestMapping(value = "csProc", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>> csProc(Model model, @RequestBody List<OrderCSVO> orderCSVO)
			throws Exception {

		// orderNo로 사용자가 cs신청한 것이 있는지 정보 가져오기
		List<OrderCSVO> orderCSVOLst = aos.selectOrderCs(new OrderCSVO(orderCSVO.get(0).getOrderNo()));

		// 교환, 반품신청 승인 프로세스
		return aos.csProcess(orderCSVO);
	}

	@RequestMapping(value = "csReject", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>> csReject(Model model, @RequestBody List<OrderCSVO> orderCSVO)
			throws Exception {

		// 교환, 반품신청 거절 프로세스
		return aos.csReject(orderCSVO);
	}

	@RequestMapping(value = "deposit", method = RequestMethod.POST)
	public void checkDeposit(@RequestBody PaymentVO payment, InterceptorRegistry registry) throws Exception {
		dcs.updateOrderStatus(payment.getOrderId(), payment.getStatus());

		if (payment.getStatus().equals("DONE")) { // 가상계좌 입금 완료
			OrderBillingVO bill = aos.selectOrderBilling(payment.getOrderId());
			dcs.updatePointForDeposit(payment.getOrderId(), bill.getOrderPoint());
		}
	}

	@RequestMapping(value = "checkOrder", method = RequestMethod.POST)
	public ResponseEntity<Map<String, String>> checkOrder(@RequestBody Map<String, String> no) throws Exception {
		String orderNo = no.get("orderNo");

		Map<String, String> result = new HashMap<>();
		String orderStatus = aos.selectOrderRow(orderNo).getOrderStatus();
		if (orderStatus.equals("결제완료")) {
			result.put("type", "checkOrder");
			result.put("result", "결제완료");

			return new ResponseEntity<Map<String, String>>(result, HttpStatus.OK);
		} else {
			result.put("type", "checkOrder");
			result.put("result", "error");

			return new ResponseEntity<Map<String, String>>(result, HttpStatus.CONFLICT);
		}
	}

	@RequestMapping(value = "updateDeliveryState", method = RequestMethod.GET)
	public ResponseEntity<Map<String, String>> changeDeliveryState(@RequestParam("no") String orderNo,
			@RequestParam("deliveryStatus") String status) throws Exception {
		Map<String, String> result = new HashMap<>();

		System.out.println(status);

		if (aos.updateDeliveryStatus(orderNo, status) == 1) {
			result.put("type", "changeDeliveryStatus");
			result.put("result", "success");

			return new ResponseEntity<Map<String, String>>(result, HttpStatus.OK);
		} else {
			result.put("type", "changeDeliveryStatus");
			result.put("result", "fail");

			return new ResponseEntity<Map<String, String>>(result, HttpStatus.CONFLICT);
		}

	}

	@RequestMapping(value = "selectDeliveryState", method = RequestMethod.GET)
	public ResponseEntity<Map<String, String>> changeDeliveryState(@RequestParam("no") String orderNo)
			throws Exception {
		Map<String, String> result = new HashMap<>();

		String status = aos.selectDeliveryStatus(orderNo);

		System.out.println(orderNo + ", " + status);

		if (status.equals("배송시작")) {
			result.put("type", "selectDeliveryStatus");
			result.put("result", "success");
			result.put("deliveryStatus", "start");

			return new ResponseEntity<Map<String, String>>(result, HttpStatus.OK);
		} else if (status.equals("배송중")) {
			result.put("type", "selectDeliveryStatus");
			result.put("result", "success");
			result.put("deliveryStatus", "ing");

			return new ResponseEntity<Map<String, String>>(result, HttpStatus.OK);
		} else if (status.equals("배송완료")) {
			result.put("type", "selectDeliveryStatus");
			result.put("result", "success");
			result.put("deliveryStatus", "finish");

			return new ResponseEntity<Map<String, String>>(result, HttpStatus.OK);
		} else {
			result.put("type", "selectDeliveryStatus");
			result.put("result", "fail");
			result.put("deliveryStatus", "undefined");

			return new ResponseEntity<Map<String, String>>(result, HttpStatus.OK);
		}

	}

}