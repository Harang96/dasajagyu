package com.cafe24.goott351.admin.board.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.goott351.admin.board.service.AdminBoardService;
import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.AdminBoardSearchDTO;

@Controller
@RequestMapping("/admin/board/*")
public class AdminBoardController {

	
	@Inject
	AdminBoardService abService;
	
	
	@RequestMapping(value = "boardAdmin", method = RequestMethod.GET)
	private void viewAdminBoard(@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
								@RequestParam(name = "pageProductCnt", defaultValue = "10") int pageProductCnt,	
								@RequestParam(name = "searchWord", defaultValue = "") String searchWord,
								@RequestParam(name = "searchType", defaultValue = "def") String searchType,
								@RequestParam(name = "colName", defaultValue = "writedate") String colName,
								@RequestParam(name = "colValue", defaultValue = "desc") String colValue,
								Model model) throws Exception {
							
		System.out.println("게시판 정보 불러오기");
		
		AdminBoardSearchDTO absDto = new AdminBoardSearchDTO();
		absDto.setSearchWord(searchWord);
		absDto.setSearchType(searchType);
		absDto.setColName(colName);
		absDto.setColValue(colValue);
		
		
		Map<String, Object> map = abService.selectAllBoard(pageNo, pageProductCnt, absDto);
		
		model.addAttribute("pagingInfo", map.get("pagingInfo"));
		model.addAttribute("adminBoardList", map.get("adminBoardList"));
		model.addAttribute("colName", colName);
		model.addAttribute("colValue", colValue);
		model.addAttribute("pageProductCnt", pageProductCnt);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchType", searchType);
		
		
		
	};
	
	@RequestMapping(value="getBoardDetail", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getBoardDetail(@RequestParam(name="no") int no) throws Exception{
		
		
		Map<String, Object> map = abService.getBoardDetail(no);
		
		
		return map;
	
	};
	
	@RequestMapping(value="editBoard", method=RequestMethod.POST)
	@ResponseBody
	public void editBoard(AdminBoardDTO abDto) throws Exception {
		
		abService.editBoard(abDto);
		
	}
	
	@RequestMapping(value="delBoard", method=RequestMethod.POST)
	public void delBoardAdmin(@RequestParam(name="no") int no) throws Exception {
		
		abService.delBoard(no);
	}
	
	@RequestMapping(value="writeBoardAdmin", method=RequestMethod.POST)
	public void writeBoard(@RequestParam(name="uuid") String uuid,
						   @RequestParam(name="title") String title,
						   @RequestParam(name="category") String category,
						   @RequestParam(name="content") String content) throws Exception {
		
		abService.writeBoardAdmin(uuid, title, category, content);
		
		
	};
	
	
	
}
