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
public class ReadCountProcess {
	private int no;
	private String idAddr;
	private int boardNo;
	private Timestamp readDate;
}
