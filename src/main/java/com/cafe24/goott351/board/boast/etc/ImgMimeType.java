package com.cafe24.goott351.board.boast.etc;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class ImgMimeType {
	
	private static Map<String, String> imgMimeType;
	
	{

	}

	static {
	  imgMimeType = new HashMap<String, String>();
	  
	  imgMimeType.put("jpg", MediaType.IMAGE_JPEG.toString());
	  imgMimeType.put("jpeg", MediaType.IMAGE_JPEG.toString());
	  imgMimeType.put("gif", MediaType.IMAGE_GIF_VALUE);
	  imgMimeType.put("png", MediaType.IMAGE_PNG_VALUE);
	}
	
	public static boolean extIsImage(String ext) {
		return imgMimeType.containsKey(ext);
		
	}
	
	public static boolean contentTypeIsImage(String contentType) {
		return imgMimeType.containsValue(contentType);
		
		
	}
	
}