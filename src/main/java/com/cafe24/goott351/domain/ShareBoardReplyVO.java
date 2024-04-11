package com.cafe24.goott351.domain;

import java.sql.Date;

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
public class ShareBoardReplyVO {
	private int replyNo;
	private String replyContent;
	private Date replyDate;
	private int boardNo;
	private String uuid;
	private String writer;
	private String userImg;
}
