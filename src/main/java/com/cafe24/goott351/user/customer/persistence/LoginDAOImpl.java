package com.cafe24.goott351.user.customer.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.AutoLoginDTO;
import com.cafe24.goott351.domain.AutoLoginSessionDTO;
import com.cafe24.goott351.domain.KakaoRegisterDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.LoginDTO;

@Repository
public class LoginDAOImpl implements LoginDAO {
	
	private static String ns = "com.cafe24.goott351.mappers.loginMapper";
	
	@Inject 
	private SqlSession ses;

	// 로그인
	@Override
	public LoginCustomerVO login(LoginDTO loginInfo) throws Exception {
		
		return ses.selectOne(ns + ".selectLoginCustomer", loginInfo);
	}

	// email로 UUID 찾기
	@Override
	public String selectUUIDwithEmail(String email) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("email", email);
		
		return ses.selectOne(ns + ".selectUUIDwithEmail", param);
	}
	
	// 자동 로그인 시 저장
	@Override
	public int updateAutoLogin(AutoLoginSessionDTO sessionDTO) throws Exception {

		return ses.update(ns + ".updateAutoLogin", sessionDTO);
	}
	
	// 자동 로그인 처리
	@Override
	public LoginCustomerVO autoLogin(AutoLoginDTO auto) throws Exception {

		return ses.selectOne(ns + ".selectLoginCustomerBySes", auto);
	}

	// 로그인 실패 시 시도 기록에 넣기
	@Override
	public void insertTrylog(String uuid) throws Exception {
		ses.update(ns + ".insertTrylog", uuid);
	}

	// 로그인 성공 시 시도 기록 제거
	@Override
	public void deleteTrylog(String uuid) throws Exception {
		System.out.println("로그인 기록 초기화 lDao : " + uuid);
		ses.delete(ns + ".deleteTrylog", uuid);
	}

	// 로그인 시 시도 기록
	@Override
	public int selectCountOfTry(String uuid) throws Exception {

		return ses.selectOne(ns + ".selectCountOfTry", uuid);
	}

	// 핸드폰 번호 중복 검사
	@Override
	public int selectCountOfPhone(String phoneNumber) throws Exception {

		return ses.selectOne(ns + ".selectCountOfPhone", phoneNumber);
	}

	// 카카오 로그인
	@Override
	public LoginCustomerVO selectKakaoLogin(LoginDTO kLogin) throws Exception {
	
		return ses.selectOne(ns + ".selectKakaoLogin", kLogin);
	}
	
	// 카카오 로그인 시 정보 없을 때 DB에 입력
	@Override
	public void insertKakaoInfo(KakaoRegisterDTO kInfo) throws Exception {
		System.out.println("DAO KInfo" + kInfo);
		ses.insert(ns + ".insertKakaoInfo", kInfo);
	}

}