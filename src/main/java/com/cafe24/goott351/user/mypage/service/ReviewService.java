package com.cafe24.goott351.user.mypage.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.domain.ProductReviewDTO;
import com.cafe24.goott351.domain.ProductReviewVO;
import com.cafe24.goott351.domain.Base64ImgDTO;

public interface ReviewService {

	ProductReviewVO getReviewableProduct(int productNo, String orderNo) throws Exception;
	
	List<ProductReviewVO> getReviewableList(String uuid) throws Exception;

	List<ProductReviewVO> getReviewableList(String uuid, int page) throws Exception;

	List<ProductReviewVO> getWroteReviewsList(String uuid) throws Exception;
	
	ProductReviewVO getReviewByNo(int reviewNo) throws Exception;
	
	String getOrderUUID(String orderNo) throws Exception;

	boolean removeProductReview(ProductReviewDTO review) throws Exception;

	boolean uploadImages(List<MultipartFile> uploadFile, int reviewNo) throws Exception;

	boolean writeProductReview(ProductReviewDTO review, List<MultipartFile> uploadFile) throws Exception;

	boolean modifyProductReview(ProductReviewDTO review, List<MultipartFile> uploadFile) throws Exception;

	int getCountOfReviewable(String uuid);

	boolean removeImageByImgNo(int no) throws Exception;

	void removeAllImagesByReviewNo(int reviewNo) throws Exception;

	

}
