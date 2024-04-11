package com.cafe24.goott351.user.order.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.Base64ImgDTO;

@Repository
public class CSDAOImpl implements CSDAO {
	
	@Inject
	private SqlSession ses;
	
	private String ns = "com.cafe24.goott351.mappers.orderCSMapper";

	@Override
	public int insertCSImages(List<Base64ImgDTO> list) {
		return ses.insert(ns+".insertCSImages", list);
	}

	@Override
	public int insertOrderCS(String orderNo, String csType, int productNo, int quantity, String reasonType, String reason, String isAdmin) {
		Map<String, Object> param = new HashMap<>();
		param.put("orderNo", orderNo);
		param.put("csType", csType);
		param.put("productNo", productNo);
		param.put("quantity", quantity);
		param.put("reasonType", reasonType);
		param.put("reason", reason);
		param.put("isAdmin", isAdmin);
		
		return ses.insert(ns+".insertOrderCS", param);
	}

	@Override
	public String selectOrderUUID(String orderNo) {
		return ses.selectOne(ns+".selectOrderUUID", orderNo);
	}

}




 