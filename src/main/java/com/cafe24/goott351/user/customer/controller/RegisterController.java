package com.cafe24.goott351.user.customer.controller;

import java.util.Random;

import javax.inject.Inject;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafe24.goott351.domain.RegisterDTO;
import com.cafe24.goott351.user.customer.service.RegisterService;



@Controller
@RequestMapping("/customer/*")
public class RegisterController {
	private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
	
	
	@Inject
	RegisterService rService;
//	
	@RequestMapping("registerCompletePage")
	public void RegisterCopletePage() throws Exception {
	
		System.out.println("약관 동의 페이지 진입");
		
		
	}
	


	
@RequestMapping(value= "register_jhs", method = RequestMethod.POST)
public String insertRegister(RegisterDTO member, @RequestParam("pathR") String preUrl, Model model, RedirectAttributes rttr) throws Exception {
	
	
	
	System.out.println(member.toString() + "으로 회원가입 해보자.");
	
	int registerMember = rService.saveRegister(member);
	
	if(registerMember == 1) {
		System.out.println("회원가입 성공!!!");
		
		model.addAttribute("registerMember",registerMember);
		
		return "redirect:registerCompletePage?path=" + preUrl;
		
	} else {

		System.out.println("회원가입 실패!!!");
//		rttr.addAttribute("status", "fail"); // 쿼리스트링으로 전달
		rttr.addFlashAttribute("status", "fail"); // 쿼리스트링으로 전달 X
		
		return "redirect:loginOpen?path=" + preUrl;
		
	}
	
}

@RequestMapping(value= "completePage", method = RequestMethod.POST)
public String insertRegister(@RequestParam("pathR") String preUrl, Model model, RedirectAttributes rttr) throws Exception {
		
		return "redirect:loginOpen?path=" + preUrl;
		

}


	@PostMapping("/EmailAuth")
	@ResponseBody
	public int emailAuth(String email) {
		
		System.out.println("전달 받은 이메일 주소 : " + email);
		
		//난수의 범위 111111 ~ 999999 (6자리 난수)
		Random random = new Random();
		int checkNum = random.nextInt(888888)+111111;
		
		Email sendEmail = new SimpleEmail(); 
			
		
		try {
			sendEmail.setHostName("smtp.naver.com");
			sendEmail.setSmtpPort(465);
			sendEmail.setCharset("euc-kr"); // 인코딩 설정(utf-8, euc-kr)
			sendEmail.setAuthenticator(new DefaultAuthenticator("qofhdzz@naver.com", "gustjd1!2@"));
			sendEmail.setFrom("qofhdzz@naver.com", "조현성"); // 보내는 사람
			sendEmail.setSubject("[다사자규] 인증코드 입니다." );
			sendEmail.setMsg("아래 6자리 코드를 입력해서 본인 인증을 완료하고 계정을 생성하세요 \r\n\r\n"
					+ " 인증 코드는 \""
					+  checkNum
					+ "\" 입니다");
			sendEmail.setSSL(true);
			sendEmail.addTo(email); // 받는 사람
			sendEmail.send();
			System.out.println("랜덤숫자 : " + checkNum);
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return checkNum;
	
		
	}
	
	
	
	
	
	@RequestMapping("duplicateEmail")
	@ResponseBody
	public int EmailChk(RegisterDTO member) throws Exception {

		System.out.println("이메일 중복확인");
		
		int result = rService.duplicateEmail(member);
		
		return result;
		
	}

	@RequestMapping("duplicateNickname")
	@ResponseBody
	public int NicknameChk(RegisterDTO member) throws Exception {

		System.out.println("닉네임 중복확인");
		
		int result = rService.duplicateNickname(member);
		
		return result;
		
	}
	
	@RequestMapping("duplicatePhoneNumber")
	@ResponseBody
	public int PhoneNumberChk(RegisterDTO member) throws Exception {

		System.out.println("핸드폰번호 중복확인");
		
		int result = rService.duplicatePhoneNumber(member);
		
		return result;
		
	}

	@RequestMapping("duplicateRefundAccount")
	@ResponseBody
	public int RefundAccountChk(RegisterDTO member) throws Exception {

		System.out.println("계좌번호 중복확인");
		
		int result = rService.duplicateRefundAccount(member);
		
		return result;
		
	}

}