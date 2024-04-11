package com.cafe24.goott351.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderBillingDTO {
	private int productAmount; // 총 상품 금액
	private int productDiscount; // 총 할인 금액
	private int shippingCost; // 배송비
	private int pointDiscount = 0; // 포인트 사용 금액
	private int orderCost; // 주문 금액
	private int orderPoint; // 적립 포인트 (주문 금액의 1%)
	private String orderId; // 주문번호
	
	
	public OrderBillingDTO(int productAmount, int productDiscount) {
		this.productAmount = productAmount;
		this.productDiscount = productDiscount;
		
		if(productAmount-productDiscount < 50000) { // 5만원 미만일 경우 배송비 청구
			this.shippingCost = 3000;
		} else {
			this.shippingCost = 0;
		}
		
		// 주문 금액(결제금액) 
		this.orderCost = this.productAmount - this.productDiscount - this.pointDiscount + this.shippingCost;
		
		// 포인트 적립 (배송비 제외 결제 금액의 1퍼센트)
		this.orderPoint = (int) ((this.productAmount - this.productDiscount) * 0.01);
	}

	public void setPointDiscount(int pointDiscount) {
		this.pointDiscount = pointDiscount;
		this.orderCost = this.productAmount - this.productDiscount - this.pointDiscount + this.shippingCost;
		if(this.shippingCost!=0 && this.orderCost <= 3000) { // 상품 금액 이상으로 배송비까지 포인트로 결제할 경우
			this.orderPoint = 0;
		} else {
			this.orderPoint = (int) ((this.productAmount - this.productDiscount - this.pointDiscount) * 0.01);			
		}
	}	
}
