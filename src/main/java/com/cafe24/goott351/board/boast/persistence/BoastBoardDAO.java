package com.cafe24.goott351.board.boast.persistence;

import java.util.List;

import com.cafe24.goott351.domain.BoardImgVO;
import com.cafe24.goott351.domain.BoardVO;
import com.cafe24.goott351.domain.ReadCountProcess;
import com.cafe24.goott351.domain.SearchCriteria;
import com.cafe24.goott351.util.BbPagingInfo;

public interface BoastBoardDAO {

	List<BoardVO> selectAllBoard() throws Exception;

	
	int insertNewBoard(BoardVO newBoard) throws Exception;


	int selectBoardNo() throws Exception;


	int insertUploadFile(int boardNo, BoardImgVO uf) throws Exception;


	List<BoardVO> selectAllBoard(BbPagingInfo pi) throws Exception;


	List<BoardVO> selectAllBoard(BbPagingInfo pi, SearchCriteria sc)throws Exception;


	int getBoardCntWithSearch(SearchCriteria sc) throws Exception;


	int getTotalPostCnt() throws Exception;


	ReadCountProcess selectReadCountProcess(int no, String idAddr)throws Exception;


	int getHourDiffReadTime(int no, String idAddr)throws Exception;


	int updateReadCountProcess(ReadCountProcess readCountProcess) throws Exception;


	int updateReadCount(int no) throws Exception;


	int insertReadCountProcess(ReadCountProcess readCountProcess) throws Exception;


	BoardVO selectBoardByNo(int no) throws Exception;


	List<BoardImgVO> selectUploadFile(int no) throws Exception;


	int likeBoard(int boardNo, String who) throws Exception;


	int updateBoardLikeCount(int n, int boardNo) throws Exception;


	int dislikeBoard(int boardNo, String who) throws Exception;


	int updateUserPoint(String why, String uuid) throws Exception;


//	List<String> selectPeopleWhoLikesBoard(int boardNo) throws Exception;



	



}
