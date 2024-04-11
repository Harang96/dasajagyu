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
public class UpdateProductDTO {

	private int productNo;
	private String productName;
	private int classNo;
	private int manufacturerNo;
	private String originalName;
	private String originalClass;
	private int salesCost;
	private int discountRate;
	private int currentQty;
	private String isRecommend;
}
