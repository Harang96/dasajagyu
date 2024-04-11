package com.cafe24.goott351.user.customer.service;

import com.cafe24.goott351.domain.AutoLoginDTO;
import com.cafe24.goott351.domain.AutoLoginSessionDTO;
import com.cafe24.goott351.domain.KakaoRegisterDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.LoginDTO;

public interface LoginService {
	
	// 로그인
	LoginCustomerVO login(LoginDTO loginInfo) throws Exception;
	
	// email로 UUID 찾기
	String getCustomerUUID(String email) throws Exception;

	// 자동 로그인 체크 시 저장
	boolean rememberAutoLogin(AutoLoginSessionDTO sessionDTO) throws Exception;

	// 자동 로그인 처리
	LoginCustomerVO autoLogin(AutoLoginDTO auto) throws Exception;

	// 로그인 실패 시 시도 기록에 넣기
	void addTrylog(LoginDTO loginInfo) throws Exception;

	// 로그인 시 시도 기록이 있는지 확인
	int checkTrylog(String uuid) throws Exception;

	// 핸드폰 번호 중복 검사
	int duplicatePhone(String phoneNumber) throws Exception;

	// 카카오 로그인
	LoginCustomerVO kakaoLogin(LoginDTO kLogin) throws Exception;

	// 카카오 로그인 시 정보 없을 때 DB에 입력
	void inputDataKakaoToDB(KakaoRegisterDTO kInfo) throws Exception;
}