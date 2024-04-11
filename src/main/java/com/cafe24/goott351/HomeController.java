package com.cafe24.goott351;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.cafe24.goott351.domain.MainReservationProductVO;
import com.cafe24.goott351.user.product.service.ProductService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private static final Timestamp before14 = new Timestamp(System.currentTimeMillis()-(1000*60*60*24*14));
	
	@Autowired
	ProductService pService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		Map<String, Object> map = null;
		map = pService.getProductListForMain();
		
		// 랜덤 상품 가져오기
		MainReservationProductVO reservationProduct = pService.getRandomReservationProduct(); 
		
		model.addAttribute("revProductListRand", map.get("revProductListRand"));
		model.addAttribute("newProductListRand", map.get("newProductListRand"));
		model.addAttribute("mdProductListRand", map.get("mdProductListRand"));
		model.addAttribute("bestProduct", map.get("bestProduct"));
		model.addAttribute("before14", before14);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("resPro", reservationProduct);
		
		return "home";
	}

	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String admin(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "redirect:/admin/sales/openSalesMain";
	}
	
	
}
