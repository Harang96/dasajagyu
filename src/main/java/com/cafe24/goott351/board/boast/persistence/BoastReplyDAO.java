package com.cafe24.goott351.board.boast.persistence;

import java.util.List;

import com.cafe24.goott351.domain.ReplyVO;

public interface BoastReplyDAO {

	List<ReplyVO> selectAllReplies(int boardNo);

	int insertNewReply(ReplyVO newReply);

}
