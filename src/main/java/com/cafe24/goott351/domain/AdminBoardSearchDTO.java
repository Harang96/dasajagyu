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

public class AdminBoardSearchDTO {
	
	private String searchWord;
	private String searchType;
	private String colName; // 검색 필터 종류
	private String colValue; // 검색 필터 값
	
	

}
