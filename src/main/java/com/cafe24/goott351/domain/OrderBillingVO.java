/**
 * 
 */
package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderBillingVO {
	private String orderNo;
	private int productAmount;
	private int productDiscount;
	private int pointDiscount;
	private int shippingCost;
	private int orderCost;
	private int orderPoint;
}
