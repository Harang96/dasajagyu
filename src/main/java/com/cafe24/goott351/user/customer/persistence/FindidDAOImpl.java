package com.cafe24.goott351.user.customer.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;


import com.cafe24.goott351.domain.FindIdVO;

@Repository
public class FindidDAOImpl implements FindidDAO{
	
	String ns = "com.cafe24.goott351.mappers.customer.findCustomerInfoMapper";
	
	@Inject
	private SqlSession ses;
	
	@Override
	public FindIdVO selectName(String phoneNumber, String name) throws Exception {
		Map<String, String> param = new HashMap<String, String>();
		param.put("name", name);
		param.put("phoneNumber", phoneNumber);
		System.out.println(param);
		
		FindIdVO find =  ses.selectOne(ns+".selectName", param);
		System.out.println(find);
		return find;
	}

}
