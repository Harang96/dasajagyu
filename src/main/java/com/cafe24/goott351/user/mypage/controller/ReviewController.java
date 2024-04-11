package com.cafe24.goott351.user.mypage.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderProductVO;
import com.cafe24.goott351.domain.ProductReviewDTO;
import com.cafe24.goott351.domain.ProductReviewVO;
import com.cafe24.goott351.user.mypage.service.ReviewService;

@Controller
@RequestMapping("/mypage/*")
public class ReviewController {
	
	@Inject
	private ReviewService rService;
	
	@RequestMapping("reviewable")
	public String reviewable(HttpSession session, Model model) throws Exception {
		String uuid = ((LoginCustomerVO) session.getAttribute("loginCustomer")).getUuid();
		System.out.println("리뷰 회원 : " + uuid);
		
		List<ProductReviewVO> list = rService.getReviewableList(uuid);
		int count = rService.getCountOfReviewable(uuid);
		
		System.out.println(list);
		
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		
		return "mypage/reviewable";
	}
	
	@RequestMapping("moreReviewable")
	@ResponseBody
	public List<ProductReviewVO> moreReviewable(@RequestParam("page") int page, HttpSession session, Model model) throws Exception {
		String uuid = ((LoginCustomerVO) session.getAttribute("loginCustomer")).getUuid();
		
		List<ProductReviewVO> list = rService.getReviewableList(uuid, page);
		System.out.println(list);
		
		return list;
	}
	
	@RequestMapping("wroteReviews")
	public String wroteReviews(HttpSession session, Model model) throws Exception {
		String uuid = "";
		uuid = ((LoginCustomerVO) session.getAttribute("loginCustomer")).getUuid();
		System.out.println("리뷰 회원 : " + uuid);
		List<ProductReviewVO> list = rService.getWroteReviewsList(uuid);
		System.out.println(list);
		
		model.addAttribute("list", list);
		
		return "mypage/wroteReviews";
	}
	
	@RequestMapping("writeReview")
	public String getWriteReview(@RequestParam("productNo") int productNo, @RequestParam("orderNo") String orderNo, 
			Model model, HttpSession session) throws Exception {
		String uuid = "";
		uuid = ((LoginCustomerVO) session.getAttribute("loginCustomer")).getUuid();
		System.out.println("리뷰 회원 : " + uuid);
			
		if(rService.getOrderUUID(orderNo).equals(uuid)) {
			ProductReviewVO product = rService.getReviewableProduct(productNo, orderNo);
			model.addAttribute("product", product);
			return "mypage/writeReview";
		} else {
			return "redirect:reviewable?fail=NotValid";
		}
	}
	
	@RequestMapping(value="writeReview", method=RequestMethod.POST)
	public String postWriteReview(@ModelAttribute ProductReviewDTO review, List<MultipartFile> uploadFile) throws Exception {
		System.out.println(review);
		System.out.println(uploadFile);
		review.setReviewStar(review.getReviewStar()/2);
		
		if(rService.writeProductReview(review, uploadFile)) {
			return "redirect:wroteReviews";
		} else {
			return "redirect:reviewable?fail=db";
		}
	}
	
	@RequestMapping("modifyReview")
	public String getModifyReview(@RequestParam int no, Model model, HttpSession session) throws Exception {
		ProductReviewVO review = rService.getReviewByNo(no);
		if(review != null) {
			if(review.getUuid().equals(((LoginCustomerVO)session.getAttribute("loginCustomer")).getUuid())) {
				model.addAttribute("review", review);
				return "mypage/modifyReview";
			} else {
				return "redirect:wroteReviews?fail=NotValid";
			}
		} else {
			return "redirect:wroteReviews?fail=null";
		}
	}
	
	@RequestMapping(value="modifyReview", method=RequestMethod.POST)
	public String postModifyReview(@ModelAttribute ProductReviewDTO review, List<MultipartFile> uploadFile) throws Exception {
		System.out.println(review);
		System.out.println(uploadFile);
		review.setReviewStar(review.getReviewStar()/2);
		if(rService.modifyProductReview(review, uploadFile)) {
			return "redirect:wroteReviews";
		} else {
			return "redirect:wroteReviews?fail=db";
		}
	}
	
	@RequestMapping(value="deleteReview", method=RequestMethod.GET)
	public ResponseEntity<String> deleteReview(@RequestParam int no, HttpSession session) throws Exception {
		System.out.println("리뷰 삭제하러왓읍니다요 "+no+"번 리뷰");
		ProductReviewVO review = rService.getReviewByNo(no);
		if(review.getUuid().equals(((LoginCustomerVO)session.getAttribute("loginCustomer")).getUuid())) {
			if(rService.removeProductReview(new ProductReviewDTO(review.getReviewNo(), review.getProductNo(), review.getOrderNo()))) {
				return ResponseEntity.ok().body("success");
			} else {
				return ResponseEntity.badRequest().body("db");
			}
		} else {
			return ResponseEntity.badRequest().body("fail_NotValid");
		}
	}

	@RequestMapping(value="deleteImg", method=RequestMethod.GET)
	public ResponseEntity<String> deleteImg(@RequestParam int no, HttpSession session) throws Exception {
		System.out.println(no+"번 이미지 삭제하러 ㄱ");
		if(rService.removeImageByImgNo(no)){
			return ResponseEntity.ok().body("success");
		} else {
			return ResponseEntity.badRequest().body("db");
		}
	}
	
	
}
