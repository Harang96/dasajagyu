package com.cafe24.goott351.board.event.persistence;

import java.util.List;

import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.EventImgVo;
import com.cafe24.goott351.domain.EventVo;

public interface EventBoardDAO {
	
	// 게시글 저장
	int saveBoard(EventVo event) throws Exception;
	
	// 이미지 저장
	int saveEventImage(int eventNo, EventImgVo fileList) throws Exception;
	
	// 저장된 게시글의 no값을 얻어오기
	int selectEventNo() throws Exception;
	
	// 전체 게시글 조회
	List<EventVo> selectMainEvent() throws Exception;
	
	// 전체 이미지 조회
	List<EventVo> selectDetailEvent() throws Exception;
	
	// eventvo 이미지뺀 나머지
	EventVo selectEventDetail(int no)throws Exception;
	
	// 이미지만 불러오기
	List<EventImgVo> selectImgList(int no) throws Exception;
	
	// 상세페이지 수정
	int updateEvent(EventVo event) throws Exception;
	
	// 상세페이지 메인수정 파일 저장
	void updateFileList(List<EventImgVo> fileList) throws Exception;
	
	
	// 게시글 삭제
	int deleteEvent(int eventNo) throws Exception;
	
	// 이미지 삭제
	void deleteImgEvent(int eventNo) throws Exception;

	List<CustomerVO> selectEventDetail(String admin)  throws Exception;

	
	
	
	
}
