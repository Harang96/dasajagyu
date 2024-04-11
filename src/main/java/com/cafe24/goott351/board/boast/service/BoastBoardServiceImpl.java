package com.cafe24.goott351.board.boast.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.board.boast.persistence.BoastBoardDAO;
import com.cafe24.goott351.domain.BoardImgVO;
import com.cafe24.goott351.domain.BoardVO;
import com.cafe24.goott351.domain.ReadCountProcess;
import com.cafe24.goott351.domain.RegisterPointLog;
import com.cafe24.goott351.domain.SearchCriteria;
import com.cafe24.goott351.user.customer.persistence.RegisterDAO;
import com.cafe24.goott351.util.BbPagingInfo;
import com.cafe24.goott351.util.PagingInfo;


@Service
public class BoastBoardServiceImpl implements BoastBoardSerivce {

	
	@Inject
	BoastBoardDAO bbDao;
	
	@Inject
	RegisterDAO rDao;
	
	
	
	
	
	@Override
	public List<BoardVO> getEntireBoard() throws Exception {

		List<BoardVO> lst = bbDao.selectAllBoard();

		return lst;
	}
	
	
	

	@Override
	public Map<String, Object> getEntireBoard(int pageNo, SearchCriteria sc)throws Exception {
		BbPagingInfo pi = getPagingInfo(pageNo, sc);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<BoardVO> lst = null;
		
		if(!sc.getSearchWord().equals("")) {
			lst = bbDao.selectAllBoard(pi, sc);
		
		}else if(sc.getSearchWord().equals("")) {
			lst = bbDao.selectAllBoard(pi);
			
		}
		returnMap.put("boardList", lst);
		returnMap.put("BbPagingInfo", pi);
		
		return returnMap;
	
	}


	private BbPagingInfo getPagingInfo(int pageNo, SearchCriteria sc) throws Exception {
		BbPagingInfo result = new BbPagingInfo();
		
		result.setPageNo(pageNo);
		
		if (!sc.getSearchWord().equals("")) {
			
			result.setTotalPostCnt(bbDao.getBoardCntWithSearch(sc));

			System.out.println(sc.toString());
			System.out.println(result.getTotalPostCnt());
		} else if (sc.getSearchWord().equals("")) {
			
			result.setTotalPostCnt(bbDao.getTotalPostCnt());
		}
		
		result.setTotalPageCnt(result.getTotalPostCnt(), result.getViewPostCntPerPage());

		result.setStartRowIndex();

		result.setTotalPagingBlockCnt();

		result.setPageBlockOfCurrentPage();

		result.setStartNumOfCurrentPagingBlock();

		result.setEndNumOfCurrentPagingBlock();
		
		return result;
	}




	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveNewBoard(BoardVO newBoard, List<BoardImgVO> fileList) throws Exception {
			System.out.println("여기까지 찍히는지도 모르겠네..");
			
			if (bbDao.insertNewBoard(newBoard) == 1) {
				int boardNo = bbDao.selectBoardNo();
				
				if (fileList.size() > 0) {
					
					for (BoardImgVO uf : fileList) {
						
						bbDao.insertUploadFile(boardNo, uf);
					}
				}
				bbDao.updateUserPoint("게시물작성", newBoard.getUuid());
			
				rDao.insertPointLog(new RegisterPointLog(-1,"게시물작성", newBoard.getUuid(), null, 100));
			}	
	}




	@Override
	public Map<String, Object> getEntireBoard(int pageNo) throws Exception {
		BbPagingInfo pi = getPageInfo(pageNo);
//		System.out.println(pi.toString());

		List<BoardVO> lst = bbDao.selectAllBoard(pi);

		Map<String, Object> returnMap = new HashMap<String, Object>();

		returnMap.put("boardList", lst);
		returnMap.put("BbPagingInfo", pi);

		return returnMap;
	}



	
	private BbPagingInfo getPageInfo(int pageNo) throws Exception{
		
		BbPagingInfo result = new BbPagingInfo();
		
		result.setPageNo(pageNo);

		result.setTotalPostCnt(bbDao.getTotalPostCnt()); 

		result.setTotalPageCnt(result.getTotalPostCnt(), result.getViewPostCntPerPage());

		result.setStartRowIndex();

		result.setTotalPagingBlockCnt();

		result.setPageBlockOfCurrentPage();

		result.setStartNumOfCurrentPagingBlock();

		result.setEndNumOfCurrentPagingBlock();

		return result;
		
		
	}




	@Override
	@Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public Map<String, Object> getBoardByNo(int no, String idAddr) throws Exception {
		int readCntResult = -1;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(bbDao.selectReadCountProcess(no, idAddr) != null){
			
			if (bbDao.getHourDiffReadTime(no, idAddr) > 23) { 
				if (bbDao.updateReadCountProcess(new ReadCountProcess(-1, idAddr, no, null)) == 1) {
					
					readCntResult = bbDao.updateReadCount(no);
				}
				
			}else {

				readCntResult = 1;
			}
			
		} else {
			if (bbDao.insertReadCountProcess(new ReadCountProcess(no, idAddr, no, null)) == 1) {
				readCntResult = bbDao.updateReadCount(no);
		}
		
		// 여기에서 멈춰있음 
	}
		
		if (readCntResult == 1) {
			
			BoardVO board = bbDao.selectBoardByNo(no);
			
			List<BoardImgVO> upFileList = bbDao.selectUploadFile(no);
			
			
			result.put("board", board);
			result.put("upFileList", upFileList);
		}
		
		return result;
	
}




	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean likeBoard(int boardNo, String who) throws Exception {
		
		
		if(bbDao.likeBoard(boardNo, who) == 1) {
			
			if(this.modifyBoardLikeCount(1, boardNo) == 1) {
				
				
			}
			
		};
		
		
		return false;
	}




	private int modifyBoardLikeCount(int n, int boardNo) throws Exception {
		
		
		return bbDao.updateBoardLikeCount(n, boardNo);
	}




	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean dislikeBoard(int boardNo, String who) throws Exception {
		boolean result = false;
		
		if(bbDao.dislikeBoard(boardNo, who) == 1) {
			
			if(this.modifyBoardLikeCount(-1, boardNo) == 1 ) {
				result = true;
				
			}
		}
		
		
		
		return result;
		
		
	}




//	@Override
//	public List<String> getPeopleWhoLikesBoard(int boardNo) throws Exception {
//		
//		return bbDao.selectPeopleWhoLikesBoard(boardNo);
//	}
	
	
	
	
	
	
}