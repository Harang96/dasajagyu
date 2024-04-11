package com.cafe24.goott351.board.boast.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.ReplyVO;

@Repository
public class BoastReplyDAOImpl implements BoastReplyDAO {

	private String replyMapper = "com.cafe24.goott351.mappers.replyMapper";
	
	@Inject
	private SqlSession ses;
	
	

	@Override
	public List<ReplyVO> selectAllReplies(int boardNo) {
		
		return ses.selectList(replyMapper + ".getAllReplies", boardNo);
	}



	@Override
	public int insertNewReply(ReplyVO newReply) {
		
		return ses.insert(replyMapper + ".insertReply", newReply);
	}

}
