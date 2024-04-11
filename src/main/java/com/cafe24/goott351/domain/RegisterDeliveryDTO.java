package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class RegisterDeliveryDTO {
	private int deliveryNo;
	private String deliveryPostcode;
	private String deliveryAddr;
	private String deliveryDetail;
	private String basicAddr;
	private String uuid;
	private String name;
	private String phoneNumber;
	
	
	public RegisterDeliveryDTO(String deliveryPostcode, String deliveryAddr, String deliveryDetail, String basicAddr,
			String uuid, String name, String phoneNumber) {
		super();
		this.deliveryPostcode = deliveryPostcode;
		this.deliveryAddr = deliveryAddr;
		this.deliveryDetail = deliveryDetail;
		this.basicAddr = basicAddr;
		this.uuid = uuid;
		this.name = name;
		this.phoneNumber = phoneNumber;
	}


	public RegisterDeliveryDTO(int deliveryNo) {
		super();
		this.deliveryNo = deliveryNo;
	}



	
}
