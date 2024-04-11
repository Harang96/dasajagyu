package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


	@AllArgsConstructor
	@NoArgsConstructor
	@Getter
	@Setter
	@ToString
	public class ProductSearchDTO {
		private String searchWord;
		private String searchType;
		private String searchCata;		
		private int classNo;
		private String originalClass;
		private int manufacturerNo;
}
