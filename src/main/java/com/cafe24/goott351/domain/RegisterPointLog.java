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
public class RegisterPointLog {
	private int no;
	private String why;
	private String customerUuid;
	private Timestamp when;
	private int howmuch;
	
	
	public RegisterPointLog(String why, String customerUuid, int howmuch) {
		super();
		this.why = why;
		this.customerUuid = customerUuid;
		this.howmuch = howmuch;
	}


	public RegisterPointLog(int no) {
		super();
		this.no = no;
	}
	
	
}
