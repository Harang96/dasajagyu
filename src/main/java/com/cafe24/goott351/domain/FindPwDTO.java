package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class FindPwDTO {
    private String newPwd;
    private String newPwd2;
    private String uuid;
    private String emailAuth;
    
    

}
    
