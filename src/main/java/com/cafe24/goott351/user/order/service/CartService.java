package com.cafe24.goott351.user.order.service;

import java.util.Map;

public interface CartService {

	Map<String, Object> getCartList(String cartid, String member);

	void addProductToCart(String cartId, String member, String productNo, String qty);

	int getCartListCnt(String cartOriginId, String member);

	void changeCartToMember(String uuid, String oldId);

	void removeCartList(String cartOriginId, String member, String productNo);

	int getCartOneList(String cartOriginId, String member, String pdNo);

	int getCartQtyInfo(String cartId, String member, String productNo);

	

	
	
	
}
