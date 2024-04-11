package com.cafe24.goott351.user.mypage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.DeliveryDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.MyPageOrderVO;
import com.cafe24.goott351.domain.MyPageReplyVO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.domain.OrderCSVO;
import com.cafe24.goott351.domain.OrderProductDTO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.OrderVO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.domain.RegisterPointLog;
import com.cafe24.goott351.domain.ReplyVO;
import com.cafe24.goott351.domain.ServiceBoardVO;
import com.cafe24.goott351.user.mypage.persistence.MyPageDAO;

@Service
public class MyPageServiceImpl implements MyPageService {
	
	
	@Inject
	MyPageDAO mpDao;

	@Override
	public Map<String, Object> getWishList(String uuid) throws Exception {

		Map<String, Object> wishListMap = new HashMap<String, Object>();
		List<ProductVO> wishProduct = mpDao.getWishList(uuid);
		
		wishListMap.put("wishProduct", wishProduct);
		
		return wishListMap;
	}
	
	@Override
	public Map<String, Object> getMyPageInfo(String uuid) throws Exception {
		
		List<MyPageOrderVO> orderList = new ArrayList<MyPageOrderVO>();
		List<OrderVO> orderVoList = mpDao.selectOreders(uuid);
		for(OrderVO ov : orderVoList) {
			OrderBillingVO obVo = mpDao.selectOrderBilling(ov.getOrderNo());
			String csType = mpDao.selectCsType(ov.getOrderNo());
			MyPageOrderVO mpOv = new MyPageOrderVO();
			mpOv.setCsType(csType);
			mpOv.setOrderVo(ov);
			mpOv.setOrderBillingVo(obVo);
			orderList.add(mpOv);
			}
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("orderList", orderList);
		
		return map;
	}

	@Override
	public Map<String, Object> getDetailOrder(String orderNo) throws Exception {

		List<OrderProductVO> opList = mpDao.selectOrderProduct(orderNo);
		OrderShippingDTO osDto = mpDao.selectOrderShipping(orderNo);
		OrderBillingVO obVo = mpDao.selectOrderBilling(orderNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("opList", opList);
		map.put("osDto", osDto);
		map.put("oBill", obVo);
		
		
		return map;
	}
	
	@Override
	public Map<String, Object> getPointLog(String uuid) throws Exception {
		
		List<RegisterPointLog> pointList = mpDao.selectPointLog(uuid);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("pointList", pointList);
		return map;
	}
	
	@Override
	   public List<DeliveryDTO> selectAddr(String uuid) throws Exception {
	      List<DeliveryDTO> dList = null;
	      if (mpDao.selectDeliveryAddr(uuid) != null) {
	         dList = mpDao.selectDeliveryAddr(uuid);
	      } 
	      return dList;
	      
	   }

	   @Override
	   @Transactional(rollbackFor = Exception.class)
	   public int deliverySaveAddr(DeliveryDTO addr)throws Exception {
	      
	      System.out.println(addr.toString() + "여기 까지오는지 확인해볼게요");
	      
	      int result = -1;
	      
	      result = mpDao.insertNewAddr(addr);
	      
	      
	      return result;
	   }

	   @Override
	   public DeliveryDTO modifyAddrNo(int deliveryNo) throws Exception {
	      
	   System.out.println(deliveryNo + "여기 까지오는지 확인해볼게요");
	      
	      DeliveryDTO result = null;
	      
	      result = mpDao.selectModifyAddNo(deliveryNo);

	      return result;
	      
	   }

	   @Override
	   public int modifyDeliveryUpdateAddr(DeliveryDTO modifyAddr) throws Exception {
	      
	      System.out.println(modifyAddr.toString() + "여기 까지오는지 확인해볼게요");
	      
	      int result = -1;
	      
	      result = mpDao.updateModifyDeliveryNewAddr(modifyAddr);
	      System.out.println(result + "제발~~~~");
	      
	      
	      return result;   
	      
	      
	   }
	   
	   @Override
		public int defaultAddrNupdate(String uuid) throws Exception {
			
			int result = -1;
		      
		     
			result = mpDao.defaultModifyUpdateAddrN(uuid);
		      
		      
		     return result;
				
		}
	   

	   @Override
	   public int modifyDeliveryDeleteAddr(DeliveryDTO deleteAddr) throws Exception {
	      System.out.println(deleteAddr.toString() + "여기 까지오는지 확인해볼게요");
	      
	      int result = -1;
	      
	      result = mpDao.deleteModifyDeliveryNewAddr(deleteAddr);
	      
	      
	      return result;
	   }

	@Override
	public List<AdminBoardDTO> getListAll(String uuid, String nickname) throws Exception {
		List<AdminBoardDTO> lst = mpDao.selectListAll(uuid, nickname);
		
		System.out.println("serviceImpl  getListAll " + lst);
		return lst;
		
	}

    @Override
    public void updateUserImg(String uuid, String userImg) throws Exception {

      mpDao.updateUserImg(uuid, userImg);
    }


    @Override
    public void updateOrderStatus(String orderNo) throws Exception {

      mpDao.updateOrderStatus(orderNo);

    }

	@Override
	public int pwdUpdate(LoginCustomerVO login) throws Exception {
		int result = -1;
		
		result = mpDao.updatePwd(login);
		 
		 return result;
	}

	@Override
	public int mobileUpdate(LoginCustomerVO login) throws Exception {
		int result = -1;
		
		mpDao.mobileUpdate(login);
		 
		 return result;
	}

	@Override
	public int nicknameUpdate(LoginCustomerVO login) throws Exception {
		int result = -1;
		
		mpDao.nicknameUpdate(login);
		 
		 return result;
	}

	@Override
	public int bankUpdate(LoginCustomerVO login) throws Exception {
		int result = -1;
		
		mpDao.bankUpdate(login);
		 
		return result;
	}



	@Override
	public List<MyPageReplyVO> getreply(String uuid) throws Exception {
		List<MyPageReplyVO> lst = mpDao.selectReply(uuid);
		
		System.out.println("serviceImpl  getreply " + lst);
		return lst;
	}

	@Override
	public int agreeUpdate(LoginCustomerVO login) throws Exception {
		
		int result = -1;
		
		mpDao.agreeUpdate(login);
		 
		return result;
	}

	@Override
	public List<Map<String, Object>> getCsList(String uuid) throws Exception {
		
		List<Map<String, Object>> csList = new ArrayList<Map<String,Object>>();
		
		List<OrderCSVO> oCsVoList = mpDao.selectOrderCsList(uuid);
		if(oCsVoList.size() > 0) {
			System.out.println("cs리스트 있음");
			for(OrderCSVO oCsVo : oCsVoList) {
				Map<String, Object> map = new HashMap<String, Object>();
				OrderProductVO oPdVo = mpDao.selectCsProductInfo(oCsVo.getProductNo(), oCsVo.getOrderNo());
				map.put("oCsVo", oCsVo);
				map.put("oPdVo", oPdVo);
				csList.add(map);
			}
			
		} else {
			System.out.println("cs리스트 없음");
		}
		
		
		return csList;
	}

	@Override
	public List<ServiceBoardVO> getSvList(String uuid) throws Exception {

		List<ServiceBoardVO> svList = mpDao.selectSvList(uuid);
		
		return svList;
	}

	@Override
	public Map<String, Object> getCsDetail(int csNo) throws Exception {
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		OrderCSVO oCsVo = mpDao.selectCsDetail(csNo);
		String csImg = mpDao.selectCsDetailImg(csNo);
		
		map.put("csInfo", oCsVo);
		map.put("csImg", csImg);
		
		
		return map;
	}

	@Override
	public LoginCustomerVO getLoginCustomerInfo(String uuid) throws Exception {

		LoginCustomerVO loginCustomer = mpDao.selectLoginCustomerInfo(uuid);
		
		return loginCustomer;
	}

	@Override
	public List<ProductQnAVO> getPdQnAList(String uuid) throws Exception {

		List<ProductQnAVO> pdQnAList = mpDao.selectPdQnAList(uuid);
		
		return pdQnAList;
	}

	@Override
	public String delPdQnA(int svBNo) throws Exception {
		
		int daoResult = -1;
		String result = "fail";
		
		daoResult = mpDao.updatePdQnA(svBNo);
		
		if(daoResult != -1) {
			result = "success";
		}
		
		
		return result;
	}

	@Override
	public int duplicatePwd(LoginCustomerVO login) throws Exception {
		
		int result = mpDao.duplicatePwd(login);
				
		return result;
		
	}
	

}
