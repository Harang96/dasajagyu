package com.cafe24.goott351.domain;


import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Data
public class CartVO {
	
	private int cart_no;
	private String uuid;
	private int productno;
	private int quantity;
	private String sessionid;
	private String classtype;
	private String classmonth;
	private String productname;
	private int classno;
	private int salescost;
	private int discountrate;
	private int discountcost;
	private int currentqty;
	private String thumbnailimg;
	private String issales;
	
	

	
	
}
