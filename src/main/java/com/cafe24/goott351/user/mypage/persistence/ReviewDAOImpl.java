package com.cafe24.goott351.user.mypage.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.Base64ImgDTO;
import com.cafe24.goott351.domain.ProductReviewDTO;
import com.cafe24.goott351.domain.ProductReviewVO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Inject
	private SqlSession ses;
	private static String ns = "com.cafe24.goott351.mappers.reviewMapper";
	
	@Override
	public ProductReviewVO selectReviewableProduct(int productNo, String orderNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("productNo", productNo);
		param.put("orderNo", orderNo);
		return ses.selectOne(ns+".selectReviewableProduct", param);
	}
	
	@Override
	public List<ProductReviewVO> selectReviewableList(String uuid) throws Exception {
		return ses.selectList(ns+".selectReviewableList", uuid);
	}
	
	@Override
	public List<ProductReviewVO> selectReviewableList(String uuid, int page) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uuid", uuid);
		param.put("start", page*10);
		return ses.selectList(ns+".selectReviewableList", param);
	}
	
	@Override
	public List<ProductReviewVO> selectWroteReviewsList(String uuid) throws Exception {
		return ses.selectList(ns+".selectWroteReviewsList", uuid);
	}
	
	@Override
	public ProductReviewVO selectReviewByNo(int reviewNo) throws Exception {
		return ses.selectOne(ns+".selectReviewByNo", reviewNo);
	}
	
	@Override
	public int insertProductReivew(ProductReviewDTO review) throws Exception {
		return ses.insert(ns+".insertProductReivew", review);
	}

	@Override
	public int updateOrderProductReview(ProductReviewDTO review, String value) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("value", value);
		param.put("productNo", review.getProductNo());
		param.put("orderNo", review.getOrderNo());
		return ses.update(ns+".updateOrderProductReview", param);
	}

	@Override
	public String selectOrderUUID(String orderNo) throws Exception {
		return ses.selectOne(ns+".selectOrderUUID", orderNo);
	}
	
	@Override
	public Float calculateRateFromReviews(int productNo) {
		return ses.selectOne(ns+".calculateRateFromReviews", productNo);
	}
	
	@Override
	public int updateProductRate(ProductReviewDTO review) throws Exception{
		return ses.update(ns+".updateProductRate", review);
	}

	@Override
	public int updateProductReivew(ProductReviewDTO review) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reviewStar", review.getReviewStar());
		param.put("reviewContent", review.getReviewContent());
		param.put("reviewNo", review.getReviewNo());
		return ses.update(ns+".updateProductReivew", param);
	}

	@Override
	public int deleteProductReivew(int reviewNo) throws Exception {
		return ses.delete(ns+".deleteProductReivew", reviewNo);
	}
	
	@Override
	public int insertReviewImages(List<Base64ImgDTO> images) throws Exception {
		return ses.insert(ns+".insertReviewImages", images);
	}

	@Override
	public int selectCountOfReviewable(String uuid) {
		return ses.selectOne(ns+".selectCountOfReviewable", uuid);
	}

	@Override
	public List<Base64ImgDTO> selectReviewImages(int reviewNo) {
		return ses.selectList(ns+".selectReviewImages", reviewNo);
	}

	@Override
	public void deleteAllImagesByReviewNo(int reviewNo) {
		ses.delete(ns+".deleteAllImagesByReviewNo", reviewNo);
	}

	@Override
	public int deleteImageByImgNo(int imgNo) {
		return ses.delete(ns+".deleteImageByImgNo", imgNo);
	}
}
