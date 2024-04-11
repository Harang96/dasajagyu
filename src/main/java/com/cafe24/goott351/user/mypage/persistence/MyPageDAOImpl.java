package com.cafe24.goott351.user.mypage.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.DeliveryDTO;
import com.cafe24.goott351.domain.MyPageReplyVO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.LoginDTO;
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

@Repository
public class MyPageDAOImpl implements MyPageDAO {
	
	@Inject
	private SqlSession ses;
	private static String ns = "com.cafe24.goott351.mappers.mypageMapper";
	
	
	@Override
	public List<ProductVO> getWishList(String uuid) throws Exception {
		
		String query = ns + ".selectWishProducts";
		
		return ses.selectList(query, uuid);
	}


	@Override
	public List<DeliveryDTO> selectDeliveryAddr(String uuid) throws Exception {
		
		
		return ses.selectList(ns + ".selectDeliveryAddr", uuid);
	}


	@Override
	public int insertNewAddr(DeliveryDTO addr) throws Exception {
		
		
		return ses.insert(ns + ".insertAddr", addr);
		
	}


	@Override
	public DeliveryDTO selectModifyAddNo(int deliveryNo) throws Exception {
		System.out.println("여기까지도 오는지 확인한번 해볼게요");
		
		return ses.selectOne(ns + ".selectDeliveryNoAddr", deliveryNo);
	}

	@Override
	public int updateModifyDeliveryNewAddr(DeliveryDTO modifyAddr) throws Exception {
		
		
		return ses.update(ns+ ".updateModifyDeliveryAddr", modifyAddr);
	}

	@Override
	public int deleteModifyDeliveryNewAddr(DeliveryDTO deleteAddr) throws Exception {
		// TODO Auto-generated method stub
		return ses.delete(ns+ ".deleteModifyDeliveryAddr", deleteAddr);
	}

	@Override
	public List<OrderVO> selectOreders(String uuid) throws Exception {
		
		String query = ns + ".selectOreders";
		
		
		return ses.selectList(query, uuid);
	}

	@Override
	public List<OrderProductVO> selectOrderProduct(String orderNo) throws Exception {
		
		String query = ns + ".selectOrderProduct";
		
		return ses.selectList(query, orderNo);
	}

	@Override
	public OrderBillingVO selectOrderBilling(String orderNo)throws Exception {
		
		String query = ns + ".selectOrderBilling";
		
		return ses.selectOne(query, orderNo);
	}

	@Override
	public OrderShippingDTO selectOrderShipping(String orderNo) throws Exception {
		
		String query = ns + ".selectOrderShipping";
		
		return ses.selectOne(query, orderNo);
	}
	


	@Override
	public int defaultModifyUpdateAddrN(String uuid) throws Exception {
		
		return ses.update(ns + ".updateDefaultModifyAddrN", uuid);
	}




	@Override
	public List<RegisterPointLog> selectPointLog(String uuid) throws Exception {

		String query = ns + ".selectPointLog";
		
		
		return ses.selectList(query, uuid);
	}


	@Override
	public void updateUserImg(String uuid, String userImg) throws Exception{
			
		String query = ns + ".updateUserImg";
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uuid", uuid);
		param.put("userImg", userImg);
		
		ses.update(query, param);
	}


	@Override
	public void updateOrderStatus(String orderNo) throws Exception {

		String query = ns + ".updateOrderStatus";
		
		ses.update(query, orderNo);
	}


	@Override
	public List<AdminBoardDTO> selectListAll(String nickname, String uuid) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		map.put("nickname", nickname);
//		System.out.println("map " + map);
		
		return ses.selectList(ns + ".selectListAll", map);
	}


	@Override
	public List<MyPageReplyVO> selectReply(String uuid) throws Exception {
		
		System.out.println(ses.selectList(ns + ".selectReply", uuid));
		return ses.selectList(ns + ".selectReply", uuid);
	}


	@Override
	public int updatePwd(LoginCustomerVO login) throws Exception {
		
		return ses.update(ns + ".pwdUpdate", login);
	}


	@Override
	public int mobileUpdate(LoginCustomerVO login) throws Exception {
		
		return ses.update(ns + ".mobileUpdate", login);
	}


	@Override
	public int nicknameUpdate(LoginCustomerVO login) throws Exception {
		
		return ses.update(ns + ".nicknameUpdate", login);
	}


	@Override
	public int bankUpdate(LoginCustomerVO login) throws Exception {
		
		return ses.update(ns + ".bankUpdate", login);
		
	}


	@Override
	public String selectCsType(String orderNo) throws Exception {
		
		String query = ns + ".selectCsType";
		
		return ses.selectOne(query, orderNo);
	}


	@Override
	public int agreeUpdate(LoginCustomerVO login) throws Exception {
		
		return ses.update(ns + ".agreeUpdate", login);
	}


	@Override
	public List<OrderCSVO> selectOrderCsList(String uuid) throws Exception{

		String query = ns + ".selectOrderCsList";
		
		return ses.selectList(query, uuid);
	}


	@Override
	public OrderProductVO selectCsProductInfo(int productNo, String orderNo) throws Exception {
		
		String query = ns + ".selectCsProductInfo";
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("productNo", productNo);
		param.put("orderNo", orderNo);
		
		return ses.selectOne(query, param);
	}


	@Override
	public List<ServiceBoardVO> selectSvList(String uuid) throws Exception {
		
		String query = ns + ".selectSvList";
		
		return ses.selectList(query, uuid);
	}


	@Override
	public OrderCSVO selectCsDetail(int csNo) throws Exception {

		String query = ns + ".selectCsDetail";
		
		
		return ses.selectOne(query, csNo);
	}


	@Override
	public String selectCsDetailImg(int csNo) throws Exception {
		
		String query = ns + ".selectCsDetailImg";
		
		return ses.selectOne(query, csNo);
	}


	@Override
	public LoginCustomerVO selectLoginCustomerInfo(String uuid) throws Exception {
		
		String query = ns + ".selectLoginCustomerInfo";
		
		return ses.selectOne(query, uuid);
	}


	@Override
	public List<ProductQnAVO> selectPdQnAList(String uuid) throws Exception {
		
		String query = ns + ".selectPdQnAList";
		
		return ses.selectList(query, uuid);
	}


	@Override
	public int updatePdQnA(int svBNo) throws Exception {

		String query = ns + ".updatePdQnA";
		
		return ses.update(query, svBNo);
	}


	@Override
	public int duplicatePwd(LoginCustomerVO login) throws Exception {
		System.out.println("여기까지 와요?");
		return ses.selectOne(ns + ".duplicatePwd", login);
	}




}
