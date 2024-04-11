package com.cafe24.goott351.admin.board.persistence;

import java.util.List;

import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.AdminBoardSearchDTO;
import com.cafe24.goott351.domain.ProductPagingVO;

public interface AdminBoardDao {

	int getTotalBoardCntBySearch(AdminBoardSearchDTO absDto) throws Exception;

	List<AdminBoardDTO> getAllBoard(ProductPagingVO pagingVO, AdminBoardSearchDTO absDto) throws Exception;

	AdminBoardDTO getBoardDetailInfo(int no) throws Exception;

	void updateBoardAdmin(AdminBoardDTO abDto) throws Exception;

	void deleteBoardAdmin(int no) throws Exception;

	void insertBoardAdmin(String uuid, String title, String category, String content) throws Exception;


}
