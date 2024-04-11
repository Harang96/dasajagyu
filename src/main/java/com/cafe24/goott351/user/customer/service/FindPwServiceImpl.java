package com.cafe24.goott351.user.customer.service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafe24.goott351.domain.FindPwDTO;
import com.cafe24.goott351.user.customer.persistence.FindpwDAO;
import com.cafe24.goott351.user.customer.persistence.LoginDAO;


@Service
public class FindPwServiceImpl implements FindPwService {

	@Inject
	private FindpwDAO fDao;
	
	@Inject
	private LoginDAO lDao;
	
	
	
	@Override
	public int updatePwd(FindPwDTO findpwdto) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		
		System.out.println(findpwdto.getEmailAuth());
		String uuid = fDao.selectUuid(findpwdto.getEmailAuth());
		System.out.println("결과값 확인해줘" + uuid);
		
		
		if(uuid!=null) {
			result = fDao.updatePwd(new FindPwDTO(findpwdto.getNewPwd(), "" , uuid, ""));
			
			if (result == 1) {
				System.out.println("로그인 기록 초기화");
				lDao.deleteTrylog(uuid);
			}
			
			System.out.println("결과값 확인해줘" + result);
		}
		
		return result;
	}



	@Override
	public String selectUuid(FindPwDTO emailComfirm) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}



	
	/**
	* @Method		: checkEmailInDB
	* @PackageName  : com.cafe24.goott351.user.customer.service
	* @Description  : 이메일이 DB에 있는지 확인
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.26        Jooyoung Lee       
	*/
	@Override
	public boolean checkEmailInDB(String email) throws Exception {
		boolean result = false;
		
		if (fDao.selectEmail(email) != null) {
			result = true;
		}
		
		return result;
	}

}
