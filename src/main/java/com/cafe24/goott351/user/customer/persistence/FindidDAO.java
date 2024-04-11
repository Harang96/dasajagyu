package com.cafe24.goott351.user.customer.persistence;

import java.util.List;


import com.cafe24.goott351.domain.FindIdVO;


public interface FindidDAO  {
	
	FindIdVO selectName(String name, String phoneNumber) throws Exception;


	
	
}
