package com.cafe24.goott351.user.product.service;

/*import java.util.List;*/
import java.util.Map;

import com.cafe24.goott351.domain.LikeCountDTO;
import com.cafe24.goott351.domain.MainReservationProductVO;
import com.cafe24.goott351.domain.ProductQnADTO;
import com.cafe24.goott351.domain.ProductSearchDTO;


public interface ProductService {
	
	Map<String, Object> getProductsListByClass(int pageNo, int classNo, ProductSearchDTO searchDto) throws Exception;

	Map<String, Object> getDcProductsList(int pageNo, ProductSearchDTO searchDto) throws Exception;

	Map<String, Object> getMdProductsList(int pageNo, ProductSearchDTO searchDto) throws Exception;

	Map<String, Object> getProductDetail(int productNo) throws Exception;

	Map<String, Object> getProductsListByOrigin(int pageNo, ProductSearchDTO searchDto) throws Exception;

	Map<String, Object> getProductBySearch(int pageNo, ProductSearchDTO searchDto) throws Exception;

	boolean likeProduct(LikeCountDTO likeDto) throws Exception;

	boolean dislikeProduct(LikeCountDTO likeDto) throws Exception;

	// 문의하기
	boolean addProductQnA(ProductQnADTO qna) throws Exception;

	Map<String, Object> getBestProductList() throws Exception;
	
	// 랜덤한 예약 상품 가져오기
	MainReservationProductVO getRandomReservationProduct() throws Exception;

	Map<String, Object> getProductListForMain() throws Exception;
}