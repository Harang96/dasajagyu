package com.cafe24.goott351.user.order.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.domain.CancelProductDTO;
import com.cafe24.goott351.domain.OrderProductVO;

public interface CSService {

	boolean uploadImages(List<MultipartFile> uploadFile, String orderNo) throws Exception;

	boolean validationCancelOrder(String orderNo, String uuid);

	boolean applyCS(String orderNo, String CSType, List<CancelProductDTO> products, String reason,
			String reasonType, List<MultipartFile> uploadFile) throws Exception;

	boolean cancelOrder(String orderNo, List<OrderProductVO> productList) throws Exception;
}
