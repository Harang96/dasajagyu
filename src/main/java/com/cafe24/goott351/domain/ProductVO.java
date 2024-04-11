package com.cafe24.goott351.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductVO {
	private int productNo; // 상품번호
	private String productName; // 상품명
	private String originalName; //작품명
	private String originalClass;
	private int manufacturerNo;
	private int classNo; // 작품 구분 (예약10, 신규20, 입고30)
	private String classMonth; // 예약상품 입고월
	private Timestamp regDate;
	private int salesCost; // 판매가
	private int purchaseCost;
	private int discountRate; // 할인율(%)
	private int currentQty;  // 재고
	private int reserveQty;
	private String thumbnailImg; // 썸네일
	private String materials;
	private String size;
	private String isSales; // 판매여부
	private String isRecommend;
	private int likeCnt;
	private float productRate;
	private String manufacturerName;
	private String className;
	private String classType;
}
