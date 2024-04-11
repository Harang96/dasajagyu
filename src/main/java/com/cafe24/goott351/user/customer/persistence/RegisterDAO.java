package com.cafe24.goott351.user.customer.persistence;

import com.cafe24.goott351.domain.RegisterDTO;
import com.cafe24.goott351.domain.RegisterDeliveryDTO;
import com.cafe24.goott351.domain.RegisterPointLog;

public interface RegisterDAO {
	
	// 회원가입 INSERTE
	int inserRegisterUser(RegisterDTO member) throws Exception;

	// 아이디 중복 체크
	int duplicateEmail(RegisterDTO member) throws Exception;

	// 닉네임 중복 체크
	int duplicateNickname(RegisterDTO member) throws Exception;

	// 핸드폰 번호 중복 체크
	int duplicatePhoneNumber(RegisterDTO member) throws Exception;
	
	// 계좌번호 중복 체크
	int duplicateRefundAccount(RegisterDTO member) throws Exception;
	
	// UUID SELECT
	String selectUuid(String emailRegister);


	// 주소 저장
	int insertAddr(RegisterDeliveryDTO registerDeliveryDTO) throws Exception;
	
	// 회원가입 포인트 저장
	int insertPointLog(RegisterPointLog pointLog) throws Exception;

	

}