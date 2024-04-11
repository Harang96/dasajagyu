package com.cafe24.goott351.user.order.persistence;

import java.util.List;

import com.cafe24.goott351.domain.DeliveryVO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingDTO;
import com.cafe24.goott351.domain.OrderDTO;
import com.cafe24.goott351.domain.OrderProductDTO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.ProductVO;

public interface OrderDAO {
	ProductVO selectProductInfo(int productNo) throws Exception;
	List<DeliveryVO> selectDeliveryList(String uuid) throws Exception;
	DeliveryVO selectDefaultDelivery(String uuid) throws Exception;
	
	int insertOrder(OrderDTO order) throws Exception;
	int insertOrderProduct(OrderProductDTO product) throws Exception;
	int insertOrderBilling(OrderBillingDTO bill) throws Exception;
	int insertShipping(OrderShippingDTO shipping) throws Exception; //딜리버리 말고 폼으로 입력받은거 넣는 객체 따로 만들어줘야함
	int updateProductQty(int productNo, int qty) throws Exception;
	int updateCustomersPoint(String uuid, int pointDiscount);
	int insertPontLog(String why, String uuid, int point);
	int hasCartProductByUUID(String uuid, int productNo);
	int hasCartProductBySessionId(String sessionId, int productNo);
	void deleteCartProduct(int cartNo);
	int getProductCurrentQty(int productNo);
	void updateCartQty(int cartNo, int qty);
	LoginCustomerVO selectOrderCustomer(String uuid);
	Integer selectCountByOrderStatus(String status);
}
