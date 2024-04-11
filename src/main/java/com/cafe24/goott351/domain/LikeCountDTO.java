package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@ToString
public class LikeCountDTO {

	private int productNo;
	private String uuid;
	private String behavior;
	private int n = 0;

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public void setBehavior(String behavior) {
		this.behavior = behavior;
	}
	public void setN(String behavior) {
		if (behavior.equals("like")){
			this.n = 1;	
		} else if (behavior.equals("dislike")) {
			this.n = -1;				
		}
	}

}

