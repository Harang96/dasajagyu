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
public class SalesOrderCsVO {
	private int csNo;
	private Date csDate;
	private String reason;
	private int  productQuantity;
	private String csType;
	private String orderNo;
	private String productName;
	private String payMethod;
	private String nickname;
}
