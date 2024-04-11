package com.cafe24.goott351.user.customer.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.RegisterDTO;
import com.cafe24.goott351.domain.RegisterDeliveryDTO;
import com.cafe24.goott351.domain.RegisterPointLog;


@Repository
public class RegisterDAOImpl implements RegisterDAO {

	private String registerMapper = "com.cafe24.goott351.mappers.registerMapper";
	private String deliveryMapper = "com.cafe24.goott351.mappers.deliveryMapper";
	private String pointLogMapper = "com.cafe24.goott351.mappers.pointLogMapper";
	
	@Inject
	private SqlSession ses; // SqlSessionTemplate 
	

	@Override
	public int inserRegisterUser(RegisterDTO member) throws Exception {
		
		return ses.insert(registerMapper + ".insertRegister", member);
	}

	public int duplicateEmail(RegisterDTO member) throws Exception {
		return ses.selectOne(registerMapper + ".idChk", member);
	}

	@Override
	public int duplicateNickname(RegisterDTO member) throws Exception {
		return ses.selectOne(registerMapper + ".nicknameChk", member);
	}

	@Override
	public int duplicatePhoneNumber(RegisterDTO member) throws Exception {
		return ses.selectOne(registerMapper + ".phoneNumberChk", member);
	}

	@Override
	public int duplicateRefundAccount(RegisterDTO member) throws Exception {
		return ses.selectOne(registerMapper + ".refundAccountChk", member);
	}


	@Override
	public String selectUuid(String emailRegister) {
		return ses.selectOne(registerMapper + ".selectUuid", emailRegister);
	}	


	@Override
	public int insertAddr(RegisterDeliveryDTO Delivery) throws Exception {
		
		return ses.insert(deliveryMapper + ".insertDelivery", Delivery);
	}

	@Override
	public int insertPointLog(RegisterPointLog pointLog) throws Exception {

		return ses.insert(pointLogMapper + ".insertPontLog", pointLog);
		
		
	}
 


}



