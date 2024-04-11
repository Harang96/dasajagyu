package com.cafe24.goott351.admin.board.service;

import java.util.Map;

import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.AdminBoardSearchDTO;

public interface AdminBoardService {

	Map<String, Object> selectAllBoard(int pageNo, int pageProductCnt, AdminBoardSearchDTO absDto) throws Exception;

	Map<String, Object> getBoardDetail(int no) throws Exception;

	void editBoard(AdminBoardDTO abDto) throws Exception;

	void delBoard(int no) throws Exception;

	void writeBoardAdmin(String uuid, String title, String category, String content) throws Exception;

}
