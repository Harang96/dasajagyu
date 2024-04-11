package com.cafe24.goott351.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.cafe24.goott351.domain.AutoLoginSessionDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.LoginDTO;
import com.cafe24.goott351.user.customer.service.LoginService;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	@Inject
	private LoginService lService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("인터셉터 작동 확인");
		boolean result = true;
		String path = request.getParameter("path");
		
		String email = (String) request.getParameter("email");
		String uuid = lService.getCustomerUUID(email);
		if (uuid != null) {
			if (lService.checkTrylog(uuid) > 4) {
				// 로그인 시 로그인 시도 횟수 체크
				result = false;
				response.sendRedirect("loginOpen?path=" + path + "&loginCheck=over&customerEmail=" + email);
			}
		}
		
		return result;
	}

	/**
	* @Method      : postHandle
	* @PackageName  : com.cafe24.goott351.interceptor.customer
	* @Description  : 로그인 인터셉터
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.27        Jooyoung Lee       postHandle
	*/
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HttpSession ses = request.getSession();
		
		if (ses.getAttribute("loginCustomer") != null) {
			LoginCustomerVO customer = (LoginCustomerVO) ses.getAttribute("loginCustomer");
			
			// 아이디 기억하기
			String rememberId = request.getParameter("rememberId");
			
			if (rememberId != null) {
				System.out.println("아이디 기억하기");
				// 쿠키에 저장
				Cookie rememberIdCookie = saveCookie("rememberId", customer.getEmail());
				response.addCookie(rememberIdCookie);
			} else if (rememberId == null){
				// 쿠키에서 제거
				Cookie rememberIdCookie = removeCookie("rememberId");
				response.addCookie(rememberIdCookie);
			}
			
			// 자동 로그인
			String autoLogin = request.getParameter("autoLogin");
			
			if (autoLogin != null) {
				String sessionKey = ses.getId();
				
				Cookie autoLoginCookie = saveCookie("autoLogin", sessionKey); 
				
				String uuid = lService.getCustomerUUID(customer.getEmail());
				
				if (uuid != null) {
					if (lService.rememberAutoLogin(new AutoLoginSessionDTO(uuid, sessionKey))) {
						response.addCookie(autoLoginCookie);
					}
				}
			}
		} else {
			System.out.println("로그인 실패 - postHandler");
			// 로그인에 실패했을 땐 아이디 저장 쿠키를 제거
			Cookie rememberIdCookie = removeCookie("rememberId"); 
			System.out.println(rememberIdCookie.getName());
			response.addCookie(rememberIdCookie);
		}
	}
	
	/**
	* @Method		: saveCookie
	* @PackageName  : com.cafe24.goott351.interceptor.customer
	* @return		: Cookie
	* @Description  : 저장용 쿠키 만들기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.28        Jooyoung Lee       자동로그인, 아이디기억
	*/
	public static Cookie saveCookie(String cookName, String cookValue) {
		Cookie saveCookie = new Cookie(cookName, cookValue);
		saveCookie.setMaxAge(5 * 365 * 24 * 60 * 60);
		saveCookie.setPath("/");
		System.out.println(saveCookie);
		
		return saveCookie;
	}
	
	/**
	* @Method		: removeCookie
	* @PackageName  : com.cafe24.goott351.interceptor.customer
	* @return		: Cookie
	* @Description  : 삭제용 쿠키 만들기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.28        Jooyoung Lee       
	*/
	public static Cookie removeCookie(String cookName) {
		Cookie deleteCookie = new Cookie(cookName, null);
		deleteCookie.setMaxAge(0);
		deleteCookie.setPath("/");
		
		return deleteCookie;
	}
	
}