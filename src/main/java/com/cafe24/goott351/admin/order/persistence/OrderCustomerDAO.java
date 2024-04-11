/**
 * 
 */
package com.cafe24.goott351.admin.order.persistence;

import com.cafe24.goott351.domain.CustomerVO;

/**
 * @author : su hyeok kim
 * @date  : 2024. 2. 28. 
 * @description : 
 * @change
 * name		 		date					detail
 * ----------------------------------------------------------------------------------
 * su hyeok kim		2024. 2. 28.	
 */
public interface OrderCustomerDAO {
	// 고객 정보 조회 
	CustomerVO selectCustomer(String uuid) throws Exception;
}
