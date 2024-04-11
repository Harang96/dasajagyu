package com.cafe24.goott351.user.order.persistence;

import java.util.List;

import com.cafe24.goott351.domain.Base64ImgDTO;

public interface CSDAO {

	int insertCSImages(List<Base64ImgDTO> list);

	String selectOrderUUID(String orderNo);

	int insertOrderCS(String orderNo, String csType, int productNo, int quantity, String reasonType, String reason, String isAdmin);
	
}
