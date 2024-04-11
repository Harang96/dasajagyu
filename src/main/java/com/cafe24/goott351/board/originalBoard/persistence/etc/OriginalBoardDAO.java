package com.cafe24.goott351.board.originalBoard.persistence.etc;



import java.util.List;

import com.cafe24.goott351.domain.AdminBoardSearchDTO;
import com.cafe24.goott351.domain.BoardCategoryVO;
import com.cafe24.goott351.domain.OriginalBoardDTO;
import com.cafe24.goott351.domain.OriginalBoardReadCountProcessDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyVO;
import com.cafe24.goott351.domain.OriginalBoardUploadedFileDTO;
import com.cafe24.goott351.domain.OriginalBoardVO;
import com.cafe24.goott351.domain.OriginalImgVO;
import com.cafe24.goott351.domain.OriginalPagingInfoVO;


public interface OriginalBoardDAO {

	// boardNo 조회
	int selectBoardNo();
	
	// no번글 리스트 가져오기
	List<OriginalImgVO> selectUploadedFile(int boardno) throws Exception;
	
	// no번 글 조회
	OriginalBoardVO selectBoardByNo(int boardno, int categoryNo, int originalCategory) throws Exception;

	// 전체 게시글 조회( + pagingInfo)
	List<OriginalBoardVO> selectAllBoard(OriginalPagingInfoVO pi, int categoryNo, int originalCategory) throws Exception;
	
	List<String> selectPeopleWhoLikesBoard(int boardno) throws Exception;
	
	int likeBoard(int boardno, String who) throws Exception;
	
	// board테이블의 좋아요/안좋아요 업데이트
	int updateBoardLikeCount(int n, int boardno) throws Exception;

	// 게시글의 작성자 조회
	String getWriterByNo(int boardno) throws Exception;
	
	// 해당 아이피 주소와 글번호 같은 것이 있는지 없는지 체크
	OriginalBoardReadCountProcessDTO selectReadCountProcess(int boardno, String ipAddr) throws Exception;
	
	// ipAddr가 no 글을 읽은지 24시간이 지났는지 아닌지 (시간차이)
	int getHourDiffReadTime(int boardno, String ipAddr) throws Exception;

	// 조회수 증가
	int updateReadCount(int boardno) throws Exception;

	// readcountprocess 테이블에서 update
	int updateReadCountProcess(OriginalBoardReadCountProcessDTO rct) throws Exception;

	// readcountprocess 테이블에 insert
	int insertReadCountProcess(OriginalBoardReadCountProcessDTO rct) throws Exception;
	
	// 싫어요
	int dislikeBoard(int boardno, String who) throws Exception;
	
	List<BoardCategoryVO> getBoardCategory(int originalCategory) throws Exception;

	List<OriginalBoardVO> selectCategory(int categoryNo, int originalCategory) throws Exception;

	int updateEdit(OriginalBoardDTO originalboarddto, int originalCategory) throws Exception;

	List<OriginalBoardVO> selectEditRead(int boardNo, int originalCategory) throws Exception;

	int getTotalBoardCntWithCate(int originalCategory) throws Exception;


	int insertboard(OriginalBoardVO newBoard, int originalCategory) throws Exception;

	int insertUploadFile(int boardNo, OriginalImgVO originaluploadFile) throws Exception;

	List<OriginalImgVO> selectImgFile(int boardNo) throws Exception;

	void deleteCategory(int boardNo) throws Exception;

	void replyContent(OriginalBoardReplyVO reply) throws Exception;

	List<OriginalBoardReplyVO> getReplyContent(int boardno) throws Exception;

	int deleteReply(int boardNo) throws Exception;

//	String getBoardCategoryName(int originalCategory);


 
}
