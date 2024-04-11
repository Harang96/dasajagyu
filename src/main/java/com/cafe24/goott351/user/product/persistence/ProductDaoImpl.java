package com.cafe24.goott351.user.product.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.Base64ImgDTO;
import com.cafe24.goott351.domain.LikeCountDTO;
import com.cafe24.goott351.domain.MainReservationProductVO;
import com.cafe24.goott351.domain.ManufacturersVO;
import com.cafe24.goott351.domain.OriginalsVO;
import com.cafe24.goott351.domain.ProductImgVO;
import com.cafe24.goott351.domain.ProductPagingVO;
import com.cafe24.goott351.domain.ProductQnADTO;
import com.cafe24.goott351.domain.ProductReviewVO;
import com.cafe24.goott351.domain.ProductSearchDTO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.domain.ServiceBoardVO;

@Repository
public class ProductDaoImpl implements ProductDao {
	
	@Autowired
	private SqlSession ses;	
	private static String ns = "com.cafe24.goott351.mappers.productMapper";
	
	/**
	* @Method       : selectNewProduct
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 상품 구분에 따른 상품 리스트 읽어오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho
	* 2024.02.28		Taeho Cho	정렬기능 추가       
	*/

	@Override
	public List<ProductVO> selectProductByClass(ProductPagingVO pagingVo, int classNo, ProductSearchDTO searchDto)
			throws Exception {
		String query = ns + ".selectProductsByClass";
		
		Map <String, Object> param = new HashMap<>();
		
		param.put("startRowIndex", pagingVo.getStartRowIndex());
		param.put("pageProductCnt", pagingVo.getPageProductCnt());
		param.put("searchType", searchDto.getSearchType());
		param.put("classNo", classNo);
		
		
		return ses.selectList(query, param);
	}
	
	/**
	* @Method       : selectNewProduct
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 상품 구분 업데이트를 위한 상품 리스트 읽어오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.29        Taeho Cho
	*/
	@Override
	public List<ProductVO> selectProductByClass(ProductPagingVO pagingVo, int classNo)
			throws Exception {
		String query = ns + ".selectProductsByClass";
		
		Map <String, Object> param = new HashMap<>();
		
		param.put("startRowIndex", pagingVo.getStartRowIndex());
		param.put("pageProductCnt", pagingVo.getPageProductCnt());
		param.put("classNo", classNo);
		
		
		return ses.selectList(query, param);
	}

	
	
	/**
	* @Method       : selectDCProduct
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 할인 상품 리스트 읽어오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho       
	* 2024.02.28		Taeho Cho	정렬기능 추가       
	*/
	@Override
	public List<ProductVO> selectDCProduct(ProductPagingVO pagingVo, ProductSearchDTO searchDto) throws Exception {
		String query = ns + ".selectDcProducts";
		
		Map <String, Object> param = new HashMap<>();
		
		param.put("startRowIndex", pagingVo.getStartRowIndex());
		param.put("pageProductCnt", pagingVo.getPageProductCnt());
		param.put("searchType", searchDto.getSearchType());

		
		return ses.selectList(query, param);
	}

	/**
	* @Method       : selectMDProduct
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 추천 상품 리스트 읽어오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho       
	* 2024.02.28		Taeho Cho	정렬기능 추가       
	*/
	@Override
	public List<ProductVO> selectMDProduct(ProductPagingVO pagingVo, ProductSearchDTO searchDto) throws Exception {
		String query = ns + ".selectMdProducts";
		
		Map <String, Object> param = new HashMap<>();
		
		param.put("startRowIndex", pagingVo.getStartRowIndex());
		param.put("pageProductCnt", pagingVo.getPageProductCnt());
		param.put("searchType", searchDto.getSearchType());

		
		return ses.selectList(query, param);
	}
	
	/**
	* @Method       : selectProductByOrigin
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 작품별 페이지 상품 리스트 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.29        Taeho Cho       
	*/
	@Override
	public List<ProductVO> selectProductByOrigin(ProductPagingVO pagingVo, ProductSearchDTO searchDto) throws Exception {
		String query = ns + ".selectProductsByOriginal";
		
		Map <String, Object> param = new HashMap<>();
		
		param.put("startRowIndex", pagingVo.getStartRowIndex());
		param.put("pageProductCnt", pagingVo.getPageProductCnt());
		param.put("searchType", searchDto.getSearchType());
		param.put("originalClass", searchDto.getOriginalClass());
		return ses.selectList(query, param);
	}
	

	/**
	* @Method       : selectProduct
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 상품 상세 정보 읽어오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.26        Taeho Cho       
	*/
	@Override
	public ProductVO selectProduct(int productNo) throws Exception {
		String query = ns + ".selectProduct";
		
		return ses.selectOne(query, productNo);
	}
	


	/**
	* @Method       : selectProductImg
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 상품 상세 이미지 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.26        Taeho Cho       
	*/
	@Override
	public List<ProductImgVO> selectProductImg(int productNo) throws Exception {
		String query = ns + ".selectProductImgList";
		
		return ses.selectList(query, productNo);
	}

	/**
	* @Method       : selectRandomMdProduct
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 상세페이지 추천 상품 렌덤으로 4개까지 불러오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.26        Taeho Cho       
	*/
	@Override
	public List<ProductVO> selectRandomMdProduct() throws Exception {
		String query = ns + ".selectMdProductRandomList";
		
		return ses.selectList(query);
	}

	/**
	* @Method       : selectOriginals
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 작품 카테고리 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.28        Taeho Cho       
	*/
	@Override
	public OriginalsVO selectOriginals(String originalClass) throws Exception {
		String query = ns + ".selectOriginals";
		
		return ses.selectOne(query, originalClass);
	}

	/**
	* @Method       : updateClassCode
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 스케쥴러를 통해 신상품을 입고 완료로 업데이트
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.01        Taeho Cho       
	*/
	@Override
	public int updateClassCode(ProductVO vo) throws Exception {
		String query = ns + ".updateClassCode";
		
		return ses.update(query, vo);
		
	}

	/**
	* @Method       : selectProductBySearch
	* @PackageName  : com.cafe24.goott351.user.product.persistence
	* @Description  : 상품 검색 기능
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.01        Taeho Cho       진행중
	*/
	@Override
	public List<ProductVO> selectProductBySearch(ProductPagingVO pagingVo, ProductSearchDTO searchDto)
			throws Exception {
		String query = ns + ".selectProductBySearch";
		
		Map <String, Object> param = new HashMap<>();

		param.put("startRowIndex", pagingVo.getStartRowIndex());
		param.put("pageProductCnt", pagingVo.getPageProductCnt());
		param.put("searchType", searchDto.getSearchType());
		param.put("searchWord", searchDto.getSearchWord());
		param.put("searchCata", searchDto.getSearchCata());
		param.put("classNo", searchDto.getClassNo());
		
		return ses.selectList(query, param);
	}

	/**
	 * @Method		: getBestProducts
	 * @PackageName	: com.cafe24.goott351.user.product.persistence
	 * @Description	: 배스트 상품 상위 30개 번호 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 15.			Taeho Cho
	 */
	@Override
	public List<Integer> getBestProducts() throws Exception {
		String query = ns + ".getBestSeller";
		
		return ses.selectList(query);
	}
	
	/**
	 * @Method		: selectAllProducts
	 * @PackageName	: com.cafe24.goott351.user.product.persistence
	 * @Description	: 전체 상품 목록 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 15.			Taeho Cho
	 */
	@Override
	public List<ProductVO> selectAllProducts() throws Exception {
		String query = ns + ".selectAllProductsForBest";
		
		return ses.selectList(query);
	}
	
	
	/**
	 * @Method		: selectAllOriginals
	 * @PackageName	: com.cafe24.goott351.user.product.persistence
	 * @Description	: 작품명 구분 리스트 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 2.			Taeho Cho
	 */
	@Override
	public List<OriginalsVO> selectAllOriginals() throws Exception {
		String query = ns + ".selectAllOriginals";
		
		return ses.selectList(query);
	}

	/**
	 * @Method		: selectAllmanufacturers
	 * @PackageName	: com.cafe24.goott351.user.product.persistence
	 * @Description	: 제작사 목록 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 2.			Taeho Cho
	 */
	@Override
	public List<ManufacturersVO> selectAllmanufacturers() throws Exception {
		String query = ns + ".selectAllManufacturers";
		
		return ses.selectList(query);
	}

	/**
	 * @Method		: likeProduct
	 * @PackageName	: com.cafe24.goott351.user.product.persistence
	 * @Description	: 좋아요 로그 저장
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 3.			Taeho Cho
	 */
	@Override
	public int likeProduct(LikeCountDTO dto) throws Exception {
		String query = ns + ".insertLikeCount";
		return ses.insert(query, dto);
	}

	/**
	 * @Method		: dislikeProduct
	 * @PackageName	: com.cafe24.goott351.user.product.persistence
	 * @Description	: 좋아요 로그 삭제
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 3.			Taeho Cho
	 */
	@Override
	public int dislikeProduct(LikeCountDTO dto) throws Exception {
		String query = ns + ".deleteLikeCount";

		return ses.delete(query, dto);
	}

	/**
	 * @Method		: updateLikeCount
	 * @PackageName	: com.cafe24.goott351.user.product.persistence
	 * @Description	: 좋아요 수 업데이트
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 3.			Taeho Cho
	 */
	@Override
	public int updateLikeCount(LikeCountDTO dto) throws Exception {
		String query = ns + ".updateLikeCountByBoardNo";
		
		return ses.update(query, dto);
		
	}

	/**
	 * @Method		: selectLikeLogByUserId
	 * @PackageName	: com.cafe24.goott351.user.product.persistence
	 * @Description	: 로그인한 회원의 좋아요 누른 상품번호 목록 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 3.			Taeho Cho
	 */
	@Override
	public List<Integer> selectLikeLogByUserId(String uuid) throws Exception {
		String query = ns + ".selectLikeLogByUserId";
		
		return ses.selectList(query, uuid);
	}

	@Override
	public int insertProductQnA(ProductQnADTO qna) throws Exception {
		String query = ns + ".insertProductQnA";
		
		return ses.insert(query, qna);
	}

	@Override
	public List<ServiceBoardVO> getProductQnAList(int productNo) throws Exception {
		return ses.selectList(ns + ".getProductQnAList", productNo);
	}

	@Override
	public List<ProductReviewVO> selectProductReview(int productNo) throws Exception {
		String query = ns + ".selectProductReview";
		
		return ses.selectList(query, productNo);
	}

	// 예약 상품의 개수 가져오기
	@Override
	public int selectCountOfReservationProduct() throws Exception {
		int result = 0;
		
		if (ses.selectOne(ns + ".selectCountOfReservationProduct") != null) {
			result = ses.selectOne(ns + ".selectCountOfReservationProduct");
		}
		
		return result;
	}

	// 랜덤한 예약 상품의 정보 가져오기
	@Override
	public MainReservationProductVO selectReservationProduct(int ranNum) throws Exception {

		return ses.selectOne(ns + ".selectReservationProduct", ranNum);
	}

	// 랜덤한 예약 상품 10개의 정보 가져오기	
	@Override
	public List<ProductVO> getRevProductListRand() throws Exception {
		String query = ns + ".selectRevProductListRand";
		
		return ses.selectList(query);
	}

	// 랜덤한 신규 상품 10개의 정보 가져오기	
	@Override
	public List<ProductVO> getNewProductListRand() throws Exception {
		String query = ns + ".selectNewProductListRand";
		
		return ses.selectList(query);
	}

	// 랜덤한 추천 상품 10개의 정보 가져오기
	@Override
	public List<ProductVO> getMdProductListRand() throws Exception {
		String query = ns + ".selectMdProductListRand";
		
		return ses.selectList(query);
	}
	
	// 판매량 1위 제품 가져오기
	@Override
	public int getBestProductNo() throws Exception {
		String query = ns + ".selectBestProductNo";

		return ses.selectOne(query);
	}

	// 최상위 Best 상품 정보 가져오기
	@Override
	public ProductVO getBestProductRand(int bestProductNo) throws Exception {
		String query = ns + ".selectBestProductRand";
		
		return ses.selectOne(query, bestProductNo);
	}
	// 리뷰 이미지 리스트 가져오기
	@Override
	public List<Base64ImgDTO> getReviewImgList(int reviewNo) throws Exception {
		String query = ns + ".selectRevewiImages";
		
		return ses.selectList(query, reviewNo);
	}

}