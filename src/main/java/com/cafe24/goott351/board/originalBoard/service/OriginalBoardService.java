package com.cafe24.goott351.board.originalBoard.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.cafe24.goott351.domain.OriginalBoardDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyVO;
import com.cafe24.goott351.domain.OriginalBoardUploadedFileDTO;
import com.cafe24.goott351.domain.OriginalBoardVO;
import com.cafe24.goott351.domain.OriginalImgVO;

public interface OriginalBoardService {



	Map<String, Object> getEntireBoard(int pageNo, int categoryNo, int originalCategory) throws Exception;

	List<String> getPeopleWhoLikesBoard(int boardNo) throws Exception;

	boolean likeBoard(int boardNo, String who) throws Exception;

	boolean dislikeBoard(int boardno, String who) throws Exception;

	Map<String, Object> getCategoryBoard(int categoryNo, int originalCategory) throws Exception;


	boolean boardUpdate(OriginalBoardDTO originalboarddto, int originalCategory) throws Exception;

	Map<String, Object> boardread(int boardNo, int originalCategory) throws Exception;

	Map<String, Object> getBoardByNo(int boardno, int categoryNo, int originalCategory, String ipAddr) throws Exception;

	void saveNewBoard(OriginalBoardVO newBoard,  List<OriginalImgVO> uploadFile, int originalCategory) throws Exception;

	List<OriginalImgVO> getImgFile(int boardNo) throws Exception;

	void deleteCategory(int boardNo) throws Exception;


	void replyContent(OriginalBoardReplyVO reply) throws Exception;


	 int deleteReply(int boardNo) throws Exception;






}
