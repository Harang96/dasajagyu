package com.cafe24.goott351.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderProductVO {
	private String orderNo; // 주문번호
	private int productNo; // 상품번호
	private String productName; // 상품명
	private int quantity; // 주문수량
	private int orderPrice; // 상품별 결제금액
	private String orderCancel; // 결제취소여부
	private String originalName; // 작품명
	private int salesCost; // 상품별 판매가
	private int discountCost; // 상품별 할인가
	private String thumbnailImg; // 썸네일 이미지
	private String review;

	public OrderProductVO(String orderNo) {
		super();
		this.orderNo = orderNo;
	}

	public OrderProductVO(String orderNo, int productNo) {
		super();
		this.orderNo = orderNo;
		this.productNo = productNo;
	}
}