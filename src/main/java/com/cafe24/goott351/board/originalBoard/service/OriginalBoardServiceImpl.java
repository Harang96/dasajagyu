package com.cafe24.goott351.board.originalBoard.service;

import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cafe24.goott351.board.originalBoard.persistence.etc.OriginalBoardDAO;
import com.cafe24.goott351.domain.BoardCategoryVO;
import com.cafe24.goott351.domain.EventImgVo;
import com.cafe24.goott351.domain.OriginalBoardDTO;
import com.cafe24.goott351.domain.OriginalBoardReadCountProcessDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyVO;
import com.cafe24.goott351.domain.OriginalBoardUploadedFileDTO;
import com.cafe24.goott351.domain.OriginalBoardVO;
import com.cafe24.goott351.domain.OriginalImgVO;
import com.cafe24.goott351.domain.OriginalPagingInfoVO;



@Service
public class OriginalBoardServiceImpl implements OriginalBoardService{
	
	@Inject
	OriginalBoardDAO Wdao;
	
	
	
	/*
	 * @Inject WorkMemberDAO mDao;
	 */
	/*
	 * @Inject WorkPointLogDAO plDao;
	 */
	
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveNewBoard(OriginalBoardVO newBoard, List<OriginalImgVO> originaluploadFile, int originalCategory)
			throws Exception {
//		새 게시글 저장 트랜잭션

//		1. board테이블에 글을 저장(insert)하고 그 후 파일을 저장해야한다. 
		if (Wdao.insertboard(newBoard, originalCategory) == 1) { // insert되엇다면

			int boardNo = Wdao.selectBoardNo(); // boardNo최대값

//			2. 업로드파일이 있는경우
			if (originaluploadFile.size() > 0) {
				for (OriginalImgVO Oi : originaluploadFile) {
					Oi.setBoardNo(boardNo);
					if(Wdao.insertUploadFile(boardNo, Oi) == 1 ) {

					}
				}
			} else {
				System.out.println("이미지 파일이 없습니다.");
			}
		}
		
	}


	@Override
	public Map<String, Object> getEntireBoard(int pageNo, int categoryNo, int originalCategory) throws Exception{
		OriginalPagingInfoVO pi = getPagingInfo(pageNo, originalCategory);
		
		List<OriginalBoardVO> lst = Wdao.selectAllBoard(pi, categoryNo, originalCategory);
		List<BoardCategoryVO> categorylst = Wdao.getBoardCategory(originalCategory);

		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("boardList", lst);
		returnMap.put("pagingInfo", pi);
		returnMap.put("categorylst", categorylst);

		
		return returnMap;
	}


	private OriginalPagingInfoVO getPagingInfo(int pageNo, int originalCategory) throws Exception{
		OriginalPagingInfoVO result = new OriginalPagingInfoVO();
		
		// pageNo 세팅
		result.setPageNo(pageNo);
		
		// 총 페이지수
		result.setTotalPageCnt(Wdao.getTotalBoardCntWithCate(originalCategory), 10);
		
		// 보여주기 시작할 row index번호 구하기
		result.setStartRowIndex();
		
		// 전체 페이징 블럭 갯수
		result.setTotalPagingBlockCnt();
		
		// 현재 페이지가 속한 페이징 블럭 번호
		result.setPageBlockofCurrentPage();
		
		// 현재 페이징 블럭 시작 페이지 번호
		result.setStartNumOfCurrentPagingBlock();
		
		// 현재 페이징 블럭 끝 페이지 번호
		result.setEndNumOfCurrentPagingBlock();
		
		
		return result;
	}
	

	@Override
	@Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public Map<String, Object> getBoardByNo(int boardno, int categoryNo, int originalCategory, String ipAddr) throws Exception {
//		해당 아이피 주소와 글번호 같은 것이 없으면 (→ 해당 아이피주소가 해당 글을 최초로 조회한 경우)
//		→ 아이피 주소와 글번호와 읽은 시간을 readcountprocess 테이블에 insert
//		→ 해당 글번호의 readcount를 증가 (update)
//		→ 해당 글을 가져옴 (select)
//
		
//		해당 아이피 주소와 글번호 같은 것이 있으면
//		1) 시간이 24시간이 지난 경우
//		→ 아이피 주소와 글번호와 읽은 시간을 readcountprocess 테이블에서 update
//		→ 해당 글번호의 readcount를 증가 (update)
//		→ 해당 글을 가져옴 (select)
//
		
//		2) 시간이 24시간이 지나지 않은 경우  
//		→ 해당 글을 가져옴 (select)

		// =========================================
		int readCntResult = -1;
		Map<String, Object> result = new HashMap<String, Object>();
		
		// 해당 아이피 주소와 글번호 같은 것이 있는지 없는지
		if(Wdao.selectReadCountProcess(boardno, ipAddr) != null) { // 조회한 적이 있다
			
		   if (Wdao.getHourDiffReadTime(boardno, ipAddr) > 23) { // 24시간이 지난 경우
			   // 아이피 주소와 글번호와 읽은 시간을 readcountprocess 테이블에서 update
			   if(Wdao.updateReadCountProcess(new OriginalBoardReadCountProcessDTO(-1, ipAddr, boardno, null)) == 1) {
				   //  해당 글번호의 조회수를 +1 증가 (update)
				   readCntResult = Wdao.updateReadCount(boardno);
			   }
			   
		   } else { // 24시간이 지나지 않은 경우
			   readCntResult = 1;
		   }
			
		} else { // 최초 조회
			// 아이피 주소와 글번호와 읽은 시간을 readcountprocess 테이블에 insert
			if (Wdao.insertReadCountProcess(new OriginalBoardReadCountProcessDTO(-1, ipAddr, boardno, null)) == 1) {
				// 해당 글번호의 readcount를 증가 (update)
				readCntResult = Wdao.updateReadCount(boardno);
			}
			
		}
			if (readCntResult == 1) {
			// 해당 (no번) 글을 가져옴 (select)
//			System.out.println(boardno + originalCategory);
			OriginalBoardVO Wboard = Wdao.selectBoardByNo(boardno , categoryNo, originalCategory);
			List<OriginalBoardReplyVO> Replylst = Wdao.getReplyContent(boardno);
			List<BoardCategoryVO> categorylst = Wdao.getBoardCategory(originalCategory);
			List<OriginalImgVO> upFileList = Wdao.selectUploadedFile(boardno);
			result.put("board", Wboard);
			result.put("upFileList", upFileList);
			result.put("categorylst", categorylst);
			result.put("replylist", Replylst);

		}
		
		return result;
		
		}
	


	@Override
	public List<String> getPeopleWhoLikesBoard(int boardno) throws Exception {
		// TODO Auto-generated method stub
		return Wdao.selectPeopleWhoLikesBoard(boardno);
	}


	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean likeBoard(int boardno, String who) throws Exception{
		boolean result = false;
	
		if (Wdao.likeBoard(boardno, who) == 1 ) {
			if (this.modifyBoardLikeCount(1, boardno) == 1 ) {
				result = true;
				
			}
	
		}
	
		return result;
	}
	
	private int modifyBoardLikeCount(int n, int boardno) throws Exception {
		return Wdao.updateBoardLikeCount(n, boardno);
	}
	
	

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean dislikeBoard(int boardno, String who) throws Exception {
		boolean result = false;
		
		if(Wdao.dislikeBoard(boardno, who) == 1) {
			if (this.modifyBoardLikeCount(-1, boardno) == 1) {
				result = true;
			}
			
		}
		return result;
	}


	@Override
	public Map<String, Object> getCategoryBoard(int categoryNo, int originalCategory) throws Exception {
		
		List<OriginalBoardVO> lst = Wdao.selectCategory(categoryNo, originalCategory);
		List<BoardCategoryVO> categorylst = Wdao.getBoardCategory(originalCategory);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("boardList", lst);
		returnMap.put("categorylst", categorylst);
		
		return returnMap;
	}


	@Override
	public Map<String, Object> boardread(int boardNo, int originalCategory) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		// 해당 (no번) 글을 가져옴 (select)
		List<OriginalBoardVO> Wboard = Wdao.selectEditRead(boardNo, originalCategory);
		
		// 업로드한 파일정보를 가져옴 (select)
		List<OriginalImgVO> upFileList = Wdao.selectUploadedFile(boardNo);
		List<BoardCategoryVO> categorylst = Wdao.getBoardCategory(originalCategory);

		result.put("boardNo", Wboard);
		result.put("categoryList", categorylst);
		result.put("upFileList", upFileList);
		
		return result;
	}


	@Override
	public boolean boardUpdate(OriginalBoardDTO originalboarddto , int originalCategory) throws Exception {

		boolean result = false;
		if (Wdao.updateEdit(originalboarddto,originalCategory) == 1) {
			result = true;
		}
		return result;
	}


	@Override
	public List<OriginalImgVO> getImgFile(int boardNo) throws Exception{

		return Wdao.selectImgFile(boardNo);
	}


	@Override
	public void deleteCategory(int boardNo) throws Exception {
		Wdao.deleteCategory(boardNo);
	}


	@Override
	public void replyContent(OriginalBoardReplyVO reply) throws Exception{
		Wdao.replyContent(reply);
	}


	@Override
	public int deleteReply(int replyNo) throws Exception {
//		Wdao.deleteReply(replier);
		return Wdao.deleteReply(replyNo);

	}


}
