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
public class CustomerCntVO {
	private int totCustomer;
	private int totMale;
	private int totFemale;
	private int withdraw;
	private int regCustomer;
}
