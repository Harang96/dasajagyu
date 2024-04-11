package com.cafe24.goott351.domain;

import java.sql.Timestamp;

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
public class BoardVO {
	private int boardNo;
	private int categoryNo;
	private String boardTitle;
	private String boardContent;
	private String uuid;
	private Timestamp writeDate;
	private int boardLike;
	private int boardRead;
	private String writer;
	
	
	
}

