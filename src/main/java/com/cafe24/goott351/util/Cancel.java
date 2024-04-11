package com.cafe24.goott351.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Cancel {
	private String transactionKey;
	private String cancelReason;
	private int taxExemptionAmount;
	private String tmpcanceledAt;
	private Timestamp canceledAt;
	private int easyPayDiscountAmount;
	private String receiptKey;
	private int cancelAmount;
	private int taxFreeAmount;
	private int refundableAmount;
	private String lastTransactionKeyList; // 임의추가

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

	public Cancel() {
	}

	public Cancel(String transactionKey, String cancelReason, int taxExemptionAmount, String tmpcanceledAt,
			int easyPayDiscountAmount, String receiptKey, int cancelAmount, int taxFreeAmount, int refundableAmount,
			String lastTransactionKeyList) throws ParseException {
		this.transactionKey = transactionKey;
		this.cancelReason = cancelReason;
		this.taxExemptionAmount = taxExemptionAmount;
		this.tmpcanceledAt = tmpcanceledAt;
		this.easyPayDiscountAmount = easyPayDiscountAmount;
		this.receiptKey = receiptKey;
		this.cancelAmount = cancelAmount;
		this.taxFreeAmount = taxFreeAmount;
		this.refundableAmount = refundableAmount;
		this.lastTransactionKeyList = lastTransactionKeyList;
		this.canceledAt = new Timestamp(sdf.parse(tmpcanceledAt).getTime());
	}

	public String getTransactionKey() {
		return transactionKey;
	}

	public void setTransactionKey(String transactionKey) {
		this.transactionKey = transactionKey;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	public int getTaxExemptionAmount() {
		return taxExemptionAmount;
	}

	public void setTaxExemptionAmount(int taxExemptionAmount) {
		this.taxExemptionAmount = taxExemptionAmount;
	}

	public String getTmpcanceledAt() {
		return tmpcanceledAt;
	}

	public void setTmpcanceledAt(String tmpcanceledAt) {
		this.tmpcanceledAt = tmpcanceledAt;
	}

	public Timestamp getCanceledAt() {
		return canceledAt;
	}

	public void setCanceledAt() throws ParseException {
		this.canceledAt = new Timestamp(sdf.parse(tmpcanceledAt).getTime());
		;
	}

	public int getEasyPayDiscountAmount() {
		return easyPayDiscountAmount;
	}

	public void setEasyPayDiscountAmount(int easyPayDiscountAmount) {
		this.easyPayDiscountAmount = easyPayDiscountAmount;
	}

	public String getReceiptKey() {
		return receiptKey;
	}

	public void setReceiptKey(String receiptKey) {
		this.receiptKey = receiptKey;
	}

	public int getCancelAmount() {
		return cancelAmount;
	}

	public void setCancelAmount(int cancelAmount) {
		this.cancelAmount = cancelAmount;
	}

	public int getTaxFreeAmount() {
		return taxFreeAmount;
	}

	public void setTaxFreeAmount(int taxFreeAmount) {
		this.taxFreeAmount = taxFreeAmount;
	}

	public int getRefundableAmount() {
		return refundableAmount;
	}

	public void setRefundableAmount(int refundableAmount) {
		this.refundableAmount = refundableAmount;
	}

	public String getLastTransactionKeyList() {
		return lastTransactionKeyList;
	}

	public void setLastTransactionKeyList(String lastTransactionKeyList) {
		this.lastTransactionKeyList = lastTransactionKeyList;
	}

	@Override
	public String toString() {
		return "CancelVO [transactionKey=" + transactionKey + ", cancelReason=" + cancelReason + ", taxExemptionAmount="
				+ taxExemptionAmount + ", tmpcanceledAt=" + tmpcanceledAt + ", canceledAt=" + canceledAt
				+ ", easyPayDiscountAmount=" + easyPayDiscountAmount + ", receiptKey=" + receiptKey + ", cancelAmount="
				+ cancelAmount + ", taxFreeAmount=" + taxFreeAmount + ", refundableAmount=" + refundableAmount
				+ ", lastTransactionKeyList=" + lastTransactionKeyList + "]";
	}

}
