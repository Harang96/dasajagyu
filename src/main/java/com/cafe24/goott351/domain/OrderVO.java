/**
 * 
 */
package com.cafe24.goott351.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author : goott5
 * @date : 2024. 2. 27.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         goott5 2024. 2. 27.
 */

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class OrderVO {
	private String orderNo;
	private Timestamp orderTime;
	private String orderStatus;
	private String payStatus;
	private Date deliveryDate;
	private String paymentKey;
	private Timestamp paymentDate;
	private String orderName;
	private String customerId;
	private String customerName;
	private String payMethod;
	private String payAccountNo;
}
