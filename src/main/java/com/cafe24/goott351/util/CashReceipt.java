package com.cafe24.goott351.util;

import java.sql.Date;
import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class CashReceipt {
	private String receiptKey;
	private String orderId;
	private String orderName;
	private String type;
	private String receiptUrl;
	private String businessNumber;
	private int amount;
	private Failure failure;
	private String customerIdentityNumber;
	private Timestamp requestedAt;
}
