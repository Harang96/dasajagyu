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
public class ServiceBoardVO {
	private Integer svBoardNo; // 글 번호
	private Date svBoardRegiDate; // 작성일
	private String svBoardContent; // 글 내용
	private String svIsHidden;
	private String svIsDelete;
	private String svType;
	private String svBoardAnswer;
	private Integer productNo; // 상품번호
	private String uuid; // 유저
	private String orderNo; // 주문 번호
	private String svBoardTitle; // 글 제목
	private String nickname;
	private String userImg;
	private Integer commentBoardNo; // 답글달 게시글번호
}