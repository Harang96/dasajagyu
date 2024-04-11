package com.cafe24.goott351.board.originalBoard.persistence.etc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.BoardCategoryVO;
import com.cafe24.goott351.domain.OriginalBoardDTO;
import com.cafe24.goott351.domain.OriginalBoardReadCountProcessDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyDTO;
import com.cafe24.goott351.domain.OriginalBoardReplyVO;
import com.cafe24.goott351.domain.OriginalBoardVO;
import com.cafe24.goott351.domain.OriginalImgVO;
import com.cafe24.goott351.domain.OriginalPagingInfoVO;


@Repository
public class OriginalBoardDAOImpl implements OriginalBoardDAO{
	
	@Inject
	private SqlSession ses; // session템플릿 객체 주입
	
	private static String ns = "com.cafe24.goott351.mappers.originalBoardMapper";


	@Override
	public int selectBoardNo() {
		return ses.selectOne(ns + ".selectBoardNo");
	}

	@Override
	public int insertboard(OriginalBoardVO newBoard, int originalCategory) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("headerno", newBoard.getHeaderNo());
		param.put("boardTitle", newBoard.getBoardTitle());
		param.put("boardContent", newBoard.getBoardContent());
		param.put("uuid", newBoard.getUuid());
		param.put("originalCategory", newBoard.getOriginalCategory());
		
		
		return ses.insert(ns + ".insertBoard", param);
	}
	
	@Override
	public int insertUploadFile(int boardNo, OriginalImgVO originaluploadFile) throws Exception{
		
		return ses.insert(ns + ".insertUploadedFile", originaluploadFile);
		
		
	}
	

	@Override
	public List<OriginalBoardVO> selectAllBoard(OriginalPagingInfoVO pi, int categoryNo, int originalCategory) throws Exception {
		
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("startRowIndex", pi.getStartRowIndex());
		param.put("viewPostCntPerPage", pi.getTotalPageCnt());
		param.put("viewPostCntPerPage", pi.getViewPostCntPerPage());
		param.put("categoryNo", categoryNo);
		param.put("originalCategory", originalCategory);
		
		return ses.selectList(ns + ".getAllBoardWithSearch", param);
	}

	@Override
	public List<OriginalImgVO> selectUploadedFile(int boardNo) throws Exception {
		
		return ses.selectList(ns + ".getUploadedFiles", boardNo);
	}

	@Override
	public OriginalBoardVO selectBoardByNo(int boardNo, int categoryNo, int originalCategory) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("boardNo", boardNo);
		param.put("orginalCategory", originalCategory);
		
		
		return ses.selectOne(ns + ".getBoardByNo", param);
	}

	@Override
	public List<String> selectPeopleWhoLikesBoard(int boardNo) throws Exception {

		return ses.selectList(ns + ".getPeopleWhoLikesBoard", boardNo);
	}

	@Override
	public int likeBoard(int boardNo, String who) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("who", who);
		param.put("boardNo", boardNo);
		
		
		return ses.insert(ns + ".like", param);
	}

	@Override
	public int updateBoardLikeCount(int n, int boardNo) throws Exception {
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("n", n);
		param.put("boardNo", boardNo);
		
		return ses.update(ns + ".incDecLikeCount", param);
	}

	@Override
	public String getWriterByNo(int boardNo) throws Exception {

		return ses.selectOne(ns + ".getWriterByNo", boardNo);
	}

	@Override
	public OriginalBoardReadCountProcessDTO selectReadCountProcess(int boardNo, String ipAddr) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("boardNo", boardNo);
		param.put("ipAddr", ipAddr);
		
		return ses.selectOne(ns + ".getReadCountProcess", param);
	}

	@Override
	public int getHourDiffReadTime(int boardNo, String ipAddr) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("ipAddr", ipAddr);
		param.put("boardNo", boardNo);
		
		return ses.selectOne(ns + ".getHourDiffReadTime", param);
	}

	@Override
	public int updateReadCount(int boardNo) throws Exception {
		
		return ses.update(ns + ".updateReadCount", boardNo);
	}

	@Override
	public int updateReadCountProcess(OriginalBoardReadCountProcessDTO ipaddr) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".insertReadCountProcess", ipaddr);
	}

	@Override
	public int insertReadCountProcess(OriginalBoardReadCountProcessDTO ipaddr) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".insertReadCountProcess", ipaddr);
	}

	@Override
	public int dislikeBoard(int boardNo, String who) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("who", who);
		param.put("boardNo", boardNo);
		
		return ses.update(ns + ".dislike", param);
	}

	@Override
	public List<BoardCategoryVO> getBoardCategory(int originalCategory) throws Exception {
		
		return ses.selectList(ns + ".getBoardCategory", originalCategory);
	}

	@Override
	public List<OriginalBoardVO> selectCategory(int categoryNo, int originalCategory) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		
		
		param.put("categoryNo", categoryNo);
		param.put("originalCategory", originalCategory);
		
		return ses.selectList(ns + ".selectCategory", param);
	}

	@Override
	public List<OriginalBoardVO> selectEditRead(int boardNo, int originalCategory) throws Exception{
		Map<String,Object> param = new HashMap<String, Object>();
		
		param.put("boardNo", boardNo);
		param.put("originalCategory", originalCategory);
		return ses.selectList(ns + ".selectEditRead", param);
	}

	@Override
	public int updateEdit(OriginalBoardDTO originalboarddto, int originalCategory) throws Exception{
		
		return ses.update(ns + ".updateEdit", originalboarddto);

	}

	@Override
	public int getTotalBoardCntWithCate(int originalCategory) throws Exception {
		
		return ses.selectOne(ns + ".getTotalBoardCntWithCate", originalCategory);
	}

	@Override
	public List<OriginalImgVO> selectImgFile(int boardNo) throws Exception{
	
		return ses.selectList(ns + ".getImgFile", boardNo);
	}

	@Override
	public void deleteCategory(int boardNo) throws Exception{
		ses.delete(ns + ".deleteImgCategory", boardNo);
	}

	@Override
	public void replyContent(OriginalBoardReplyVO reply) throws Exception {
		ses.insert(ns + ".replyInsert", reply);
		
	}

	@Override
	public List<OriginalBoardReplyVO> getReplyContent(int boardno) throws Exception {
		return ses.selectList(ns+ ".getReplyContent", boardno);
	}

	@Override
	public int deleteReply(int replyNo) throws Exception {

	
		return ses.delete(ns + ".deleteReply", replyNo) ;
	}

//	@Override
//	public String getBoardCategoryName(int originalCategory) {
//		  return ses.selectOne(ns + ".getBoardCategoryName", originalCategory); 
//	}





}
