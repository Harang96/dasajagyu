/**
 * 
 */
package com.cafe24.goott351.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author : su hyeok kim
 * @date  : 2024. 2. 28. 
 * @description : 
 * @change
 * name		 		date					detail
 * ----------------------------------------------------------------------------------
 * su hyeok kim		2024. 2. 28.	
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class CustomerVO {
	private String uuid;
	private String email;
	private String name;
	private String birthday;
	private String phone_number;
	private String gender;
	private String nickname;
	private String session_key;
	private String user_img;
	private int user_point;
	private Date register_date;
	private String is_admin;
	private String msg_agree;
	private String bank_name;
	private String refund_account;
	private String addr;
	private String addr_postcode;
	private String addr_detail;
	private String addr_extra;

}
