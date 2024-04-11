package com.cafe24.goott351.board.event.service;

import java.time.LocalDateTime;
import java.util.List;

import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.EventImgVo;
import com.cafe24.goott351.domain.EventVo;

public interface EventBoardService {
    // 게시글 저장
    void saveEvent(String title, LocalDateTime startDate, LocalDateTime endDate, String content, List<EventImgVo> fileList) throws Exception;
    
	// 게시글 전체 조회
	List<EventVo> getMainEvent() throws Exception;
	
	// 이미지 전체 조회
	List<EventVo> getDetailEvent() throws Exception;

	// 이미지뺀 eventVo
	EventVo getEventDetail(int no) throws Exception;

	// 이미지만 불러오기
	List<EventImgVo> getimgList(int no) throws Exception;

	// 상세페이지 수정
	void updateEvent(EventVo event, List<EventImgVo> fileList, List<EventImgVo> detailfileList) throws Exception;

	boolean deleteEvent(int eventNo) throws Exception;

	List<CustomerVO> getAdmin(String admin) throws Exception;


}