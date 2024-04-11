/**
 * 
 */
package com.cafe24.goott351.admin.order.persistence;

import java.util.List;
import java.util.Map;

import com.cafe24.goott351.domain.CancelProductDTO;
import com.cafe24.goott351.domain.FilterDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.domain.OrderCSVO;
import com.cafe24.goott351.domain.OrderCsDTO;
import com.cafe24.goott351.domain.CancelUtilDTO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.OrderVO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.domain.RegisterPointLog;
import com.cafe24.goott351.util.PagingInfo;

/**
 * @author : goott5
 * @date : 2024. 2. 27.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         goott5 2024. 2. 27.
 */
public interface OrderAdminDAO {
	// order 전체 조회
	List<OrderVO> selectAllList(PagingInfo pi) throws Exception;

	List<OrderVO> selectAllList(PagingInfo pi, FilterDTO param) throws Exception;

	// 전체 order수 조회
	int getTotalOrderCnt() throws Exception;

	// 검색어 갯수 조회
	int getOrderCntWithSearch(String searchValue) throws Exception;

	// orderNo로 PaymentKey 조회
	String selectPaymentkey(String orderNo) throws Exception;

	// orderNo 로 제품리스트 조회
	List<OrderProductVO> selectOrderProductList(String orderNo) throws Exception;

	// orderNo 로 isCancel이 N 인 제품리스트 조회
	List<OrderProductVO> selectOrderNotCanceledProductList(String orderNo) throws Exception;

	// orderNo로 주문row 가져오기
	OrderVO selectOrderRow(String orderNo) throws Exception;

	// productNo로 상품명 가져오기
	String selectPrdNmByPrdNo(int productNo) throws Exception;

	// orderNo로 orderBilling 객체 가져오기
	OrderBillingVO selectOrderBilling(String orderNo) throws Exception;

	// 주문번호로 주문한 사용자 정보 가져오기
	LoginCustomerVO selectCustomerInfo(String orderNo) throws Exception;

	// orderCancel = "Y" 로 변경
	int updateOrderCancel(String orderNo, int productNo) throws Exception;

	// order_billing테이블 해당 주문건 update
	int updateOrderBilling(CancelUtilDTO param) throws Exception;

	// products테이블의 재고 update
	int updateQuantity(int productNo, int quantity) throws Exception;

	// customer테이블에 사용 포인트 환불
	int updateCustomerPoint(String orderNo, int pointDiscount) throws Exception;

	// order_cs테이블 insert
	int insertCs(String reason, CancelProductDTO product, String orderNo, String csType, String adminYn); // 재고가 0이 아닌경우

	int insertCs(String reason, int productNo, String orderNo, String csType, String adminYn);// 재고가 0인 경우

	// orders테이블의 해당 주문 건 상태 변경
	int updateOrderStatus(String orderNo, String status) throws Exception;

	// 해당 상품 재고 가져오기
	int selectProductQuantity(int productNo) throws Exception;

	// 주문번호로 취소상품갯수 가져오기
	int selectOrderCancelRowCount(String orderNo) throws Exception;

	// 주문건이 결제대기상태인지 확인
	String selectOrderstatus(String orderNo) throws Exception;

	OrderProductVO selectCancelOrderProduct(Map<String, Object> param) throws Exception;

	// 결제시 적립된 포인트 취소금액만큼 환수
	int updateCustomerEarningPoint(CancelUtilDTO cancelUtil) throws Exception;

	// insert pointLog
	int insertPointLog(RegisterPointLog pointLog) throws Exception;

	// 주문번호, 상품번호로 상품정보 가져오기
	List<OrderProductVO> selectOrderProduct(OrderProductVO orderProductVO) throws Exception;

	// 주문cs 신청
	int insertCs(CancelUtilDTO cancelUtil) throws Exception;
	int insertCs(OrderCsDTO orderCsDTO) throws Exception;

	// 사용자가 cs신청한 것이 있는지 정보 가져오기
	List<OrderCSVO> selectOrderCs(OrderCSVO orderCSVO) throws Exception;
	
	// 배송상태 조회
	String selectDeliveryStatus(String orderNo) throws Exception;
	
	// 배송상태 업데이트
	int updateDeliveryStatus(String orderNo, String status) throws Exception;
	
	// 상품 정보 가져오기 
	ProductVO selectProduct(int productNo) throws Exception;
	
	// OrderCS테이블 업데이트
	int updateOrderCsProcessed(OrderCSVO orderCSVO) throws Exception;
	
	// 주문번호로 배송정보 가져오기
	OrderShippingDTO selectOrderShippingInfo(String orderNo) throws Exception;
	
	// orderNo 로 사용자가 cs신청한 것이 있는지 찾아서 썸네일 이미지, 상품명, 가격 정보 가져오기
	CancelUtilDTO selectThumnailImage(String orderNo) throws Exception;
	
	// orderNo로 image테이블에서 이미지 가져오기
	List<String> selectBase64(String orderNo) throws Exception;
	
	// 고객 정보 update(포인트 환수, 환급)
	int updateCustomerOfOrderBilling(OrderBillingVO orderBillingVO) throws Exception;

	// 취소된 주문 Billing 0으로 업데이트
	int updateCanceledOrderBilling(String orderNo) throws Exception;
}