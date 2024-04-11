/**
 * 
 */
package com.cafe24.goott351.admin.order.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.CustomerVO;

/**
 * @author : su hyeok kim
 * @date : 2024. 2. 28.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 2. 28.
 */
@Repository
public class OrderCustomerDAOImpl implements OrderCustomerDAO {
	private static String ns = "com.cafe24.goott351.mappers.orderAdminMapper";

	@Inject
	private SqlSession ses;

	/**
	 * @Method : selectCustomer
	 * @PackageName : com.cafe24.goott351.admin.order.persistence
	 * @Description : ===========================================================
	 *              DATE AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.02.28 su hyeok kim
	 */
	@Override
	public CustomerVO selectCustomer(String uuid) throws Exception {
		return ses.selectOne(ns + ".selectCustomer", uuid);
	}

}
