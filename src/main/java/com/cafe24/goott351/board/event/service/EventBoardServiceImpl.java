package com.cafe24.goott351.board.event.service;

import java.time.LocalDateTime;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cafe24.goott351.board.event.persistence.EventBoardDAO;
import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.EventImgVo;
import com.cafe24.goott351.domain.EventVo;




@Service
public class EventBoardServiceImpl implements EventBoardService {

//	@Inject
//	EventBoardDAO ebDao;
	
	@Autowired
	private EventBoardDAO eventDAO;
	
	@Override
	public void saveEvent(String title, LocalDateTime startDate, LocalDateTime endDate, String content,
			List<EventImgVo> fileList) throws Exception {
		 EventVo event = new EventVo();
	        event.setTitle(title);
	        event.setStartDate(startDate);
	        event.setEndDate(endDate);
	        event.setContent(content);
	        
	        
	      // 게시글 저장
	       if(eventDAO.saveBoard(event) == 1) {
	    	  int eventNo = eventDAO.selectEventNo();
	        
	     // 이미지 정보 저장
	        if (!fileList.isEmpty()) {
	            for (EventImgVo ei : fileList) {
	                ei.setEventNo(eventNo);
	                eventDAO.saveEventImage(eventNo, ei);
	            }
	        } else {
	            System.out.println("이미지 파일이 없습니다.");
	        }
	     }
	 }
	
	
	
	@Override
	public List<EventVo> getMainEvent() throws Exception {
		
		List<EventVo> lst = eventDAO.selectMainEvent();
		return lst;
	}

	@Override
	public List<EventVo> getDetailEvent() throws Exception {
		
		List<EventVo> lst = eventDAO.selectDetailEvent();
		return lst;
	}



	@Override
	public EventVo getEventDetail(int no) throws Exception {
		EventVo event = eventDAO.selectEventDetail(no);
		event.setEventNo(no);
		return event;
		
		
	}



	@Override
	public List<EventImgVo> getimgList(int no) throws Exception {
		
		List<EventImgVo> lst = eventDAO.selectImgList(no);
		return lst;
	}



	@Override
	public void updateEvent(EventVo event,  List<EventImgVo> fileList, List<EventImgVo> detailFileList) throws Exception {
			
		// 게시글 저장
	       if(eventDAO.updateEvent(event) == 1) {
	    	  int eventNo = event.getEventNo();
//	      
	        
	     // 이미지 정보 저장
	    	  eventDAO.deleteImgEvent(eventNo);
	        if (!fileList.isEmpty()) {
	            for (EventImgVo ei : fileList) {
	                ei.setEventNo(eventNo);
	                eventDAO.saveEventImage(eventNo, ei);
	               
	            }
	        } else {
	            System.out.println("이미지 파일이 없습니다.");
	        }
	        
	        if (!detailFileList.isEmpty()) {
	            for (EventImgVo ei : detailFileList) {
	                ei.setEventNo(eventNo);
	                eventDAO.saveEventImage(eventNo, ei);
	                
	            }
	        } else {
	            System.out.println("이미지 파일이 없습니다.");
	        }
	        
	     }
           
	}



	@Override
	public boolean deleteEvent(int eventNo) throws Exception {
		boolean result  = false;
		if (eventDAO.deleteEvent(eventNo) == 1) {
			result = true;
		};
		 System.out.println("삭제할 이벤트No : " + eventNo);
		return result;
	}



	@Override
	public List<CustomerVO> getAdmin(String admin) throws Exception {
		List<CustomerVO> lst = eventDAO.selectEventDetail(admin);
		System.out.println("lst " + lst);
		return lst;
		
	}


}