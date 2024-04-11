package com.cafe24.goott351.user.order.persistence;

import java.util.List;

import com.cafe24.goott351.domain.CartVO;

public interface CartDAO {


	List<CartVO> getCartList(String cartId, String member);

	int getProductOnCart(String cartId,String member, String productNo);

	void updateProductOnCart(String cartId, String member, String productNo, String qty);

	void insertProductOnCart(String cartId, String member, String productNo, String qty);

	int getCartListCnt(String cartOriginId, String member);

	void insertChangeCart(List<CartVO> totList);

	List<CartVO> getTotCartList(String uuid, String oldId);

	int deleteOldCart(String uuid, String oldId);

	void removeCartList(String cartOriginId, String member, String productNo);

	int getCartOneList(String cartOriginId, String member, String pdNo);

	


}
