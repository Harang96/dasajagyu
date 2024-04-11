package com.cafe24.goott351.board.share.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafe24.goott351.board.share.service.ShareBoardService;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.ModifyShareBoardDTO;
import com.cafe24.goott351.domain.PageSearchDTO;
import com.cafe24.goott351.domain.ShareBoardImgVO;
import com.cafe24.goott351.domain.ShareBoardLikeDTO;
import com.cafe24.goott351.domain.ShareBoardReplyContentDTO;
import com.cafe24.goott351.domain.ShareBoardReplyDTO;
import com.cafe24.goott351.domain.ShareBoardReplyVO;
import com.cafe24.goott351.domain.ShareBoardReplyWriteDTO;
import com.cafe24.goott351.domain.ShareBoardVO;
import com.cafe24.goott351.domain.WrittenSharePostDTO;
import com.cafe24.goott351.interceptor.LoginInterceptor;
import com.cafe24.goott351.util.GetIpFromRequest;
import com.cafe24.goott351.util.SbPagingInfo;

@Controller
@RequestMapping("/board/*")
public class ShareBoardController {
	@Inject
	private ShareBoardService sbService;
	
	/**
	* @Method		: shareBoardOpen
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: String
	* @Description  : 정보 공유 게시판 열기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.06        Jooyoung Lee       
	*/
	@RequestMapping(value="shareBoardOpen", method=RequestMethod.GET)
	public String shareBoardOpen(Model m, HttpServletRequest req, HttpServletResponse res, @RequestParam(value="pageNo", defaultValue="1") int pageNo,
			@RequestParam(value="searchType", defaultValue="") String searchType, @RequestParam(value="searchWord", defaultValue="") String searchWord) {
		Map<String, Object> result = null;
		PageSearchDTO ps = new PageSearchDTO(pageNo, searchType, searchWord);
		
		try {
			result = sbService.getAllListOfShareBoard(ps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		m.addAttribute("sbList", result.get("sbList"));
		m.addAttribute("pagingInfo", result.get("pi"));
		m.addAttribute("popPost", result.get("popPost"));
		
		return "board/listOfShareBoard";
	}
	
	/**
	* @Method		: openWriteShareBoardPost
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: String
	* @Description  : 정보 공유 게시판 글쓰기 열기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.06        Jooyoung Lee       
	*/
	@RequestMapping(value="writeShareBoard", method=RequestMethod.GET)
	public String openWriteShareBoardPost() {
		return "board/writeShareBoardPost";
	}
	
	/**
	* @Method		: saveWrittenPost
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: String
	* @Description  : 정보 공유 게시판 게시글 저장
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.06        Jooyoung Lee       
	*/
	@RequestMapping(value="saveWrittenShareBoardPost", method=RequestMethod.POST)
	public String saveWrittenPost(WrittenSharePostDTO post, RedirectAttributes rttr, HttpServletResponse res) {
		System.out.println(post);
		String returnPath = "redirect:shareBoardOpen";
		
		if (post != null) {
			try {
				if (sbService.saveWrittenPost(post) == "point") {
					Cookie cookie = LoginInterceptor.saveCookie("pointSuccess", "");
					res.addCookie(cookie);
				} else {
					Cookie cookie = LoginInterceptor.saveCookie("writeSuccess", "");
					res.addCookie(cookie);
				}
			} catch (Exception e) {
				e.printStackTrace();
				
				Cookie cookie = LoginInterceptor.saveCookie("writeFail", "");
				res.addCookie(cookie);
				returnPath = "redirect:writeShareBoard";
			}
		} else {
			Cookie cookie = LoginInterceptor.saveCookie("writeFail", "");
			res.addCookie(cookie);
			returnPath = "redirect:writeShareBoard";
		}

		return returnPath;
	}
	
	/**
	* @Method		: openSharePost
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: String
	* @Description  : 게시글 보기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.08        Jooyoung Lee       
	*/
	@RequestMapping(value="openSharePost", method=RequestMethod.GET)
	public String openSharePost(@RequestParam("boardNo") int boardNo, Model m, HttpServletRequest req, HttpServletResponse res, RedirectAttributes rttr) {
		String result = "board/openSharePost";
		LoginCustomerVO customer = (LoginCustomerVO) req.getSession().getAttribute("loginCustomer");
		
		Map<String, Object> post = new HashMap<String, Object>();
		try {
			post = sbService.getPostByNo(boardNo);
			
			ShareBoardVO sb = (ShareBoardVO) post.get("post");
			
			if (sb != null) { // 게시글을 가져왔을 때
				// 조회수 관련
				if (customer != null) { // 로그인 한 유저가 있을 때
					sbService.setBoardReadWhenLogin(sb, customer);
					
					putModelaAttribute(m, boardNo);
					
				} else { // 로그인 한 유저가 없을 때
					String userIp = GetIpFromRequest.getIp(req);
					sbService.setBoardReadNotLogin(sb, userIp);
					
					putModelaAttribute(m, boardNo);
				}
	
			} else { // 가져온 게시글이 null일 때
				Cookie cookie = LoginInterceptor.saveCookie("getPostFail", "");
				res.addCookie(cookie);
				result = "redirect:shareBoardOpen";
			}
		} catch (Exception e) {
			e.printStackTrace();
			Cookie cookie = LoginInterceptor.saveCookie("getPostFail", "");
			res.addCookie(cookie);
			result = "redirect:shareBoardOpen";
		}
		
		return result;
	}

	/**
	* @Method		: putModelaAttribute
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: void
	* @Description  : 게시글 열 때 정보 담기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.08        Jooyoung Lee       Model에 담기	       
	*/
	private void putModelaAttribute(Model m, int boardNo) throws Exception {
		Map<String, Object> post = sbService.getPostByNo(boardNo);
		ShareBoardVO sb = (ShareBoardVO) post.get("post");
		List<ShareBoardReplyVO> sre = (List<ShareBoardReplyVO>) post.get("postReply");
		SbPagingInfo rPi = (SbPagingInfo) post.get("replyPaging");
		
		m.addAttribute("post", sb);
		if (sre != null) {
			m.addAttribute("postReply", sre);
		}
		m.addAttribute("replyPaging", rPi);
	}
	
	/**
	* @Method		: removeSharePost
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: String
	* @Description  : 게시글 삭제
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.10        Jooyoung Lee       
	*/
	@RequestMapping(value="removeSharePost", method=RequestMethod.GET)
	public String removeSharePost(@RequestParam("boardNo") String boardNo, RedirectAttributes rttr, HttpServletResponse res) {
		String returnPath = "redirect:shareBoardOpen";
		
		try {
			if (sbService.removeSharePost(boardNo) == 1) {
				Cookie cookie = LoginInterceptor.saveCookie("deleteSuccess", "success");
				res.addCookie(cookie);
			} else {
				Cookie cookie = LoginInterceptor.saveCookie("deleteFail", "fail");
				res.addCookie(cookie);
				
				returnPath = "redirect:openSharePost?boardNo=" + boardNo;
			}
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("deleteStatus", "fail");
			returnPath = "redirect:openSharePost?boardNo=" + boardNo;
		}
		
		return returnPath;
	}
	
	/**
	* @Method		: openModifyPost
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: String
	* @Description  : 게시글 수정 창 열기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.10        Jooyoung Lee       
	*/
	@RequestMapping(value="openModifyPost", method=RequestMethod.GET)
	public String openModifyPost(@RequestParam("boardNo") int boardNo, Model m, RedirectAttributes rttr, HttpServletResponse res) {
		String returnPath = "board/modifySharePost";
		
		Map<String, Object> post = new HashMap<String, Object>();
		try {
			post = sbService.getPostByNo(boardNo);

			ShareBoardVO sb = (ShareBoardVO) post.get("post");
			
			if (sb != null) {
				putModelaAttribute(m, boardNo);
			} else {
				Cookie cookie = LoginInterceptor.saveCookie("openModifyFail", "");
				res.addCookie(cookie);
				returnPath = "redirect:openSharePost?boardNo=" + boardNo;
			}
		} catch (Exception e) {
			e.printStackTrace();
			Cookie cookie = LoginInterceptor.saveCookie("openModifyFail", "");
			res.addCookie(cookie);
			returnPath = "redirect:openSharePost?boardNo=" + boardNo;
		}
		
		return returnPath;
	}
	
	/**
	* @Method		: modifyShareBoardPost
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: String
	* @Description  : 게시글 수정
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.10        Jooyoung Lee       
	*/
	@RequestMapping(value="modifyShareBoardPost", method=RequestMethod.POST)
	public String modifyShareBoardPost(ModifyShareBoardDTO post, RedirectAttributes rttr, HttpServletResponse res) {
		String returnPath = "redirect:openSharePost?boardNo=" + post.getBoardNo();

		try {
			if (sbService.modifyPost(post) == 1) {
				Cookie cookie = LoginInterceptor.saveCookie("modifySuccess", "");
				res.addCookie(cookie);
			} else {
				Cookie cookie = LoginInterceptor.saveCookie("modifyFail", "");
				res.addCookie(cookie);
				returnPath = "redirect:openModifyPost?boardNo=" + post.getBoardNo();
			}
		} catch (Exception e) {
			e.printStackTrace();
			Cookie cookie = LoginInterceptor.saveCookie("modifyFail", "");
			res.addCookie(cookie);
			returnPath = "redirect:openModifyPost?boardNo=" + post.getBoardNo();
		}		
		
		return returnPath;
	}
	
	/**
	* @Method		: checkShareLike
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: ResponseEntity<String>
	* @Description  : 게시글 로드 후 좋아요 눌렀는지 확인
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.11        Jooyoung Lee       
	*/
	@RequestMapping(value="checkShareLike", method=RequestMethod.GET)
	public ResponseEntity<String> checkShareLike(ShareBoardLikeDTO likeInfo) {
		ResponseEntity<String> rs = null;
		
		try {
			if (sbService.checkLike(likeInfo)) {
				rs = new ResponseEntity<String>("find", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			rs = new ResponseEntity<String>("fail", HttpStatus.FORBIDDEN);
		}
		
		return rs;
	}
	
	/**
	* @Method		: likeSharePost
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: ResponseEntity<Integer>
	* @Description  : 좋아요
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.11        Jooyoung Lee       
	*/
	@RequestMapping(value="likeSharePost", method=RequestMethod.GET)
	public ResponseEntity<Integer> likeSharePost(ShareBoardLikeDTO likeInfo) {
		ResponseEntity<Integer> rs = null;
		
		int likeCount = -1;
		
		try {
			likeCount = sbService.likePost(likeInfo);
			if (likeCount != -1) {
				rs = new ResponseEntity<Integer> (likeCount, HttpStatus.OK);
			} else {
				rs = new ResponseEntity<Integer>(likeCount, HttpStatus.FORBIDDEN);
			}
		} catch (Exception e) {
			e.printStackTrace();
			rs = new ResponseEntity<Integer>(likeCount, HttpStatus.FORBIDDEN);
		}
		
		
		return rs;
	}
	
	/**
	* @Method		: dislikeSharePost
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: ResponseEntity<Map<String,Object>>
	* @Description  : 좋아요 취소
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.11        Jooyoung Lee       
	*/
	@RequestMapping(value="dislikeSharePost", method=RequestMethod.GET)
	public ResponseEntity<Integer> dislikeSharePost(ShareBoardLikeDTO likeInfo) {
		ResponseEntity<Integer> rs = null;
		
		int likeCount = -1;
		
		try {
			likeCount = sbService.dislikePost(likeInfo);
			if (likeCount != -1) {
				rs = new ResponseEntity<Integer> (likeCount, HttpStatus.OK);
			} else {
				rs = new ResponseEntity<Integer>(likeCount, HttpStatus.FORBIDDEN);
			}
		} catch (Exception e) {
			e.printStackTrace();
			rs = new ResponseEntity<Integer>(likeCount, HttpStatus.FORBIDDEN);
		}
		
		
		return rs;
	}
	
	
	/**
	* @Method		: writeShareReply
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: ResponseEntity<Integer>
	* @Description  : 댓글 입력
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.12        Jooyoung Lee       
	*/
	@RequestMapping(value="writeShareReply", method=RequestMethod.POST)
	public ResponseEntity<String> writeShareReply(ShareBoardReplyWriteDTO reply) {
		ResponseEntity<String> result = null;
		
		try {
			if (sbService.writeReply(reply) == 1) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	* @Method		: getShareReply
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: ResponseEntity<Map<String,Object>>
	* @Description  : 댓글 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.13        Jooyoung Lee       
	*/
	@RequestMapping(value="getShareReply", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getShareReply(ShareBoardReplyDTO reply) {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> replyMap = new HashMap<String, Object>();
		
		try {
			replyMap = sbService.getReplyByBoardNO(reply);
			
			result = new ResponseEntity<Map<String,Object>> (replyMap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<Map<String,Object>> (replyMap, HttpStatus.FORBIDDEN);
		}
		
		return result;
	}
	
	/**
	* @Method		: removeShareReply
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: ResponseEntity<String>
	* @Description  : 댓글 삭제
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.14        Jooyoung Lee       
	*/
	@RequestMapping(value="removeShareReply", method=RequestMethod.POST)
	public ResponseEntity<String> removeShareReply(@RequestParam("replyNo") int replyNo) {
		ResponseEntity<String> result = null;
		
		try {
			if (sbService.removeReply(replyNo) == 1) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	* @Method		: modifyShareReply
	* @PackageName  : com.cafe24.goott351.user.board.controller
	* @return		: ResponseEntity<String>
	* @Description  : 댓글 수정
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.14        Jooyoung Lee       
	*/
	@RequestMapping(value="modifyShareReply", method=RequestMethod.POST)
	public ResponseEntity<String> modifyShareReply(ShareBoardReplyContentDTO reply) {
		ResponseEntity<String> result = null;
		
		try {
			if (sbService.modifyReply(reply) == 1) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
