package com.cafe24.goott351.board.boast.service;

import java.util.List;
import java.util.Map;

import com.cafe24.goott351.domain.BoardImgVO;
import com.cafe24.goott351.domain.BoardVO;
import com.cafe24.goott351.domain.SearchCriteria;
import com.cafe24.goott351.domain.ShareBoardImgVO;

public interface BoastBoardSerivce {
	
	
	List<BoardVO> getEntireBoard() throws Exception;

	void saveNewBoard(BoardVO newBoard, List<BoardImgVO> fileList) throws Exception;

	Map<String, Object> getEntireBoard(int pageNo) throws Exception;
	
	Map<String, Object> getEntireBoard(int pageNo, SearchCriteria sc)throws Exception;

	Map<String, Object> getBoardByNo(int no, String idAddr) throws Exception;

	boolean likeBoard(int boardNo, String who) throws Exception;

	boolean dislikeBoard(int boardNo, String who) throws Exception;

//	List<String> getPeopleWhoLikesBoard(int no) throws Exception;

	
}
