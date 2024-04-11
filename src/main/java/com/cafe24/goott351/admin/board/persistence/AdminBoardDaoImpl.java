package com.cafe24.goott351.admin.board.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.AdminBoardSearchDTO;
import com.cafe24.goott351.domain.ProductPagingVO;

@Repository
public class AdminBoardDaoImpl implements AdminBoardDao {
	
	@Inject
	private SqlSession ses;
	private static String ns = "com.cafe24.goott351.mappers.adminBoardMapper";
	
	
	@Override
	public int getTotalBoardCntBySearch(AdminBoardSearchDTO absDto) throws Exception{
		
		String query = ns + ".getTotalBoardCntBySearch";
		
		return ses.selectOne(query, absDto);
		
	
	}


	@Override
	public List<AdminBoardDTO> getAllBoard(ProductPagingVO pagingVO, AdminBoardSearchDTO absDto) throws Exception{
		
		String query = ns + ".getAllBoardList";
		
		Map <String, Object> param = new HashMap<>();
		
		param.put("startRowIndex", pagingVO.getStartRowIndex());
		param.put("pageProductCnt", pagingVO.getPageProductCnt());
		param.put("searchType", absDto.getSearchType());
		param.put("searchWord", absDto.getSearchWord());
		param.put("colName", absDto.getColName());
		param.put("colValue", absDto.getColValue());
		
		
		return ses.selectList(query, param);
	}


	@Override
	public AdminBoardDTO getBoardDetailInfo(int no) throws Exception{

		String query = ns + ".getBoardDetailInfo";
		
		
		return ses.selectOne(query, no);
	}


	@Override
	public void updateBoardAdmin(AdminBoardDTO abDto) throws Exception{
		
		String query = ns + ".updateBoardAdmin";
		
		Map <String, Object> param = new HashMap<>();
		
		param.put("categoryno", abDto.getCategoryno());
		param.put("boardtitle", abDto.getBoardtitle());
		param.put("boardcontent", abDto.getBoardcontent());
		param.put("boardno", abDto.getBoardno());
		
		ses.update(query, param);
		
	}


	@Override
	public void deleteBoardAdmin(int no) throws Exception{
		
		String query = ns + ".deleteBoardAdmin";
		
		ses.delete(query, no);
		
	}


	@Override
	public void insertBoardAdmin(String uuid, String title, String category, String content) throws Exception{
		
		String query = ns + ".insertBoardAdmin";
		
		Map <String, Object> param = new HashMap<>();
		
		param.put("uuid",uuid);
		param.put("title",title);
		param.put("category",category);
		param.put("content",content);
		
		ses.insert(query, param);
	}





}
