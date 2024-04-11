package com.cafe24.goott351.admin.sales.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafe24.goott351.admin.sales.persistence.SalesDAO;
import com.cafe24.goott351.domain.PageSearchDTO;
import com.cafe24.goott351.domain.SalesOrderCsVO;
import com.cafe24.goott351.util.SbPagingInfo;

@Service
public class SalesServiceImpl implements SalesService {
	@Inject
	private SalesDAO sDao;

	/**
	* @Method		: getTotalSales
	* @PackageName  : com.cafe24.goott351.admin.sales.service
	* @Description  : 전체 기간 총매출 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	@Override
	public int getTotalSales() throws Exception {

		return sDao.selectTotalSales();
	}

	/**
	* @Method		: getWeekSales
	* @PackageName  : com.cafe24.goott351.admin.sales.service
	* @Description  : 기간별 총매출 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	@Override
	public int getPeriodSales(String start, String end) throws Exception {

		return sDao.selectPeriodSales(start, end);
	}

	
	/**
	* @Method		: getTotalNetProfit
	* @PackageName  : com.cafe24.goott351.admin.sales.service
	* @Description  : 전체 기간 순이익 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	@Override
	public int getTotalNetProfit() throws Exception {

		return sDao.selectTotalNetProfit();
	}
	
	/**
	* @Method		: getPeriodNetProfit
	* @PackageName  : com.cafe24.goott351.admin.sales.service
	* @Description  : 기간별 순이익 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	@Override
	public int getPeriodNetProfit(String start, String end) throws Exception {

		return sDao.selectPeriodNetProfit(start, end);
	}

	/**
	* @Method		: getOrderCsList
	* @PackageName  : com.cafe24.goott351.admin.sales.service
	* @Description  : 취소 목록 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.18        Jooyoung Lee       
	*/
	@Override
	public Map<String, Object> getOrderCsList(int pageNo) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<SalesOrderCsVO> list = sDao.selectOrderCsList();
		SbPagingInfo pi = getPagingInfo(pageNo);
		
		result.put("orderCs", list);
		result.put("orderCsPi", pi);

		return result;
	}
	
	private SbPagingInfo getPagingInfo(int pageNo) throws Exception {
		SbPagingInfo pi = new SbPagingInfo();
		
		// 전체 글의 개수
		int totalPostCnt = sDao.selectCountOfCs(pageNo); 
		
		pi.setAttribute(totalPostCnt, pageNo, 15);
		System.out.println(pi);
		
		return pi;
	}

}
