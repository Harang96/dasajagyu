package com.cafe24.goott351.user.customer.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafe24.goott351.domain.AutoLoginDTO;
import com.cafe24.goott351.domain.AutoLoginSessionDTO;
import com.cafe24.goott351.domain.KakaoRegisterDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.LoginDTO;
import com.cafe24.goott351.user.customer.persistence.LoginDAO;

@Service
public class LoginServiceImpl implements LoginService {
	@Inject
	private LoginDAO lDao;

	/**
	* @Method		: login
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : 로그인
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.27        Jooyoung Lee       
	*/
	@Override
	public LoginCustomerVO login(LoginDTO loginInfo) throws Exception {
		
		LoginCustomerVO customer = lDao.login(loginInfo);
		
		if (customer != null) {
			lDao.deleteTrylog(customer.getUuid());
		}
		
		return customer;
	}
	
	/**
	* @Method		: getCustomerUUID
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : email로 UUID 찾기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.27        Jooyoung Lee       
	*/
	@Override
	public String getCustomerUUID(String email) throws Exception {
		String uuid = lDao.selectUUIDwithEmail(email);
		
		return uuid;
	}
	
	/**
	* @Method		: rememberAutoLogin
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : 자동 로그인 시 저장
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.27        Jooyoung Lee       
	*/
	@Override
	public boolean rememberAutoLogin(AutoLoginSessionDTO sessionDTO) throws Exception {
		boolean result = false;
		
		if (lDao.updateAutoLogin(sessionDTO) == 1) {
			result = true;
		}
		
		return result;
	}

	/**
	* @Method		: autoLogin
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : 자동 로그인 처리
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.27        Jooyoung Lee       
	*/
	@Override
	public LoginCustomerVO autoLogin(AutoLoginDTO auto) throws Exception {
		LoginCustomerVO customer = lDao.autoLogin(auto);
		
		return customer;
	}

	/**
	* @Method		: addTrylog
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : 로그인 실패 시 시도 기록에 넣기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.28        Jooyoung Lee       
	*/
	@Override
	public void addTrylog(LoginDTO loginInfo) throws Exception {
		// 해당 uuid가 customers에 있는지 확인
		String uuid = lDao.selectUUIDwithEmail(loginInfo.getEmail());
		System.out.println(uuid);
		if (uuid != null) {
			// 시도 기록에 insert
			lDao.insertTrylog(uuid);
		}
	}

	/**
	* @Method		: checkTrylog
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : 로그인 시 시도 기록이 있는지 확인
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.28        Jooyoung Lee       
	*/
	@Override
	public int checkTrylog(String uuid) throws Exception {
		int result = 0;
		
		if (uuid != null) {
			result = lDao.selectCountOfTry(uuid);
		}
		
		return result;
	}

	/**
	* @Method		: duplicatePhone
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : 핸드폰 번호 중복 검사
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.02        Jooyoung Lee       
	*/
	@Override
	public int duplicatePhone(String phoneNumber) throws Exception {
		
		return lDao.selectCountOfPhone(phoneNumber);
	}

	/**
	* @Method		: kakaoLogin
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : 카카오 로그인 
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.02        Jooyoung Lee       
	*/
	@Override
	public LoginCustomerVO kakaoLogin(LoginDTO kLogin) throws Exception {
		
		return lDao.selectKakaoLogin(kLogin);
	}
	
	/**
	* @Method		: inputDataKakaoToDB
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : 카카오 로그인 시 정보 없을 때 DB에 입력
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.02        Jooyoung Lee       
	*/
	@Override
	public void inputDataKakaoToDB(KakaoRegisterDTO kInfo) throws Exception {
		System.out.println("서비스단 : " + kInfo);
		lDao.insertKakaoInfo(kInfo);
	}

}