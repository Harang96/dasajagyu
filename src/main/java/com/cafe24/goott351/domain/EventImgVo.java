package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString

public class EventImgVo {
	private int eventimgNo;
	private int eventNo;
	private String originalImgname;
	private String newImgname;
	private long imgSize;
	private String imgExt;
	private String mainimgFilepath;
	private String detailimgFilepath;
	private int eventimgIdentify;
	private String imgUrl;
}
