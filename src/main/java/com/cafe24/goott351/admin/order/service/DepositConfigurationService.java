/**
 * 
 */
package com.cafe24.goott351.admin.order.service;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;

/**
 * @author : su hyeok kim
 * @date : 2024. 3. 12.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 3. 12.
 */
@Configuration
@EnableAsync
public interface DepositConfigurationService {
	// 가상계좌 이체 확인 시 상태 변경
	void updateOrderStatus(String orderNo, String status) throws Exception;
}
