package com.cafe24.goott351.domain;

import java.sql.Timestamp;

import com.cafe24.goott351.util.VirtualAccount;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

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
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderDTO {
    private String orderId;
    private String paymentKey;
    private String orderName;
    private String method;
    private Timestamp approvedAt;
    private String status;
    private String uuid;
    private String orderStatus;
    private VirtualAccount virtualAccount;
    private String number;
    private int amount;
}
