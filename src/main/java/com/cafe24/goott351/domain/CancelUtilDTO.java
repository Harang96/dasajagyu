package com.cafe24.goott351.domain;

import java.sql.Timestamp;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CancelUtilDTO {
	private String customerId;
	private String transactionKey;
	private String cancelType;
	private String cancelReason;
	private Timestamp canceledAt;
	private int cancelAmount;
	private int cancelProductDiscount;
	private int refundCost = 0;
	private int refundPoint = 0;
	private int refundShipping = 0;
	private int refundEarningPoint = 0;
	private String adminYn;
	private String csType;

	private List<CancelProductDTO> productArr;
	private List<OrderProductVO> cancelItem;
	private String orderNo;
	private int productNo;
	private String productName;
	private int quantity;
	private int orderPrice;
	private String orderCancel;
	private String originalName;
	private int salesCost;
	private int discountCost;
	private String thumbnailImg;
	private String paymentKey;

	private boolean isShippingRefund;
	private int step;
	private boolean isFirstConn;

	private LoginCustomerVO customer;

	public CancelUtilDTO(int refundEarningPoint, String customerId) {
		this.refundEarningPoint = refundEarningPoint;
		this.customerId = customerId;
	}

	public CancelUtilDTO(int cancelAmount, int cancelProductDiscount, int refundCost, int refundPoint,
			int refundShipping, int refundEarningPoint, String orderNo) {
		this.cancelAmount = cancelAmount;
		this.cancelProductDiscount = cancelProductDiscount;
		this.refundCost = refundCost;
		this.refundPoint = refundPoint;
		this.refundShipping = refundShipping;
		this.refundEarningPoint = refundEarningPoint;
		this.orderNo = orderNo;
	}

	public CancelUtilDTO(String cancelType, String cancelReason) {
		super();
		this.cancelType = cancelType;
		this.cancelReason = cancelReason;
	}

	public CancelUtilDTO(String cancelReason, String adminYn, int quantity, int productNo, String csType,
			String orderNo) {
		super();
		this.cancelReason = cancelReason;
		this.adminYn = adminYn;
		this.quantity = quantity;
		this.productNo = productNo;
		this.csType = csType;
		this.orderNo = orderNo;
	}

	public CancelUtilDTO(int step, String orderNo, int productNo, String csType, boolean isFirstConn) {
		super();
		this.step = step;
		this.orderNo = orderNo;
		this.orderNo = orderNo;
		this.productNo = productNo;
		this.csType = csType;
		this.isFirstConn = isFirstConn;
	}

	public CancelUtilDTO(int step, String orderNo, int productNo, String csType, String cancelType,
			List<OrderProductVO> cancelItem) {
		super();
		this.step = step;
		this.orderNo = orderNo;
		this.orderNo = orderNo;
		this.productNo = productNo;
		this.csType = csType;
		this.cancelType = cancelType;
		this.cancelItem = cancelItem;
	}

	public CancelUtilDTO(int step, List<OrderProductVO> cancelItem, String csType, String cancelType) {
		super();
		this.step = step;
		this.cancelItem = cancelItem;
		this.csType = csType;
		this.cancelType = cancelType;
	}
	
	public CancelUtilDTO(String adminYn, String cancelReason, String cancelType, String csType, LoginCustomerVO customer, boolean isShippingRefund, String orderNo, List<CancelProductDTO> productArr, String paymentKey) {
		super();
		this.adminYn = adminYn;
		this.cancelReason = cancelReason;
		this.cancelType = cancelType;
		this.csType = csType;
		this.customer = customer;
		this.isShippingRefund = isShippingRefund;
		this.orderNo = orderNo;
		this.productArr = productArr;
		this.paymentKey = paymentKey;
	}

}
