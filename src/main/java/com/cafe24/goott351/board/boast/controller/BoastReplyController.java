package com.cafe24.goott351.board.boast.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.cafe24.goott351.board.boast.service.BoastReplyService;
import com.cafe24.goott351.domain.ReplyVO;


@RestController
@RequestMapping("/reply/*")
public class BoastReplyController {
	
	@Inject
	BoastReplyService brService;

	@RequestMapping(value = "all/{boardNo}/{pageNo}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> getAllReplies(@PathVariable("boardNo") int boardNo,
			@PathVariable("pageNo") int pageNo) {
		System.out.println(boardNo + "번 글의 " + pageNo + "번 페이지 댓글을 가져오자");

		ResponseEntity <List<ReplyVO>> result = null;
//		ResponseEntity<Map<String, Object>> result = null;

		try {
			//
//			PagingInfo pi = new PagingInfo();

			List<ReplyVO> lst = brService.getAllReplies(boardNo);
			result = new ResponseEntity<>(lst, HttpStatus.OK);
			
//			Map<String, Object> map = new HashMap<String, Object>();
//			map.put("replyList", lst);
//			map.put("pagingInfo", pi);
//			
//			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<List<ReplyVO>>(HttpStatus.CONFLICT);
		}

		return result;

	}
	
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> saveReply(@RequestBody ReplyVO newReply) {
		System.out.println(newReply.toString() + "댓글을 저장하자");
		ResponseEntity<String> result = null;
		try {
			if (brService.saveReply(newReply)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.FORBIDDEN);
		}

		return result;

	}

	
}
