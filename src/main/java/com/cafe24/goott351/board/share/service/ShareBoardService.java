package com.cafe24.goott351.board.share.service;

import java.util.Map;

import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.ModifyShareBoardDTO;
import com.cafe24.goott351.domain.PageSearchDTO;
import com.cafe24.goott351.domain.ShareBoardLikeDTO;
import com.cafe24.goott351.domain.ShareBoardReplyContentDTO;
import com.cafe24.goott351.domain.ShareBoardReplyDTO;
import com.cafe24.goott351.domain.ShareBoardReplyWriteDTO;
import com.cafe24.goott351.domain.ShareBoardVO;
import com.cafe24.goott351.domain.WrittenSharePostDTO;

public interface ShareBoardService {

	// 보드 리스트 전부 불러오기
	Map<String, Object> getAllListOfShareBoard(PageSearchDTO ps) throws Exception;

	// 게시글 저장
	String saveWrittenPost(WrittenSharePostDTO post) throws Exception;

	// 게시글 불러오기
	Map<String, Object> getPostByNo(int boardNo) throws Exception;

	// 로그인 한 유저의 조회 기록, 조회수 처리
	void setBoardReadWhenLogin(ShareBoardVO sb, LoginCustomerVO customer) throws Exception;

	// 로그인 하지 않은 유저의 조회 기록, 조회수 처리
	void setBoardReadNotLogin(ShareBoardVO sb, String userIp) throws Exception;

	// 게시글 삭제
	int removeSharePost(String boardNo) throws Exception;
	
	// 게시글 수정
	int modifyPost(ModifyShareBoardDTO post) throws Exception;

	// 게시글이 로드되고 좋아요를 눌렀는지 확인
	boolean checkLike(ShareBoardLikeDTO likeInfo) throws Exception;

	// 게시글 좋아요
	int likePost(ShareBoardLikeDTO likeInfo) throws Exception;
	
	// 게시글 좋아요 취소
	int dislikePost(ShareBoardLikeDTO likeInfo) throws Exception;

	// 댓글 가져오기
	Map<String, Object> getReplyByBoardNO(ShareBoardReplyDTO replyInfo) throws Exception;

	// 댓글 작성
	int writeReply(ShareBoardReplyWriteDTO reply) throws Exception;

	// 댓글 삭제
	int removeReply(int replyNo) throws Exception;

	// 댓글 수정
	int modifyReply(ShareBoardReplyContentDTO reply) throws Exception;
}
