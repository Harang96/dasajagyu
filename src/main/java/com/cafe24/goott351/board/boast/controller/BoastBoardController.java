 package com.cafe24.goott351.board.boast.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.board.boast.etc.GetUserIPAddr;
import com.cafe24.goott351.board.boast.etc.UploadFileProcess;
import com.cafe24.goott351.board.boast.service.BoastBoardSerivce;
import com.cafe24.goott351.domain.BoardImgVO;
import com.cafe24.goott351.domain.BoardVO;
import com.cafe24.goott351.domain.SearchCriteria;
import com.cafe24.goott351.util.BbPagingInfo;

@Controller
@RequestMapping("board/*")
public class BoastBoardController {

	@Inject
	BoastBoardSerivce bbService;
	
	
	 Logger logger = LoggerFactory.getLogger(BoastBoardController.class);

	 List<BoardImgVO> fileList = new ArrayList<BoardImgVO>();
	
	@RequestMapping("listAllBoast")
	public void listAllBoastGet(Model model, @RequestParam(value="pageNo" , defaultValue= "1") int pageNo,
			@RequestParam(value="searchType", defaultValue="") String searchType,
			@RequestParam(value="searchWord", defaultValue="") String searchWord) throws Exception {
	
		
	
		SearchCriteria sc = new SearchCriteria(searchWord, searchType);
		
		bbService.getEntireBoard(pageNo, sc);
	
		
		Map<String, Object> map = bbService.getEntireBoard(pageNo, sc);
		
		model.addAttribute("boardList", (List<BoardVO>)map.get("boardList"));
		System.out.println("map" + map);
		model.addAttribute("BbPagingInfo", (BbPagingInfo)map.get("BbPagingInfo"));
	}
	
	
	
	
	@RequestMapping("writeBoastBoard")
	public void wirteBoastBoardGet(HttpSession ses) throws Exception {
		

		String uuid = UUID.randomUUID().toString();
		
		ses.setAttribute("csrfToken", uuid);
		
		
		System.out.println();
		
	}
	
	
	@RequestMapping(value="writeBoastBoard", method=RequestMethod.POST)
	public String writeBoard(BoardVO newBoard, @RequestParam("csrfToken") String inputcsrf, HttpSession ses) {
		System.out.println("csrf : " + inputcsrf);

		String redirectPage = "";
		if(ses.getAttribute("csrfToken").equals(inputcsrf)) {
			try {
				bbService.saveNewBoard(newBoard, fileList);
				redirectPage = "listAllBoast";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				redirectPage = "listAllBoast?status=fail";
			}
			
			
		}
		return "redirect:" + redirectPage;
		
	}
	    
	@RequestMapping(value = "boastUploadFile", method = RequestMethod.POST)
	public @ResponseBody List<BoardImgVO> uploadFile(MultipartFile uploadFile, HttpServletRequest req){
		System.out.println(uploadFile.getOriginalFilename());
		System.out.println(uploadFile.getSize());
		System.out.println(uploadFile.getContentType());
		
		String realPath = req.getSession().getServletContext().getRealPath("/resources/uploads");
		System.out.println("realPath : " + realPath);
		
		BoardImgVO uf = null;
		
		
		try {
			uf = UploadFileProcess.fileupload(uploadFile.getOriginalFilename(), (int)uploadFile.getSize(),
					uploadFile.getContentType(), uploadFile.getBytes(), realPath);

			if (uf != null) {
				fileList.add(uf);
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for (BoardImgVO f : this.fileList) {
			System.out.println(f.toString());

		}
		return fileList;
	}
		
	@RequestMapping("boastRemoveFile")
	public ResponseEntity<String> removeFile(@RequestParam("boastRemoveFile") String remFile, HttpServletRequest req) {

		System.out.println(remFile );
		ResponseEntity<String> result = null;
		
		String realPath = req.getSession().getServletContext().getRealPath("/resources/uploads");
		UploadFileProcess.deleteFile(fileList, remFile, realPath);

		int ind = 0;
		for (BoardImgVO uf : fileList) {
			if (!remFile.equals(uf.getImgOriginName())) {
				ind++;
			} else {
				break;
			}
		}
		System.out.println("index : " + ind);
		
		fileList.remove(ind);

		result = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return result;
	}
	
		
	@RequestMapping("boastRemAllFile")
	public ResponseEntity<String> remAllFile(HttpServletRequest req) {
		String realPath = req.getSession().getServletContext().getRealPath("../resources/uploads");
			
		UploadFileProcess.deleteAllFile(fileList, realPath);
		
		fileList.clear();
		
		return new ResponseEntity<String>("success",  HttpStatus.ACCEPTED);
	}
		
	
	
	
	@RequestMapping("viewBoastBoard")
	public void viewBoastBoardGet(@RequestParam("boardNo") int boardNo, HttpServletRequest req, Model model) throws Exception{
		
		Map<String, Object> result = bbService.getBoardByNo(boardNo, GetUserIPAddr.getIp(req));
		
		model.addAttribute("board", (BoardVO)result.get("board"));
		model.addAttribute("upFileList", (List<BoardImgVO>)result.get("upFileList"));
		
	}
	
	
}
