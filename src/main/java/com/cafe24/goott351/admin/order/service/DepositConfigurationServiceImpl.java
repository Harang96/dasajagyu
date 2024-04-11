/**
 * 
 */
package com.cafe24.goott351.admin.order.service;

import javax.inject.Inject;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;

import com.cafe24.goott351.admin.order.persistence.OrderAdminDAO;
import com.cafe24.goott351.domain.OrderBillingVO;
import com.cafe24.goott351.user.order.persistence.CSDAO;
import com.cafe24.goott351.user.order.persistence.OrderDAO;

/**
 * @author : su hyeok kim
 * @date : 2024. 3. 12.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 3. 12.
 */
@Service
@Configuration
@EnableAsync
public class DepositConfigurationServiceImpl implements DepositConfigurationService {
	@Inject
	private OrderAdminDAO dao;
	
	@Inject
	private CSDAO csdao;
	
	@Inject
	private OrderDAO odao;
	/**
	 * @Method : updateOrderStatus
	 * @PackageName : com.cafe24.goott351.admin.order.service
	 * @Description : 가상계좌 이체 확인 시 상태 변경
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.12 su hyeok kim
	 */
	@Override
	@Async
	public void updateOrderStatus(String orderNo, String status) throws Exception {

		System.out.println("사용자가 결제함. 결제완료처리하기 " + dao.updateOrderStatus(orderNo, parseToHangle(status)));
	}
	
	private String parseToHangle(String engParam) {
		String result = "";

		switch (engParam) {
		case "completePayment":
		case "DONE":
			result = "결제완료";
			break;
		case "waitingForDeposit":
		case "WAITING_FOR_DEPOSIT":
			result = "입금대기";
			break;
		case "preparingProduct":
			result = "상품준비중";
			break;
		case "shipping":
			result = "배송중";
			break;
		case "deliveryCompleted":
			result = "배송완료";
			break;
		case "partiallyRefunded":
		case "PARTIAL_CANCELED":
			result = "부분취소";
			break;
		case "fullRefund":
		case "CANCELED":
		case "EXPIRED":
			result = "주문취소";
			break;
		case "ABORTED":
			result = " 결제실패";
			break;
		default:
			result = engParam;
		}

		return result;
	}

	public void updatePointForDeposit(String orderNo, int orderPoint) throws Exception {
		String uuid = csdao.selectOrderUUID(orderNo);
		if(odao.updateCustomersPoint(uuid, orderPoint)==1) {
			odao.insertPontLog("구매적립", uuid, orderPoint);			
		}
		
	}

}
