package com.cafe24.goott351.user.mypage.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.domain.ProductReviewDTO;
import com.cafe24.goott351.domain.ProductReviewVO;
import com.cafe24.goott351.domain.Base64ImgDTO;
import com.cafe24.goott351.user.mypage.persistence.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	private ReviewDAO rDao;

	
	@Override
	public ProductReviewVO getReviewableProduct(int productNo, String orderNo) throws Exception {
		return rDao.selectReviewableProduct(productNo, orderNo);
	}
	
	@Override
	public List<ProductReviewVO> getReviewableList(String uuid) throws Exception {
		return rDao.selectReviewableList(uuid);
	}
	@Override
	public List<ProductReviewVO> getReviewableList(String uuid, int page) throws Exception {
		return rDao.selectReviewableList(uuid, page);
	}

	@Override
	public int getCountOfReviewable(String uuid) {
		return rDao.selectCountOfReviewable(uuid);
	}

	@Override
	public List<ProductReviewVO> getWroteReviewsList(String uuid) throws Exception {
		List<ProductReviewVO> list = rDao.selectWroteReviewsList(uuid);
		for(ProductReviewVO review : list) {
			review.setReviewImages(rDao.selectReviewImages(review.getReviewNo()));
		}
		return list;
	}
	
	@Override
	public ProductReviewVO getReviewByNo(int reviewNo) throws Exception {
		ProductReviewVO review = rDao.selectReviewByNo(reviewNo);
		review.setReviewImages(rDao.selectReviewImages(review.getReviewNo()));
		return review;
	}
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean writeProductReview(ProductReviewDTO review, List<MultipartFile> uploadFile) throws Exception {
		if(rDao.insertProductReivew(review)==1) {
			System.out.println(review.toString());
			if(rDao.updateOrderProductReview(review, "Y")==1) {
				if(updateRate(review)){
					if(uploadImages(uploadFile, review.getReviewNo())) {
						System.out.println(review.getProductNo()+"번 상품 리뷰 등록 완료");
						return true;
					} else {
						System.out.println("리뷰 이미지 업로드 실패");
					}
				}
			}
		}
		return false;
	}
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean modifyProductReview(ProductReviewDTO review, List<MultipartFile> uploadFile) throws Exception {
		if(rDao.updateProductReivew(review)==1) {
			if(updateRate(review)){
				if(uploadImages(uploadFile, review.getReviewNo())) {
					System.out.println(review.getProductNo()+"번 상품 리뷰 수정 완료");
					return true;
				} else {
					System.out.println("리뷰 이미지 업로드 실패");
				}
			}
		}
		return false;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean removeProductReview(ProductReviewDTO review) throws Exception {
		removeAllImagesByReviewNo(review.getReviewNo());
		if(rDao.deleteProductReivew(review.getReviewNo())==1) {
			if(rDao.updateOrderProductReview(review, "N")==1) {
				if(updateRate(review)){
					System.out.println(review.getProductNo()+"번 상품 리뷰 삭제 완료");
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public void removeAllImagesByReviewNo(int reviewNo) throws Exception {
		rDao.deleteAllImagesByReviewNo(reviewNo);
	}

	@Override
	public boolean removeImageByImgNo(int imgNo) throws Exception {
		if(rDao.deleteImageByImgNo(imgNo)==1) {
			return true;
		} else {
			return false;
		}
	}


	@Override
	public String getOrderUUID(String orderNo) throws Exception {
		String uuid = rDao.selectOrderUUID(orderNo); 
		System.out.println("서비스단 UUID ::: "+uuid);
		return uuid;
	}
	
	@Override
	public boolean uploadImages(List<MultipartFile> uploadFile, int reviewNo) throws Exception{
		if(uploadFile!=null || (uploadFile.get(0).getOriginalFilename()).equals("")) {
			List<Base64ImgDTO> list = fileToBase64(uploadFile, reviewNo);
			if(list.size()>0) {
				if(rDao.insertReviewImages(list)==list.size()) {
					return true;
				} else {
					return false;
				}
			} else {
				System.out.println("업로드할 이미지가 없음");
				return true;
			}
		} else {
			return true;
		}
		
	}
	
	private boolean updateRate(ProductReviewDTO review) throws Exception {
		Float rate = rDao.calculateRateFromReviews(review.getProductNo());
		if(rate == null) {
			review.setRate(0f);
		} else {
			review.setRate(rate);
		}
		if(rDao.updateProductRate(review)==1) {
			return true;
		} else {
			return false;
		}
	}
	
	private List<Base64ImgDTO> fileToBase64(List<MultipartFile> uploadFile, int reviewNo) throws Exception{
		List<Base64ImgDTO> list = new ArrayList<Base64ImgDTO>();
		for(MultipartFile file : uploadFile) {
			if(file.getSize()!=0) {
				Base64ImgDTO img = new Base64ImgDTO();
				String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
				img.setReviewNo(reviewNo);
				img.setBase64("data:image/"+ext+";base64,"+Base64.getEncoder().encodeToString(file.getBytes()));
				img.setImgSize(file.getSize());
				list.add(img);
			}
		}
		System.out.println(list);
		return list;
		
	}
	
	

}
