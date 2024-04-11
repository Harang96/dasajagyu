package com.cafe24.goott351.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OriginalBoardVO {
	private	int boardNo;
	private int categoryNo;
	private int headerNo;
	private String boardTitle;
	private String boardContent;
	private String uuid;
	private Timestamp writeDate;
	private int boardLike;
	private int boardRead;
	private int originalCategory;
	private String boardCategoryName;
	private String nickname;

}
