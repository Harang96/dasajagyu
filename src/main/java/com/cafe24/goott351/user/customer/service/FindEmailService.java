package com.cafe24.goott351.user.customer.service;

import com.cafe24.goott351.domain.FindPwDTO;

public interface FindEmailService {

	
	String selectUuid(FindPwDTO emailAuth) throws Exception;
	
}
