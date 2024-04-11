package com.cafe24.goott351.user.mypage.service;

import java.util.List;
import java.util.Map;

import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.DeliveryDTO;
import com.cafe24.goott351.domain.MyPageReplyVO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.ReplyVO;
import com.cafe24.goott351.domain.ServiceBoardVO;
import com.cafe24.goott351.domain.LoginCustomerVO;

public interface MyPageService {

	Map<String, Object> getWishList(String uuid) throws Exception;

	List<DeliveryDTO> selectAddr(String uuid) throws Exception;

	int deliverySaveAddr(DeliveryDTO addr) throws Exception;

	DeliveryDTO modifyAddrNo(int deliveryNo) throws Exception;

	int modifyDeliveryUpdateAddr(DeliveryDTO modifyAddr) throws Exception;

	int modifyDeliveryDeleteAddr(DeliveryDTO deleteAddr) throws Exception;

	List<AdminBoardDTO> getListAll(String uuid,String nickname) throws Exception;
	
	Map<String, Object> getMyPageInfo(String uuid) throws Exception;

	Map<String, Object> getDetailOrder(String orderNo) throws Exception;
		
	int defaultAddrNupdate(String uuid)throws Exception;

	int pwdUpdate(LoginCustomerVO login) throws Exception;

	int mobileUpdate(LoginCustomerVO login)throws Exception;

	int nicknameUpdate(LoginCustomerVO login) throws Exception;

	int bankUpdate(LoginCustomerVO login) throws Exception;

	int agreeUpdate(LoginCustomerVO login) throws Exception;

	Map<String, Object> getPointLog(String uuid) throws Exception;

	void updateUserImg(String uuid, String userImg) throws Exception;

	void updateOrderStatus(String orderNo) throws Exception;

	List<MyPageReplyVO> getreply(String uuid) throws Exception;
	
	List<Map<String, Object>> getCsList(String uuid) throws Exception;

	List<ServiceBoardVO> getSvList(String uuid) throws Exception;

	Map<String, Object> getCsDetail(int csNo) throws Exception;

	LoginCustomerVO getLoginCustomerInfo(String uuid) throws Exception;

	List<ProductQnAVO> getPdQnAList(String uuid) throws Exception;

	String delPdQnA(int svBNo) throws Exception;

	int duplicatePwd(LoginCustomerVO login) throws Exception;

}
