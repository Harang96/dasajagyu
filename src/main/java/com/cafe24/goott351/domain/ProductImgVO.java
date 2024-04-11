package com.cafe24.goott351.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductImgVO {
	private int imgNo;
	private int productNo;
	private String originalFilename;
	private String newFilename;
	private String imgUrl;
	private int imgSize;
	private String imgExt;
	private Timestamp regDate;

}
