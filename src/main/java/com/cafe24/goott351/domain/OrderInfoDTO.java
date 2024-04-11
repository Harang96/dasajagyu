package com.cafe24.goott351.domain;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderInfoDTO {
	private List<OrderProductDTO> products;
	private OrderBillingDTO bill;
	private OrderShippingDTO shipping;
	private OrderDTO order;
	private String sessionId;
}
