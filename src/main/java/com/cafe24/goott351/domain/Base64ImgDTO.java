package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Base64ImgDTO {
	private int imgNo;
	private String base64;
	private long imgSize;
	private int reviewNo;
	private String orderNo;
}
