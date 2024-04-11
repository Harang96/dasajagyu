package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class BoardImgVO {
	private int boardNo;
	private int imgNo;
	private String imgExt;
	private int imgSize;
	private String imgPath;
	private String imgNewName;
	private String imgOriginName;
}
