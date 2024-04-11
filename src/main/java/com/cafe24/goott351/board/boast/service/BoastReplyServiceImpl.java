package com.cafe24.goott351.board.boast.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.board.boast.persistence.BoastBoardDAO;
import com.cafe24.goott351.board.boast.persistence.BoastReplyDAO;
import com.cafe24.goott351.domain.RegisterPointLog;
import com.cafe24.goott351.domain.ReplyVO;
import com.cafe24.goott351.user.customer.persistence.RegisterDAO;

@Service
public class BoastReplyServiceImpl implements BoastReplyService {

	@Inject
	BoastReplyDAO brDao;
	
	@Inject
	RegisterDAO rDao;
	
	@Override
	public List<ReplyVO> getAllReplies(int boardNo) throws Exception {
		List<ReplyVO> lst = brDao.selectAllReplies(boardNo);

		return lst;
	}

	@Override
	@Transactional(rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
	public boolean saveReply(ReplyVO newReply) throws Exception {
		boolean result = false;
//		1) 새댓글 저장 (insert)
		brDao.insertNewReply(newReply);
//		2) point 부여 (답글작성, 1점) (member테이블 userPoint update한다.)
//		3) pointlog 기록 (pointlog테이블에 insert한다.)
		result = true;
					
				
			
		
		return result;
	}

}
