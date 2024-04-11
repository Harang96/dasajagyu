package com.cafe24.goott351.admin.customer.service;

import java.util.List;
import java.util.Map;

import com.cafe24.goott351.domain.CustomerCntVO;
import com.cafe24.goott351.domain.CustomerSearchDTO;

public interface AdminCustomerService {

	Map<String, Object> selectAllCustomer(int pageNo, int pageProductCnt, CustomerSearchDTO csDto) throws Exception;

	void updateUserInfo(String uuid, String nickname, String isAdmin) throws Exception;

	void updateUserPoint(int point, List<String> userList) throws Exception;

	void deleteCustomer(String email, String reason) throws Exception;

	void resetCustomerPwd(String email, String rndPwd) throws Exception;

	CustomerCntVO selectCustomerInfo() throws Exception;

	

}
