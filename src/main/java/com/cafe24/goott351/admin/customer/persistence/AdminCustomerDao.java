package com.cafe24.goott351.admin.customer.persistence;

import java.util.List;
import java.util.Map;

import com.cafe24.goott351.domain.CustomerCntVO;
import com.cafe24.goott351.domain.CustomerSearchDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.ProductPagingVO;

public interface AdminCustomerDao {

	List<LoginCustomerVO> getAllCustomer(ProductPagingVO pagingVo, CustomerSearchDTO csDto) throws Exception;

	int getTotalCustomerCntBySearch(CustomerSearchDTO csDto) throws Exception;

	CustomerCntVO getCustomerCnt() throws Exception;

	void updateUserInfo(String uuid, String nickname, String isAdmin) throws Exception;

	void updateUserPoint(int point, List<String> userList) throws Exception;

	void insertUserPointLog(int point, List<String> userList) throws Exception;

	void insertDrawLog(String email, String reason) throws Exception;

	void deletCustomerInfo(String email) throws Exception;

	void resetCustomerPwd(String email, String rndPwd)throws Exception;

}
