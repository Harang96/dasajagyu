package com.cafe24.goott351.user.customer.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.cafe24.goott351.domain.FindIdVO;
import com.cafe24.goott351.user.customer.persistence.FindidDAO;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;


@Service
public class FindIdServiceImpl implements FindIdService {
	
	@Inject
	private FindidDAO iDao;

	@Override
	public FindIdVO selectName(String phoneNumber, String name) throws Exception {
		FindIdVO userFindNumber = iDao.selectName(phoneNumber,name);
		System.out.println("뭘출력하는지 알려줘 : " + userFindNumber);
		
		
		return userFindNumber;

	}

	@Override
	public void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) {
		String api_key = "NCS05NKLHQ9FFL6E";
	    String api_secret = "1Y0MCLCJRYVX31RFRN96XV98E5QHHKQB";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", userPhoneNumber);    // 수신전화번호
	    params.put("from", "010-9001-4669");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");
	    params.put("text", "[다사자규] 본인확인 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	        JSONObject obj = (JSONObject) coolsms.send(params);
	        System.out.println(obj.toString());
	      } catch (CoolsmsException e) {
	        System.out.println(e.getMessage());
	        System.out.println(e.getCode());
	      }
	    
	}

		
	}



	


	
