package com.cafe24.goott351.admin.sales.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.SalesOrderCsVO;

@Repository
public class SalesDAOImpl implements SalesDAO {
	private String ns = "com.cafe24.goott351.mappers.salesMapper";

	@Inject 
	private SqlSession ses;

	// 전체 기간 총매출 가져오기
	@Override
	public int selectTotalSales() throws Exception {
		int result = 0;
		
		if (ses.selectOne(ns + ".selectTotalSales") != null) {
			result = ses.selectOne(ns + ".selectTotalSales");
		}
		
		return ses.selectOne(ns + ".selectTotalSales");
	}

	// 기간별 총매출 가져오기
	@Override
	public int selectPeriodSales(String start, String end) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("start", start);
		param.put("end", end);
		
		int result = 0;
		
		if (ses.selectOne(ns + ".selectPeriodSales", param) != null) {
			result = ses.selectOne(ns + ".selectPeriodSales", param);
		}
		
		return result;
	}

	// 전체 기간 순이익 가져오기
	@Override
	public int selectTotalNetProfit() throws Exception {
		int result = 0;
		
		if (ses.selectOne(ns + ".selectTotalNetProfit") != null) {
			result = ses.selectOne(ns + ".selectTotalNetProfit");
		}
		
		return result;
	}

	// 기간별 순이익 가져오기
	@Override
	public int selectPeriodNetProfit(String start, String end) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("start", start);
		param.put("end", end);

		int result = 0;
		
		if (ses.selectOne(ns + ".selectPeriodNetProfit", param) != null) {
			result = ses.selectOne(ns + ".selectPeriodNetProfit", param);
		}
		
		return result;
	}

	// 취소 목록 가져오기
	@Override
	public List<SalesOrderCsVO> selectOrderCsList() throws Exception {

		return ses.selectList(ns + ".selectOrderCsList");
	}

	@Override
	public int selectCountOfCs(int pageNo) throws Exception {
		int result = 0;
		
		if (ses.selectOne(ns + ".selectCountOfCs", pageNo) != null) {
			result = ses.selectOne(ns + ".selectCountOfCs", pageNo);
		}
	
		return result;
	}
}
