/**
 * 
 */
package com.cafe24.goott351.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author : su hyeok kim
 * @date : 2024. 3. 12.
 * @description : 가상계좌에서 입금 확인될 경우 프로세스를 처리하기위한 인터셉터
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 3. 12.
 */
public class CheckDepositInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 특정 컨트롤러 호출 전에 실행할 작업
		return true; // true 반환 시 다음 단계 진행, false 반환 시 중단
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// 특정 컨트롤러 호출 후에 실행할 작업

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// 특정 컨트롤러 호출 후에 완료된 후 실행할 작업

	}

}
