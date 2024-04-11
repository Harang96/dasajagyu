package com.cafe24.goott351.board.event.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.cafe24.goott351.board.event.service.EventBoardService;
import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.EventImgVo;
import com.cafe24.goott351.domain.EventVo;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.util.UploadEventFileProcess;


@Controller
@RequestMapping("/board/*")
public class EventBoardController {

	@Autowired
	private EventBoardService eventService;


	private static final Logger logger = LoggerFactory.getLogger(EventBoardController.class);

	private List<EventImgVo> fileList = new ArrayList<>();
	private List<EventImgVo> detailfileList = new ArrayList<>();
    private List<EventVo> eventList = new ArrayList<>();
    private List<EventVo> detailEventList = new ArrayList<>();
	
    
	@RequestMapping("/board/writeEventBoard")
	public void writeEventBoard() {
		fileList.clear();
		detailfileList.clear();
	}
		
	@RequestMapping("detailViewEventBoard")
	public void detailViewEventBoard(@RequestParam(name = "no") int no,
									  Model model) {
			
			EventVo eventDetail = null;
		    List<EventImgVo> imgList = null;
			
		try {
			// eventVo 이미지뺀 나머지	
			 eventDetail = eventService.getEventDetail(no);
			
			// 그이벤트번호에 해당하는 이미지들		
			 imgList = eventService.getimgList(no);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
		
		model.addAttribute("eventDetail", eventDetail);
		model.addAttribute("imgList", imgList);
		
		
	}
	
	@RequestMapping("/modifyViewEvent")
	public String showEditEventPage(@RequestParam(name = "no") int no, Model model) {
		// 여기에 이벤트 수정 페이지에 필요한 데이터를 가져오는 로직을 추가하세요.
		fileList.clear();
		detailEventList.clear();
		
		EventVo eventDetail = null;
		List<EventImgVo> imgList = null;
		try {
			eventDetail = eventService.getEventDetail(no);
			// 그이벤트번호에 해당하는 이미지들		
			imgList = eventService.getimgList(no);
			
			for(EventImgVo ev : imgList) {
				
				if(ev.getEventimgIdentify() == 1) {
					//fileList.clear();	
					fileList.add(ev);
				} else {
					detailfileList.clear();
					detailfileList.add(ev);
				}
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		model.addAttribute("eventDetail", eventDetail);
		model.addAttribute("imgList", imgList);
		
		
		return "board/modifyViewEvent"; // 수정 페이지로 이동할 JSP 파일 경로를 반환
	}
	
	
	@RequestMapping(value = "/modifyEvent", method = RequestMethod.POST)
	public String editEvent(@RequestParam("eventNo") int eventNo,
			@RequestParam("title") String title,
			@RequestParam(value = "startDate", required = false) String startDateString,
			@RequestParam(value = "endDate", required = false) String endDateString,
			@RequestParam("content") String content,
			HttpServletRequest req,
			Model model) {
			
			LocalDateTime startDate;
			LocalDateTime endDate;

		    // 시작 날짜와 종료 날짜가 모두 비어 있는 경우 기본값 설정
		    if (startDateString == null && endDateString == null) {
		        startDate = LocalDateTime.parse("3010-03-26T00:00");
		        endDate = LocalDateTime.parse("3010-03-26T00:00");
		    } else {
		        startDate = LocalDateTime.parse(startDateString);
		        endDate = LocalDateTime.parse(endDateString);
		    }
		 
		
		try {
			EventVo event = new EventVo();
			event.setEventNo(eventNo);
			event.setTitle(title);
			event.setStartDate(startDate);
			event.setEndDate(endDate);
			event.setContent(content);
			
			eventService.updateEvent(event, fileList, detailfileList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			// 예외 발생 시에도 이벤트 보드로 리다이렉트
			return "redirect:eventBoard";
			
		}
		return "redirect:eventBoard";
	}
	
	
	
	
	@RequestMapping(value = "/deleteEvent", method = RequestMethod.POST)
	public ResponseEntity<String> deleteEvent(int eventNo)  {	
		System.out.println("deleteEvent 일로옴");
		
		ResponseEntity<String> result = null;
			
			 try {
				 
				if (eventService.deleteEvent(eventNo)) {
					result =  new ResponseEntity<String>("success", HttpStatus.OK);
				};
			} catch (Exception e) {
				e.printStackTrace();
				result = new ResponseEntity<String>("success", HttpStatus.CONFLICT);

			};
			return result;
	}
	
	
	
	// 게시판 전체 목록 조회
	@RequestMapping("eventBoard")
	public void eventImgBoard(Model model, HttpServletRequest req) {
		
		
		try {
			eventList = eventService.getMainEvent();
			detailEventList = eventService.getDetailEvent();
//			customer = eventService.getAdmin(eventadmin);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
			
		// 변환된 날짜를 저장할 리스트 생성
	    List<String> formattedDates = new ArrayList<>();
	    
	    // LocalDateTime 객체를 문자열로 변환하여 리스트에 추가
	    for (EventVo event : eventList) {
	        LocalDateTime startDate = event.getStartDate();
	        LocalDateTime endDate = event.getEndDate();
	        
	        String formattedStartDate = startDate.toString().replace("T", " ");
	        String formattedEndDate = endDate.toString().replace("T", " ");
	        
	        formattedDates.add(formattedStartDate + " ~ " + formattedEndDate);
	    }
		
	    
		model.addAttribute("eventList", eventList);
		model.addAttribute("detailEventList", detailEventList);
		model.addAttribute("formattedDates", formattedDates);
		
	}

	@RequestMapping(value = "/writeEventBoard", method = RequestMethod.POST)
	public String writeEventBoard(@RequestParam("title") String title,
			@RequestParam(value = "startDate", required = false) String startDateString,
			@RequestParam(value = "endDate", required = false) String endDateString,
			@RequestParam("content") String content,
			Model model) {
		
		 LocalDateTime startDate;
		 LocalDateTime endDate;

		    // 시작 날짜와 종료 날짜가 모두 비어 있는 경우 기본값 설정
		    if (startDateString == null && endDateString == null) {
		        startDate = LocalDateTime.parse("3010-03-26T00:00");
		        endDate = LocalDateTime.parse("3010-03-26T00:00");
		    } else {
		        startDate = LocalDateTime.parse(startDateString);
		        endDate = LocalDateTime.parse(endDateString);
		    }
		 
		
		try {
			List<EventImgVo> allList = new ArrayList<>();
			allList.addAll(fileList);
			allList.addAll(detailfileList);
			eventService.saveEvent(title, startDate, endDate, content, allList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 기존의 fileList를 초기화
				fileList.clear();
				detailfileList.clear();
				
				
		return "redirect:eventBoard";
	}

	
	@RequestMapping(value = "uploadFile", method = RequestMethod.POST)
	public @ResponseBody List<EventImgVo> uploadFile(MultipartFile uploadFile, HttpServletRequest req) throws Exception {
	    String realPath = req.getSession().getServletContext().getRealPath("resources/event");
	    
	    System.out.println("realPath : " + realPath);

	    List<EventImgVo> result = new ArrayList<>();

	    try {
	        String fileName = uploadFile.getOriginalFilename();

	        // 이미 해당 파일이 경로에 존재하는지 확인
	        boolean isFileExist = UploadEventFileProcess.checkFileExist(fileName, realPath);

	        // 파일이 존재하지 않는 경우에만 업로드
	        if (!isFileExist) {
	            EventImgVo ei = UploadEventFileProcess.fileUpload(fileName, uploadFile.getSize(),
	                    uploadFile.getContentType(), uploadFile, realPath, 1);
	            
	            if (ei != null) {
	            	fileList.clear();
	                fileList.add(ei);
	                result.add(ei);
	            }
	            
	            
	        } else {
	            System.out.println("이미 존재하는 파일입니다: " + fileName);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    
	    return result;
	}

	@RequestMapping(value = "detailUploadFile", method = RequestMethod.POST)
	public @ResponseBody List<EventImgVo> detailUploadFile(MultipartFile uploadFile, HttpServletRequest req) throws Exception {


		// 파일이 실제로 저장될 경로 realPath
		String realPath = req.getSession().getServletContext().getRealPath("resources/event");
		
		try {
			EventImgVo ei = UploadEventFileProcess.fileUpload(uploadFile.getOriginalFilename(), uploadFile.getSize(),
					uploadFile.getContentType(), uploadFile, realPath, 2);
			if (ei != null) {
				
				detailfileList.add(ei); // DB에 넣어두기위한 값
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return detailfileList;
	}

	@RequestMapping("remFile")
	public ResponseEntity<String> removeFile(@RequestParam("removeFile") String remFile, HttpServletRequest req) {
		ResponseEntity<String> result = null;

		String realPath = req.getSession().getServletContext().getRealPath("resources/event");
		UploadEventFileProcess.deleteFile(fileList, remFile, realPath);
		
		// fileList에서 remFile을 삭제하기 (가변 배열삭제)
		// 0, 1, 2을 삭제한다고치면 1삭제를 누르면 2는 앞으로 땡겨져서 1번째가 된다
		int ind = 0;
		for (EventImgVo ei : fileList) {
			 if(!remFile.equals(ei.getOriginalImgname())) {
				 ind++;	
			} else if (remFile.equals(ei.getOriginalImgname())) {
				break;
			}
		}
			
		
		
		
			
			fileList.remove(ind);
			
			result = new ResponseEntity<String>("success", HttpStatus.OK);
			
			return result;
	}
	
	@RequestMapping("remDetailFile")
	public ResponseEntity<String> removeDetailFile(@RequestParam("removeFile") String remFile, HttpServletRequest req) {
		
		ResponseEntity<String> result = null;
		
		String realPath = req.getSession().getServletContext().getRealPath("resources/event");
		UploadEventFileProcess.deleteDetailFile(detailfileList, remFile, realPath);
		
		// fileList에서 remFile을 삭제하기 (가변 배열삭제)
		// 0, 1, 2을 삭제한다고치면 1삭제를 누르면 2는 앞으로 땡겨져서 1번째가 된다
		int ind = 0;
		for (EventImgVo ei : detailfileList) {
			
			 if(!remFile.equals(ei.getOriginalImgname())) {
				 ind++;	
			} else if (remFile.equals(ei.getOriginalImgname())) {
				break;
			}
		}
			
		
		
			
			detailfileList.remove(ind);
			
			result = new ResponseEntity<String>("success", HttpStatus.OK);
			
			return result;
			
	}
	
	
	@RequestMapping("remAllFile")
	public ResponseEntity<String> remAllFile(HttpServletRequest req) {
		String realPath = req.getSession().getServletContext().getRealPath("resources/event");

		UploadEventFileProcess.deleteAllFile(fileList, realPath);

		fileList.clear();

		return new ResponseEntity<String>("success", HttpStatus.OK);
		
		

	}
	
	// LocalDateTime 객체를 Date 객체로 변환하는 메서드
	public Date ToDate(LocalDateTime localDateTime) {
	    return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
	}

	
	
}
