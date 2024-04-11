package com.cafe24.goott351.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString

public class MyPageOrderVO {
	private OrderVO orderVo;
	private List<OrderProductVO> orderProductVoList;
	private OrderBillingVO orderBillingVo;
	private OrderShippingDTO orderShippingDto;
	private String csType;
}
