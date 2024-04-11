package com.cafe24.goott351.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.domain.EventImgVo;





public class UploadEventFileProcess {
	
	public static EventImgVo fileUpload(String originalImgname, long imgSize, String contentType, MultipartFile uploadFile, String realPath, int eventimgIdentify) throws Exception {
	    EventImgVo ei = new EventImgVo();
	   
	    if (imgSize > 0) {
	        
	            
	            String completePath = makeCalculatePath(realPath); // 물리적 경로 + \년\월\일
	            String imgUrl = makeImgToBase64String(uploadFile);
	            
	            ei.setNewImgname(getNewFileName(originalImgname, realPath, completePath));
	            ei.setOriginalImgname(originalImgname);
	            ei.setImgSize(imgSize);
	            ei.setImgExt(originalImgname.substring(originalImgname.lastIndexOf(".")));
	            ei.setEventimgIdentify(eventimgIdentify);
	            ei.setImgUrl(imgUrl);
	            
	            FileCopyUtils.copy(uploadFile.getBytes(), new File(realPath + ei.getNewImgname())); // 원본이미지 저장

	            if (ImageMimeType.isImageContentType(contentType)) {
	                // 파일이 이미지인 경우 - > 썸네일 생성
	                System.out.println("이미지입니다.....");
	                makeThumbNailImage(ei,realPath,completePath);
	            } else {
	                System.out.println("이미지가 아닙니다...");
	                
	            }
	    
	   
	    return ei;
	        
	    }  
	     else {
	        System.out.println("업로드된 파일이 없습니다.");
	        return null;
	    }
	    
	    
	}
	
	
	public static String makeCalculatePath(String realPath) {
		// 현재 날짜 얻어오기
		Calendar now = Calendar.getInstance();
		
		String year = File.separator + (now.get(Calendar.YEAR) + ""); // \2024
		String month = year + File.separator + (new DecimalFormat("00").format(now.get(Calendar.MONTH) +1)); // \2024\01
		String date= month + File.separator + (new DecimalFormat("00").format(now.get(Calendar.DATE)) + ""); // \2024\01\22
		
		makeDirectory(realPath, year, month, date);
		
		return realPath +  date;
	}
	
	
	private static void makeDirectory(String realPath,String...strings) { // 가변인자 방식으로 받기 (배열 방식)
		// directory 생성
		if (!new File(realPath + strings[strings.length - 1]).exists()) { // date 경로 디렉토리가 없으면
			for (String path : strings) {
				File temp = new File(realPath + path);
				if(!temp.exists()){
					temp.mkdirs();			// 생성
				}
			}
			
		} 
	}
	
	

//	public static EventImgVo detailFileUpload(String originalImgname, long imgSize, String contentType, byte[] data, String realPath, int eventimgIdentify) throws IOException {
//	    EventImgVo ei = new EventImgVo();
//	    if (imgSize > 0) {
//	        
//	            ei.setNewImgname(getNewDetailFileName(originalImgname, realPath));
//	            ei.setOriginalImgname(originalImgname);
//	            ei.setImgSize(imgSize);
//	            ei.setImgExt(originalImgname.substring(originalImgname.lastIndexOf(".")));
//	            ei.setEventimgIdentify(2); // eventimgIdentify 설정
//	            FileCopyUtils.copy(data, new File(realPath + ei.getNewImgname())); // 원본이미지 저장
//
//	            if (ImgMimeType.contentTypeIsImage(contentType)) {
//	                // 파일이 이미지인 경우 - > 썸네일 생성
//	                System.out.println("이미지입니다.....");
//	                makeThumbNailImage(ei,realPath);
//	            } else {
//	                System.out.println("이미지가 아닙니다...");
//	                
//	            }
//	    
//	    System.out.println ("업로드프로세스" + ei.toString());
//	    return ei;
//	        
//	    }  
//	     else {
//	        System.out.println("업로드된 파일이 없습니다.");
//	        return null;
//	    }
//	    
//	    
//	}

   

	private static void makeThumbNailImage(EventImgVo ei, String realPath, String completePath) throws IOException {
		// 저장된 원본 파일을 읽어서 스케일 다운하여 썸네일을 만든다.
		String saveDir = completePath.substring(realPath.length()) ;
		
		BufferedImage originImg = ImageIO.read(new File(realPath + ei.getNewImgname()));
		
//		Scalr.resize(originImg, Scalr.Method.AUTOMATIC, Mode.FIT_TO_HEIGHT, 50);
		BufferedImage thumbNailImg = Scalr.resize(originImg, Scalr.Mode.FIT_TO_HEIGHT, 20);
		
		
		// 썸네일 저장
		String thumbImgName = "thumb_" + ei.getOriginalImgname();
		
		
		String ext = ei.getOriginalImgname().substring(ei.getOriginalImgname().lastIndexOf(".") + 1);
		File saveTarget = new File(realPath + File.separator + thumbImgName);
		
		
		if (ImageIO.write(thumbNailImg, ext, saveTarget)) { // 썸네일 저장
			
			System.out.println("썸네일 이미지 저장 완료");
		} else {
			System.out.println("썸네일 이미지 저장 실패");
		}
		
		
	}
	
//	private static String getNewDetailFileName(String originalImgname, String realPath) {
//		String uuid = UUID.randomUUID().toString();
//		
//		String newFileName = uuid + "_" + originalImgname;
//		
//		// 테이블에 저장될 업로드 파일이름
//		System.out.println("테이블에 저장될 업로드 파일이름 : " + File.separator + newFileName);
//		
//				
//		return  File.separator + newFileName;
//	}


	private static String getNewFileName(String originalImgname, String realPath, String completePath) {
		String uuid = UUID.randomUUID().toString();
		
		String newFileName = uuid + "_" + originalImgname;
		
		String saveDir = completePath.substring(realPath.length()) ;
		// 테이블에 저장될 업로드 파일이름
				
		
		return  saveDir + File.separator + newFileName;
	}

	public static void deleteFile(List<EventImgVo> fileList, String remFile, String realPath) {
		// (x)를 클릭 -> 삭제
		
		for (EventImgVo ei : fileList) {
			if (remFile.equals(ei.getOriginalImgname())) { // 지워야할 파일 찾았다.
				
				
				File delFile = new File(realPath + ei.getNewImgname());
				
				if(delFile.exists()) {
					delFile.delete();
				}
				
			
					File thumbFile = new File(realPath);
					System.out.println("thumbFile " + thumbFile);
					if (thumbFile.exists()) {
						thumbFile.delete();
					}
				}
				
			}
		}
		
	public static void deleteDetailFile(List<EventImgVo> detailfileList, String remFile, String realPath) {
		// (x)를 클릭 -> 삭제
		
		for (EventImgVo ei : detailfileList) {
			if (remFile.equals(ei.getOriginalImgname())) { // 지워야할 파일 찾았다.
				
				
				File delFile = new File(realPath + ei.getNewImgname());
				
				if(delFile.exists()) {
					delFile.delete();
				}
				
			
					File thumbFile = new File(realPath);
					
					if (thumbFile.exists()) {
						thumbFile.delete();
					}
				}
				
			}
		}	
	
	
		
	
	

	public static void deleteAllFile(List<EventImgVo> fileList, String realPath) {
		// 취소버튼 클릭시 모든 드래그드랍한 파일 삭제
		
				for (EventImgVo ei : fileList) {
					
						
						File delFile = new File(realPath + ei.getNewImgname());
//						System.out.println("delFile " + delFile);
						
						if(delFile.exists()) {
							delFile.delete();	
						}
						
						
							File thumbFile = new File(realPath);
//							System.out.println("uf.getThumbFileName " + uf.getThumbFileName());
							
							if (thumbFile.exists()) {
								thumbFile.delete();
						}
						
					
				}	
	}
	
	public static String makeImgToBase64String(MultipartFile uploadFile) {
		// img 파일을 base64String으로 만들기
		// encoding (파일 -> 문자열)
		String result = null;
		
		byte[] file;
		try {
	        file = uploadFile.getBytes();
	        result = Base64.getEncoder().encodeToString(file);
//			System.out.println("Base64 인코딩 결과 : " + result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static boolean checkFileExist(String fileName, String realPath) {
	    File directory = new File(realPath);
	    File[] files = directory.listFiles();
	    if (files != null) {
	        for (File file : files) {
	            if (file.getName().equals(fileName)) {
	                return true; // 파일이 이미 존재함
	            }
	        }
	    }
	    return false; // 파일이 존재하지 않음
	}

	
	
}