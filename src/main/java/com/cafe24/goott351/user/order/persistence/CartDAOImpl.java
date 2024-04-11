package com.cafe24.goott351.user.order.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.CartVO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	private SqlSession ses;
	private static String ns = "com.cafe24.goott351.mappers.cartMapper";

	@Override
	public List<CartVO> getCartList(String cartId, String member) {

		String query = ns + ".selectCartList";
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("customerType", member);
		param.put("cartId", cartId);

		return ses.selectList(query, param);
	}

	@Override
	public int getProductOnCart(String cartId, String member, String productNo) {

		String query = ns + ".selectProductOnCart";

		Map<String, Object> param = new HashMap<String, Object>();

		param.put("customerType", member);
		param.put("cartId", cartId);
		param.put("productNo", productNo);

		return ses.selectOne(query, param);
	}

	@Override
	public void updateProductOnCart(String cartId, String member, String productNo, String qty) {

		String query = ns + ".updateProductOnCart";

		Map<String, Object> param = new HashMap<String, Object>();

		param.put("customerType", member);
		param.put("qty", qty);
		param.put("cartId", cartId);
		param.put("productNo", productNo);

		ses.update(query, param);
	}

	@Override
	public void insertProductOnCart(String cartId, String member, String productNo, String qty) {
		String query = ns + ".insertProductOnCart";

		Map<String, Object> param = new HashMap<String, Object>();

		param.put("customerType", member);
		param.put("qty", qty);
		param.put("cartId", cartId);
		param.put("productNo", productNo);

		ses.insert(query, param);
	}

	@Override
	public int getCartListCnt(String cartOriginId, String member) {

		String query = ns + ".selectCartListCnt";

		Map<String, Object> param = new HashMap<String, Object>();

		param.put("customerType", member);
		param.put("cartId", cartOriginId);

		return ses.selectOne(query, param);
	}

	@Override
	public void insertChangeCart(List<CartVO> totList) {

		String query = ns + ".insertNewCartList";
		System.out.println(query);
		
		ses.insert(query, totList);
	}

	@Override
	public List<CartVO> getTotCartList(String uuid, String oldId) {
		String query = ns + ".selectTotCartList";
		
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("uuid", uuid);
		param.put("oldId", oldId);
		
		return ses.selectList(query, param);
	}

	@Override
	public int deleteOldCart(String uuid, String oldId) {
		
		String query = ns + ".deleteOldCart";
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("uuid", uuid);
		param.put("oldId", oldId);
		
		 return ses.delete(query, param);
	}

	@Override
	public void removeCartList(String cartOriginId, String member, String productNo) {
		
		String query = ns + ".deleteCartList";
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("productNo", productNo);
		param.put("customerType", member);
		param.put("cartId", cartOriginId);
		
		ses.delete(query, param);
		
		
	}

	@Override
	public int getCartOneList(String cartOriginId, String member, String pdNo) {
		
		String query = ns + ".selectOneCart";
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("productNo", pdNo);
		param.put("customerType", member);
		param.put("cartId", cartOriginId);
		
		return ses.selectOne(query, param);
	}

	

}
