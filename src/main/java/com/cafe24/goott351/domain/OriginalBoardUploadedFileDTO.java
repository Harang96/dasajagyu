package com.cafe24.goott351.domain;

import lombok.Data;

@Data
public class OriginalBoardUploadedFileDTO {
	private String FileName;
	private String ext;
	private String newFileName;
	private long imgSize;
	private int boardNo;
	private String base64String;
	private String thumbFileName;
}

