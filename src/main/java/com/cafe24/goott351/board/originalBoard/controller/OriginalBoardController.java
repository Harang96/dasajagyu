package com.cafe24.goott351.board.originalBoard.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.board.originalBoard.etc.GetUserIPAddr;
import com.cafe24.goott351.board.originalBoard.service.OriginalBoardService;
import com.cafe24.goott351.domain.OriginalBoardDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyVO;
import com.cafe24.goott351.domain.OriginalBoardUploadedFileDTO;
import com.cafe24.goott351.domain.OriginalBoardVO;
import com.cafe24.goott351.domain.OriginalImgVO;
import com.cafe24.goott351.util.UploadOriginalFile;






@Controller
@RequestMapping("/board/*")
public class OriginalBoardController {
	
	@Inject
	OriginalBoardService bService;
	

 
	
	private static final Logger logger = LoggerFactory.getLogger(OriginalBoardController.class);
	private List<OriginalImgVO> imgList = new ArrayList<OriginalImgVO>();
    

	@RequestMapping("originalBoard")
	public void workboard(Model model, @RequestParam(value="originalCategory", defaultValue = "1") int originalCategory,
									 @RequestParam(value="categoryNo", defaultValue =" 3") int categoryNo,
									 @RequestParam(value="pageNo", defaultValue="1") int pageNo,
									 HttpSession ses, HttpServletRequest req) throws Exception {
	    
			
		
		    logger.info(pageNo + "페이지의 게시판 글조회가 호출됨");
		    logger.info(categoryNo + "카테고리 분류가 필요함");       
		    logger.info(originalCategory + "작품 카테고리 분류함");
		    Map<String, Object> map = bService.getEntireBoard(pageNo , categoryNo, originalCategory);
		    model.addAttribute("boardList", map.get("boardList")); // 바인딩
		    model.addAttribute("pagingInfo", map.get("pagingInfo"));
		    model.addAttribute("categoryList", map.get("categorylst"));
		    model.addAttribute("originalCategory", originalCategory);

		}
	
	
	
	@RequestMapping("originalWriteboard")
	public void workwriteboard(HttpSession ses, Model model, @RequestParam(value="originalCategory", defaultValue = "1") int originalCategory,
												@RequestParam(value="categoryNo", defaultValue ="3") int categoryNo) throws Exception
								 {
		logger.info("originalWriteboard가 호출됨");
		logger.info(categoryNo + "카테고리 분류가 필요함");		
		logger.info(originalCategory + "작품 카테고리 분류함");
		Map<String, Object>	map = bService.getCategoryBoard(categoryNo, originalCategory);
		
		model.addAttribute("categoryList", map.get("categorylst"));
		model.addAttribute("category", originalCategory);
		String uuid = UUID.randomUUID().toString();
		ses.setAttribute("csrfToken", uuid); // 세션에 바인딩
		
		
		
	}
	
	@RequestMapping(value="originalBoardwrite", method=RequestMethod.POST)
	public String originalwriteBoard(@ModelAttribute OriginalBoardVO requestboard, @RequestParam("csrfToken") String csrf, HttpSession ses) {
		logger.info("게시판 글 작성 newBoard : " + requestboard.toString());
		logger.info("csrf : " + csrf);
		
		String redirectPage = "";
		
//		System.out.println("뭘가져오는지 알려줘" + requestboard);

		if( (((String)ses.getAttribute("csrfToken")).equals(csrf)) ) { //scrfToken이 같을때만 게시글을 저장한다. 
			try {
				bService.saveNewBoard(requestboard, imgList, 1);
				redirectPage = "originalWriteboard";
				
			} catch (Exception e) {
//				System.out.println("break!");
				e.printStackTrace();
				redirectPage = "originalWriteboard?status=fail";
//				for(UploadedFile uf : ufList) {
//					removeFile(uf.getOriginalFileName());
//				}
			}
			
		}
		return "redirect:/board/originalBoard";
		
	}		
	

	@RequestMapping(value="originUploadFile" , method=RequestMethod.POST)
	public @ResponseBody List<OriginalImgVO> originaluploadFile(MultipartFile originaluploadFile, OriginalImgVO originalImg, HttpServletRequest req) throws Exception {
		logger.info("파일을 업로드함");
		String originalRealPath = req.getSession().getServletContext().getRealPath("resources/original");
		
		List<OriginalImgVO> result = new ArrayList<>();
		OriginalImgVO oi = null;

		try {
			String fileName = originaluploadFile.getOriginalFilename();
			boolean filePath = UploadOriginalFile.checkFile(fileName, originalRealPath);
			
			// 파일이 존재하지 않을시
			if (!filePath) {
				oi = UploadOriginalFile.originalFileUpload(fileName, originaluploadFile.getSize(),
						originaluploadFile.getContentType(), originalRealPath, originaluploadFile.getBytes(), originaluploadFile);
				if (oi != null) {
					imgList.clear();
					imgList.add(oi);
					result.add(oi);
				}
			} else {
				System.out.println("이미 존재하는 파일입니다: " + fileName);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
//		for (OriginalImgVO f : this.imgList) {
//			System.out.println("현재 파일 업로드 리스트: ");
//		}
		return imgList;

	}
	
	
	@RequestMapping("originalEditboard")
	public void originalEditboard(@RequestParam("boardNo") int boardNo,@RequestParam(value="originalCategory", defaultValue = "1") int originalCategory,
			@RequestParam(value="categoryNo", defaultValue =" 3") int categoryNo, HttpServletRequest req, Model model) throws Exception {
		
		logger.info(boardNo + "번 글을 수정하자");
		logger.info(categoryNo + "카테고리 분류가 필요함");		
		logger.info(originalCategory + "작품 카테고리 분류함");
		
		Map<String, Object> result = bService.getBoardByNo(boardNo, categoryNo, originalCategory, GetUserIPAddr.getIp(req));

		model.addAttribute("board", result.get("board"));
		model.addAttribute("categoryList", result.get("categorylst"));
		model.addAttribute("category", result.get("originalCategory"));	
	

	}
	
	
	
	
	@RequestMapping(value = "updateOriginalBoard", method = RequestMethod.POST)
	public String originEditForm(OriginalBoardDTO originalboarddto, @RequestParam(value="originalCategory", defaultValue = "1") int originalCategory,
			@RequestParam(value="categoryNo", defaultValue ="3") int categoryNo,Model model) throws Exception { 
								
//		System.out.println(categoryNo);
//		System.out.println(originalCategory + "이거지금 안찍혀?");
		logger.info(originalboarddto + "수정할꺼야");
		
		bService.boardUpdate(originalboarddto,originalCategory);
		
		
		return "redirect:/board/originalBoard";
	}
	

	@RequestMapping("originalViewboard")
	public void workviewboard(@RequestParam("boardNo") int boardNo,@RequestParam(value="originalCategory", defaultValue = "1") int originalCategory,
			@RequestParam(value="categoryNo", defaultValue =" 3") int categoryNo, HttpServletRequest req, Model model) throws Exception {
		
	
		logger.info(boardNo + "번 글을 상세조회하자!");
		logger.info(categoryNo + "카테고리 분류가 필요함");		
		logger.info(originalCategory + "작품 카테고리 분류함");
		
		Map<String, Object> result = bService.getBoardByNo(boardNo, categoryNo, originalCategory, GetUserIPAddr.getIp(req));
		
		//		List<OriginalBoardReplyVO> Replylst = bService.replylst(boardNo);
		model.addAttribute("board", result.get("board"));
		model.addAttribute("categoryList", result.get("categorylst"));
		model.addAttribute("category", originalCategory);
		model.addAttribute("likePeople", bService.getPeopleWhoLikesBoard(boardNo));
		model.addAttribute("upFileList", result.get("upFileList") );
		model.addAttribute("replylist", result.get("replylist"));
	
	
	}


	
	@RequestMapping(value = "/deleteCategory", method = RequestMethod.POST)
	public String deleteboard(int boardNo, HttpServletResponse response) throws Exception {
		System.out.println(boardNo + "번 글을 삭제하자");
		
		try {
			bService.deleteCategory(boardNo);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			// 예외 발생 시에도 보드로 리다이렉트
            throw new RuntimeException("Error updating " + e.getMessage());
	        
		}
		 return "redirect:originalBoard";
		
	}

	@RequestMapping(value = "likedislike", method = RequestMethod.POST)
	public ResponseEntity<String> likeDislike(@RequestParam("who") String who,
											  @RequestParam("boardNo") int boardNo,
											  @RequestParam("behavior") String behavior) {
												
		ResponseEntity<String> result = null;
		System.out.println(who + "님이 " + boardNo + "번 글을 " + behavior + "하신다고 합니다." );
		
		boolean dbResult = false;
		
		try {
			
			if (behavior.equals("like")) {
				dbResult = bService.likeBoard(boardNo, who);
			} else if (behavior.equals("dislike")) {
				dbResult = bService.dislikeBoard(boardNo, who);
			}
			
			if (dbResult) { 
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
		}
		
		return result;
		
	}




	public List<OriginalImgVO> getImgList() {
		return imgList;
	}



	public void setImgList(List<OriginalImgVO> imgList) {
		this.imgList = imgList;
	}
	
	
	@RequestMapping(value = "originalReply", method=RequestMethod.POST)
	public ResponseEntity<String> originalReplay(@RequestParam("parentNo") int parentNo, @RequestParam("replyContent") String replyContent,@RequestParam("replier") String replier, HttpServletRequest req) throws Exception {
		
		ResponseEntity<String> result = null;
		OriginalBoardReplyVO reply = new OriginalBoardReplyVO();
		
		reply.setReplyContent(replyContent);
	    reply.setBoardNo(parentNo);
	    reply.setUuid(replier);
	    
		bService.replyContent(reply);
		
	    return result;
	}
	
	@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
    public ResponseEntity<String> replydelete(@RequestParam("replier") String replier,
    										@RequestParam("boardNo") int boardNo,
    										@RequestParam("replyNo") int replyNo) throws Exception {
		ResponseEntity<String> result = null;
		if(bService.deleteReply(replyNo) == 1) {
			
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
		}
			
		
		return result;
	}

	

	

}
