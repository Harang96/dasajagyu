package com.cafe24.goott351.domain;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductReviewVO {	
	private int reviewNo; // 리뷰 번호
	private int productNo; // 상품번호
	private String orderNo; // 주문번호

	private String reviewContent; // 리뷰
	private Float reviewStar; // 별점
	private Timestamp reviewDate; // 리뷰 작성일
	private List<Base64ImgDTO> reviewImages; // 리뷰 이미지
	
	private String productName; // 상품명
	private String originalName; // 작품명
	private String thumbnailImg; // 썸네일 이미지
	
	private Date orderTime; // 주문일
	
	private String uuid; // 작성자 uuid
	private String name;
	private String nickname; 
	private String userImg;
	
}
