package com.cafe24.goott351.user.customer.service;


import com.cafe24.goott351.domain.FindIdVO;

public interface FindIdService {
 
	void certifiedPhoneNumber(String userPhoneNumber, int randomNumber);

	FindIdVO selectName(String phoneNumber, String name) throws Exception;

	
}
