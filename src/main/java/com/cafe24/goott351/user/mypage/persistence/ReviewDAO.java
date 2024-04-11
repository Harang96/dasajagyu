package com.cafe24.goott351.user.mypage.persistence;

import java.util.List;

import com.cafe24.goott351.domain.Base64ImgDTO;
import com.cafe24.goott351.domain.ProductReviewDTO;
import com.cafe24.goott351.domain.ProductReviewVO;

public interface ReviewDAO {

	List<ProductReviewVO> selectReviewableList(String uuid) throws Exception;

	List<ProductReviewVO> selectReviewableList(String uuid, int page) throws Exception;
	
	List<ProductReviewVO> selectWroteReviewsList(String uuid) throws Exception;

	ProductReviewVO selectReviewByNo(int reviewNo) throws Exception;

	int insertProductReivew(ProductReviewDTO review) throws Exception;

	int updateOrderProductReview(ProductReviewDTO review, String value) throws Exception;

	String selectOrderUUID(String orderNo) throws Exception;

	int updateProductRate(ProductReviewDTO review) throws Exception;

	int updateProductReivew(ProductReviewDTO review) throws Exception;

	int deleteProductReivew(int reviewNo) throws Exception;

	int insertReviewImages(List<Base64ImgDTO> images) throws Exception;

	int selectCountOfReviewable(String uuid);

	List<Base64ImgDTO> selectReviewImages(int reviewNo);

	ProductReviewVO selectReviewableProduct(int productNo, String orderNo);

	void deleteAllImagesByReviewNo(int reviewNo);

	int deleteImageByImgNo(int imgNo);

	Float calculateRateFromReviews(int productNo);

	
}
