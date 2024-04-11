package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class FindpwVO {
    private String newPwd;
    private String newPwd2;
    private String uuid;
    private String emailComfirm;
}