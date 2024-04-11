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
public class OriginalBoardReplyDTO {
		private int replyNo;
		private int boardNo;
		private String replyContent;
		private String uuid;
}
