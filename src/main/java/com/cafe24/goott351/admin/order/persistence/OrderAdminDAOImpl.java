package com.cafe24.goott351.admin.order.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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

@Repository
public class OrderAdminDAOImpl implements OrderAdminDAO {
	private static String ns = "com.cafe24.goott351.mappers.orderAdminMapper";

	@Inject
	private SqlSession ses;

	@Override
	public int getTotalOrderCnt() throws Exception {
		return ses.selectOne(ns + ".selectTotalOrderCnt");
	}

	@Override
	public List<OrderVO> selectAllList(PagingInfo pi) throws Exception {
		return ses.selectList(ns + ".selectAllOrders", pi);
	}

	@Override
	public List<OrderVO> selectAllList(PagingInfo pi, FilterDTO param) throws Exception {
		Map<String, Object> param2 = new HashMap<String, Object>();
		param2.put("orderType", param.getOrderType());
		param2.put("searchValue", param.getSearchValue());
		param2.put("startRowIndex", pi.getStartRowIndex());
		param2.put("viewPostCntPerPage", pi.getViewPostCntPerPage());

		return ses.selectList(ns + ".selectAllOrdersWithFilter", param2);
	}

	@Override
	public int getOrderCntWithSearch(String searchValue) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchWord", "%" + searchValue + "%");

		return ses.selectOne(ns + ".getAllListCntWithSearch", param);

	}

	@Override
	public String selectPaymentkey(String orderNo) throws Exception {
		return ses.selectOne(ns + ".selectPaymentkey", orderNo);
	}

	@Override
	public List<OrderProductVO> selectOrderNotCanceledProductList(String orderNo) throws Exception {
		return ses.selectList(ns + ".selectOrderProductOfNotCanceledList", orderNo);
	}

	@Override
	public List<OrderProductVO> selectOrderProductList(String orderNo) throws Exception {
		return ses.selectList(ns + ".selectOrderProductList", orderNo);
	}

	@Override
	public OrderProductVO selectCancelOrderProduct(Map<String, Object> param) throws Exception {
		return ses.selectOne(ns + ".selectCancelOrderProduct", param);
	}

	@Override
	public OrderVO selectOrderRow(String orderNo) throws Exception {
		return ses.selectOne(ns + ".selectOrderRow", orderNo);
	}

	@Override
	public String selectPrdNmByPrdNo(int orderNo) throws Exception {
		return ses.selectOne(ns + ".selectPrdNmByPrdNo", orderNo);
	}

	@Override
	public OrderBillingVO selectOrderBilling(String orderNo) throws Exception {
		return ses.selectOne(ns + ".selectOrderBilling", orderNo);
	}

	@Override
	public LoginCustomerVO selectCustomerInfo(String orderNo) throws Exception {
		return ses.selectOne(ns + ".selectCustomerInfo", orderNo);
	}

	@Override
	public int updateOrderCancel(String orderNo, int productNo) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orderNo", orderNo);
		param.put("productNo", productNo);

		return ses.update(ns + ".updateOrderProduct", param);
	}

	@Override
	public int selectProductQuantity(int productNo) throws Exception {
		return ses.selectOne(ns + ".selectProductQuantityByProductNo", productNo);
	}

	@Override
	public int updateQuantity(int productNo, int quantity) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("productNo", productNo);
		param.put("quantity", quantity);

		return ses.update(ns + ".updateProductQuantity", param);
	}

	@Override
	public int insertCs(OrderCsDTO orderCsDTO) {
		return ses.insert(ns + ".insertCsForObjOfOrderCsDTO", orderCsDTO);
	}
	
	@Override
	public int insertCs(String reason, CancelProductDTO product, String orderNo, String csType, String adminYn) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reason", reason);
		param.put("orderNo", orderNo);
		param.put("quantity", product.getQuantity());
		param.put("productNo", product.getNo());
		param.put("csType", csType);
		param.put("adminYn", adminYn);
		
		System.out.println("param :: " + param);
		
		return ses.insert(ns + ".insertCsByAdmin", param);
	}

	@Override
	public int insertCs(String reason, int productNo, String orderNo, String csType, String adminYn) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reason", reason);
		param.put("orderNo", orderNo);
		param.put("productNo", productNo);
		param.put("csType", csType);
		param.put("adminYn", adminYn);

		System.out.println("param :: " + param);

		return ses.insert(ns + ".insertCsByAdmin", param);
	}

	@Override
	public int updateOrderStatus(String orderNo, String status) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orderNo", orderNo);
		param.put("status", status);

		return ses.update(ns + ".updateOrderStatus", param);
	}

	@Override
	public int selectOrderCancelRowCount(String orderNo) throws Exception {
		return ses.selectOne(ns + ".selectOrderCancelRowCount", orderNo);
	}

	@Override
	public int updateCustomerPoint(String orderNo, int pointDiscount) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orderNo", orderNo);
		param.put("pointDiscount", pointDiscount);

		return ses.update(ns + ".updateCustomerPoint", param);
	}

	@Override
	public String selectOrderstatus(String orderNo) throws Exception {
		return ses.selectOne(ns + ".selectOrderstatus", orderNo);
	}

	@Override
	public int updateOrderBilling(CancelUtilDTO param) throws Exception {
		return ses.update(ns + ".updateOrderBilling", param);
	}

	@Override
	public int updateCanceledOrderBilling(String orderNo) throws Exception {
		return ses.update(ns + ".updateCanceledOrderBilling", orderNo);
	}

	@Override
	public int updateCustomerEarningPoint(CancelUtilDTO cancelUtil) throws Exception {
		return ses.update(ns + ".updateCustomerEarningPoint", cancelUtil);
	}

	@Override
	public int insertPointLog(RegisterPointLog pointLog) throws Exception {
		return ses.update(ns + ".insertPointLog", pointLog);
	}

	@Override
	public List<OrderProductVO> selectOrderProduct(OrderProductVO orderProductVO) throws Exception {
		return ses.selectList(ns + ".selectOrderProduct", orderProductVO);
	}

	@Override
	public int insertCs(CancelUtilDTO cancelUtil) throws Exception {
		return ses.insert(ns + ".insertCs", cancelUtil);
	}

	@Override
	public List<OrderCSVO> selectOrderCs(OrderCSVO orderCSVO) throws Exception {
		return ses.selectList(ns + ".selectOrderCs", orderCSVO);
	}

	@Override
	public int updateDeliveryStatus(String orderNo, String status) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orderNo", orderNo);
		param.put("status", status);
		
		return ses.update(ns + ".updateDeliveryStatus", param);
	}

	@Override
	public String selectDeliveryStatus(String orderNo) throws Exception {
		return ses.selectOne(ns + ".selectDeliveryStatus", orderNo);
	}

	@Override
	public ProductVO selectProduct(int productNo) throws Exception {
		return ses.selectOne(ns + ".selectProduct", productNo);
	}

	@Override
	public int updateOrderCsProcessed(OrderCSVO orderCSVO) throws Exception {
		return ses.update(ns + ".updateOrderCsProcessed", orderCSVO);
	}

	@Override
	public OrderShippingDTO selectOrderShippingInfo(String orderNo) throws Exception {
		return ses.selectOne(ns + ".selectOrderShippingInfo", orderNo);
	}

	@Override
	public CancelUtilDTO selectThumnailImage(String orderNo) throws Exception {
		return ses.selectOne(ns + ".selectThumnailImage", orderNo);
	}

	@Override
	public List<String> selectBase64(String orderNo) throws Exception {
		return ses.selectList(ns + ".selectBase64", orderNo);
	}

	@Override
	public int updateCustomerOfOrderBilling(OrderBillingVO orderBillingVO) throws Exception {
		return ses.update(ns + ".updateCustomerOfOrderBilling", orderBillingVO);
	}
	
	

}