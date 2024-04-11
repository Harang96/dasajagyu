package com.cafe24.goott351.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderCsDTO {
	private String reason;
	private String adminYn;
	private int productQuantity;
	private int productNo;
	private String csType;
	private String orderNo;
	private String reasonType;
	private String csProcessed;
	
}
