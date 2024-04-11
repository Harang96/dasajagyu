package com.cafe24.goott351.admin.sales.persistence;

import java.util.List;

import com.cafe24.goott351.domain.SalesOrderCsVO;

public interface SalesDAO {

	// 전체 기간 총매출 가져오기
	int selectTotalSales() throws Exception;

	// 기간별 총매출 가져오기
	int selectPeriodSales(String start, String end) throws Exception;

	// 전체 기간 순이익 가져오기
	int selectTotalNetProfit() throws Exception;

	// 기간별 순이익 가져오기
	int selectPeriodNetProfit(String start, String end) throws Exception;

	// 취소 목록 가져오기
	List<SalesOrderCsVO> selectOrderCsList() throws Exception;

	// 전체 글의 개수 가져오기
	int selectCountOfCs(int pageNo) throws Exception;

}
