package com.cafe24.goott351.board.boast.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.BoardImgVO;
import com.cafe24.goott351.domain.BoardVO;
import com.cafe24.goott351.domain.ReadCountProcess;
import com.cafe24.goott351.domain.SearchCriteria;
import com.cafe24.goott351.domain.ShareBoardImgVO;
import com.cafe24.goott351.util.BbPagingInfo;
import com.cafe24.goott351.util.PagingInfo;

@Repository
public class BoastBoardDAOImpl implements BoastBoardDAO {

	private String boastBoardMapper = "com.cafe24.goott351.mappers.boastBoardMapper";
	
	@Inject
	SqlSession ses;
	
	
	@Override
	public List<BoardVO> selectAllBoard() throws Exception{
		
		return ses.selectList(boastBoardMapper + ".getAllBoard");
	}


	@Override
	public int insertNewBoard(BoardVO newBoard) throws Exception {
		return ses.insert(boastBoardMapper + ".insertNewBoard" , newBoard);
	}


	@Override
	public int selectBoardNo() throws Exception {
		
		return ses.selectOne(boastBoardMapper + ".getNo");
	}



	@Override
	public int insertUploadFile(int boardNo, BoardImgVO uf) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("imgOriginName", uf.getImgOriginName());
		param.put("imgNewName", uf.getImgNewName());
		param.put("imgSize", uf.getImgSize());
		param.put("boardNo", boardNo);
		
		System.out.println("param" + param);
		
		return ses.insert(boastBoardMapper + ".insertUploadedFile", param);
	}


	@Override
	public List<BoardVO> selectAllBoard(BbPagingInfo pi) throws Exception {
		return ses.selectList(boastBoardMapper + ".getAllBoard", pi);
	}


	@Override
	public List<BoardVO> selectAllBoard(BbPagingInfo pi, SearchCriteria sc) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchType", sc.getSearchType());
		param.put("searchWord", "%" + sc.getSearchWord() + "%");
		param.put("startRowIndex", pi.getStartRowIndex());
		param.put("viewPostCntPerPage", pi.getViewPostCntPerPage());
		
		return ses.selectList(boastBoardMapper + ".getAllBoardWithSearch", param);
	}


	@Override
	public int getBoardCntWithSearch(SearchCriteria sc) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchType", sc.getSearchType());
		param.put("searchWord", "%" + sc.getSearchWord() + "%");
		
		return ses.selectOne(boastBoardMapper + ".getTotalBoardCntWithSearch", param);
	}


	@Override
	public int getTotalPostCnt() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(boastBoardMapper + ".getBoardCnt");
	}


	@Override
	public ReadCountProcess selectReadCountProcess(int no, String idAddr) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("boardNo", no);
		param.put("idAddr", idAddr);
		
		
		return ses.selectOne(boastBoardMapper + ".getReadCountProcess", param);
		
	}


	@Override
	public int getHourDiffReadTime(int no, String idAddr) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("boardNo", no);
		param.put("idAddr", idAddr);
		return ses.selectOne(boastBoardMapper + ".getHourDiffReadTime", param);
	}


	@Override
	public int updateReadCountProcess(ReadCountProcess rcp)throws Exception {
		
		return ses.update(boastBoardMapper + ".updateReadCountProcess", rcp);
	}


	@Override
	public int updateReadCount(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(boastBoardMapper + ".updateReadCount", no);
	}


	@Override
	public int insertReadCountProcess(ReadCountProcess rcp) {
		return ses.insert(boastBoardMapper + ".insertReadCountProcess", rcp);
	}


	@Override
	public BoardVO selectBoardByNo(int no) throws Exception {
		
		return ses.selectOne(boastBoardMapper + ".getBoardByNo", no);
	}


	@Override
	public List<BoardImgVO> selectUploadFile(int no) throws Exception {
		
		
		return ses.selectList(boastBoardMapper + ".getUploadedFiles", no);
	}


	@Override
	public int likeBoard(int boardNo, String who) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uuid", who);
		param.put("boardNo", boardNo);
		
		return ses.insert(boastBoardMapper + ".like", param);
	}


	@Override
	public int dislikeBoard(int boardNo, String who)throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uuid", who);
		param.put("boardNo", boardNo);
		
		return ses.delete(boastBoardMapper + ".dislike", param);
	}

	
	
	@Override
	public int updateBoardLikeCount(int n, int boardNo)throws Exception {
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("n", n);
		param.put("boardNo", boardNo);
		
		
		return ses.update(boastBoardMapper + ".incDecLikeCount", param);
	}


	@Override
	public int updateUserPoint(String why, String uuid) throws Exception {
	Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("why", why);
		param.put("uuid", uuid);
		
		return ses.update(boastBoardMapper + ".updateUserPoint", param);
	}


//	@Override
//	public List<String> selectPeopleWhoLikesBoard(int boardNo) throws Exception {
//
//		return ses.selectOne(boastBoardMapper + ".getPeopleWhoLikesBoard", boardNo);
//	}







		


}
