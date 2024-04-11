/**
 * 
 */
package com.cafe24.goott351.admin.order.service;

import java.util.Map;

import com.cafe24.goott351.domain.OrderCsDTO;
import com.cafe24.goott351.domain.RefundReceiveAccountDTO;

/**
 * @author : su hyeok kim
 * @date : 2024. 3. 22.
 * @description : 전체 주문취소일 경우 처리로직
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 3. 22.
 */
public interface OrderCancelService {
	Map<String, String> cancelOrders(OrderCsDTO orderCs, RefundReceiveAccountDTO account) throws Exception;
}
