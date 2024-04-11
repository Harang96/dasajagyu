package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class OriginalImgVO {
	private int imgNo;
	private String imgExt;
	private long imgSize;
	private String imgNewName;
	private String imgOriginName;
	private String base64;
	private int boardNo;
}
