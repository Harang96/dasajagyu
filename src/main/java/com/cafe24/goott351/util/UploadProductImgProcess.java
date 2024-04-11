package com.cafe24.goott351.util;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.domain.Product‫ImgDTO;

public class UploadProductImgProcess {

	/**
	 * @Method		: fileUpload
	 * @PackageName	: com.cafe24.goott351.util
	 * @Return		: Product‫ImgDTO
	 * @Description	: 이미지 파일 업로드
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 9.			Taeho Cho
	 */
	public static Product‫ImgDTO fileUpload(MultipartFile uploadFile, String realPath) {
		Product‫ImgDTO piDto = new Product‫ImgDTO();
        if (uploadFile == null || uploadFile.isEmpty()) {
            // 업로드할 파일이 없는 경우 예외 발생
            throw new IllegalArgumentException("업로드할 파일이 없습니다.");
        }
		
		
		try {
			String originalFilename = uploadFile.getOriginalFilename();
			long fileSize = uploadFile.getSize();
			String contentType = uploadFile.getContentType();
			byte[] bytes = uploadFile.getBytes();
			String imgUrl = makeImgToBase64String(uploadFile);
			
			String completePath = makeCalculatePath(realPath); // 물리적 경로 + \년\월\일
			
			if (fileSize > 0) {
				piDto.setNewFilename(getNewFileName(originalFilename, realPath, completePath));
				piDto.setOriginalFilename(originalFilename);
				piDto.setImgSize(fileSize);
				piDto.setImgExt(originalFilename.substring(originalFilename.lastIndexOf(".") + 1));
				piDto.setImgUrl(imgUrl);
				
				FileCopyUtils.copy(bytes, new File(realPath + piDto.getNewFilename())); // 원본이미지 저장
			
			}
		
		} catch (IOException e) {
			e.printStackTrace();
	        return null;
		}
		return piDto;
	}

	/**
	 * @Method		: makeCalculatePath
	 * @PackageName	: com.cafe24.goott351.util
	 * @Return		: String
	 * @Description	: 저장 경로 생성
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 9.			Taeho Cho
	 */
	public static String makeCalculatePath(String realPath) {
		// 현재 날짜 얻어오기
		Calendar now = Calendar.getInstance();
		
		String year = File.separator + (now.get(Calendar.YEAR) + ""); // \2024
		String month = year + File.separator + (new DecimalFormat("00").format(now.get(Calendar.MONTH) +1)); // \2024\01
		String date= month + File.separator + (new DecimalFormat("00").format(now.get(Calendar.DATE)) + ""); // \2024\01\22
		
		makeDirectory(realPath, year, month, date);
		
		return realPath +  date;
	}

	/**
	 * @Method		: makeDirectory
	 * @PackageName	: com.cafe24.goott351.util
	 * @Return		: void
	 * @Description	: 이미지 저장 경로에 따른 디렉터리 생성
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 9.			Taeho Cho
	 */
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

	/**
	 * @Method		: getNewFileName
	 * @PackageName	: com.cafe24.goott351.util
	 * @Return		: String
	 * @Description	: 새로운 파일 이름을 생성
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 9.			Taeho Cho
	 */
	private static String getNewFileName(String originalFilename, String realPath, String completePath) {
		String uuid = UUID.randomUUID().toString();
		String newFilename = uuid + "_" + originalFilename;
		String saveDir = completePath.substring(realPath.length()) ;
		
		// 테이블에 저장될 업로드 파일이름
		
		return saveDir + File.separator + newFilename;
	}
	
	/**
	 * @return 
	 * @Method		: deleteFile
	 * @PackageName	: com.cafe24.goott351.util
	 * @Return		: void
	 * @Description	: fileList 내에서 해당 파일 삭제
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 9.			Taeho Cho
	 */
	public static boolean deleteFile(List<Product‫ImgDTO> fileList, String removeFile, String realPath) {
		// (x)를 클릭 => 삭제
		boolean result = false;
		for (Product‫ImgDTO dto : fileList) {
			if (dto.getNewFilename().equals(removeFile)) {
				
				File deleteFile = new File(realPath + dto.getNewFilename());
				if (deleteFile.exists()) {
					deleteFile.delete();
					result = true;
				}
			}
		}
		return result;
	}

	public static void deleteFile(Product‫ImgDTO piDto, String removeFile, String realPath) {
		// (x)를 클릭 => 삭제
		if (piDto.getNewFilename().equals(removeFile)) {
			File deleteFile = new File(realPath + piDto.getNewFilename());
			if (deleteFile.exists()) {
				deleteFile.delete();					
			}
		}
	}

	/**
	 * @Method		: deleteAllFile
	 * @PackageName	: com.cafe24.goott351.util
	 * @Return		: void
	 * @Description	: 취소 버튼을 클릭하면 모든 removeFile 파일 삭제
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 9.			Taeho Cho
	 */
	public static void deleteAllFile(List<Product‫ImgDTO> fileList, String realPath) {
		// 취소 버튼을 클릭 => 모드 삭제
		for (Product‫ImgDTO dto : fileList) {
			File deleteFile = new File(realPath + dto.getNewFilename());
			if (deleteFile.exists()) {
				deleteFile.delete();					
			}
		}
	}
	
	/**
	 * @Method		: deleteAllFile
	 * @PackageName	: com.cafe24.goott351.util
	 * @Return		: void
	 * @Description	:  취소 버튼을 클릭하면 모든 removeFile 삭제
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 9.			Taeho Cho
	 */
	public static void deleteAllFile(Product‫ImgDTO ufDto, String realPath) {
		// 취소 버튼을 클릭 => 모드 삭제
		File deleteFile = new File(realPath + ufDto.getNewFilename());
		if (deleteFile.exists()) {
			deleteFile.delete();					
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
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
