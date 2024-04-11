package com.cafe24.goott351.board.share.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.board.share.persistence.ShareBoardDAO;
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
import com.cafe24.goott351.util.PagingInfo;
import com.cafe24.goott351.util.SbPagingInfo;

@Service
public class ShareBoardServiceImpl implements ShareBoardService {
	@Inject
	private ShareBoardDAO sbDao;

	/**
	* @Method		: getAllListOfShareBoard
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 보드 리스트 전부 불러오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.03        Jooyoung Lee       
	*/
	@Override
	public Map<String, Object> getAllListOfShareBoard(PageSearchDTO ps) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<ShareBoardVO> sbList = sbDao.selectListOfShareBoard(ps);
		SbPagingInfo pi = getPagingInfo(ps);
		List<ShareBoardVO> popPost = sbDao.selectPopPost();
		
		result.put("sbList", sbList);
		result.put("pi", pi);
		result.put("popPost", popPost);
		
		return result;
	}

	/**
	* @Method		: getPagingInfo
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @return		: SbPagingInfo
	 * @throws Exception 
	* @Description  : 페이징 정보를 가져옴
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.04        Jooyoung Lee       
	*/
	private SbPagingInfo getPagingInfo(PageSearchDTO ps) throws Exception {
		SbPagingInfo pi = new SbPagingInfo();
		
		// 전체 글의 개수
		int totalPostCnt = 0;
		if (!ps.getSearchType().equals("writer")) { // writer가 아닐 때
			totalPostCnt = sbDao.selectTotalPostCnt(ps); 
		} else if (ps.getSearchType().equals("writer")) {
			totalPostCnt = sbDao.selectTotalPostCntWriter(ps);
		}
		
		pi.setAttribute(totalPostCnt, ps.getPageNo(), 20);
		
		return pi;
	}

	/**
	* @Method		: saveWrittenPost
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 게시글 저장
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.06        Jooyoung Lee       트랜잭션
	*/
	@Override
	@Transactional(isolation=Isolation.READ_COMMITTED, rollbackFor=Exception.class)
	public String saveWrittenPost(WrittenSharePostDTO post) throws Exception {
		String result = "";
		
		if (sbDao.insertPost(post) == 1) { // board에 글 입력
			if (sbDao.selectLastBoardNo() > 0) {
				WrittenDateVO writtenDate = sbDao.checkWrittenDate(post.getWriter());
				if (writtenDate != null) { // 글 쓴 적이 있으면
					int boardNo = sbDao.selectLastBoardNo();
					if (sbDao.insertWriteLog(post, boardNo) == 1) { // 기록을 남김
						// 받아온 데이터를 처리, 날이 다른지 확인
						if (!checkDateDiff(writtenDate.getWriteDate())) { // 다르면
							if (sbDao.updatePoint(post) == 1) {
								if (sbDao.insertPointLog(post) == 1) {
									result = "point";
								}
							}
						} 
					} 
				} else { // 글 쓴 적이 없으면
					int boardNo = sbDao.selectLastBoardNo();
					if (sbDao.insertWriteLog(post, boardNo) == 1) {
						if (sbDao.updatePoint(post) == 1) {
							if (sbDao.insertPointLog(post) == 1) {
								result = "point";
							}
						}
					}
				}
			}
		}
		
		return result;
	}

	/**
	* @Method		: checkDateDiff
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @return		: boolean
	* @Description  : 마지막으로 글 쓴 날짜가 오늘인지 확인
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.07        Jooyoung Lee       같으면 true
	*/
	private boolean checkDateDiff(Date date) {
		boolean result = false;
		
		// 글 쓴 시간
		LocalDate dateLocal = date.toLocalDate();
		int year = dateLocal.getYear();
		int month = dateLocal.getMonthValue();
		int day = dateLocal.getDayOfMonth();
		System.out.println("쓴 날짜 : " + year + "년" + month + "월" + day + "일");
		
		// 지금
		LocalDate now = LocalDate.now();
		int yearN = now.getYear();
		int monthN = now.getMonthValue();
		int dayN = now.getDayOfMonth();
		System.out.println("지금 : " + yearN + "년" + monthN + "월" + dayN + "일");
		
		if (year == yearN && month == monthN && day == dayN) {
			result = true;
		} 
		
		return result;
	}

	/**
	* @Method		: getPostByNo
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 게시글 불러오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.07        Jooyoung Lee       
	*/
	@Override
	public Map<String, Object> getPostByNo(int boardNo) throws Exception {
		Map<String, Object> post = new HashMap<String, Object>();
		
		ShareBoardVO sb = sbDao.selectPostByNo(boardNo);
		List<ShareBoardImgVO> sbi = sbDao.selectPostImgByNo(boardNo);
		
		ShareBoardReplyDTO replyInfo = new ShareBoardReplyDTO(boardNo, 1);
		Map<String, Object> reMap = getReplyByBoardNO(replyInfo);
		
		if (sb != null) {
			post.put("post", sb);
			post.put("postImg", sbi);
			post.put("postReply", reMap.get("postReply"));
			post.put("replyPaging", reMap.get("replyPaging"));
		}
		
		return post;
	}

	/**
	* @Method		: setBoardReadWhenLogin
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 로그인 한 유저의 조회 기록, 조회수 처리
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.07        Jooyoung Lee       
	*/
	@Override
	@Transactional(isolation=Isolation.READ_COMMITTED, rollbackFor=Exception.class)
	public void setBoardReadWhenLogin(ShareBoardVO sb, LoginCustomerVO customer) throws Exception{
		String uuid = customer.getUuid();
		setBoardRead(sb, uuid);
	}

	/**
	* @Method		: setBoardReadNotLogin
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 로그인 하지 않은 유저의 조회 기록, 조회수 처리
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.08        Jooyoung Lee       
	*/
	@Override
	@Transactional(isolation=Isolation.READ_COMMITTED, rollbackFor=Exception.class)
	public void setBoardReadNotLogin(ShareBoardVO sb, String userIp) throws Exception {
		setBoardRead(sb, userIp);
	}
	
	/**
	* @Method		: setBoardRead
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @return		: void
	* @Description  : 실질적인 조회 처리
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.08        Jooyoung Lee       
	*/
	private void setBoardRead(ShareBoardVO sb, String userInfo) throws Exception {
		// read_log에 기록이 있는지 판단
		WrittenDateVO readDate = sbDao.selectReadLog(sb, userInfo);
		System.out.println(readDate);
		if (readDate != null) {
			System.out.println("readDate != null");
			// read_log에 기록 넣기
			if (sbDao.insertReadLog(sb, userInfo) == 1) {
				if (!checkDateDiff(readDate.getWriteDate())) { // read_log의 시간이 오늘인지 판단
					// 오늘이 아니면 -> 조회수 올리기
					sbDao.updateReadCount(sb);
				}
			}
		} else { // 기록이 없으면 -> 조회수 올려주기, 기록 넣기
			if (sbDao.insertReadLog(sb, userInfo) == 1) {
				sbDao.updateReadCount(sb);
			}
		}
		
	}

	/**
	* @Method		: removeSharePost
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 게시글 삭제
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.10        Jooyoung Lee       
	*/
	@Override
	public int removeSharePost(String boardNo) throws Exception {
		
		return sbDao.deleteSharePost(boardNo);
	}

	/**
	* @Method		: modifyPost
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 게시글 수정
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.10        Jooyoung Lee       
	*/
	@Override
	public int modifyPost(ModifyShareBoardDTO post) throws Exception {
		
		return sbDao.updatePost(post);
	}

	/**
	* @Method		: checkLike
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 게시글이 로드되고 좋아요를 눌렀는지 확인
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.11        Jooyoung Lee       눌렀으면 true
	*/
	@Override
	public boolean checkLike(ShareBoardLikeDTO likeInfo) throws Exception {
		boolean result = false;
		
		if (sbDao.checkLike(likeInfo) != null) {
			result = true;
		}
		
		return result;
	}

	/**
	* @Method		: likePost
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 게시글 좋아요
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.11        Jooyoung Lee       
	*/
	@Override
	@Transactional(isolation=Isolation.READ_COMMITTED, rollbackFor=Exception.class)
	public int likePost(ShareBoardLikeDTO likeInfo) throws Exception {
		int likeCount = -1;
		
		// 좋아요
		if (sbDao.likePost(likeInfo) == 1) {
			if (sbDao.insertLikelog(likeInfo) == 1) { // 좋아요 로그에 추가하기
				// 좋아요 이후 좋아요 수 가져오기 
				likeCount = sbDao.selectCountOfLike(likeInfo);
			}
		}
		
		return likeCount;
	}
	
	/**
	* @Method		: dislikePost
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 게시글 좋아요 취소
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.11        Jooyoung Lee       
	*/
	@Override
	@Transactional(isolation=Isolation.READ_COMMITTED, rollbackFor=Exception.class)
	public int dislikePost(ShareBoardLikeDTO likeInfo) throws Exception {
		int likeCount = -1;
		
		// 좋아요 제거
		if (sbDao.dislikePost(likeInfo) == 1) {
			if (sbDao.deleteLikelog(likeInfo) == 1) { // 좋아요 로그에서 지우기
				// 좋아요 제거 이후 좋아요 수 가져오기 
				likeCount = sbDao.selectCountOfLike(likeInfo);
			}
		}
		
		return likeCount;
	}
	
	/**
	* @Method		: getReplyByBoardNO
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 댓글 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.11        Jooyoung Lee       
	*/
	@Override
	public Map<String, Object> getReplyByBoardNO(ShareBoardReplyDTO replyInfo) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<ShareBoardReplyVO> sre = sbDao.selectReplyByNo(replyInfo);
		SbPagingInfo rPi = getReplyPagingInfo(replyInfo);
		
		map.put("postReply", sre);
		map.put("replyPaging", rPi);
		
		return map;
	}

	/**
	* @Method		: getReplyPagingInfo
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @return		: SbPagingInfo
	* @Description  : 댓글의 페이징
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.12        Jooyoung Lee       
	*/
	private SbPagingInfo getReplyPagingInfo(ShareBoardReplyDTO replyInfo) throws Exception {
		SbPagingInfo rPi = new SbPagingInfo();
		
		// 전체 글의 개수
		int totalReplyCnt = 0;
		totalReplyCnt = sbDao.selectReplyCount(replyInfo);
		
		rPi.setAttribute(totalReplyCnt, replyInfo.getPageNo(), 10);
		
		return rPi;
	}

	/**
	* @Method		: writeReply
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 댓글 작성
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.12        Jooyoung Lee       
	*/
	@Override
	public int writeReply(ShareBoardReplyWriteDTO reply) throws Exception {

		return sbDao.insertReply(reply);
	}

	
	/**
	* @Method		: removeReply
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 댓글 삭제
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.13        Jooyoung Lee       
	*/
	@Override
	public int removeReply(int replyNo) throws Exception {

		return sbDao.deleteReply(replyNo);
	}

	/**
	* @Method		: modifyReply
	* @PackageName  : com.cafe24.goott351.user.board.service
	* @Description  : 댓글 수정
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.14        Jooyoung Lee       
	*/
	@Override
	public int modifyReply(ShareBoardReplyContentDTO reply) throws Exception {

		return sbDao.updateReply(reply);
	}
	
}
