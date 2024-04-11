package com.cafe24.goott351.user.customer.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.goott351.domain.FindIdVO;
import com.cafe24.goott351.domain.FindPwDTO;
import com.cafe24.goott351.domain.RegisterDTO;
import com.cafe24.goott351.user.customer.service.FindIdService;
import com.cafe24.goott351.user.customer.service.FindPwService;

import net.nurigo.sdk.message.request.SingleMessageSendingRequest;


@Controller
@RequestMapping("/customer/*")
public class FindInfoController {
	
	@Inject
	FindPwService fService;
	
	@Inject
	FindIdService Iservice;
	
	
	
	@RequestMapping(value="FindinfoId", method=RequestMethod.GET)
	public String FindinfoId() {
		// 아이디찾기에서 로그인/회원가입 페이지로 이동 텍스트 클릭시, 로그인페이지 이동
		
		return "customer/findinfo_id";
	}
	
	
	/**
	* @Method      : FindEmailAuth
	* @PackageName : com.cafe24.goott351.user.customer.controller
	* @Return      : String
	* @Description : 이메일 찾기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.12        Jiwoo seo       
	*/
	private String saveEmail = null;
	
	@ResponseBody
	@RequestMapping(value="FindEmailAuth", method=RequestMethod.POST)
	public int emailAuth(String email) {
		
		// 난수의 범위 111111 ~ 999999 (6자리 난수)
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		Email sendEmail = new SimpleEmail();
	    System.out.println(email);
		try {
			sendEmail.setHostName("smtp.naver.com");
			sendEmail.setSmtpPort(465);
			sendEmail.setCharset("euc-kr"); // 인코딩 설정(utf-8, euc-kr)
			sendEmail.setAuthenticator(new DefaultAuthenticator("dw0215@naver.com", "mymusicfor147!"));
			sendEmail.setFrom("dw0215@naver.com", "서지우");
			sendEmail.setSubject("[다사자규] 인증코드 입니다.");
			sendEmail.setMsg("아래 6자리 코드를 입력해서 본인 인증을 완료하고 계정을 다시 이용하세요 \r\n\r\n"
					+ " 인증 코드는 \""
					+  checkNum
					+ "\" 입니다");
			sendEmail.setSSL(true);
			sendEmail.addTo(email);
			sendEmail.send();
			
			saveEmail = email;
			
			System.out.println("랜덤숫자 : " + checkNum);
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return checkNum;
	}
	
	@PostMapping("/customer/")
	@RequestMapping(value="confrimMsg", method=RequestMethod.POST)
	public @ResponseBody Map<String, String> confrimMsg(HttpServletRequest request, HttpSession ses, HttpServletResponse resp,
							@RequestBody FindPwDTO FindpwDTO)throws Exception {
		FindpwDTO.setEmailAuth(saveEmail);
		
		int confrimMsg = fService.updatePwd(FindpwDTO);
		System.out.println("결과값 확인" + confrimMsg);
		
		
		 Map<String, String> response = new HashMap<>();
		 
		 
		if(confrimMsg == 1) {
			System.out.println("업데이트 성공");
			response.put("status","success");
			
		} else {
			System.out.println("업데이트 실패");
			response.put("status","fail");
		} 
		
		
		return response;
		
		
		
	}
	
	@RequestMapping(value="idSearch_click", method=RequestMethod.POST)
	@ResponseBody
	public FindIdVO idSearch(@RequestParam("name")  String name, @RequestParam("phoneNumber") String phoneNumber, Model model )throws Exception{

		System.out.println(name + "이름");
		System.out.println(phoneNumber + "전화번호");
	
//		Map<String, String> response = new HashMap<>();
		
		
		FindIdVO confirmId = Iservice.selectName(phoneNumber,name);
//		
		
		if(confirmId != null && confirmId.getName().equals(name)) {
			System.out.println("출력 성공");
			System.out.println("이메일: " + confirmId.getEmail());
			
			confirmId.setEmail(confirmId.getEmail());
			
			model.addAttribute("confirmId",confirmId);
			
			
			
			
			
		} else {
			System.out.println("출력실패");
//			response.put("status","fail");
		} 
		
		return confirmId;
//		return response;
	
	}

	
	@RequestMapping("findinfo_id")
	public String findpw() {

		return "customer/findinfo_id";
	}


	@RequestMapping("phoneNumberCodeTest")
	public void phoneNumberCodeTestGet() {
		System.out.println("이거 핸드폰 인증 테스트 입니다.");
		
	}
	
	
	@RequestMapping("loginOpen")
	public void goToLoginOpenGet() {
		System.out.println("이거 핸드폰 인증 테스트 입니다.");
		
	}
	
	@RequestMapping(value = "/phoneCheck", method = RequestMethod.GET)
	@ResponseBody
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) { // 휴대폰 문자보내기
		int randomNumber = (int)((Math.random()* (999999 - 100000 + 1)) + 100000);//난수 생성

		Iservice.certifiedPhoneNumber(userPhoneNumber,randomNumber);
		
		return Integer.toString(randomNumber);
	}
	
	
	
//	@RequestMapping(value="customerEmail", method=RequestMethod.POST)
//	public String customerEmail(@RequestParam("email")  String email, Model model)throws Exception {
//		
//		
//		model.addAttribute("eamil", email);
//		
//		return "/customer/findinfo_id"; 
//	}

}
