package com.cafe24.goott351.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderShippingDTO {
	private String reciever;
	private String phone;
	private String address;
	private String zipCode;
	private String request;
	private String orderId;
}
