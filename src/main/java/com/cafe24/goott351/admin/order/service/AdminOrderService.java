/**
 * 
 */
package com.cafe24.goott351.admin.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.FilterDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.domain.OrderCSVO;
import com.cafe24.goott351.domain.CancelUtilDTO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.OrderVO;
import com.cafe24.goott351.domain.PaymentVO;

/**
 * @author : su hyeok kim
 * @date : 2024. 2. 27.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 2. 27.
 */
public interface AdminOrderService {
	// 어드민 전체 주문내역 select
	Map<String, Object> selectOrderList(FilterDTO param) throws Exception;

	List<OrderVO> selectFilteredOrderList(FilterDTO param) throws Exception;

	// 사용자 정보 select
	CustomerVO selectCustomer(String uuid) throws Exception;

	// orderNo로 paymentKey조회
	String selectPaymentkey(String orderNo) throws Exception;

	// 주문번호로 주문상품 리스트 가져오기
	List<OrderProductVO> selectOrderProductList(String orderNo, String ny) throws Exception;

	// 주문번호로 주문객체 가져오기
	OrderVO selectOrderRow(String orderNo) throws Exception;

	// 주문번호로 주문상품가격, 할인금액, 총결제금액 가져오기
	OrderBillingVO selectOrderBilling(String orderNo) throws Exception;

	// 주문번호로 주문한 사용자 정보 가져오기
	LoginCustomerVO selectCustomerInfo(String orderNo) throws Exception;

	// 관리자가 재고부족으로 상품을 취소한 상황을 가정한 트랜잭션 처리
	ResponseEntity<Map<String, String>> cancelByAdminProcess(CancelUtilDTO param, OrderBillingVO orderBilling)
			throws Exception;

	// 사용자가 주문 취소한 상황을가정한 트랜잭션 처리
	ResponseEntity<Map<String, String>> cancelByCustomerProcess(CancelUtilDTO param, OrderBillingVO orderBilling)
			throws Exception;

	// orderNo 로 결제 정보 가져오기
	PaymentVO selectPaymentObjectByOrderNo(String orderNo) throws Exception;

	// paymentKey 로 결제 취소
	PaymentVO updatePaymentObject(CancelUtilDTO param, OrderBillingVO orderBilling) throws Exception;

	// 주문건이 결제대기상태인지 확인
	String selectOrderstatus(String orderNo) throws Exception;

	// 주문번호, 상품번호로 상품정보 가져오기
	List<OrderProductVO> selectOrderProduct(OrderProductVO orderProductVO) throws Exception;

	// 주문cs 신청
	int insertCs(CancelUtilDTO cancelUtil) throws Exception;

	// 사용자가 cs신청한 것이 있는지 정보 가져오기
	List<OrderCSVO> selectOrderCs(OrderCSVO orderCSVO) throws Exception;

	// 배송상태 조회
	String selectDeliveryStatus(String orderNo) throws Exception;

	// 배송상태 업데이트
	int updateDeliveryStatus(String orderNo, String status) throws Exception;

	// cs 처리
	ResponseEntity<Map<String, String>> csProcess(List<OrderCSVO> orderCSVOLst) throws Exception;

	// cs 거절
	ResponseEntity<Map<String, String>> csReject(List<OrderCSVO> orderCSVOLst) throws Exception;

	// 주문번호로 배송정보 가져오기
	OrderShippingDTO selectOrderShippingInfo(String orderNo) throws Exception;

	// orderNo로 image테이블에서 이미지 가져오기
	List<String> selectBase64(String orderNo) throws Exception;

	// 취소 api 호출 메서드
	PaymentVO callCancelPaymentAPI(CancelUtilDTO param) throws Exception;
}