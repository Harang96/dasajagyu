package com.cafe24.goott351.user.order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.cafe24.goott351.domain.CartVO;
import com.cafe24.goott351.user.order.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	CartDAO cDao;

	@Override
	public Map<String, Object> getCartList(String cartId, String member) {

		Map<String, Object> cartMap = new HashMap<String, Object>();
		List<CartVO> productList = cDao.getCartList(cartId, member);
		
		cartMap.put("cartList", productList);

		return cartMap;
	}

	
	
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void addProductToCart(String cartId, String member, String productNo, String qty) {

		if (cDao.getProductOnCart(cartId, member, productNo) == 1) {
			// 중복상품 있음
			cDao.updateProductOnCart(cartId, member, productNo, qty);
		} else {
			// 중복상품 없음
			cDao.insertProductOnCart(cartId, member, productNo, qty);
		}

	}

	@Override
	public int getCartListCnt(String cartOriginId, String member) {
		int result = -1;

		result = cDao.getCartListCnt(cartOriginId, member);
		

		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void changeCartToMember(String uuid, String oldId) {
		List<CartVO> totList = cDao.getTotCartList(uuid, oldId);
				
		for (CartVO cv : totList) { 
			cv.setUuid(uuid);
		} 
		
		
		System.out.println(totList);
		
		int result = cDao.deleteOldCart(uuid, oldId);
		cDao.insertChangeCart(totList);
		
		

	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void removeCartList(String cartOriginId, String member, String productNo) {
		
		cDao.removeCartList(cartOriginId, member, productNo);
		
	}

	@Override
	public int getCartOneList(String cartOriginId, String member, String pdNo) {
		
		int newQty = cDao.getCartOneList(cartOriginId, member, pdNo);
		return newQty;
	}




	@Override
	public int getCartQtyInfo(String cartId, String member, String productNo) {
		
		int result = cDao.getProductOnCart(cartId, member, productNo); 
		
		return result;
	}

}