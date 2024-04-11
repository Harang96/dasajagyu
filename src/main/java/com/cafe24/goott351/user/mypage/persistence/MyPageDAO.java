package com.cafe24.goott351.user.mypage.persistence;

import java.util.List;

import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.DeliveryDTO;
import com.cafe24.goott351.domain.MyPageReplyVO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.domain.OrderCSVO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.OrderVO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.domain.RegisterPointLog;
import com.cafe24.goott351.domain.ReplyVO;
import com.cafe24.goott351.domain.ServiceBoardVO;


public interface MyPageDAO {

	List<ProductVO> getWishList(String uuid) throws Exception;

	List<DeliveryDTO> selectDeliveryAddr(String uuid) throws Exception;

	int insertNewAddr(DeliveryDTO addr) throws Exception;

	DeliveryDTO selectModifyAddNo(int deliveryNo) throws Exception;

	int updateModifyDeliveryNewAddr(DeliveryDTO modifyAddr)throws Exception;

	int deleteModifyDeliveryNewAddr(DeliveryDTO deleteAddr)throws Exception;

	List<OrderVO> selectOreders(String uuid)throws Exception;

	List<OrderProductVO> selectOrderProduct(String orderNo)throws Exception;

	OrderBillingVO selectOrderBilling(String orderNo)throws Exception;

	OrderShippingDTO selectOrderShipping(String orderNo)throws Exception;
	
	int defaultModifyUpdateAddrN(String uuid)throws Exception;
  
	List<RegisterPointLog> selectPointLog(String uuid)throws Exception;

	void updateUserImg(String uuid, String userImg)throws Exception;

	void updateOrderStatus(String orderNo)throws Exception;

	List<AdminBoardDTO> selectListAll(String uuid, String nickname) throws Exception;

	List<MyPageReplyVO> selectReply(String uuid) throws Exception;

	int updatePwd(LoginCustomerVO login) throws Exception;

	int mobileUpdate(LoginCustomerVO login)throws Exception;

	int nicknameUpdate(LoginCustomerVO login) throws Exception;

	int bankUpdate(LoginCustomerVO login) throws Exception;

	String selectCsType(String orderNo) throws Exception;

	int agreeUpdate(LoginCustomerVO login) throws Exception;

	List<OrderCSVO> selectOrderCsList(String uuid) throws Exception;

	OrderProductVO selectCsProductInfo(int productNo, String orderNo) throws Exception;

	List<ServiceBoardVO> selectSvList(String uuid) throws Exception;

	OrderCSVO selectCsDetail(int csNo) throws Exception;

	String selectCsDetailImg(int csNo) throws Exception;

	LoginCustomerVO selectLoginCustomerInfo(String uuid) throws Exception;

	List<ProductQnAVO> selectPdQnAList(String uuid) throws Exception;

	int updatePdQnA(int svBNo) throws Exception;

	int duplicatePwd(LoginCustomerVO login) throws Exception;


		


}
 