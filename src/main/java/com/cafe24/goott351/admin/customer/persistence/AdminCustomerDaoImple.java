package com.cafe24.goott351.admin.customer.persistence;

import java.io.Console;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.CustomerCntVO;
import com.cafe24.goott351.domain.CustomerSearchDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.ProductPagingVO;

@Repository
public class AdminCustomerDaoImple implements AdminCustomerDao {
		
	@Inject
	private SqlSession ses;
	private static String ns = "com.cafe24.goott351.mappers.adminCustomerMapper";
	
	

	@Override
	public int getTotalCustomerCntBySearch(CustomerSearchDTO csDto) {
		
		String query = ns + ".getTotalCustomerCntBySearch";
		
		return ses.selectOne(query, csDto);
	}


	@Override
	public List<LoginCustomerVO> getAllCustomer(ProductPagingVO pagingVo, CustomerSearchDTO csDto) throws Exception{
		
		String query = ns + ".selectAllCustomerList";
		
		Map <String, Object> param = new HashMap<>();
		
		param.put("startRowIndex", pagingVo.getStartRowIndex());
		param.put("pageProductCnt", pagingVo.getPageProductCnt());
		param.put("searchWord", csDto.getSearchWord());
		param.put("searchType", csDto.getSearchType());
		param.put("colName", csDto.getColName());
		param.put("colValue", csDto.getColValue());
		
	
		return ses.selectList(query, param);
	}


	@Override
	public CustomerCntVO getCustomerCnt() throws Exception{
		
		String query = ns + ".getCustomerCnt";
		
		return ses.selectOne(query);
	}


	@Override
	public void updateUserInfo(String uuid, String nickname, String isAdmin) throws Exception{

		String query = ns + ".updateUserInfo";
		
		Map <String, Object> param = new HashMap<>();

		param.put("nickname", nickname);
		param.put("isAdmin", isAdmin);
		param.put("uuid", uuid);
		
		ses.update(query, param);
	}


	@Override
	public void updateUserPoint(int point, List<String> userList) throws Exception{
		
		String query = ns + ".updateUserPoint";
		
		Map <String, Object> param = new HashMap<>();

		param.put("point", point);
		param.put("list", userList);
		
		ses.update(query, param);
		
	}


	@Override
	public void insertUserPointLog(int point, List<String> userList) throws Exception{

		String query = ns + ".insertUserPointLog";
		
		Map <String, Object> param = new HashMap<>();

		param.put("point", point);
		param.put("list", userList);
		
		ses.insert(query, param);
	}


	@Override
	public void insertDrawLog(String email, String reason) throws Exception{
		
		String query = ns + ".insertDrawLog";
		
		Map <String, Object> param = new HashMap<>();

		param.put("email", email);
		param.put("reason", reason);
		
		ses.insert(query, param);
	}


	@Override
	public void deletCustomerInfo(String email) throws Exception{

		String query = ns + ".deletCsInfo";
		
		ses.delete(query, email);
	}


	@Override
	public void resetCustomerPwd(String email, String rndPwd) throws Exception{

		String query = ns + ".resetCustomerPwd";
		
		Map <String, Object> param = new HashMap<>();

		param.put("email", email);
		param.put("rndPwd", rndPwd);
		
		ses.update(query, param);
	}
	
	
	
}
