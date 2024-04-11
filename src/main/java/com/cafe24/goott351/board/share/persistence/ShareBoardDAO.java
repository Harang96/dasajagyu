package com.cafe24.goott351.board.share.persistence;

import java.util.List;

import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.ModifyShareBoardDTO;
import com.cafe24.goott351.domain.PageSearchDTO;
import com.cafe24.goott351.domain.ShareBoardImgVO;
import com.cafe24.goott351.domain.ShareBoardLikeDTO;
import com.cafe24.goott351.domain.ShareBoardReplyContentDTO;
import com.cafe24.goott351.domain.ShareBoardReplyDTO;
import com.cafe24.goott351.domain.ShareBoardReplyVO;
import com.cafe24.goott351.domain.ShareBoardReplyWriteDTO;
import com.cafe24.goott351.domain.ShareBoardVO;
import com.cafe24.goott351.domain.WrittenDateVO;
import com.cafe24.goott351.domain.WrittenSharePostDTO;

public interface ShareBoardDAO {

	// 보드 리스트 전부 불러오기
	List<ShareBoardVO> selectListOfShareBoard(PageSearchDTO ps) throws Exception;

	// 인기글 가져오기
	List<ShareBoardVO> selectPopPost() throws Exception;

	// 페이징 정보 가져오기
	int selectTotalPostCnt(PageSearchDTO ps) throws Exception;

	// 페이징 정보 가져오기(작성자)
	int selectTotalPostCntWriter(PageSearchDTO ps) throws Exception;

	// 게시글 저장
	int insertPost(WrittenSharePostDTO post) throws Exception;
	
	// 글 쓴 기록 저장
	int insertWriteLog(WrittenSharePostDTO post, int boardNo) throws Exception;

	// 저장된 글의 board_no 가져오기
	int selectLastBoardNo() throws Exception;

	// 글 쓴 기록 확인
	WrittenDateVO checkWrittenDate(String writer) throws Exception;

	// 유저 포인트 업데이트
	int updatePoint(WrittenSharePostDTO post) throws Exception;

	// 유저 포인트 기록 추가
	int insertPointLog(WrittenSharePostDTO post) throws Exception;

	// 게시글 불러오기
	ShareBoardVO selectPostByNo(int boardNo) throws Exception;

	// 게시글 이미지 불러오기
	List<ShareBoardImgVO> selectPostImgByNo(int boardNo) throws Exception;

	// 로그인 한 유저의 조회 기록 체크
	WrittenDateVO selectReadLog(ShareBoardVO sb, String customer) throws Exception;

	// 로그인 한 유저의 조회 기록 입력
	int insertReadLog(ShareBoardVO sb, String customer) throws Exception;

	// 조회수 올리기
	void updateReadCount(ShareBoardVO sb) throws Exception;

	// 게시글 삭제
	int deleteSharePost(String boardNo) throws Exception;

	// 게시글 수정
	int updatePost(ModifyShareBoardDTO post) throws Exception;

	// 게시글이 로드되고 좋아요를 눌렀는지 확인
	Object checkLike(ShareBoardLikeDTO likeInfo) throws Exception;

	// 좋아요
	int likePost(ShareBoardLikeDTO likeInfo) throws Exception;

	// 좋아요 로그 추가
	int insertLikelog(ShareBoardLikeDTO likeInfo) throws Exception;

	// 좋아요 제거
	int dislikePost(ShareBoardLikeDTO likeInfo) throws Exception;

	// 좋아요 로그 제거
	int deleteLikelog(ShareBoardLikeDTO likeInfo) throws Exception;

	// 게시글 좋아요 수 가져오기
	int selectCountOfLike(ShareBoardLikeDTO likeInfo) throws Exception;

	// 댓글 가져오기(보드넘버로)
	List<ShareBoardReplyVO> selectReplyByNo(ShareBoardReplyDTO replyInfo) throws Exception;

	// 댓글 개수 가져오기
	int selectReplyCount(ShareBoardReplyDTO replyInfo) throws Exception;

	// 댓글 작성
	int insertReply(ShareBoardReplyWriteDTO reply) throws Exception;

	// 댓글 삭제
	int deleteReply(int replyNo) throws Exception;

	// 댓글 수정
	int updateReply(ShareBoardReplyContentDTO reply) throws Exception;

}
