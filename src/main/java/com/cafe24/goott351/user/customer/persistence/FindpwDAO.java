package com.cafe24.goott351.user.customer.persistence;

import com.cafe24.goott351.domain.FindPwDTO;

// @Repository
public interface FindpwDAO {

	int updatePwd(FindPwDTO findpwdto) throws Exception;

	String selectUuid(String emailAuth) throws Exception;

	
	// j : 이메일이 DB에 있는지 확인
	Object selectEmail(String email) throws Exception;


		
}