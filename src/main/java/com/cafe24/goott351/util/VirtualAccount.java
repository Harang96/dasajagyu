package com.cafe24.goott351.util;

import java.sql.Date;
import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class VirtualAccount {
    private String accountNumber;
    private String accountType;
    private String bank;
    private String bankCode;
    private String customerName;
    private Timestamp dueDate;
    private String expired;
    private String settlementStatus;
    private String refundStatus;
    private String refundReceiveAccount;
}
