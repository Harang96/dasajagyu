package com.cafe24.goott351.user.order.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.DeliveryVO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingDTO;
import com.cafe24.goott351.domain.OrderDTO;
import com.cafe24.goott351.domain.OrderProductDTO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.ProductVO;

@Repository
public class OrderDAOImpl implements OrderDAO {

	@Inject
	private SqlSession ses;
	
	private String orderMapper = "com.cafe24.goott351.mappers.orderMapper";
	private String productMapper = "com.cafe24.goott351.mappers.productMapper";
	private String deliveryMapper = "com.cafe24.goott351.mappers.deliveryMapper";
	private String pointLogMapper = "com.cafe24.goott351.mappers.pointLogMapper";
	
	@Override
	public List<DeliveryVO> selectDeliveryList(String uuid) throws Exception {
		return ses.selectList(deliveryMapper+".selectDeliveryList", uuid);
	}
	
	@Override
	public DeliveryVO selectDefaultDelivery(String uuid) throws Exception {
		return ses.selectOne(deliveryMapper+".selectDefaultDelivery", uuid);
	}
	
	@Override
	public ProductVO selectProductInfo(int productNo) throws Exception {
		return ses.selectOne(productMapper+".selectProductInfo", productNo);
	}

	@Override
	public int insertOrder(OrderDTO order) throws Exception {
		return ses.insert(orderMapper+".insertOrder", order);
	}

	@Override
	public int insertOrderProduct(OrderProductDTO product) throws Exception {
		return ses.insert(orderMapper+".insertOrderProduct", product);
	}

	@Override
	public int insertOrderBilling(OrderBillingDTO bill) throws Exception {
		return ses.insert(orderMapper+".insertOrderBilling", bill);
	}

	@Override
	public int insertShipping(OrderShippingDTO shipping) throws Exception {
		return ses.insert(orderMapper+".insertShipping", shipping);
	}

	@Override
	public int updateProductQty(int productNo, int qty) throws Exception {
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("productNo", productNo);
		param.put("qty", qty);
		return ses.update(productMapper+".updateOrderdProductQty", param);
	}

	@Override
	public int updateCustomersPoint(String uuid, int point) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uuid", uuid);
		param.put("point", point);
		return ses.update(orderMapper+".updateCustomersPoint", param);
	}

	@Override
	public int insertPontLog(String why, String uuid, int point) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("why", why);
		param.put("customerUuid", uuid);
		param.put("howmuch", point);
		return ses.update(pointLogMapper+".insertPontLog", param);
	}

	@Override
	public int hasCartProductByUUID(String uuid, int productNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("uuid", uuid);
		param.put("productNo", productNo);
		Integer cartNo = ses.selectOne(orderMapper+".hasCartProductByUUID", param);
		System.out.println(cartNo);
		if(cartNo==null) {
			return 0;
		} else {
			return cartNo;			
		}
		
	}

	@Override
	public int hasCartProductBySessionId(String sessionId, int productNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("sessionId", sessionId);
		param.put("productNo", productNo);
		Integer cartNo = ses.selectOne(orderMapper+".hasCartProductByUUID", param);
		if(cartNo == null) {
			return 0;
		} else {
			return cartNo;			
		}
	}

	@Override
	public void  deleteCartProduct(int cartNo) {
		ses.delete(orderMapper+".deleteCartProduct", cartNo);
	}

	@Override
	public int getProductCurrentQty(int productNo) {
		return ses.selectOne(orderMapper+".getProductCurrentQty", productNo);
	}

	@Override
	public void updateCartQty(int cartNo, int qty) {
		Map<String, Object> param = new HashMap<>();
		param.put("cartNo", cartNo);
		param.put("qty", qty);
		ses.update(orderMapper+".updateCartQty", param);
	}

	@Override
	public LoginCustomerVO selectOrderCustomer(String uuid) {
		return ses.selectOne(orderMapper+".selectOrderCustomer", uuid);
	}

	@Override
	public Integer selectCountByOrderStatus(String status) {
		Map<String, String> param = new HashMap<>();
		param.put("status", status);
		return ses.selectOne(orderMapper+".selectCountByOrderStatus", param);
	}

	
	
	

	

}
