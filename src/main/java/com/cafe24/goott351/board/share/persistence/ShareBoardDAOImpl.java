package com.cafe24.goott351.board.share.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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

@Repository
public class ShareBoardDAOImpl implements ShareBoardDAO {
	private String ns = "com.cafe24.goott351.mappers.shareBoardMapper";

	@Inject 
	private SqlSession ses;
	
	// 보드 리스트 전부 불러오기
	@Override
	public List<ShareBoardVO> selectListOfShareBoard(PageSearchDTO ps) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchType", ps.getSearchType());
		param.put("searchWord", "%" + ps.getSearchWord() + "%");
		
		return ses.selectList(ns + ".selectListOfShareBoard", param);
	}

	// 인기글 가져오기
	@Override
	public List<ShareBoardVO> selectPopPost() throws Exception {
		
		return ses.selectList(ns + ".selectPopPost");
	}
	
	// 페이징 정보 가져오기
	@Override
	public int selectTotalPostCnt(PageSearchDTO ps) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchType", ps.getSearchType());
		param.put("searchWord", "%" + ps.getSearchWord() + "%");
		
		return ses.selectOne(ns + ".selectTotalPostCnt", param);
	}
	
	// 페이징 정보 가져오기(작성자)
	@Override
	public int selectTotalPostCntWriter(PageSearchDTO ps) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchType", ps.getSearchType());
		param.put("searchWord", "%" + ps.getSearchWord() + "%");
		
		return ses.selectOne(ns + ".selectTotalPostCntWriter", param);
	}

	// 게시글 저장
	@Override
	public int insertPost(WrittenSharePostDTO post) throws Exception {
		int result = ses.insert(ns + ".insertPost", post);
		System.out.println(result);
		
		return result;
	}

	// 글 쓴 기록 저장
	@Override
	public int insertWriteLog(WrittenSharePostDTO post, int boardNo) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("boardNo", boardNo);
		param.put("writer", post.getWriter());
		
		return ses.insert(ns + ".insertWriteLog", param);
	}
	
	// 저장된 글의 board_no 가져오기
	@Override
	public int selectLastBoardNo() throws Exception {

		return ses.selectOne(ns + ".selectLastBoardNo");
	}
	
	// 글 쓴 기록 확인
	@Override
	public WrittenDateVO checkWrittenDate(String writer) throws Exception {
		
		return ses.selectOne(ns + ".checkWrittenDate", writer);
	}

	// 유저 포인트 업데이트
	@Override
	public int updatePoint(WrittenSharePostDTO post) throws Exception {
		
		return ses.update(ns + ".updatePoint", post);
	}

	// 유저 포인트 기록 추가
	@Override
	public int insertPointLog(WrittenSharePostDTO post) throws Exception {
		
		return ses.insert(ns + ".insertPointLog", post);
	}

	// 게시글 불러오기
	@Override
	public ShareBoardVO selectPostByNo(int boardNo) throws Exception {

		return ses.selectOne(ns + ".selectPostByNo", boardNo);
	}

	@Override
	public List<ShareBoardImgVO> selectPostImgByNo(int boardNo) throws Exception {
		
		return ses.selectList(ns + ".selectPostImgByNo", boardNo);
	}
	
	// 로그인 한 유저의 조회 기록 체크
	@Override
	public WrittenDateVO selectReadLog(ShareBoardVO sb, String customer) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uuid", customer);
		param.put("boardNo", sb.getBoardNo());
		
		return ses.selectOne(ns + ".selectReadLogCus", param);
	}

	// 로그인 한 유저의 조회 기록 입력
	@Override
	public int insertReadLog(ShareBoardVO sb, String customer) throws Exception {
		System.out.println("기록 넣기");
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uuid", customer);
		param.put("boardNo", sb.getBoardNo());
		
		return ses.insert(ns + ".insertReadLogCus", param);
	}

	// 조회수 올리기
	@Override
	public void updateReadCount(ShareBoardVO sb) throws Exception {
		System.out.println("조회수 올리기");
		ses.update(ns + ".updateReadCount", sb);
	}

	// 게시글 삭제
	@Override
	public int deleteSharePost(String boardNo) throws Exception {
		
		return ses.delete(ns + ".deleteSharePost", boardNo);
	}

	// 게시글 수정
	@Override
	public int updatePost(ModifyShareBoardDTO post) throws Exception {

		return ses.update(ns + ".updatePost", post);
	}

	// 게시글이 로드되고 좋아요를 눌렀는지 확인
	@Override
	public Object checkLike(ShareBoardLikeDTO likeInfo) throws Exception {

		return ses.selectOne(ns + ".checkLike", likeInfo);
	}

	// 좋아요
	@Override
	public int likePost(ShareBoardLikeDTO likeInfo) throws Exception {

		return ses.update(ns + ".likePost", likeInfo);
	}
	
	// 좋아요 로그 추가
	@Override
	public int insertLikelog(ShareBoardLikeDTO likeInfo) throws Exception {
		 
		return ses.insert(ns + ".insertLikelog", likeInfo);
	}
	
	// 좋아요 제거
	@Override
	public int dislikePost(ShareBoardLikeDTO likeInfo) throws Exception {

		return ses.update(ns + ".dislikePost", likeInfo);
	}

	// 좋아요 로그 제거
	@Override
	public int deleteLikelog(ShareBoardLikeDTO likeInfo) throws Exception {

		return ses.delete(ns + ".deleteLikelog", likeInfo);
	}

	// 게시글 좋아요 수 가져오기
	@Override
	public int selectCountOfLike(ShareBoardLikeDTO likeInfo) throws Exception {

		return ses.selectOne(ns + ".selectCountOfLike", likeInfo);
	}

	// 댓글 가져오기(보드넘버로)
	@Override
	public List<ShareBoardReplyVO> selectReplyByNo(ShareBoardReplyDTO replyInfo) throws Exception {

		return ses.selectList(ns + ".selectReplyByNo", replyInfo);
	}

	// 댓글 개수 가져오기
	@Override
	public int selectReplyCount(ShareBoardReplyDTO replyInfo) throws Exception {

		return ses.selectOne(ns + ".selectReplyCount", replyInfo);
	}

	// 댓글 작성
	@Override
	public int insertReply(ShareBoardReplyWriteDTO reply) throws Exception {

		return ses.insert(ns + ".insertReply", reply);
	}

	// 댓글 삭제
	@Override
	public int deleteReply(int replyNo) throws Exception {

		return ses.delete(ns + ".deleteReply", replyNo);
	}

	// 댓글 수정
	@Override
	public int updateReply(ShareBoardReplyContentDTO reply) throws Exception {

		return ses.update(ns + ".updateReply", reply);
	}

}
