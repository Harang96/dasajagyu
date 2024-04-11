package com.cafe24.goott351.util;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.domain.OriginalImgVO;

public class UploadOriginalFile {

	
	
	
	public static OriginalImgVO originalFileUpload(String fileName, long size, String contentType,
			String originalRealPath, byte[] data, MultipartFile originaluploadFile) throws Exception {

		OriginalImgVO Oi = new OriginalImgVO();
		String completePath = makeCalculatePath(originalRealPath);
		String base64 = originalImgToBase64(originaluploadFile);
		if (size > 0) {
			Oi.setImgOriginName((getNewFileName(fileName, originalRealPath, completePath)));
			Oi.setImgSize(size);
			Oi.setImgExt(fileName.substring(fileName.lastIndexOf(".")));
			Oi.setBase64(base64);
			
			FileCopyUtils.copy(data, new File(originalRealPath + Oi.getImgOriginName()));

			if (ImageMimeType.isImageContentType(contentType)) {
				// 파일 이미지인 경우 ->
				System.out.println("이미지입니다.....");
				return Oi;
			} else {
				System.out.println("이미지가 아닙니다...");
				return null;
			}
		}

		return Oi;
	}

	private static String getNewFileName(String FileName, String realPath, String completePath) {
		String uuid = UUID.randomUUID().toString();
		
		String ImgFileName = uuid + "_" + FileName;
		
		// 테이블에 저장될 업로드 파일이름
		System.out.println("테이블에 저장될 업로드 파일이름 : " + File.separator + ImgFileName);
		
				
				
		
		return  File.separator + ImgFileName;
	}


	public static String originalImgToBase64(MultipartFile originaluploadFile) {
		
		String result = null;
		
		byte[] file;
		
		try {
			file = originaluploadFile.getBytes();
			result = Base64.getEncoder().encodeToString(file);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return result;
		
	}
	

	public static String makeCalculatePath(String realPath) {
		// 현재 날짜를 얻어오기
		Calendar cal = Calendar.getInstance();
		// 2024 / 01 / 22
//		String year = cal.get(Calendar.YEAR) + ""; // 인트를 스트링으로
//		String month = (cal.get(Calendar.MONTH) + 1) + "";
//		System.out.println(new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1));
//		
//		String date = cal.get(Calendar.DATE) + "";
//		System.out.println(year + ", " + month + ", " + date );
		
		// realPath\2024\01\22
		String year = File.separator + (cal.get(Calendar.YEAR) + ""); // \2024
		String month = year + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1); // \2024\01
		String date = month + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // \2024\01\22
		
		makeDirectory(realPath, year, month, date);
		
		return realPath + date;
		
	}

	
	private static void makeDirectory(String realPath, String...strings) { // 실질적으로 디렉토리를 만드는 메서드
		// year,month,date를 가변인자로 받아보자 (String...strings)
		// 디렉토리 생성
		 if(!new File(realPath + strings[strings.length -1]).exists()) { // date경로 디렉토리 없으면 (index번호로 따지면 0,1,2 인데 length로 따지면 3이니 -1을 해줘야한다. 
			 for (String path : strings) {
				 File tmp = new File(realPath + path);
				 if (!tmp.exists()) {
					 tmp.mkdir();
				 }
			 }
		 }
		
		 
	}
	
	public static boolean checkFile(String fileName, String realPath) {
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
