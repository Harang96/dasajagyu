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
public class LoginCustomerVO {
	private String uuid;
	private String email;
	private String password;
	private String name;
	private Date birthday;
	private String phoneNumber;
	private String gender;
	private String nickname;
	private String sessionKey;
	private String userImg;
	private int userPoint;
	private Date registerDate;
	private String isAdmin;
	private String msgAgree;
	private String bankName;
	private String refundAccount;
	private String socialLogin;
	private String basicAddr;

}
