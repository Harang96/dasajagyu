package com.cafe24.goott351.user.mypage.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.ServiceBoardDTO;
import com.cafe24.goott351.domain.ServiceBoardVO;
import com.cafe24.goott351.user.mypage.service.CustomerCenterService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/contact")
public class CustomerCenterController {

	@Inject
	private CustomerCenterService ccs;

	@RequestMapping(value = "/myInquiry", method = RequestMethod.GET)
	private String myInquiry(Model model, @RequestParam(value = "no", defaultValue = "-1") int svBoardNo)
			throws Exception {

		// Service_board 테이블에서 모든 데이터 가져오기
		List<ServiceBoardDTO> lst = ccs.selectQnaBoardList(new ServiceBoardDTO("qna"));

		System.out.println("qna 리스트 가져오는지 보기 " + lst);

		model.addAttribute("qnaList", lst);

		return "csCenter/customerCenterInqLst";
	}

	@GetMapping("faq")
	@RequestMapping(value = "/faq", method = RequestMethod.GET)
	private String faqList(Model model, @RequestParam(value = "no", defaultValue = "-1") int svBoardNo, HttpSession ses)
			throws Exception {

		// Service_board 테이블에서 모든 데이터 가져오기
		List<ServiceBoardDTO> lst = ccs.selectQnaBoardList(new ServiceBoardDTO("faq"));
		LoginCustomerVO customer = (LoginCustomerVO) (ses.getAttribute("loginCustomer"));

		boolean isAdmin = false;
		if (customer != null) {
			if (customer.getIsAdmin().equals("M") || customer.getIsAdmin().equals("A")) {
				isAdmin = true;
			}
		}

		model.addAttribute("faqList", lst);

		return "csCenter/customerCenterFAQLst";
	}

	@RequestMapping(value = "/faq/detail", method = RequestMethod.GET)
	private String faqBoardDetail(Model model, @RequestParam(value = "no", defaultValue = "-1") Integer svBoardNo)
			throws Exception {

		// Service_board 테이블에서 해당 게시글의 데이터 가져오기
		ServiceBoardVO row = ccs.selectQnaBoard(new ServiceBoardDTO(svBoardNo));

		if (row.getCommentBoardNo() != null) {
			ServiceBoardVO commentBoard = ccs.selectQnaBoard(new ServiceBoardDTO(row.getCommentBoardNo()));
			model.addAttribute("commentBoard", commentBoard);
		}
		model.addAttribute("data", row);

		return "csCenter/customerCenterFAQDtil";
	}

	@GetMapping("qna")
	@RequestMapping(value = "/qna", method = RequestMethod.GET)
	private String qnaBoard(Model model, @RequestParam(value = "no", defaultValue = "-1") int svBoardNo,
			HttpSession ses) throws Exception {

		// Service_board 테이블에서 모든 데이터 가져오기
		List<ServiceBoardDTO> lst = ccs.selectQnaBoardList(new ServiceBoardDTO("qna"));
		LoginCustomerVO customer = (LoginCustomerVO) (ses.getAttribute("loginCustomer"));

		boolean isAdmin = false;
		if (customer != null) {
			if (customer.getIsAdmin().equals("M") || customer.getIsAdmin().equals("A")) {
				isAdmin = true;
			}
		}

		model.addAttribute("qnaList", lst);

		return "csCenter/customerCenterQnALst";
	}

	@RequestMapping(value = "/qna/detail", method = RequestMethod.GET)
	private String qnaBoardDetail(Model model, @RequestParam(value = "no", defaultValue = "-1") Integer svBoardNo)
			throws Exception {

		// Service_board 테이블에서 해당 게시글의 데이터 가져오기
		ServiceBoardVO row = ccs.selectQnaBoard(new ServiceBoardDTO(svBoardNo));

		if (row.getCommentBoardNo() != null) {
			ServiceBoardVO commentBoard = ccs.selectQnaBoard(new ServiceBoardDTO(row.getCommentBoardNo()));
			model.addAttribute("commentBoard", commentBoard);
		}
		model.addAttribute("data", row);

		return "csCenter/customerCenterQnADtil";
	}

	@RequestMapping(value = "/findOrder", method = RequestMethod.GET)
	private String noMemOrderInq() throws Exception {
		return "csCenter/customerCenterSrchOrder";
	}

	@RequestMapping(value = "/newWrite", method = RequestMethod.GET)
	private String newWrite(Model model, @ModelAttribute ServiceBoardDTO post) throws Exception {

		model.addAttribute("svType", post.getSvType());
		if (post.getCommentBoardNo() != null) {
			model.addAttribute("commentBoardNo", post.getCommentBoardNo());
		}

		return "csCenter/newWrite";
	}

	@RequestMapping(value = "/editWrite", method = RequestMethod.GET)
	private String editWrite(Model model, @ModelAttribute ServiceBoardDTO post) throws Exception {
		System.out.println(post.getSvBoardNo() + "글수정 페이지 진입.");

		// Service_board 테이블에서 헤딩 글 데이터 가져오기
		ServiceBoardVO postObj = ccs.selectQnaBoard(post);
		ObjectMapper objectMapper = new ObjectMapper();

		System.out.println("post :: " + objectMapper.writeValueAsString(post));

		model.addAttribute("svType", post.getSvType());
		model.addAttribute("post", objectMapper.writeValueAsString(postObj));

		return "csCenter/editWrite";
	}

	@RequestMapping(value = "/deleteWrite", method = RequestMethod.GET)
	private String deleteWrite(Model model, @ModelAttribute ServiceBoardDTO post) throws Exception {
		String returnPath = "";
		if (post.getSvIsHidden() == null) {
			post.setSvIsHidden("Y");
		}
		if (post.getSvIsDelete() == null) {
			post.setSvIsDelete("Y");
		}
		System.out.println("글삭제 , " + post);

		if (post != null) {
			try {
				int updateResult = ccs.updatePostSoftDelete(post.getSvBoardNo()); // 게시글 삭제
				System.out.println("updateResult :: " + updateResult);
				int updateResult2 = ccs.updatePostHidden(post.getSvIsHidden()); // isHidden 수정
				System.out.println("updateResult2 :: " + updateResult2);
				if (updateResult == 1) {
					returnPath = post.getSvType();
					System.out.println("글삭제 성공!" + returnPath);
				}
			} catch (Exception e) {
				e.printStackTrace();
				returnPath = "customerCenterError";
			}
		}
		return "redirect:" + returnPath;
	}

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	private String write(@ModelAttribute ServiceBoardDTO post) throws Exception {
		String returnPath = "";

		if (post.getOrderNo().equals("")) {
			post.setOrderNo(null);
		}
		System.out.println("새글저장");

		if (post != null) {

			try {
				int result;
				ServiceBoardDTO postObject = null;
				if (post.getCommentBoardNo() != null) {
					postObject = ccs.insertNewPostAdmin(post);
					result = 1;
				} else {
					result = ccs.insertNewPost(post);
				}

				if (result == 1 && post.getCommentBoardNo() != null) {
					returnPath = post.getSvType() + "/detail?no=" + post.getCommentBoardNo();
					System.out.println("글쓰기 성공!" + returnPath);
				} else if (result == 1) {
					returnPath = post.getSvType() + "/detail?no=" + post.getSvBoardNo();
					System.out.println("글쓰기 성공!" + returnPath);
				} else if (result == -1) {
					returnPath = "customerCenterError";
					System.out.println("글쓰기 실패!");
				}
			} catch (Exception e) {
				e.printStackTrace();
				returnPath = "customerCenterError";
			}

		}
		return "redirect:" + returnPath;
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	private String modify(@ModelAttribute ServiceBoardDTO post) throws Exception {
		String returnPath = "";

		if (post.getOrderNo().equals("")) {
			post.setOrderNo(null);
		}
		if (post.getSvIsHidden() == null) {
			post.setSvIsHidden("N");
		}
		if (post.getSvIsDelete() == null) {
			post.setSvIsDelete("N");
		}
		if (post.getProductNo() == 0) {
			post.setProductNo(null);
		}
		System.out.println("글수정 , " + post);

		if (post != null) {
			try {
				int updateResult = ccs.updatePost(post); // 게시글 수정
				System.out.println("updateResult :: " + updateResult);
				int updateResult2 = ccs.updatePostHidden(post.getSvIsHidden()); // isHidden 수정
				System.out.println("updateResult2 :: " + updateResult2);
				if (updateResult == 1) {
					returnPath = post.getSvType() + "/detail?no=" + post.getSvBoardNo();
					System.out.println("글수정 성공!" + returnPath);
				}
			} catch (Exception e) {
				e.printStackTrace();
				returnPath = "customerCenterError";
			}
		}
		return "redirect:" + returnPath;
	}

	private boolean checkIsAdmin(String uuid) throws Exception {
		boolean result = false;
		if (uuid != null) {
			if (!uuid.equals("")) {
				String userType = ccs.selectUserIsAdmin(uuid).getIs_admin();
				if (userType.equals("M") || userType.equals("A")) {
					result = true;
				}
			}
		}

		return result;
	}

	@RequestMapping("/customerCenterError")
	private String error() throws Exception {
		String returnPath = "";

		System.out.println("에러");

		return "csCenter/customerCenterError";
	}

}
