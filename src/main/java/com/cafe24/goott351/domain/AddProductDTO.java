package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
public class AddProductDTO {
	private String productName;
	private String originalName; 
	private String originalClass;
	private int manufacturerNo;
	private int classNo;
	private String classMonth;
	private int salesCost;
	private int purchaseCost;
	private int currentQty;
	private String thumbnailImg;
	private String materials;
	private String size;
	private String isSales;
}
