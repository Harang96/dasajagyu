package com.cafe24.goott351.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductReviewDTO {
	private int reviewNo; 
	private int productNo; // 상품번호
	private String orderNo; // 주문번호
	private String uuid; // 작성자 uuid
	private String originalName; // 작품명
	private String reviewContent; // 리뷰
	private Float reviewStar; // 별점
	private Float rate; //평점
	
	public ProductReviewDTO(int reviewNo, int productNo, String orderNo) {
		super();
		this.reviewNo = reviewNo;
		this.productNo = productNo;
		this.orderNo = orderNo;
	}
	
}