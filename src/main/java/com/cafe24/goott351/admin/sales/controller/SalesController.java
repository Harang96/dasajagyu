package com.cafe24.goott351.admin.sales.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cafe24.goott351.admin.customer.service.AdminCustomerService;
import com.cafe24.goott351.admin.sales.service.SalesService;
import com.cafe24.goott351.domain.CustomerCntVO;
import com.cafe24.goott351.domain.SalesOrderCsVO;
import com.cafe24.goott351.user.order.service.OrderService;

@Controller
@RequestMapping("/admin/sales/*")
public class SalesController {
	@Inject 
	private SalesService sService;
	
	@Inject
	AdminCustomerService acService; 
	
	@Inject
	private OrderService oService;
	
	/**
	* @Method		: openSalesMain
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: String
	* @Description  : 매출 통계 메인 오픈
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	@RequestMapping(value="openSalesMain", method=RequestMethod.GET)
	public String openSalesMain(Model m) {
		LocalDate today = LocalDate.now();
		Map<String, Object> sales = new HashMap<String, Object>();
		Map<String, Object> netProfits = new HashMap<String, Object>();
		Map<String, Object> orderCs = new HashMap<String, Object>();
		
		try {
			// 총매출 뽑기
			sales = getSalesMap(today);
			
			// 순이익 뽑기
			netProfits = getNetProfitsMap(today);
			
			// 취소 목록 뽑기
			orderCs = sService.getOrderCsList(1);
			
			//회원 정보 뽑기
			CustomerCntVO csCntVo = acService.selectCustomerInfo();
			
			// 주문
			Map<String, Integer> orderSummary = oService.getOrderSummary();
			
			m.addAttribute("sales", sales);
			m.addAttribute("netProfits", netProfits);
			m.addAttribute("orderCs", orderCs.get("orderCs"));
			m.addAttribute("csInfo", csCntVo);
			m.addAttribute("orderSummary", orderSummary);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/sales/salesMain";
	}

	/**
	* @Method		: getSalesMap
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: Map<String,Object>
	* @Description  : 총매출 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	private Map<String, Object> getSalesMap(LocalDate today) throws Exception {
		Map<String, Object> sales = new HashMap<String, Object>();
		
		// 총매출
		int totalSales = sService.getTotalSales(); // 전체
		int daySales = getDaySales(today); // 일간
		int weekSales = getWeekSales(today); // 주간
		int monthSales = getMonthSales(today); // 월간
		int yearSales = getYearSales(today); // 연간
		
		sales.put("totalSales", totalSales);
		sales.put("daySales", daySales);
		sales.put("weekSales", weekSales);
		sales.put("monthSales", monthSales);
		sales.put("yearSales", yearSales);
		
		return sales;
	}

	private Map<String, Object> getNetProfitsMap(LocalDate today) throws Exception {
		Map<String, Object> netProfits = new HashMap<String, Object>();
		
		// 순이익
		int totalNetProfit = sService.getTotalNetProfit(); // 전체
		int dayNetProfit = getDayNetProfit(today); // 일간
		int weekNetProfit = getWeekNetProfit(today); // 주간
		int monthNetProfit = getMonthNetProfit(today); // 월간
		int yearNetProfit = getYearNetProfit(today); // 연간
		
		netProfits.put("totalNetProfit", totalNetProfit);
		netProfits.put("dayNetProfit", dayNetProfit);
		netProfits.put("weekNetProfit", weekNetProfit);
		netProfits.put("monthNetProfit", monthNetProfit);
		netProfits.put("yearNetProfit", yearNetProfit);
		
		return netProfits;
	}

	/**
	* @Method		: getDaySales
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: int
	* @Description  : 일별 총매출
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	private int getDaySales(LocalDate today) throws Exception {
		// 오늘
		String startOfDay = today.toString();
		
		// 내일
		String endOfDay = (today.plusDays(1)).toString();
		
        return sService.getPeriodSales(startOfDay, endOfDay);
	}

	/**
	* @Method		: getWeekSalesNow
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: int
	 * @throws Exception 
	* @Description  : 주간 총매출
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	private int getWeekSales(LocalDate today) throws Exception {
		// 이번 주의 시작(월)
		LocalDate startOfWeekL = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
		String startOfWeek = startOfWeekL.toString();
		
		// 이번 주의 끝(일)
        LocalDate endOfWeekL = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));
		String endOfWeek = (endOfWeekL.plusDays(1)).toString();
		
        return sService.getPeriodSales(startOfWeek, endOfWeek);
	}
	
	/**
	* @Method		: getMonthSalesNow
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: int
	* @Description  : 월간 총 매출
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	private int getMonthSales(LocalDate today) throws Exception {
		// 월의 시작일
        LocalDate startOfMonthL = today.withDayOfMonth(1);
        String startOfMonth = startOfMonthL.toString();
        
        // 월의 끝일
        LocalDate endOfMonthL = today.with(TemporalAdjusters.lastDayOfMonth());
        String endOfMonth = (endOfMonthL.plusDays(1)).toString();
    
		return sService.getPeriodSales(startOfMonth, endOfMonth);
	}

	/**
	* @Method		: getYearSalesNow
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: int
	* @Description  : 연간 총매출
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	private int getYearSales(LocalDate today) throws Exception {
		// 연의 시작일
        LocalDate startOfYearL = today.withDayOfYear(1);
        String startOfYear = startOfYearL.toString();
        
        // 연의 끝일
        LocalDate endOfYearL = today.with(TemporalAdjusters.lastDayOfYear());
        String endOfYear = (endOfYearL.plusDays(1)).toString();
    
		return sService.getPeriodSales(startOfYear, endOfYear);
	}
	
	/**
	* @Method		: getDayNetProfit
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: int
	* @Description  : 일간 순이익
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	private int getDayNetProfit(LocalDate today) throws Exception {
		// 오늘
		String startOfDay = today.toString();
		
		// 내일
		String endOfDay = (today.plusDays(1)).toString();
		
        return sService.getPeriodNetProfit(startOfDay, endOfDay);
	}
	
	/**
	* @Method		: getWeekNetProfit
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: int
	* @Description  : 주간 순이익
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	private int getWeekNetProfit(LocalDate today) throws Exception {
		// 이번 주의 시작(월)
		LocalDate startOfWeekL = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
		String startOfWeek = startOfWeekL.toString();
		
		// 이번 주의 끝(일)
        LocalDate endOfWeekL = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));
		String endOfWeek = (endOfWeekL.plusDays(1)).toString();
		
        return sService.getPeriodNetProfit(startOfWeek, endOfWeek);
	}
	
	/**
	* @Method		: getMonthNetProfit
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: int
	* @Description  : 월간 순이익
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	private int getMonthNetProfit(LocalDate today) throws Exception {
		// 월의 시작일
        LocalDate startOfMonthL = today.withDayOfMonth(1);
        String startOfMonth = startOfMonthL.toString();
        
        // 월의 끝일
        LocalDate endOfMonthL = today.with(TemporalAdjusters.lastDayOfMonth());
        String endOfMonth = (endOfMonthL.plusDays(1)).toString();
		
        return sService.getPeriodNetProfit(startOfMonth, endOfMonth);
	}
	
	/**
	* @Method		: getYearNetProfit
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: int
	* @Description  : 연간 순이익
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	private int getYearNetProfit(LocalDate today) throws Exception {
		// 연의 시작일
        LocalDate startOfYearL = today.withDayOfYear(1);
        String startOfYear = startOfYearL.toString();
        
        // 연의 끝일
        LocalDate endOfYearL = today.with(TemporalAdjusters.lastDayOfYear());
        String endOfYear = (endOfYearL.plusDays(1)).toString();
		
        return sService.getPeriodNetProfit(startOfYear, endOfYear);
	}
	
	/**
	* @Method		: getSalesGraphInfo
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: ResponseEntity<List<Integer>>
	* @Description  : 해당 연도의 월별 매출 리스트
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.15        Jooyoung Lee       
	*/
	@RequestMapping(value="getSalesGraphInfo", method=RequestMethod.GET)
	private ResponseEntity<Map<String, Object>> getSalesGraphInfo(@RequestParam("year") int year) {
		ResponseEntity<Map<String, Object>> result = null;

		List<Integer> salesList = new ArrayList<Integer>();
		List<Integer> netProfitsList = new ArrayList<Integer>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			for (int m = 1; m < 13; m++) {
				String start = year + "-" + m + "-" + "1";
				String end = year + "-" + (m + 1) + "-" + "1";
				
				// 매출
				int tmpSales = 0;
				if (sService.getPeriodSales(start, end) >= 0) {
					tmpSales = (sService.getPeriodSales(start, end) / 10000);
				}
						
				salesList.add(tmpSales);
				
				// 순이익
				int tmpNetProfits = 0;
				if (sService.getPeriodNetProfit(start, end) >= 0) {
					tmpNetProfits = (sService.getPeriodNetProfit(start, end) / 10000);
				}
				
				netProfitsList.add(-tmpNetProfits);
			}
			
			// 연간 매출과 연간 이익
			String thisYearStr = year + "-01-01";
			LocalDate thisYear = LocalDate.parse(thisYearStr);
			int sales = getYearSales(thisYear);
			int netProfits = getYearNetProfit(thisYear);

			map.put("salesList", salesList);
			map.put("netProfitsList", netProfitsList);
			map.put("sales", sales);
			map.put("netProfits", netProfits);
			
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.FORBIDDEN);
		}
	
		
		return result;
	}
	
	/**
	* @Method		: getDaySales
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: ResponseEntity<Integer>
	* @Description  : 날짜별 일간 매출 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.17        Jooyoung Lee       
	*/
	@RequestMapping(value="getDaySales", method=RequestMethod.GET)
	public ResponseEntity<Integer> getDaySales(@RequestParam("day") String day) {
		ResponseEntity<Integer> result = null;
		LocalDate today = LocalDate.parse(day);
		
		try {
			int sales = getDaySales(today);
			result = new ResponseEntity<Integer>(sales, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	* @Method		: getDayNetProfit
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: ResponseEntity<Integer>
	* @Description  : 날짜별 순이익 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.17        Jooyoung Lee       
	*/
	@RequestMapping(value="getDayNetProfit", method=RequestMethod.GET)
	public ResponseEntity<Integer> getDayNetProfit(@RequestParam("day") String day) {
		ResponseEntity<Integer> result = null;
		LocalDate today = LocalDate.parse(day);
		
		try {
			int netProfit = getDayNetProfit(today);
			result = new ResponseEntity<Integer>(netProfit, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	* @Method		: getWeekSales
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: ResponseEntity<Integer>
	* @Description  : 주간 매출 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.18        Jooyoung Lee       
	*/
	@RequestMapping(value="getWeekSales", method=RequestMethod.GET)
	public ResponseEntity<Integer> getWeekSales(@RequestParam("day") String day) {
		ResponseEntity<Integer> result = null;
		LocalDate today = LocalDate.parse(day);
		
		try {
			int sales = getWeekSales(today);
			result = new ResponseEntity<Integer>(sales, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	* @Method		: getWeekNetProfit
	* @PackageName  : com.cafe24.goott351.admin.sales.controller
	* @return		: ResponseEntity<Integer>
	* @Description  : 주간 순이익 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.18        Jooyoung Lee       
	*/
	@RequestMapping(value="getWeekNetProfit", method=RequestMethod.GET)
	public ResponseEntity<Integer> getWeekNetProfit(@RequestParam("day") String day) {
		ResponseEntity<Integer> result = null;
		LocalDate today = LocalDate.parse(day);
		
		try {
			int netProfit = getWeekNetProfit(today);
			result = new ResponseEntity<Integer>(netProfit, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value="getOrderCsListByPageNo", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getOrderCsListByPageNo(@RequestParam("pageNo") int pageNo) {
		ResponseEntity<Map<String, Object>> result = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			map = sService.getOrderCsList(pageNo);
			
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.FORBIDDEN);
		}
		
		return result;
	}
}
