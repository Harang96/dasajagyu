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
public class DeliveryDTO {
   private int deliveryNo;
   private String deliveryPostcode;
   private String deliveryAddr;
   private String deliveryDetail;
   private String basicAddr;
   private String uuid;
   private String deliveryName;
   private String phoneNumber;

}
