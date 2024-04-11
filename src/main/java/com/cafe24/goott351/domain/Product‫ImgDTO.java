package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Product‫ImgDTO {


	private int productNo;
	private String originalFilename;
	private String newFilename;
	private String imgUrl;
	private long imgSize;
	private String imgExt;

}
