package com.cafe24.goott351.board.boast.service;

import java.util.List;

import com.cafe24.goott351.domain.ReplyVO;

public interface BoastReplyService {

	List<ReplyVO> getAllReplies(int boardNo) throws Exception;

	boolean saveReply(ReplyVO newReply) throws Exception;

}
