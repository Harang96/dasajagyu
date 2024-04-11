/**
 * 
 */
package com.cafe24.goott351.domain;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author : su hyeok kim
 * @date : 2024. 3. 19.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 3. 19.
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderCSVO {
	private int csNo;
	private Timestamp csDate;
	private String reason;
	private String isAdmin;
	private int productQuantity;
	private int productNo;
	private String csType;
	private String orderNo;
	private String reasonType;
	private String csProcessed;
	
	private String productName;
	private int salesCost;
	
	
	public OrderCSVO(String orderNo, int csNo){
		super();
		this.orderNo = orderNo;
		this.csNo = csNo;
	}

	public OrderCSVO(String orderNo){
		super();
		this.orderNo = orderNo;
	}
	
}
