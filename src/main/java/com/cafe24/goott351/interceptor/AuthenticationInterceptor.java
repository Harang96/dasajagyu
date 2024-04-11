package com.cafe24.goott351.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	/**
	* @Method      : preHandle
	* @PackageName  : com.cafe24.goott351.interceptor.customer
	* @Description  : 인증 인터셉터 > 로그인 페이지
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.27        Jooyoung Lee       PostHandle
	*/
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean result = false;
		
		if (request.getSession().getAttribute("loginCustomer") != null) {
			// 로그인 한 유저가 있을 때
			result = true;
		} else {
			// 로그인을 하지 않은 유저
			String uri = request.getRequestURI();
			
			System.out.println(uri);
			response.sendRedirect("/customer/loginOpen?path=" + uri);
		}
		
		return result;
	}
	
}