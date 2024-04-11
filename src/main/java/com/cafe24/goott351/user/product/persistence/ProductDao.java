package com.cafe24.goott351.user.product.persistence;

import java.util.List;

import com.cafe24.goott351.domain.Base64ImgDTO;
import com.cafe24.goott351.domain.LikeCountDTO;
import com.cafe24.goott351.domain.MainReservationProductVO;
import com.cafe24.goott351.domain.ManufacturersVO;
import com.cafe24.goott351.domain.OriginalsVO;
import com.cafe24.goott351.domain.ProductImgVO;
import com.cafe24.goott351.domain.ProductPagingVO;
import com.cafe24.goott351.domain.ProductQnADTO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.ProductReviewVO;
import com.cafe24.goott351.domain.ProductSearchDTO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.domain.ServiceBoardVO;

public interface ProductDao {

	List<ProductVO> selectProductByClass(ProductPagingVO pagingVo, int classNo, ProductSearchDTO searchDto) throws Exception;

	List<ProductVO> selectProductByClass(ProductPagingVO pagingVo, int classNo) throws Exception;

	List<ProductVO> selectDCProduct(ProductPagingVO pagingVo, ProductSearchDTO searchDto) throws Exception;

	List<ProductVO> selectMDProduct(ProductPagingVO pagingVo, ProductSearchDTO searchDto) throws Exception;

	ProductVO selectProduct(int productNo) throws Exception;

	List<ProductImgVO> selectProductImg(int productNo) throws Exception;

	List<ProductVO> selectRandomMdProduct() throws Exception;

	List<ProductVO> selectProductByOrigin(ProductPagingVO pagingVo, ProductSearchDTO searchDto) throws Exception;

	OriginalsVO selectOriginals(String originalClass) throws Exception;

	int updateClassCode(ProductVO vo) throws Exception;

	List<ProductVO> selectProductBySearch(ProductPagingVO pagingVo, ProductSearchDTO searchDto) throws Exception;

	List<OriginalsVO> selectAllOriginals() throws Exception;

	List<ManufacturersVO> selectAllmanufacturers() throws Exception;

	int likeProduct(LikeCountDTO dto) throws Exception;

	int dislikeProduct(LikeCountDTO dto) throws Exception;

	int updateLikeCount(LikeCountDTO dto) throws Exception;

	List<Integer> selectLikeLogByUserId(String uuid) throws Exception;

	int insertProductQnA(ProductQnADTO qna) throws Exception;
	/* 디테일페이지 문의하기 내용 추가 */

	List<ServiceBoardVO> getProductQnAList(int productNo) throws Exception;
	/* 디테일페이지 문의하기 리스트 가져오기 */

	List<ProductReviewVO> selectProductReview(int productNo) throws Exception;
	/* 디테일페이지 등록된 제품 리뷰 리스트 가져오기 */

	List<Integer> getBestProducts() throws Exception;
	/* 베스트 상품 리스트 가져오기 */

	List<ProductVO> selectAllProducts() throws Exception;
	/* 데이터베이스에 등록된 모든 상품들의 리스트 가져오기 */

	// 예약 상품의 개수 가져오기
	int selectCountOfReservationProduct() throws Exception;

	// 랜덤한 예약 상품의 정보 가져오기
	MainReservationProductVO selectReservationProduct(int ranNum) throws Exception;

	List<ProductVO> getRevProductListRand() throws Exception;

	List<ProductVO> getNewProductListRand() throws Exception;

	List<ProductVO> getMdProductListRand() throws Exception;

	int getBestProductNo() throws Exception;

	ProductVO getBestProductRand(int bestProductNo) throws Exception;

	List<Base64ImgDTO> getReviewImgList(int reviewNo) throws Exception;


}