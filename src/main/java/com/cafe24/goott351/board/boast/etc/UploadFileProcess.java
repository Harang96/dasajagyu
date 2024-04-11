package com.cafe24.goott351.board.boast.etc;


import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.imgscalr.Scalr.Mode;
import org.springframework.util.FileCopyUtils;

import com.cafe24.goott351.domain.BoardImgVO;
import com.cafe24.goott351.domain.ShareBoardImgVO;


public class UploadFileProcess {
	
	public static BoardImgVO fileupload(String imgOriginName, int size, String contentType, byte[] data, String realPath) throws IOException {
	
		String completePath = makeCalculatePath(realPath); 
	
		BoardImgVO uf = new BoardImgVO();
		
		if(size > 0) {
			uf.setImgNewName(getNeFileName(imgOriginName, realPath, completePath));
//			getNeFileName(originalFileName, realPath, completePath);
			uf.setImgOriginName(imgOriginName);
			uf.setImgSize(size);
			
			
			FileCopyUtils.copy(data, new File(realPath + uf.getImgNewName()));
			
			if(ImgMimeType.contentTypeIsImage(contentType)) {
				System.out.println("반갑습니다!!!");
				
				makeThumbNailImage(uf, completePath, realPath);
				
			} else {
				System.out.println("안녕하세요!!!");	
			}
		}
		return uf;
				
		
	}


	private static void makeThumbNailImage(BoardImgVO uf, String completePath, String realPath) throws IOException {
		// TODO Auto-generated method stub
	System.out.println(realPath + uf.getImgNewName());
		
		BufferedImage originImg	= ImageIO.read(new File(realPath + uf.getImgNewName())); 
		
		
//		Scalr.resize(originImg, Scalr.Method.AUTOMATIC, Mode.FIT_TO_HEIGHT, 50);
		BufferedImage thumbNailImg = Scalr.resize(originImg, Mode.FIT_TO_HEIGHT, 50);
	
		String thumbImgName = uf.getImgOriginName();
		String ext = uf.getImgOriginName().substring(uf.getImgOriginName().lastIndexOf(".") + 1);
		File saveTarget = new File(completePath + File.separator + thumbImgName);
		
		if(ImageIO.write(thumbNailImg, ext, saveTarget)) {
			
			uf.setImgExt(ext);
			
		}
	
		
	}


	private static String getNeFileName(String imgOriginName, String realPath, String completePath) {
		String uuid = UUID.randomUUID().toString();
		
		String ImgNewName = uuid + "_" + imgOriginName;
		
		System.out.println("안녕하신가요? : " + completePath.substring(realPath.length()) + File.separator + ImgNewName);
	
		
		
		
		return completePath.substring(realPath.length()) + File.separator + ImgNewName;
	}

	public static String makeCalculatePath(String realPath) {
		Calendar cal = Calendar.getInstance();
		// 2024 / 01 / 22
//		String year = cal.get(Calendar.YEAR) + "";
//		System.out.println(year);
//		String month = (cal.get(Calendar.MONTH) + 1) + "";
//		System.out.println(new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1));
		
		
//		String date = cal.get(Calendar.DATE) + "";
//		System.out.println(year+ ", " + month  + ", " + date);
		
		//realPath\2024\01\22
		String year = File.separator + (cal.get(Calendar.YEAR) + ""); // \2024
		String month = year + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1); // \2024\01
		String date = month + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // \2024\01\22
		
		makeDirectory(realPath, year, month, date);
		
		return realPath + date;
	}

	private static void makeDirectory(String realPath, String...strings) { 
		
		if(!new File(realPath + strings[strings.length - 1]).exists()) { 
			for(String path : strings) {
				File tmp = new File(realPath + path);
				if(!tmp.exists()) {
					tmp.mkdir();
					
				}	
			}
		}
	}

	public static void deleteFile(List<BoardImgVO> fileList, String remFile, String realPath) {
		
		for (BoardImgVO uf : fileList) {
			if(remFile.equals(uf.getImgOriginName())) { 
				
				File delFile = new File(realPath + uf.getImgNewName());
				
				if(delFile.exists()) {
				delFile.delete();
				
				}
					
					
				}
				
			}
			
			
		}
		

	public static void deleteAllFile(List<BoardImgVO> fileList, String realPath) {
		for(BoardImgVO uf : fileList) {
			File delFile = new File(realPath + uf.getImgNewName());
		
			if(delFile.exists()) {
				delFile.delete();
				
				}
		}
		
		
	}
	

	}