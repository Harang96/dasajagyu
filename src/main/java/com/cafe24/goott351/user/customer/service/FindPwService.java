package com.cafe24.goott351.user.customer.service;

import com.cafe24.goott351.domain.FindPwDTO;

public interface FindPwService {
	

	int updatePwd(FindPwDTO FindpwDTO) throws Exception;

	String selectUuid(FindPwDTO emailAuth) throws Exception;

	// j : 이메일이 DB에 있는지 확인
	boolean checkEmailInDB(String email) throws Exception;

	
}

