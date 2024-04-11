package com.cafe24.goott351.user.customer.service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.domain.RegisterDTO;
import com.cafe24.goott351.domain.RegisterDeliveryDTO;
import com.cafe24.goott351.domain.RegisterPointLog;
import com.cafe24.goott351.user.customer.persistence.RegisterDAO;


@Service
public class RegisterServiceImpl implements RegisterService {

	@Inject
	RegisterDAO rDao;

	
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int saveRegister(RegisterDTO member) throws Exception {
		
		int result = -1;

		System.out.println("member : 회원가입 처리 해보자" + member.toString());
		
		// 1) 회원가입을 한다.
		if(member != null) {
			System.out.println("회원가입 멤버 정보: " + member.toString());
			result = rDao.inserRegisterUser(member);
			
			System.out.println(result + "이게 몇이 되나요?");
			// 
			if (result == 1) {
				String uuid = rDao.selectUuid(member.getEmailRegister());
				result = rDao.insertAddr(new RegisterDeliveryDTO(member.getAddrPostcode(), member.getAddr(), member.getAddrDetail(), "Y", uuid, member.getName(), member.getPhoneNumber()));
				if(result == 1) {
				result = rDao.insertPointLog(new RegisterPointLog("회원가입", uuid, 3000));


			}
	
			}
		} 
		return result;
	}

	@Override
	public int duplicateEmail(RegisterDTO member) throws Exception {
		int result = rDao.duplicateEmail(member);
		return result;
	}


	@Override
	public int duplicateNickname(RegisterDTO member)throws Exception {
		int result = rDao.duplicateNickname(member);
		return result;
	}


	@Override
	public int duplicatePhoneNumber(RegisterDTO member)throws Exception {
		int result = rDao.duplicatePhoneNumber(member);
		return result;
	}


	@Override
	public int duplicateRefundAccount(RegisterDTO member)throws Exception {
		int result = rDao.duplicateRefundAccount(member);
		return result;
	}







}
