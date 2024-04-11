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
public class ReplyVO {
	private int replyNo;
	private Timestamp replyDate;
	private String replyContent;
	private int boardNo;
	private String uuid;
	private int categoryno;
	
	
}

