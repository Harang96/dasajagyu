package com.cafe24.goott351.domain;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ProductQnADTO {
	private int svBoardNo; // 문의 제목
	private String svBoardTitle; // 문의 제목
	private String svBoardContent; // 문의 내용
	private String svBoardAnswer; // 문의 내용
	private int productNo; // 문의 상품번호
	private String uuid; // 유저 uuid
}