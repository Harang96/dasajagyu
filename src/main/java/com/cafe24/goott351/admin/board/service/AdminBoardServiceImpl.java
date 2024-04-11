package com.cafe24.goott351.admin.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafe24.goott351.admin.board.persistence.AdminBoardDao;
import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.AdminBoardSearchDTO;
import com.cafe24.goott351.domain.ProductPagingVO;

@Service
public class AdminBoardServiceImpl implements AdminBoardService {

	
	@Inject
	AdminBoardDao abDao;

	@Override
	public Map<String, Object> selectAllBoard(int pageNo, int pageProductCnt, AdminBoardSearchDTO absDto) throws Exception {

		Map<String, Object> adminBoardMap = new HashMap<String, Object>();
		
		System.out.println("Admin 게시판 service");
		
		ProductPagingVO pagingVO = getPagingInfo(pageNo, pageProductCnt, absDto);
		List<AdminBoardDTO> adminBoardList = abDao.getAllBoard(pagingVO, absDto);
		
		
		adminBoardMap.put("pagingInfo", pagingVO);
		adminBoardMap.put("adminBoardList", adminBoardList);
		
		
		return adminBoardMap;
	}

	
	
	
	
	private ProductPagingVO getPagingInfo(int pageNo, int pageProductCnt, AdminBoardSearchDTO absDto) throws Exception{
		ProductPagingVO vo = new ProductPagingVO();
		
		vo.setPageNo(pageNo);
		
		vo.setPageProductCnt(pageProductCnt);	

		vo.setTotalProductCnt(abDao.getTotalBoardCntBySearch(absDto));
		// 총 페이지수
		vo.setTotalPageCnt(vo.getTotalProductCnt(), vo.getPageProductCnt());
		// 보이기 시작할 번호
		vo.setStartRowIndex();
		// 전체 페이징 블럭 갯수	
		vo.setTotalPagingBlock();
		// 현재 페이징 블럭
		vo.setCurrentPageBlock();
		// 현재 페이징 시작 번호
		vo.setStartPageNum();
		// 현재 페이징 마지막 번호
		vo.setEndPageNum();
		
		return vo;
	}





	@Override
	public Map<String, Object> getBoardDetail(int no) throws Exception{
		
		Map<String, Object> abMap = new HashMap<String, Object>();
		
		AdminBoardDTO abDetail = abDao.getBoardDetailInfo(no);
		
		abMap.put("abDetailInfo", abDetail);
		
		
		return abMap;
	}





	@Override
	public void editBoard(AdminBoardDTO abDto) throws Exception{
		
		abDao.updateBoardAdmin(abDto);
		
	}





	@Override
	public void delBoard(int no) throws Exception{
		
		abDao.deleteBoardAdmin(no);
		
	}





	@Override
	public void writeBoardAdmin(String uuid, String title, String category, String content) throws Exception{

		abDao.insertBoardAdmin(uuid, title, category, content);
		
	}
}
