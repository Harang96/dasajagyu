package com.cafe24.goott351.admin.customer.controller;


import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cafe24.goott351.admin.customer.service.AdminCustomerService;
import com.cafe24.goott351.domain.CustomerCntVO;
import com.cafe24.goott351.domain.CustomerSearchDTO;

@Controller
@RequestMapping("/admin/customer/*")
public class AdminCustomerController {

	@Inject
	AdminCustomerService acService;
	
	@RequestMapping(value = "customerAdmin", method = RequestMethod.GET)
	private void selectCustomerList(@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
									@RequestParam(name = "pageProductCnt", defaultValue = "10") int pageProductCnt,	
									@RequestParam(name = "searchWord", defaultValue = "") String searchWord,
									@RequestParam(name = "searchType", defaultValue = "def") String searchType,
									@RequestParam(name = "colName", defaultValue = "registerDate") String colName,
									@RequestParam(name = "colValue", defaultValue = "desc") String colValue,
									Model model) throws Exception {
		
		System.out.println("회원관리 불러오기");
		
		CustomerSearchDTO csDto = new CustomerSearchDTO();
		csDto.setSearchWord(searchWord);
		csDto.setSearchType(searchType);
		csDto.setColName(colName);
		csDto.setColValue(colValue);
		
		
		
		Map<String, Object> map = acService.selectAllCustomer(pageNo, pageProductCnt, csDto);
		CustomerCntVO csCntVo = acService.selectCustomerInfo();
		model.addAttribute("customerList", map.get("customerList"));
		model.addAttribute("pagingInfo", map.get("pagingInfo"));
		model.addAttribute("colName", colName);
		model.addAttribute("colValue", colValue);
		model.addAttribute("pageProductCnt", pageProductCnt);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchType", searchType);
		model.addAttribute("customerInfo", csCntVo);
	};
	
	@RequestMapping(value="editCsInfo", method = RequestMethod.POST)
	public void updateUserInfo(HttpServletRequest req,
								@RequestParam(name = "uuid") String uuid,
								@RequestParam(name = "nickname") String nickname,
								@RequestParam(name = "isAdmin") String isAdmin) throws Exception {

		
		
		acService.updateUserInfo(uuid, nickname, isAdmin);
		
		System.out.println(uuid + nickname + isAdmin);
		
	};
	
	@RequestMapping(value="updatePoint", method = RequestMethod.POST)
	public void updateUserPoint(@RequestParam(name = "point") int point,
								@RequestParam(name = "userList[]") List<String> userList
								) throws Exception {
									  
		System.out.println("포인트 점수 = " + point);
		System.out.println("포인트 리스트 = " + userList);
		
		acService.updateUserPoint(point, userList);
		
	};
	
	@RequestMapping(value = "delCsInfo", method = RequestMethod.POST)
	public void delCsInfo(@RequestParam(name = "email") String email,
						  @RequestParam(name = "reason") String reason) throws Exception {
		
		System.out.println("회원탈퇴를 진행");
		
		acService.deleteCustomer(email, reason);
		
	}
	
	@RequestMapping(value="sendEmail", method = RequestMethod.POST)
	public void sendEmailToUser(@RequestParam(name = "title") String title,
								@RequestParam(name = "content") String content,
								@RequestParam(name = "userList[]") List<String> userList) {
		
		System.out.println("이메일 보냅니다!");
		
			try {
				
				for (String e : userList) {
					HtmlEmail sendEmail = new HtmlEmail();
					
					sendEmail.setHostName("smtp.naver.com");
					sendEmail.setSmtpPort(465);
					sendEmail.setCharset("euc-kr");
					sendEmail.setAuthenticator(new DefaultAuthenticator("qofhdzz@naver.com", "gustjd1!2@"));
					sendEmail.setFrom("qofhdzz@naver.com", "조현성"); // 보내는 사람
					sendEmail.setSubject(title);
					sendEmail.setHtmlMsg("<html>" + content + "</html>");
					sendEmail.setTextMsg("Your email client does not support HTML messages");
					sendEmail.setSSL(true);
					sendEmail.addTo(e);
					sendEmail.send();
				}
			} catch (EmailException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}
	
	
	@RequestMapping(value="resetCustomerPwd", method = RequestMethod.POST)
	public void resetCustomerPwd(@RequestParam(name = "email") String email) throws Exception {
		
		String rndPwd = getRandomPwd();
	    
		System.out.println("-----비번 초기화-------");
		System.out.println("email : " + email );
		System.out.println("rndPwd : " + rndPwd );
		System.out.println("---------- 끝----------");
		
		acService.resetCustomerPwd(email, rndPwd);

		try {
				HtmlEmail sendEmail = new HtmlEmail();
				
				sendEmail.setHostName("smtp.naver.com");
				sendEmail.setSmtpPort(465);
				sendEmail.setCharset("euc-kr");
				sendEmail.setAuthenticator(new DefaultAuthenticator("qofhdzz@naver.com", "gustjd1!2@"));
				sendEmail.setFrom("qofhdzz@naver.com", "조현성"); // 보내는 사람
				sendEmail.setSubject("다사자규 비밀번호 초기화 메일입니다.");
				sendEmail.setHtmlMsg("<html><div><h3>다사자규 비밀번호 초기화</h3><br/><span>초기화 비밀번호 : "+rndPwd+"</span><br/><span><a href='http://goott351.cafe24.com/customer/loginOpen?path=/'>로그인하러 가기</a></span></div></html>");
				sendEmail.setTextMsg("Your email client does not support HTML messages");
				sendEmail.setSSL(true);
				sendEmail.addTo(email);
				sendEmail.send();
			
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	private String getRandomPwd() {
		
		char[] rndAllChar = new char[]{
		        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
		        'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
		        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
		        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
		        '@', '$', '!', '%', '*', '?', '&'
		};
		
		char[] numberChar = new char[] {
		        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
		};

		char[] uppercaseChar = new char[] {
		        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
		        'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
		};

		char[] lowercaseChar = new char[] {
		        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
		        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
		};

		char[] symbolChar = new char[] {
		        '@', '$', '!', '%', '*', '?', '&'
		};
		
		SecureRandom random = new SecureRandom();
		StringBuilder stringBuilder = new StringBuilder();
		
		List<Character> pwdChar = new ArrayList<Character>();
		
		int numberCharLength = numberChar.length;
		pwdChar.add(numberChar[random.nextInt(numberCharLength)]);

	    int uppercaseCharLength = uppercaseChar.length;
	    pwdChar.add(uppercaseChar[random.nextInt(uppercaseCharLength)]);

	    int lowercaseCharLength = lowercaseChar.length;
	    pwdChar.add(lowercaseChar[random.nextInt(lowercaseCharLength)]);

	    int symbolCharLength = symbolChar.length;
	    pwdChar.add(symbolChar[random.nextInt(symbolCharLength)]);
		
	    int rndAllCharLength = rndAllChar.length;
	    
	    for (int i = 0; i < 12-4; i++) {
	    	pwdChar.add(rndAllChar[random.nextInt(rndAllCharLength)]);
	    }

	    Collections.shuffle(pwdChar);

	    for (Character character : pwdChar) {
	        stringBuilder.append(character);
	    }

	    return stringBuilder.toString();
		
	}
	
}
