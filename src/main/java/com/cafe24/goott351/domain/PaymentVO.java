package com.cafe24.goott351.domain;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.cafe24.goott351.util.Cancel;
import com.cafe24.goott351.util.Card;
import com.cafe24.goott351.util.CashReceipt;
import com.cafe24.goott351.util.Failure;
import com.cafe24.goott351.util.VirtualAccount;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class PaymentVO {
	private String lastTransactionKey;
	private String paymentKey;
	private String orderId;
	private String orderName;
	private int taxExemptionAmount;
	private String status;
	private Timestamp requestedAt;
	private Timestamp approvedAt;
	private boolean useEscrow;
	private Card card;
	private VirtualAccount virtualAccount;
	private CashReceipt cashReceipt;
	private ArrayList<Cancel> cancels;
	private String secret;
	private Object easyPay;
	private boolean isPartialCancelable;
	private String transactionKey;
	private int totalAmount;
	private int balanceAmount;
	private int suppliedAmount;
	private String method;
	private Failure fail;
	
	public PaymentVO(String status) {
		this.status = status;
	}
}

