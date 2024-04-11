package com.cafe24.goott351.domain;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ServiceBoardDTO {
	private Integer svBoardNo; // 글 번호
	private Timestamp svBoardRegiDate; // 작성일
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

	private Integer commentBoardNo; // 답글달 게시글번호

	public ServiceBoardDTO(int svBoardNo, Timestamp svBoardRegiDate, String svIsHidden, String svType, int productNo,
			String orderNo, String svBoardTitle, String nickname) {
		super();
		this.svBoardNo = svBoardNo;
		this.svBoardRegiDate = svBoardRegiDate;
		this.svIsHidden = svIsHidden;
		this.svType = svType;
		this.productNo = productNo;
		this.orderNo = orderNo;
		this.svBoardTitle = svBoardTitle;
		this.nickname = nickname;
	}

	public ServiceBoardDTO(int svBoardNo) {
		super();
		this.svBoardNo = svBoardNo;
	}
	
	public ServiceBoardDTO(String svType) {
		super();
		this.svType = svType;
	}
}