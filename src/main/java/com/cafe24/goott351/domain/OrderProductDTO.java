package com.cafe24.goott351.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderProductDTO {
	private int productNo;
	private int qty;
	private String originalName;
	private String orderId;
	private int salesCost; // 개당 판매가
	private int discountCost; // 개당 할인가
	private int orderPrice; // 개당 실판매가 (판매가-할인가)
	private String thumbImg; //썸네일
	private String productName;
	private String sessionId;
	private int currentQty;
	private int cancelStep;
	
	public OrderProductDTO(int productNo, int qty) {
		this.productNo = productNo;
		this.qty = qty;
	}
	
	public void setOrderPrice() {
		this.orderPrice = this.salesCost - this.discountCost;
	}
	
}
