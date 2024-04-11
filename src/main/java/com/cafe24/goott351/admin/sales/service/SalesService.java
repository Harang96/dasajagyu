package com.cafe24.goott351.admin.sales.service;

import java.util.Map;

import com.cafe24.goott351.domain.SalesOrderCsVO;

public interface SalesService {

	// 전체 기간 총매출 가져오기
	int getTotalSales() throws Exception;

	// 기간별 총매출 가져오기
	int getPeriodSales(String startOfWeek, String endOfWeek) throws Exception;

	// 전체 기간 순이익 가져오기
	int getTotalNetProfit() throws Exception;

	// 기간별 순이익 가져오기
	int getPeriodNetProfit(String startOfDay, String endOfDay) throws Exception;

	// 취소 목록 가져오기
	Map<String, Object> getOrderCsList(int pageNo) throws Exception;

}
