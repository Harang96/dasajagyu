package com.cafe24.goott351.user.order.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.user.order.service.CartService;

@Controller
@RequestMapping("/cart/*")
public class CartController {

	@Inject
	CartService cService;

	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public ResponseEntity<Object> addProduct(HttpServletRequest req, HttpServletResponse resp, @RequestParam("productNo") String productNo, @RequestParam("qty") String qty) {
		System.out.println("상품 넣기 = " + productNo + ", 수량" + qty);

		// 이전페이지 주소 저장
		//String referer = req.getHeader("Referer");

		HttpSession reqSes = req.getSession();

//		System.out.println(reqSes.getId());
//		System.out.println(reqSes.getAttribute("loginCustomer"));
		
		

		String member = "";
		String cartOriginId = "";
		// 로그인 유무 판단!
		if (reqSes.getAttribute("loginCustomer") != null) {
			LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
			cartOriginId = customer.getUuid();
			member = "member";
		} else {
			cartOriginId = reqSes.getId();
			member = "nonMember";
		}

		
		Cookie cartId = WebUtils.getCookie(req, "cartId");
		// 카드 쿠키 유무 판단
		// 없으면 쿠키생성, 있으면 바로 다음으로
		if (cartId == null) {
			Cookie idcookie = new Cookie("cartId", cartOriginId);
			idcookie.setPath("/");
			idcookie.setMaxAge(24 * 60 * 60);
			resp.addCookie(idcookie);
		} else {
			if(cartId.getValue().length() > 32 && member == "nonMember") {
				Cookie idcookie = new Cookie("cartId", cartOriginId);
				idcookie.setPath("/");
				idcookie.setMaxAge(24 * 60 * 60);
				resp.addCookie(idcookie);
			} else {
				cartOriginId = cartId.getValue();				
			}
		}
		
		if(cService.getCartQtyInfo(cartOriginId, member, productNo) == 1) {
			cService.addProductToCart(cartOriginId, member, productNo, "0");
		} else {
			cService.addProductToCart(cartOriginId, member, productNo, qty);
		}

		Cookie cartCnt = WebUtils.getCookie(req, "cartCnt");
		int cartListCnt = cService.getCartListCnt(cartOriginId, member);
		// 장바구니 수량
		if (cartCnt == null) {
			Cookie cntcookie = new Cookie("cartCnt", cartListCnt + "");
			cntcookie.setPath("/");
			cntcookie.setMaxAge(24 * 60 * 60);
			resp.addCookie(cntcookie);
		} else {
			cartCnt.setValue(cartListCnt + "");
			cartCnt.setPath("/");
			cartCnt.setMaxAge(24 * 60 * 60);
			resp.addCookie(cartCnt);
		}
		
		ResponseEntity<Object> result = new ResponseEntity<Object>("success", HttpStatus.OK);

		//return "redirect:" + referer;
		return result;
	}

	@RequestMapping("removeCart")
	public String removeCart(HttpServletRequest req, HttpServletResponse resp, @RequestParam("productNo") String productNo) {
		// 이전페이지 주소 저장
		//String referer = req.getHeader("Referer");

		HttpSession reqSes = req.getSession();

		Cookie cartId = WebUtils.getCookie(req, "cartId");

		String member = "";
		String cartOriginId = cartId.getValue();
		// 로그인 유무 판단!
		if (reqSes.getAttribute("loginCustomer") != null) {
			member = "member";
		} else {
			member = "nonMember";
		}

		cService.removeCartList(cartOriginId, member, productNo);

		Cookie cartCnt = WebUtils.getCookie(req, "cartCnt");
		int cartListCnt = cService.getCartListCnt(cartOriginId, member);
		cartCnt.setValue(cartListCnt + "");
		cartCnt.setPath("/");
		cartCnt.setMaxAge(24 * 60 * 60);
		resp.addCookie(cartCnt);

//		return "redirect:" + referer;
		return null;
	}

	@RequestMapping("updateQty")
	public String updateQty(Model model, HttpServletRequest req, HttpServletResponse resp, @RequestParam Map<String, Object> param) throws IOException {
		System.out.println(param.get("pdNo"));

		String pdNo = (String) param.get("pdNo");
		String qty = (String) param.get("qty");

		HttpSession reqSes = req.getSession();
		String member = "";
		String cartOriginId = "";
		if (reqSes.getAttribute("loginCustomer") != null) {
			LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
			cartOriginId = customer.getUuid();
			member = "member";
		} else {
			cartOriginId = reqSes.getId();
			member = "nonMember";
		}
		cService.addProductToCart(cartOriginId, member, pdNo, qty);

		/*
		 * int newQty = cService.getCartOneList(cartOriginId, member ,pdNo);
		 * 
		 * String result = pdNo + "_" + newQty;
		 * 
		 * PrintWriter out = resp.getWriter(); out.print(result);
		 */
		Map<String, Object> map = null;
		map = cService.getCartList(cartOriginId, member);
		if (map != null) {
			model.addAttribute("cartList", map.get("cartList"));
		} else if (map == null) {
			model.addAttribute("cartList", null);
		}
		
		return null;

	}

	@RequestMapping("viewCart")
	public String viewCart(HttpServletRequest req,HttpServletResponse resp, Model model) {
		System.out.println("카트리스트 불러오기");

		HttpSession reqSes = req.getSession();
		String member = "";

		if (reqSes.getAttribute("loginCustomer") != null) {
			member = "member";
		} else {
			member = "nonMember";
		}

		Map<String, Object> map = null;
		Cookie cartId = WebUtils.getCookie(req, "cartId");

		if (cartId != null) {
			map = cService.getCartList(cartId.getValue(), member);
		}
		
		if(map != null) {
			Cookie cartCnt = WebUtils.getCookie(req, "cartCnt");
			int cartListCnt = cService.getCartListCnt(cartId.getValue(), member);
			cartCnt.setValue(cartListCnt + "");
			cartCnt.setPath("/");
			cartCnt.setMaxAge(24 * 60 * 60);
			resp.addCookie(cartCnt);
		}
		
		
		if (map != null) {
			model.addAttribute("cartList", map.get("cartList"));
		} else if (map == null) {
			model.addAttribute("cartList", null);
		}

		return "cart";
	}

}