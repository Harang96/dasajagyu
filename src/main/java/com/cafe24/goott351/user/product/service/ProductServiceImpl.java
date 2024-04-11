package com.cafe24.goott351.user.product.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.domain.Base64ImgDTO;
import com.cafe24.goott351.domain.LikeCountDTO;
import com.cafe24.goott351.domain.LoginCustomerVO;
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
import com.cafe24.goott351.user.product.persistence.ProductDao;
import com.cafe24.goott351.user.product.persistence.etc.ProductPagingDao;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDao pDao;
	@Autowired
	ProductPagingDao pageDao;
	@Autowired
	private HttpSession ses;

	/**
	* @Method       : getProductsListByClass
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Description  : 상품 구분별 목록 (페이징 포함) service
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho       
	*/
	@Override
	public Map<String, Object> getProductsListByClass(int pageNo, int classNo, ProductSearchDTO searchDto) throws Exception{
	
		Map<String, Object> productMap = new HashMap<>();

		ProductPagingVO pagingVo = getPagingInfo(pageNo, classNo);
		List<ProductVO> list = pDao.selectProductByClass(pagingVo, classNo, searchDto); 
		List<Integer> productLikeLog = null;
		if (ses.getAttribute("loginCustomer") != null) {
			LoginCustomerVO loginUser = (LoginCustomerVO) ses.getAttribute("loginCustomer");
			productLikeLog = pDao.selectLikeLogByUserId(loginUser.getUuid());
		}
		productMap.put("productList", list);
		productMap.put("pagingInfo", pagingVo);
		productMap.put("productLikeLog", productLikeLog);
		
		return productMap;
	}

	/**
	* @Method       : getDcProductsList
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Description  : 할인 상품 (페이징 포함) service
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho       
	*/
	@Override
	public Map<String, Object> getDcProductsList(int pageNo, ProductSearchDTO searchDto) throws Exception {
		Map<String, Object> productMap = new HashMap<>();
		
		ProductPagingVO pagingVo = getDCPagingInfo(pageNo);
		List<ProductVO> list = pDao.selectDCProduct(pagingVo, searchDto); 
		List<Integer> productLikeLog = null;
		if (ses.getAttribute("loginCustomer") != null) {
			LoginCustomerVO loginUser = (LoginCustomerVO) ses.getAttribute("loginCustomer");
			productLikeLog = pDao.selectLikeLogByUserId(loginUser.getUuid());
		}
		
		productMap.put("productList", list);
		productMap.put("pagingInfo", pagingVo);
		productMap.put("productLikeLog", productLikeLog);		
		
		return productMap;
	}

	/**
	* @Method       : getMdProductsList
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Description  : 추천 상품 (페이징 포함) service
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho       
	*/
	@Override
	public Map<String, Object> getMdProductsList(int pageNo, ProductSearchDTO searchDto) throws Exception {
		Map<String, Object> productMap = new HashMap<>();
		
		ProductPagingVO pagingVo = getMDPagingInfo(pageNo);
		List<ProductVO> list = pDao.selectMDProduct(pagingVo, searchDto); 
		List<Integer> productLikeLog = null;
		if (ses.getAttribute("loginCustomer") != null) {
			LoginCustomerVO loginUser = (LoginCustomerVO) ses.getAttribute("loginCustomer");
			productLikeLog = pDao.selectLikeLogByUserId(loginUser.getUuid());
		}
		
		productMap.put("productList", list);
		productMap.put("pagingInfo", pagingVo);
		productMap.put("productLikeLog", productLikeLog);		
		
		return productMap;
	}
	
	/**
	* @Method       : getProductsListByOrigin
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Description  : 작품 구분에 따른 상품 Service
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.29        Taeho Cho       
	*/
	@Override
	public Map<String, Object> getProductsListByOrigin(int pageNo, ProductSearchDTO searchDto)
			throws Exception {
		Map<String, Object> productMap = new HashMap<>();

		ProductPagingVO pagingVo = getPagingInfoOrigin(pageNo, searchDto);
		List<ProductVO> list = pDao.selectProductByOrigin(pagingVo, searchDto); 
		OriginalsVO originVo = pDao.selectOriginals(searchDto.getOriginalClass()); 
		List<OriginalsVO> originalList = pDao.selectAllOriginals(); 
		List<Integer> productLikeLog = null;
		
		if (ses.getAttribute("loginCustomer") != null) {
			LoginCustomerVO loginUser = (LoginCustomerVO) ses.getAttribute("loginCustomer");
			productLikeLog = pDao.selectLikeLogByUserId(loginUser.getUuid());
		}
		productMap.put("productLikeLog", productLikeLog);
		
		productMap.put("productList", list);
		productMap.put("pagingInfo", pagingVo);
		productMap.put("original", originVo);
		productMap.put("originals", originalList);
		
		return productMap;
	}
	
	   /**
	    * @Method      : getBestProductList
	    * @PackageName   : com.cafe24.goott351.user.product.service
	    * @Description   : 베스트 상품 출력을 위한 정보 가져오는 Service
	    * ===========================================================
	    * DATE            AUTHOR         MEMO
	    * -----------------------------------------------------------
	    * 2024. 3. 15.         Taeho Cho
	    */
	   @Override
	   public Map<String, Object> getBestProductList() throws Exception {
	      Map<String, Object> productMap = new HashMap<>();
	      
	      List<ProductVO> list = pDao.selectAllProducts();
	      List<Integer> best30 = pDao.getBestProducts();
	      List<Integer> productLikeLog = null;
	      
	      if (ses.getAttribute("loginCustomer") != null) {
	         LoginCustomerVO loginUser = (LoginCustomerVO) ses.getAttribute("loginCustomer");
	         productLikeLog = pDao.selectLikeLogByUserId(loginUser.getUuid());
	      }
	      productMap.put("productLikeLog", productLikeLog);
	      productMap.put("best30", best30);
	      productMap.put("productList", list);

	      return productMap;
	   }
	
	
	/**
	* @Method       : getProductDetail
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Description  : 상품 상세 정보 및 상세 페이지에 필요한 파일 추출
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.26        Taeho Cho       
	*/
	@Override
	public Map<String, Object> getProductDetail(int productNo) throws Exception {
		Map<String, Object> productMap = new HashMap<>();
		ProductVO productVo = pDao.selectProduct(productNo);
		List<ProductImgVO> productImgList = pDao.selectProductImg(productNo);
		List<ProductVO> mdProductList = pDao.selectRandomMdProduct();
		List<Integer> productLikeLog = null;
		List<ServiceBoardVO> productQnaList = pDao.getProductQnAList(productNo); // 문의하기 리스트
		List<ProductReviewVO> reviews = pDao.selectProductReview(productNo); // 리뷰 리스트
		List<Integer> reviewNoList = null;		
		for (ProductReviewVO review : reviews) {
			int reviewNo = review.getReviewNo();
			List<Base64ImgDTO> reviewImgList = pDao.getReviewImgList(reviewNo);
			if (reviewImgList != null) {
				review.setReviewImages(reviewImgList);
			}
		}		
		
		if (ses.getAttribute("loginCustomer") != null) {
			LoginCustomerVO loginUser = (LoginCustomerVO) ses.getAttribute("loginCustomer");
			productLikeLog = pDao.selectLikeLogByUserId(loginUser.getUuid());
		}
		productMap.put("product", productVo);
		productMap.put("productImgList", productImgList);
		productMap.put("mdProductList", mdProductList);
		productMap.put("productLikeLog", productLikeLog);
		productMap.put("qna", productQnaList);
		productMap.put("reviews", reviews);

		
		return productMap;
	}	
	
	/**
	* @Method       : getProductBySearch
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Description  : 검색 조건 기능 Service
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.01        Taeho Cho       
	*/
	@Override
	public Map<String, Object> getProductBySearch(int pageNo, ProductSearchDTO searchDto) throws Exception {
		Map<String, Object> productMap = new HashMap<>();
		
		ProductPagingVO pagingVo = getPagingInfo(pageNo, searchDto);
		List<ProductVO> productList = pDao.selectProductBySearch(pagingVo, searchDto);
		List<OriginalsVO> originalList = pDao.selectAllOriginals();
		List<ManufacturersVO> manufacturerList = pDao.selectAllmanufacturers();
		List<Integer> productLikeLog = null;
		if (ses.getAttribute("loginCustomer") != null) {
			LoginCustomerVO loginUser = (LoginCustomerVO) ses.getAttribute("loginCustomer");
			productLikeLog = pDao.selectLikeLogByUserId(loginUser.getUuid());
		}

		productMap.put("productList", productList);
		productMap.put("originalList", originalList);
		productMap.put("manufacturerList", manufacturerList);
		productMap.put("pagingInfo", pagingVo);
		productMap.put("productLikeLog", productLikeLog);
		
		return productMap;
	}

	
	/**
	 * @Method		: likeProduct
	 * @PackageName	: com.cafe24.goott351.user.product.service
	 * @Description	: 좋아요 로그 추가 및 카운트 증가
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 3.			Taeho Cho
	 */
	@Override
	@Transactional (rollbackFor = Exception.class)
	public boolean likeProduct(LikeCountDTO likeDto) throws Exception {
		boolean result = false;
		if (pDao.likeProduct(likeDto) == 1){
			if (pDao.updateLikeCount(likeDto) == 1);
			result = true;
		};
		return result;
		
	}

	/**
	 * @Method		: dislikeProduct
	 * @PackageName	: com.cafe24.goott351.user.product.service
	 * @Description	: 좋아요 로그 삭제 및 카운트 감소
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 3.			Taeho Cho
	 */
	@Override
	@Transactional (rollbackFor = Exception.class)
	public boolean dislikeProduct(LikeCountDTO likeDto) throws Exception {
		boolean result = false;
		if (pDao.dislikeProduct(likeDto) == 1){
			if (pDao.updateLikeCount(likeDto) == 1);
			result = true;
		};
		return result;
		
	}
	
	
	/**
	* @Method       : getPagingInfo
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Return       : ProductPagingVo
	* @Description  : 상품 구분 시 페이징
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho
	* 2024.02.28		Taeho Cho	정렬 기준 추가
	*/
	private ProductPagingVO getPagingInfo(int pageNo, int classNo) {
		ProductPagingVO vo = new ProductPagingVO();
		vo.setPageNo(pageNo);
		// 전제 게시글
		vo.setTotalProductCnt(pageDao.getTotalProductCnt(classNo));
		// 총 페이지수
		vo.setTotalPageCnt(vo.getTotalProductCnt(), vo.getPageProductCnt());
		// 보이기 시작할 번호
		vo.setStartRowIndex();
		// 전체 페이징 블럭 갯수
		vo.setTotalPagingBlock();
		// 현재 페이징 블럭
		vo.setCurrentPageBlock();
		// 현재 페이징 시작 번호
		vo.setStartPageNum();
		// 현재 페이징 마지막 번호
		vo.setEndPageNum();
		
		return vo;
	}

	/**
	* @Method       : getPagingInfo
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Return       : ProductPagingVo
	* @Description  : 작품 구분 시 페이징
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho
	*/
	private ProductPagingVO getPagingInfoOrigin(int pageNo, ProductSearchDTO searchDto) {
		ProductPagingVO vo = new ProductPagingVO();
		vo.setPageNo(pageNo);
		// 전제 게시글
		vo.setTotalProductCnt(pageDao.getTotalProductCntOrigin(searchDto));
		// 총 페이지수
		vo.setTotalPageCnt(vo.getTotalProductCnt(), vo.getPageProductCnt());
		// 보이기 시작할 번호
		vo.setStartRowIndex();
		// 전체 페이징 블럭 갯수
		vo.setTotalPagingBlock();
		// 현재 페이징 블럭
		vo.setCurrentPageBlock();
		// 현재 페이징 시작 번호
		vo.setStartPageNum();
		// 현재 페이징 마지막 번호
		vo.setEndPageNum();
		
		return vo;
	}

	
	/**
	* @Method       : getPagingInfo
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Return       : ProductPagingVo
	* @Description  : 상품 페이징
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho
	*/
	public ProductPagingVO getPagingInfo(int pageNo) throws Exception {
		ProductPagingVO vo = new ProductPagingVO();
		vo.setPageNo(pageNo);
		// 전체 게시글
		vo.setTotalProductCnt(pageDao.getTotalProductCnt());
		// 전제 게시글
		vo.setTotalPageCnt(vo.getTotalProductCnt(), vo.getPageProductCnt());
		// 총 페이지수
		vo.setStartRowIndex();
		// 보이기 시작할 번호
		vo.setTotalPagingBlock();
		// 현재 페이징 블럭
		vo.setCurrentPageBlock();
		// 현재 페이징 시작 번호
		vo.setStartPageNum();
		// 현재 페이징 마지막 번호
		vo.setEndPageNum();
		
		return vo;
	}
	
	public ProductPagingVO getMDPagingInfo(int pageNo) throws Exception {
		ProductPagingVO vo = new ProductPagingVO();
		vo.setPageNo(pageNo);
		// 전체 게시글
		vo.setTotalProductCnt(pageDao.getTotalMDProductCnt());
		// 전제 게시글
		vo.setTotalPageCnt(vo.getTotalProductCnt(), vo.getPageProductCnt());
		// 총 페이지수
		vo.setStartRowIndex();
		// 보이기 시작할 번호
		vo.setTotalPagingBlock();
		// 현재 페이징 블럭
		vo.setCurrentPageBlock();
		// 현재 페이징 시작 번호
		vo.setStartPageNum();
		// 현재 페이징 마지막 번호
		vo.setEndPageNum();
		
		return vo;
	}
	
	public ProductPagingVO getDCPagingInfo(int pageNo) throws Exception {
		ProductPagingVO vo = new ProductPagingVO();
		vo.setPageNo(pageNo);
		// 전체 게시글
		vo.setTotalProductCnt(pageDao.getTotalDCProductCnt());
		// 전제 게시글
		vo.setTotalPageCnt(vo.getTotalProductCnt(), vo.getPageProductCnt());
		// 총 페이지수
		vo.setStartRowIndex();
		// 보이기 시작할 번호
		vo.setTotalPagingBlock();
		// 현재 페이징 블럭
		vo.setCurrentPageBlock();
		// 현재 페이징 시작 번호
		vo.setStartPageNum();
		// 현재 페이징 마지막 번호
		vo.setEndPageNum();
		
		return vo;
	}

	/**
	* @Method       : getPagingInfo
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Return       : ProductPagingVo
	* @Description  : 검색 조건에 따른 페이징
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.01        Taeho Cho
	*/
	private ProductPagingVO getPagingInfo(int pageNo, ProductSearchDTO searchDto) {
		ProductPagingVO vo = new ProductPagingVO();
		vo.setPageNo(pageNo);
		
//		if (searchDto.getSearchWord().equals("")) { // 검색어가 없으면
			// 전제 게시글
//			vo.setTotalProductCnt(pageDao.getTotalProductCnt());
//		} else if (!searchDto.getSearchWord().equals("") && !searchDto.getSearchType().equals("")) { // 검색어가 있으면
			// 전제 게시글
			vo.setTotalProductCnt(pageDao.getTotalProductCnt(searchDto));
//		}
		// 총 페이지수
		vo.setTotalPageCnt(vo.getTotalProductCnt(), vo.getPageProductCnt());
		// 보이기 시작할 번호
		vo.setStartRowIndex();
		// 전체 페이징 블럭 갯수
		vo.setTotalPagingBlock();
		// 현재 페이징 블럭
		vo.setCurrentPageBlock();
		// 현재 페이징 시작 번호
		vo.setStartPageNum();
		// 현재 페이징 마지막 번호
		vo.setEndPageNum();
		
		return vo;
	}
	
	/**
	* @Method       : addProductQnA
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Return       : ProductQnADTO
	* @Description  : 문의하기 등록하기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.19        Yeonji Kim
	*/
	@Override
	public boolean addProductQnA(ProductQnADTO qna) throws Exception {
		 boolean result = false;
		    // 상품 문의를 데이터베이스에 저장(insert)
		    if (pDao.insertProductQnA(qna) == 1) {
		        // 상품 문의가 성공적으로 추가되면 결과를 true로 반환
		        result = true;
		    }
		return result;
	}


	/**
	* @Method      : getRandomReservationProduct
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Description  : 랜덤한 예약 상품 가져오기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.21        Jooyoung Lee      
	*/
	@Override
	public MainReservationProductVO getRandomReservationProduct() throws Exception {
		int ranNum = getRandomNumInProduct();
		
		MainReservationProductVO result = pDao.selectReservationProduct(ranNum);
		result.setClassMonth(setClassMonth(result.getClassMonth()));
		
		return result;
	}


	private String setClassMonth(String classMonth) {
		String year = "20" + classMonth.split("년 ")[0];
		String month = classMonth.split("년 ")[1];
		
		if (month.contains("분기")) {
			 int tmpMonth = 3 * (Integer.parseInt(month.split("분기")[0]) - 1) + 1;
			 month = tmpMonth + "";
		} else {
			month = month.split("월")[0];
		}
		
		return year + "-" + month;
	}

	/**
	* @Method      : getRandomNumInProduct
	* @PackageName  : com.cafe24.goott351.user.product.service
	* @Return      : int
	* @Description  : 예약 상품 내에서 랜덤한 수 뽑기
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.21        Jooyoung Lee       
	*/
	private int getRandomNumInProduct() throws Exception {
		int result = 0;
		Random random = new Random();
		
		int countOfReservationProduct = pDao.selectCountOfReservationProduct();
		result = random.nextInt(countOfReservationProduct) + 1;
		
		return result;
	}


	/**
	 * @Method		: getProductListForMain
	 * @PackageName	: com.cafe24.goott351.user.product.service
	 * @Description	: 메인화면에 출력할 상품 정보 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 22.			Taeho Cho
	 */
	@Override
	public Map<String, Object> getProductListForMain() throws Exception {
		
		Map<String, Object> productMap = new HashMap<>();
		
		List<ProductVO> revProductListRand = pDao.getRevProductListRand();
		List<ProductVO> newProductListRand = pDao.getNewProductListRand();
		List<ProductVO> mdProductListRand = pDao.getMdProductListRand();
		int bestProductNo =	pDao.getBestProductNo();
		ProductVO bestProduct = pDao.getBestProductRand(bestProductNo);
		
		
		productMap.put("revProductListRand", revProductListRand);
		productMap.put("newProductListRand", newProductListRand);
		productMap.put("mdProductListRand", mdProductListRand);
		productMap.put("bestProduct", bestProduct);
		
		
		
		return productMap;
	}
}