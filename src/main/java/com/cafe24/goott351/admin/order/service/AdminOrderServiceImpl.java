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
import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.admin.order.persistence.OrderAdminDAO;
import com.cafe24.goott351.admin.order.persistence.OrderCustomerDAO;
import com.cafe24.goott351.domain.CancelProductDTO;
import com.cafe24.goott351.domain.CancelUtilDTO;
import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.FilterDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.domain.OrderCSVO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.OrderVO;
import com.cafe24.goott351.domain.PaymentVO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.domain.RegisterPointLog;
import com.cafe24.goott351.user.order.persistence.OrderDAO;
import com.cafe24.goott351.util.Failure;
import com.cafe24.goott351.util.PagingInfo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {

	private String secretKey = "test_sk_Wd46qopOB896vjREWvK3ZmM75y0v:";

	@Inject
	private OrderAdminDAO dao;
	@Inject
	private OrderCustomerDAO cDao;

	@Inject
	private OrderDAO odi; // order단 클래스 inject

	@Override
	public Map<String, Object> selectOrderList(FilterDTO param) throws Exception {
		List<OrderVO> lst = null;
		PagingInfo pi = getPagingInfo(param.getPageNo(), param.getSearchValue());
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if (!param.getSearchValue().equals("")) {
			lst = dao.selectAllList(pi, param);
		} else {
			lst = dao.selectAllList(pi);
		}

		for (OrderVO row : lst) {
			LoginCustomerVO customer = dao.selectCustomerInfo(row.getOrderNo());
			if (customer != null) {
				row.setCustomerName(customer.getName());
			}
		}

		resultMap.put("orderList", lst);
		resultMap.put("pagingInfo", pi);

		return resultMap;
	}

	@Override
	public List<OrderVO> selectFilteredOrderList(FilterDTO param) throws Exception {
		List<OrderVO> lst = null;
		PagingInfo pi = getPagingInfo(param.getPageNo(), param.getSearchValue());
		param.setOrderType(parseToHangle(param.getOrderType()));

		lst = dao.selectAllList(pi, param);

		return lst;
	}

	@Override
	public CustomerVO selectCustomer(String uuid) throws Exception {
		return cDao.selectCustomer(uuid);
	}

	public String parseToHangle(String engParam) {
		String result = "";

		switch (engParam) {
		case "completePayment":
		case "DONE":
			result = "결제완료";
			break;
		case "waitingForDeposit":
		case "WAITING_FOR_DEPOSIT":
			result = "입금대기";
			break;
		case "preparingProduct":
			result = "상품준비중";
			break;
		case "shipping":
			result = "배송중";
			break;
		case "deliveryCompleted":
			result = "배송완료";
			break;
		case "partiallyRefunded":
		case "PARTIAL_CANCELED":
			result = "부분취소";
			break;
		case "fullRefund":
		case "CANCELED":
		case "EXPIRED":
			result = "주문취소";
			break;
		case "ABORTED":
			result = " 결제실패";
			break;
		default:
			result = engParam;
		}

		return result;
	}

	private PagingInfo getPagingInfo(int pageNo, String searchValue) throws Exception {
		PagingInfo result = new PagingInfo();

		// pageNo세팅
		result.setPageNo(pageNo);

		// 전체 게시글 수 세팅
		// 검색어가 있을 경우
		if (!searchValue.equals("")) {
			result.setTotalPostCnt(dao.getOrderCntWithSearch(searchValue));
			System.out.println("검색어 결과 총 갯수 : " + dao.getOrderCntWithSearch(searchValue));
		} else if (searchValue.equals("")) { // 검색어가 없을 경우
			result.setTotalPostCnt(dao.getTotalOrderCnt());
		}

		result.setTotalPostCnt(dao.getTotalOrderCnt());

		System.out.println("전체 게시글 수 : " + dao.getTotalOrderCnt());

		// 총 페이지 수
		result.setTotalPageCnt(result.getTotalPostCnt(), result.getViewPostCntPerPage());

		// 보여주기 시작할 row Index번호 구하기
		result.setStartRowIndex();

		// 전체 페이징 블럭 갯수
		result.setTotalPagingBlockCnt();

		// 현재 페이지가 속한 페이징 블럭 번호
		result.setPageBlockOfCurrentPage();

		// 현재 페이징 블럭 페이지 시작 번호
		result.setStartNumOfCurrentPagingBlock();

		// 현재 페이징 블럭 페이지 끝 번호
		result.setEndNumOfCurrentPagingBlock();

		return result;
	}

	@Override
	public String selectPaymentkey(String orderNo) throws Exception {
		return dao.selectPaymentkey(orderNo);
	}

	@Override
	public List<OrderProductVO> selectOrderProductList(String orderNo, String ny) throws Exception {
		List<OrderProductVO> lst = ny == "N" ? dao.selectOrderNotCanceledProductList(orderNo)
				: dao.selectOrderProductList(orderNo);
		for (OrderProductVO product : lst) {
			product.setProductName(dao.selectPrdNmByPrdNo(product.getProductNo()));
		}

		return lst;
	}

	@Override
	public OrderVO selectOrderRow(String orderNo) throws Exception {
		return dao.selectOrderRow(orderNo);
	}

	@Override
	public OrderBillingVO selectOrderBilling(String orderNo) throws Exception {
		return dao.selectOrderBilling(orderNo);
	}

	@Override
	public LoginCustomerVO selectCustomerInfo(String orderNo) throws Exception {
		return dao.selectCustomerInfo(orderNo);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public ResponseEntity<Map<String, String>> cancelByAdminProcess(CancelUtilDTO param, OrderBillingVO orderBilling)
			throws Exception {
		boolean result = false;
		Map<String, String> resultMap = new HashMap<>();

		// 주문취소api
		PaymentVO payment = updatePaymentObject(param, orderBilling);

		if (payment.getFail() == null) { // 에러가 발생하지 않은 경우

			// 파라미터로 받은 productArr에 있는 데이터를 한개씩 꺼내기
			for (CancelProductDTO product : param.getProductArr()) {
				// orderCancel = "Y" 로 변경하기
				if (dao.updateOrderCancel(param.getOrderNo(), product.getNo()) == 1) {
					payment.setStatus(parseToHangle(payment.getStatus())); // 상태 변경

					// products 테이블 재고 업데이트하기 (주문취소하여 취소된 수량만큼 업데이트)
					if (dao.updateQuantity(product.getNo(), product.getQuantity()) == 1) {

						// orderNo로 사용자가 cs신청한 것이 있는지 정보 가져오기
						List<OrderCSVO> orderCSVOLst = selectOrderCs(new OrderCSVO(param.getOrderNo()));

						if (param.getCsType() != null) {
							if (param.getCsType().equals("반품") || param.getCsType().equals("교환")) {

								for (OrderCSVO orderCSVO : orderCSVOLst) {
									if (orderCSVO.getOrderNo().equals(param.getOrderNo())) {
										// order_cs에 cs_processed 를 Y 로 변경
										orderCSVO.setCsProcessed("Y");

										// order_cs 테이블에 로그 update
										if (dao.updateOrderCsProcessed(orderCSVO) == 1) {
											result = true;
											System.out.println("반품트랜잭션이 처리됨.");
										} else {
											result = false;
											System.out.println("반품트랜잭션이 처리되지않음.");
										}
									}
								}

							} else if (param.getCsType().equals("취소")) {
								// order_cs 테이블에 로그 insert
								if (dao.insertCs(param.getCancelReason(), product, param.getOrderNo(), param
										.getCsType(), param.getAdminYn()) == 1) {

									if (dao.updateOrderStatus(param.getOrderNo(), payment.getStatus()) == 1) {
										result = true;
										System.out.println("취소트랜잭션이 모두 처리됨.");
									} else { // updateOrderStatus 실패시
										result = false;
									}
								} else {
									result = false;
								}
							} else {
								result = false;
							}
						} else {
							result = false;
						}
					} else {
						result = false;
					}
				} else {
					result = false;
				}
			}
		} else { // 에러 발생한 경우
			result = false;
			resultMap.put("code", payment.getFail().getCode());
			resultMap.put("message", payment.getFail().getMessage());
		}

		if (result) {
			resultMap.put("type", "cancel");
			resultMap.put("result", "success");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
		} else {
			resultMap.put("type", "cancel");
			resultMap.put("result", "fail");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.BAD_REQUEST);
		}
	}

	@Override
	public PaymentVO selectPaymentObjectByOrderNo(String orderNo) throws Exception {
		Encoder encoder = Base64.getEncoder();
		byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
		String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);
		URL url = new URL("https://api.tosspayments.com/v1/payments/orders/" + orderNo);
		System.out.println("url : " + url);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("Authorization", authorizations);
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setRequestMethod("GET");
		int code = connection.getResponseCode();
		boolean isSuccess = code == 200 ? true : false;
		InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
		Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser.parse(reader);
		ObjectMapper objectMapper = new ObjectMapper();
		PaymentVO result = objectMapper.readValue(jsonObject.toJSONString(), PaymentVO.class);
		System.out.println("jsonObject : " + jsonObject);
		responseStream.close();
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public PaymentVO updatePaymentObject(CancelUtilDTO param, OrderBillingVO orderBilling) throws Exception {

		// 취소한 상품 리스트
		List<OrderProductVO> cancelProducts = getCancelProductInfo(param);

		// 취소상품의 원금합계를 세팅
		param.setCancelAmount(getCancelAmount(cancelProducts));

		// 취소상품의 할인율을 계산한 총 할인금액을 세팅
		param.setCancelProductDiscount(getCancelProductDiscount(cancelProducts));

		Integer sumOfCancelPrice = Optional.ofNullable(param.getProductArr())
				.map(list -> list.stream().mapToInt(CancelProductDTO::getPrice).sum())
				.orElseGet(() -> param.getCancelItem().stream().mapToInt(OrderProductVO::getOrderPrice).sum());

		String customerId = dao.selectOrderRow(param.getOrderNo()).getCustomerId(); // customer_id

		// 취소 상품 가격이 balanceAmount(api로 취소 가능한 최대 금액)
		if (param.isShippingRefund()) { // 배송비를 고객에게 청구한다.
			param.setRefundShipping(orderBilling.getShippingCost());
		}
		if (sumOfCancelPrice < (orderBilling.getOrderCost() - orderBilling.getShippingCost())) {
			param.setRefundCost(sumOfCancelPrice);
		} else {
			param.setRefundCost(orderBilling.getOrderCost());
			param.setRefundPoint((sumOfCancelPrice - param.getRefundCost()));

			if (odi.updateCustomersPoint(customerId, param.getRefundPoint()) == 1) {
				if (param.getRefundPoint() > 0
						&& odi.insertPontLog("주문시 사용포인트 환불", customerId, param.getRefundPoint()) == 1) {
					System.out.println("포인트 환불 프로세스가 정상적으로 처리됨.");
					// 주문자가 주문할 때 사용한 포인트 환불처리하기
				}
			}
		}

		// order_billing 환불 후 금액으로 업데이트
		if (dao.updateOrderBilling(param) == 1) {
			param.setRefundEarningPoint((int) (Math.ceil((param.getRefundCost()) * 0.01)));

			// 적립된 포인트 중 취소포인트만큼 환수
			if (dao.updateCustomerEarningPoint(new CancelUtilDTO(param.getRefundEarningPoint(), customerId)) == 1) {
				if (dao.updateOrderBilling(new CancelUtilDTO(0, 0, 0, 0, 0, param.getRefundEarningPoint(),
						param.getOrderNo())) == 1) {
					if (param.getRefundEarningPoint() > 0 && dao.insertPointLog(new RegisterPointLog("주문시 적립포인트 환불",
							customerId, param.getRefundEarningPoint() * -1)) == 1) {
						System.out.println("적립포인트 환수 프로세스가 정상적으로 처리됨.");
						orderBilling
								.setOrderPoint((int) ((orderBilling.getOrderCost() - param.getRefundCost()) * 0.01));
						// 주문자가 주문할 때 받은 적립 포인트 환수처리하기
					}
				}
			}

		}

		if (param.getRefundCost() == 0) {
			if (param.getCancelAmount() - param.getCancelProductDiscount() == param.getRefundPoint()) {
				return new PaymentVO("CANCELED");
			} else {
				return new PaymentVO("PARTIAL_CANCELED");
			}
		} else {

			return callCancelPaymentAPI(param);
		}
	}

	// 취소 api 호출
	@Override
	@Transactional(rollbackFor = Exception.class)
	public PaymentVO callCancelPaymentAPI(CancelUtilDTO param) throws Exception {
		JSONObject obj = new JSONObject();
		String bank = param.getCustomer().getBankName().replaceAll("은행", "");

		String accountNumber = param.getCustomer().getRefundAccount().replaceAll("-", "");
		String holderName = param.getCustomer().getName();

		Encoder encoder = Base64.getEncoder();
		byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
		String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);

		URL url = new URL("https://api.tosspayments.com/v1/payments/" + param.getPaymentKey() + "/cancel");

		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("Authorization", authorizations);
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setRequestMethod("POST");
		connection.setDoOutput(true);

		obj.put("cancelReason", param.getCancelReason());
		obj.put("cancelAmount", param.getRefundCost() + "");

		JSONObject refundReceiveAccount = new JSONObject();
		refundReceiveAccount.put("bank", bank);
		refundReceiveAccount.put("accountNumber", accountNumber);
		refundReceiveAccount.put("holderName", holderName);

		obj.put("refundReceiveAccount", refundReceiveAccount);

		System.out.println(obj);

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

		return payment;
	}

	@Override
	public String selectOrderstatus(String orderNo) throws Exception {
		return dao.selectOrderstatus(orderNo);
	}

	// 취소상품 가격 정보 가져오기
	private List<OrderProductVO> getCancelProductInfo(CancelUtilDTO cancelProduct) throws Exception {
		List<OrderProductVO> prdList = new ArrayList<OrderProductVO>();

		if (cancelProduct.getProductArr() != null) {
			for (CancelProductDTO product : cancelProduct.getProductArr()) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("orderNo", cancelProduct.getOrderNo());
				param.put("productNo", product.getNo());
				prdList.add(dao.selectCancelOrderProduct(param));
			}
		} else {
			for (OrderProductVO product : cancelProduct.getCancelItem()) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("orderNo", cancelProduct.getOrderNo());
				param.put("productNo", product.getProductNo());
				prdList.add(dao.selectCancelOrderProduct(param));
			}
		}
		return prdList;
	}

	private int getCancelAmount(List<OrderProductVO> lst) {
		int sum = 0;
		for (OrderProductVO product : lst) {
			sum += product.getSalesCost();
		}
		return sum;
	}

	private int getCancelProductDiscount(List<OrderProductVO> lst) {
		int sum = 0;
		for (OrderProductVO product : lst) {
			sum += product.getDiscountCost();
		}
		return sum;
	}

	@Override
	public List<OrderProductVO> selectOrderProduct(OrderProductVO orderProductVO) throws Exception {
		return dao.selectOrderProduct(orderProductVO);
	}

	@Override
	public int insertCs(CancelUtilDTO cancelUtil) throws Exception {
		return dao.insertCs(cancelUtil);
	}

	@Override
	public List<OrderCSVO> selectOrderCs(OrderCSVO orderCSVO) throws Exception {
		return dao.selectOrderCs(orderCSVO);
	}

	@Override
	public ResponseEntity<Map<String, String>> cancelByCustomerProcess(CancelUtilDTO param, OrderBillingVO orderBilling)
			throws Exception {

		return null;
	}

	@Override
	public int updateDeliveryStatus(String orderNo, String status) throws Exception {
		String statusHan = "";
		if (status.equals("start")) {
			statusHan = "배송시작";
		} else if (status.equals("ing")) {
			statusHan = "배송중";
		} else if (status.equals("finish")) {
			statusHan = "배송완료";
		}

		return dao.updateDeliveryStatus(orderNo, statusHan);
	}

	@Override
	public String selectDeliveryStatus(String orderNo) throws Exception {
		return dao.selectDeliveryStatus(orderNo);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public ResponseEntity<Map<String, String>> csProcess(List<OrderCSVO> orderCSVOLst) throws Exception {
		boolean result = false;
		Map<String, String> resultMap = new HashMap<>();

		if (orderCSVOLst.get(0).getCsType().equals("교환")) {

			// 교환일 경우 재고수량을 상품수량 만큼 마이너스한다.
			for (OrderCSVO orderCSVO : orderCSVOLst) {
				if (dao.updateQuantity(orderCSVO.getProductNo(), orderCSVO.getProductQuantity() * -1) == 1) {
					orderCSVO.setCsProcessed("Y"); // cs_processed 를 Y 로 설정한다.

					if (dao.updateOrderCsProcessed(orderCSVO) == 1) {
						result = true;
					}
				} else {
					orderCSVO.setCsProcessed("N"); // cs_processed 를 N 으로 설정한다.
					dao.updateOrderCsProcessed(orderCSVO);
					result = false;
					break;
				}
			}
		} else if (orderCSVOLst.get(0).getCsType().equals("반품")) {

			// 주문번호로 paymentKey 가져오기
			String paymentKey = selectPaymentkey(orderCSVOLst.get(0).getOrderNo());

			// cancelUtil 를 만들기위한 데이터 수집
			LoginCustomerVO customerVO = selectCustomerInfo(orderCSVOLst.get(0).getOrderNo());
			OrderBillingVO tmpBillingVO = selectOrderBilling(orderCSVOLst.get(0).getOrderNo());
			ProductVO productVO = dao.selectProduct(orderCSVOLst.get(0).getProductNo());
			List<OrderProductVO> notCanceledProductList = dao
					.selectOrderNotCanceledProductList(orderCSVOLst.get(0).getOrderNo());

			// 단순 변심 반품일 때는 재고가 재고 += cs신청수량 되어야한다.
			for (OrderCSVO orderCSVO : orderCSVOLst) {
				if (dao.updateQuantity(orderCSVO.getProductNo(), orderCSVO.getProductQuantity()) == 1) {
					OrderProductVO csTargetProduct = null;
					for (OrderProductVO product : notCanceledProductList) {
						if (product.getProductNo() == orderCSVO.getProductNo()) {
							csTargetProduct = product;
							break;
						}
					}

					CancelProductDTO productDTO = new CancelProductDTO(orderCSVO.getProductNo(),
							csTargetProduct.getProductName(), csTargetProduct.getSalesCost(),
							orderCSVO.getProductQuantity(),
							csTargetProduct.getSalesCost() * orderCSVO.getProductQuantity());
					List<CancelProductDTO> tmpProductDTO = new ArrayList<>();
					tmpProductDTO.add(productDTO);
					// cancelUtil 를 만들기위한 데이터 수집 끝

					// 수집한 데이터로 cancelUtil객체를 생성한다.
					CancelUtilDTO tmpCancelDTO = new CancelUtilDTO("Y", orderCSVO.getReason(),
							orderCSVO.getReasonType(), orderCSVO.getCsType(), customerVO, true, orderCSVO.getOrderNo(),
							tmpProductDTO, paymentKey);

					// 해당 상품 취소 프로세스
					if (cancelByAdminProcess(tmpCancelDTO, tmpBillingVO).getStatusCode() == HttpStatus.OK) {
						orderCSVO.setCsProcessed("Y"); // cs_processed 를 Y 로 설정한다.

						if (dao.updateOrderCsProcessed(orderCSVO) == 1) {
							result = true;
						} else {
							result = false;
							break;
						}
					} else {
						orderCSVO.setCsProcessed("N"); // cs_processed 를 N 으로 설정한다.
						dao.updateOrderCsProcessed(orderCSVO);
						result = false;
						break;
					}
				} else {
					result = false;
					break;
				}
			}
		} else {
			result = false;
		}

		if (result) {
			resultMap.put("type", "csProcess");
			resultMap.put("result", "success");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
		} else {
			resultMap.put("type", "csProcess");
			resultMap.put("result", "fail");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.BAD_REQUEST);
		}
	}

	@Override
	public ResponseEntity<Map<String, String>> csReject(List<OrderCSVO> orderCSVOLst) throws Exception {
		boolean result = false;
		Map<String, String> resultMap = new HashMap<>();

		for (OrderCSVO orderCSVO : orderCSVOLst) {
			orderCSVO.setCsProcessed("N"); // cs_processed 를 N으로 설정한다.

			if (dao.updateOrderCsProcessed(orderCSVO) == 1) {
				result = true;
			} else {
				result = false;
				break;
			}
		}

		if (result) {
			resultMap.put("type", "csReject");
			resultMap.put("result", "success");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
		} else {
			resultMap.put("type", "csReject");
			resultMap.put("result", "fail");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.BAD_REQUEST);
		}
	}

	@Override
	public OrderShippingDTO selectOrderShippingInfo(String orderNo) throws Exception {
		return dao.selectOrderShippingInfo(orderNo);
	}

	@Override
	public List<String> selectBase64(String orderNo) throws Exception {
		return dao.selectBase64(orderNo);
	}

}