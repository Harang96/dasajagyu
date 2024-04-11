package com.cafe24.goott351.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class DeliveryVO {
	private int deliveryNo;
	private String deliveryPostcode;
	private String deliveryAddr;
	private String deliveryDetail;
	private String basicAddr;
	private String deliveryName;
	private String phoneNumber;
	private String uuid;
}
