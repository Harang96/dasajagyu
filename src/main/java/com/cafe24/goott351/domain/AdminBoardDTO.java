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

public class AdminBoardDTO {
	private int boardno;
	private int categoryno;
	private int headerno;
	private String boardtitle;
	private String boardcontent;
	private String name;
	private String nickname;
	private String categoryname;
	private Date writedate;
	private int boardlike;
	private int boardread;
	
}
