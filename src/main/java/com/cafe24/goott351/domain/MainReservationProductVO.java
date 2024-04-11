package com.cafe24.goott351.domain;

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
public class MainReservationProductVO {
	private int productNo;
	private String productName; 
	private String originalName;
	private int salesCost;
	private int discountRate;
	private String classMonth;
	private String isRecommend;
	private int currentQty;
	private String thumbnailImg;
}
