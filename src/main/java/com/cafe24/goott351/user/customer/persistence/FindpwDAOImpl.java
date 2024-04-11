package com.cafe24.goott351.user.customer.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.FindPwDTO;

@Repository
public class FindpwDAOImpl implements FindpwDAO{

	String ns = "com.cafe24.goott351.mappers.customer.findCustomerInfoMapper";
	@Inject
	private SqlSession ses; // SqlSessionTemplate 객체 주입
	@Override
	public String selectUuid(String emailAuth) throws Exception{
		return ses.selectOne(ns+".selectuuid",emailAuth);
	}
	@Override
	public int updatePwd(FindPwDTO findpwdto) throws Exception{
		return ses.update(ns+".updatePw",findpwdto);
	}
	
	
	
	
	
	// j : 이메일이 DB에 있는지 확인
	@Override
	public Object selectEmail(String email) throws Exception {

		return ses.selectOne(ns + ".selectEmail", email);
	}

   
}
//	@Override
//	public int updatePw(FindpwDTO newpw) throws Exception {
	     
//		return ses.update(ns+".updatePw", newpw);
//	}
//
//	
//
//}

