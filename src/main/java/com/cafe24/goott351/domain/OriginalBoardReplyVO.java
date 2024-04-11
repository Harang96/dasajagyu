package com.cafe24.goott351.domain;

import java.sql.Date;

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
public class OriginalBoardReplyVO {
	private int replyNo;
	private String replyContent;
	private int boardNo;
	private String uuid;
	private String nickname;
}
