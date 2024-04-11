package com.cafe24.goott351.admin.customer.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafe24.goott351.admin.customer.persistence.AdminCustomerDao;
import com.cafe24.goott351.domain.CustomerCntVO;
import com.cafe24.goott351.domain.CustomerSearchDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.ProductPagingVO;

@Service
public class AdminCustomerServiceImpl implements AdminCustomerService {

	
	@Inject
	AdminCustomerDao acDao;

	@Override
	public Map<String, Object> selectAllCustomer(int pageNo, int pageProductCnt, CustomerSearchDTO csDto) throws Exception {
		Map<String, Object> customerMap = new HashMap<>();
		
		System.out.println(csDto);
		
		ProductPagingVO pagingVo = getPagingInfo(pageNo, pageProductCnt, csDto);
		List<LoginCustomerVO> customerList = acDao.getAllCustomer(pagingVo, csDto);
		
		
		customerMap.put("pagingInfo", pagingVo);
		customerMap.put("customerList", customerList);
		
		
		
		
		return customerMap;
		
	}
	
	@Override
	public CustomerCntVO selectCustomerInfo() throws Exception{
		
		CustomerCntVO csCntVo = acDao.getCustomerCnt();
		
		return csCntVo;
	}

	private ProductPagingVO getPagingInfo(int pageNo, int pageProductCnt, CustomerSearchDTO csDto) throws Exception{
		ProductPagingVO vo = new ProductPagingVO();
		vo.setPageNo(pageNo);
		
		vo.setPageProductCnt(pageProductCnt);	

		vo.setTotalProductCnt(acDao.getTotalCustomerCntBySearch(csDto));
		// 총 페이지수
		vo.setTotalPageCnt(vo.getTotalProductCnt(), vo.getPageProductCnt());
		// 보이기 시작할 번호
		vo.setStartRowIndex();
		// 전체 페이징 블럭 갯수	
		vo.setTotalPagingBlock();
		// 현재 페이징 블럭
		vo.setCurrentPageBlock();
		// 현재 페이징 시작 번호
		vo.setStartPageNum();
		// 현재 페이징 마지막 번호
		vo.setEndPageNum();
		
		return vo;
	}

	@Override
	public void updateUserInfo(String uuid, String nickname, String isAdmin) throws Exception {
		
		acDao.updateUserInfo(uuid, nickname, isAdmin);
		
	}

	@Override
	public void updateUserPoint(int point, List<String> userList) throws Exception {

		acDao.updateUserPoint(point, userList);
		acDao.insertUserPointLog(point, userList);
		
	}

	@Override
	public void deleteCustomer(String email, String reason) throws Exception {
		
		acDao.insertDrawLog(email, reason);
		acDao.deletCustomerInfo(email);
		
		
		
	}

	@Override
	public void resetCustomerPwd(String email, String rndPwd) throws Exception{

		acDao.resetCustomerPwd(email, rndPwd);
	}
	
	
	
}
