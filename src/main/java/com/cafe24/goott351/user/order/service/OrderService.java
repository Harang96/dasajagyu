package com.cafe24.goott351.user.order.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.http.ResponseEntity;

import com.cafe24.goott351.domain.OrderProductDTO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.OrderDTO;
import com.cafe24.goott351.domain.OrderInfoDTO;
import com.cafe24.goott351.domain.DeliveryVO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingDTO;
import com.cafe24.goott351.domain.ProductVO;

public interface OrderService {

	OrderInfoDTO getOrderInfo(List<OrderProductDTO> cartList) throws Exception;
	
	List<DeliveryVO> getDeliveryList(String uuid) throws Exception;
	DeliveryVO getDefaultDelivery(String uuid) throws Exception;
	
	
	Map<String, Object> confirmPayment(OrderDTO orderConfirm) throws Exception;

	boolean placeOrder(OrderInfoDTO orderInfo)
			throws Exception;

	void removeCartItems(String uuid, String sessionId, List<OrderProductDTO> products);

	Map<String, Object> compareProductQty(List<OrderProductDTO> productList);

	void changeCartQty(String uuid, String sessionId, List<Integer> productNoList, int qty);

	LoginCustomerVO getOrderCustomer(String uuid) throws Exception;

	Map<String, Integer> getOrderSummary() throws Exception;
	
	}
