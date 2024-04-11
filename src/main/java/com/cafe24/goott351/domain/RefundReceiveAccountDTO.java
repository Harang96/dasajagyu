package com.cafe24.goott351.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 결제 취소 후 금액이 환불될 계좌의 정보 ( 가상계좌 결제에만 필수 )
@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class RefundReceiveAccountDTO {
	private String bank;
	private String accountNumber;
	private String holderName;
	
	
}