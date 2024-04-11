package com.cafe24.goott351.user.customer.controller;

import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.cafe24.goott351.domain.AutoLoginDTO;
import com.cafe24.goott351.domain.AutoLoginSessionDTO;
import com.cafe24.goott351.domain.KakaoRegisterDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.LoginDTO;
import com.cafe24.goott351.interceptor.LoginInterceptor;
import com.cafe24.goott351.user.customer.service.LoginService;
import com.cafe24.goott351.user.order.service.CartService;
import com.cafe24.goott351.util.KakaoApi;

@Controller
@RequestMapping("/customer/*")
public class LoginController {
	
	private final KakaoApi kakaoApi = new KakaoApi();
	
	@Inject 
	private LoginService lService;
	
	@Inject
	private CartService cService;
	
	/**
	* @Method      : loginOpen
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @Return      : String
	* @Description  : 로그인 페이지 오픈
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.24        Jooyoung Lee       
	*/
	@RequestMapping(value="loginOpen", method=RequestMethod.GET)
	public String loginOpen() {
		// 헤더를 누르면 헤더에서 현 페이지의 링크를 따서 보내는 작업 필요
		return "customer/login";
	}
	
	/**
	* @Method      : login
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @Return      : String
	* @Description  : 로그인
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Jooyoung Lee       로그인 실패 시 로그인 페이지로
	*/
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(Model m, LoginDTO loginInfo, String path, HttpServletRequest req, HttpServletResponse res, RedirectAttributes rttr) {
		System.out.println("로그인");
		System.out.println(loginInfo);
		
		HttpSession ses = req.getSession();
		try {
			// 로그인
			LoginCustomerVO customer = lService.login(loginInfo);
			if (customer != null) {
				
				ses.setAttribute("loginCustomer", customer);
				
				// 카트 정보 넣기
				cartLogin(customer, req, res);
				
			} else {
				// 로그인 트라이 로그
				lService.addTrylog(loginInfo);
				
				// 로그인 페이지로 돌려 보내기
				rttr.addFlashAttribute("loginStatus", "fail");
				rttr.addFlashAttribute("customerEmail", loginInfo.getEmail());
				return "redirect:loginOpen?path=" + path;
			}
			
			return "redirect:" + path;
				
		} catch (Exception e) {
			// 로그인 페이지로 돌려 보내기
			e.printStackTrace();
			rttr.addFlashAttribute("loginStatus", "fail");
			rttr.addFlashAttribute("customerEmail", loginInfo.getEmail());
			return "redirect:loginOpen?path=" + path;
		}

	}
	
	/**
	* @Method      : logout
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @Return      : String
	* @Description  : 로그아웃
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.26        Jooyoung Lee       
	*/
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String logout(Model m, @RequestParam("path") String preUrl, HttpServletRequest req, HttpServletResponse res, RedirectAttributes rttr) {
		HttpSession ses = req.getSession();
		System.out.println("로그아웃");
		LoginCustomerVO customer = (LoginCustomerVO) ses.getAttribute("loginCustomer");
		if (customer != null) {
			ses.removeAttribute("loginCustomer");
			ses.invalidate();
			req.getSession(true);
			
			// 장바구니 로그아웃
			cartLogout(customer, req, res);

			// 쿠키 제거
			Cookie autoLoginCookie = LoginInterceptor.removeCookie("autoLogin");
			res.addCookie(autoLoginCookie);
			
			// DB의 세션값 제거
			String uuid = customer.getUuid();
			AutoLoginSessionDTO sessionDTO = new AutoLoginSessionDTO(uuid, null);
			try {
				lService.rememberAutoLogin(sessionDTO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "redirect:" + preUrl;
	}
	
	
	
	/**
	* @Method      : cartLogin
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @Return      : void
	* @Description  : 로그인 시 장바구니 정보 업데이트
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.28        Sangyong Lee       
	*/
	public void cartLogin(LoginCustomerVO customer, HttpServletRequest req, HttpServletResponse res) {
		// 로그인시 카트 쿠키처리
		Cookie cartId = WebUtils.getCookie(req, "cartId");
		if(cartId != null && !cartId.getValue().equals("-")) {
			String oldId = cartId.getValue();
			cartId.setValue(customer.getUuid());
			cartId.setPath("/");
			cartId.setMaxAge(24*60*60);
			res.addCookie(cartId);
			// 카트 서비스단 로직
			
			if(oldId.length() != 36) {
				cService.changeCartToMember(customer.getUuid(), oldId);
			}
			
		} else {
			Cookie newCartId = new Cookie("cartId",customer.getUuid());
			newCartId.setPath("/");
			newCartId.setMaxAge(24*60*60);
			res.addCookie(newCartId);
		}
		
		Cookie cartCnt = WebUtils.getCookie(req, "cartCnt");
		int cartListCnt = cService.getCartListCnt(customer.getUuid(), "member");
		// 장바구니 수량
		if (cartCnt == null) {
			Cookie cntcookie = new Cookie("cartCnt", cartListCnt+"");
			cntcookie.setPath("/");
			cntcookie.setMaxAge(24*60*60);
			res.addCookie(cntcookie);
		} else {
			cartCnt.setValue(cartListCnt+"");
			cartCnt.setPath("/");
			cartCnt.setMaxAge(24*60*60);
			res.addCookie(cartCnt);
		}
		
	}
	
	/**
	* @Method      : cartLogout
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @Return      : void
	* @Description  : 로그아웃 시 장바구니 쿠키 삭제
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.28        Sangyong Lee       
	*/
	public void cartLogout(LoginCustomerVO customer, HttpServletRequest req, HttpServletResponse res) {
		Cookie cartId = WebUtils.getCookie(req, "cartId");
		Cookie cartCnt = WebUtils.getCookie(req, "cartCnt");
		
		if(cartId != null) {
			cartId.setMaxAge(0);
			cartId.setPath("/");
			res.addCookie(cartId);
		}
		
		if (cartCnt != null) {
			cartCnt.setMaxAge(0);
			cartCnt.setPath("/");
			res.addCookie(cartCnt);
		}
	}
	
	/**
	* @Method		: autoLogin
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @return		: String
	* @Description  : 자동 로그인
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.29        Jooyoung Lee       
	*/
	@RequestMapping(value="autoLogin", method=RequestMethod.GET)
	public String autoLogin(AutoLoginDTO auto, @RequestParam("path") String path, HttpServletRequest req, HttpServletResponse res, RedirectAttributes rttr) {
		
		HttpSession ses = req.getSession();
		
		try {
			LoginCustomerVO customer = lService.autoLogin(auto);
			if (customer != null) {
				ses.setAttribute("loginCustomer", customer);
			} else {
				Cookie rememberIdCookie = LoginInterceptor.removeCookie("rememberId"); 
				System.out.println(rememberIdCookie.getName());
				
				Cookie autoLoginCookie = LoginInterceptor.removeCookie("autoLogin"); 
				System.out.println(autoLoginCookie.getName());
				
				res.addCookie(rememberIdCookie);
				res.addCookie(autoLoginCookie);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Cookie rememberIdCookie = LoginInterceptor.removeCookie("rememberId"); 
			System.out.println(rememberIdCookie.getName());
			
			Cookie autoLoginCookie = LoginInterceptor.removeCookie("autoLogin"); 
			System.out.println(autoLoginCookie.getName());
			
			res.addCookie(rememberIdCookie);
			res.addCookie(autoLoginCookie);
		}
		
		return "redirect:" + path;
	}	
	
	/**
	* @Method      : sessionCheck
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @Return      : ResponseEntity<String>
	* @Description  : 자동로그인이 필요한지 세션 체크
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.28        Jooyoung Lee       
	*/
	@RequestMapping(value="sessionCheck", method=RequestMethod.GET)
	public ResponseEntity<String> sessionCheck(HttpServletRequest req) {
		HttpSession ses = req.getSession();
		
		LoginCustomerVO customer = (LoginCustomerVO) ses.getAttribute("loginCustomer");
		ResponseEntity<String> rs = new ResponseEntity<String>("", HttpStatus.OK);
		if (customer != null) { // 
			rs = new ResponseEntity<String>("data", HttpStatus.OK);
		}
		
		return rs;
	}
	
	/**
	* @Method		: getCodeForKakao
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @return		: String
	* @Description  : 카카오 로그인 API > 정보 받아오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.02        Jooyoung Lee       코드 > 토큰 > 정보
	*/
	@RequestMapping(value="getCodeForKakao", method=RequestMethod.GET)
	public String getCodeForKakao(@RequestParam String code, HttpServletRequest req, HttpServletResponse res) {
		
		Cookie[] cookies = req.getCookies();
		String path = "";
		if (cookies != null) {
            // 쿠키에서 패스 읽기
			for (Cookie cookie : cookies) {
                if (cookie.getName().equals("kakaoPath")) {
                	path = cookie.getValue();
                    break;
                }
            }
            
            // 쿠키에서 패스 지우기
			Cookie kakaoPathCookie = LoginInterceptor.removeCookie("kakaoPath"); 
			System.out.println(kakaoPathCookie.getName());
			res.addCookie(kakaoPathCookie);
		}
		
		// 1. 인가 코드 받기 
		// (@RequestParam String code)

        // 2. 토큰 받기
        String accessToken = kakaoApi.getAccessToken(code);

        // 3. 사용자 정보 받기
        Map<String, Object> userInfo = kakaoApi.getUserInfo(accessToken);

        System.out.println("accessToken = " + accessToken);
        
        // 로그인 처리
        kakaoLogin(userInfo, req, res);
        
        return "redirect:" + path;
	}
	
	/**
	* @Method		: kakaoLogin
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @return		: void
	* @Description  : 카카오 로그인 바인딩
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.02        Jooyoung Lee       
	*/
	private void kakaoLogin(Map<String, Object> userInfo, HttpServletRequest req, HttpServletResponse res) {
		HttpSession ses = req.getSession();
		
		String email = (String)userInfo.get("email"); 	
        String nickname = (String)userInfo.get("nickname");
        String gender = (String)userInfo.get("gender");
        // 핸드폰 번호는 랜덤으로 생성
        String phoneNumber = makeRanNum();
        
        try {
			while (lService.duplicatePhone(phoneNumber) == 1) {
				System.out.println("핸드폰 번호가 중복입니다.");
				phoneNumber = makeRanNum();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        KakaoRegisterDTO kInfo = new KakaoRegisterDTO(email, nickname, gender, phoneNumber);
        
        // 없는 이메일이면 DB에 추가  
        try {
			if (lService.getCustomerUUID(email) == null) {
				// DB에 등록
				System.out.println("kInfo : " + kInfo);
				lService.inputDataKakaoToDB(kInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        // 로그인 처리
        LoginDTO kLogin = new LoginDTO(email, null);
        LoginCustomerVO customer;
		try {
			customer = lService.kakaoLogin(kLogin);

			if (customer != null) {
				ses.setAttribute("loginCustomer", customer);
			}
		} catch (Exception e) { // 로그인 하다 오류
			customer = null;
		}
        
	}

	/**
	* @Method		: makeRanNum
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @return		: String
	* @Description  : 랜덤 핸드폰 번호 생성
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.02        Jooyoung Lee       
	*/
	private String makeRanNum() {
		Random rand = new Random();
		
		String phoneNum = "010-";
		String middleNum = String.format("%04d", rand.nextInt(10000));
		String lastNum = String.format("%04d", rand.nextInt(10000));
		
		phoneNum += middleNum + "-" + lastNum;
		System.out.println(phoneNum);		
		
		
		return phoneNum;
	}
	
	/**
	* @Method		: kakaoLogout
	* @PackageName  : com.cafe24.goott351.user.customer.controller
	* @return		: String
	* @Description  : 카카오 로그아웃
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.20        Jooyoung Lee       
	*/
	@RequestMapping(value="kakaoLogout", method=RequestMethod.GET)
	public String kakaoLogout(HttpServletRequest req, HttpServletResponse res) {
		Cookie[] cookies = req.getCookies();
		String path = "";
		if (cookies != null) {
            // 쿠키에서 패스 읽기
			for (Cookie cookie : cookies) {
                if (cookie.getName().equals("kakaoLogoutPath")) {
                	path = cookie.getValue();
                    break;
                }
            }
            
            // 쿠키에서 패스 지우기
			Cookie kakaoPathCookie = LoginInterceptor.removeCookie("kakaoLogoutPath"); 
			System.out.println(kakaoPathCookie.getName());
			res.addCookie(kakaoPathCookie);
			
			// 로그아웃
			HttpSession ses = req.getSession();
			System.out.println("로그아웃");
			LoginCustomerVO customer = (LoginCustomerVO) ses.getAttribute("loginCustomer");
			if (customer != null) {
				ses.removeAttribute("loginCustomer");
				ses.invalidate();
				req.getSession(true);
				
				// 장바구니 로그아웃
				cartLogout(customer, req, res);

				// 쿠키 제거
				Cookie autoLoginCookie = LoginInterceptor.removeCookie("autoLogin");
				res.addCookie(autoLoginCookie);
				
				// DB의 세션값 제거
				String uuid = customer.getUuid();
				AutoLoginSessionDTO sessionDTO = new AutoLoginSessionDTO(uuid, null);
				try {
					lService.rememberAutoLogin(sessionDTO);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
		
		return "redirect:" + path;
		
	}
	
	
	
}
