package com.cafe24.goott351.user.customer.service;


import com.cafe24.goott351.domain.RegisterDTO;

public interface RegisterService {


	// 회원가입
	int saveRegister(RegisterDTO member) throws Exception;

	// 이메일 중복확인
	int duplicateEmail(RegisterDTO member)throws Exception;
	
	// 닉네임 중복확인
	int duplicateNickname(RegisterDTO member)throws Exception;
	
	// 핸드폰 번호 중복확인
	int duplicatePhoneNumber(RegisterDTO member)throws Exception;
	
	// 계좌 번호 중복확인
	int duplicateRefundAccount(RegisterDTO member)throws Exception;


	
	

	
	

	
}