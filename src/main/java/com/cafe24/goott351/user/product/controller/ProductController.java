package com.cafe24.goott351.user.product.controller;

import java.sql.Timestamp;
/*import java.util.List;*/
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
/*import org.springframework.web.bind.annotation.GetMapping;*/
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cafe24.goott351.domain.LikeCountDTO;
import com.cafe24.goott351.domain.ProductQnADTO;
import com.cafe24.goott351.domain.ProductSearchDTO;
import com.cafe24.goott351.user.product.service.ProductService;

@Controller
@RequestMapping ("/product/*")
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	private static final Timestamp before14 = new Timestamp(System.currentTimeMillis()-(1000*60*60*24*14));
	
	@Autowired
	ProductService pService;
	
	/**
	* @Method       : listProductByClass
	* @PackageName  : com.cafe24.goott351.user.product.controller
	* @Return       : void
	* @Description  : 상품 구분별 상품 목록 출력 Controller
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho
    * 2024.02.28		Taeho Cho	정렬 조건 추가
    * 2024.02.29		Taeho Cho	사진위에 상품 상태 테그 추가 적용
	*/
	@RequestMapping(value="viewList", method=RequestMethod.GET)
	private void getlistProductByClass (@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
								        @RequestParam("classNo") int classNo,
								        @RequestParam(name = "searchType", defaultValue = "dateDecs") String searchType,
								        Model model) throws Exception {
		ProductSearchDTO searchDto = new ProductSearchDTO();
		searchDto.setSearchType(searchType);		
		
		Map<String, Object> map = null;
		map = pService.getProductsListByClass(pageNo, classNo, searchDto);
		
		model.addAttribute("productList", map.get("productList"));
		model.addAttribute("pagingInfo", map.get("pagingInfo"));
		model.addAttribute("classNo", classNo);
		model.addAttribute("productLikeLog", map.get("productLikeLog"));
		model.addAttribute("searchType", searchType);
		model.addAttribute("before14", before14);		
	}
	
	/**
	* @Method       : listDcProduct
	* @PackageName  : com.cafe24.goott351.user.product.controller
	* @Return       : void
	* @Description  : 할인 상품 목록 출력 Controller
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho
	* 2024.02.28		Taeho Cho	정렬 조건 추가
    * 2024.02.29		Taeho Cho	사진위에 상품 상태 테그 추가 적용
	*/
	@RequestMapping(value="viewDCList", method=RequestMethod.GET)
	private void getlistDcProduct (@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,				 
			   					@RequestParam(name = "searchType", defaultValue = "dateDecs") String searchType,
					   		    Model model) throws Exception {
		ProductSearchDTO searchDto = new ProductSearchDTO();
		searchDto.setSearchType(searchType);
		
		Map<String, Object> map = null;
		map = pService.getDcProductsList(pageNo, searchDto);
		
		
		model.addAttribute("productList", map.get("productList"));
		model.addAttribute("pagingInfo", map.get("pagingInfo"));
		model.addAttribute("productLikeLog", map.get("productLikeLog"));
		model.addAttribute("searchType", searchType);
		model.addAttribute("before14", before14);		
	}
	
	/**
	* @Method       : listMdProduct
	* @PackageName  : com.cafe24.goott351.user.product.controller
	* @Return       : void
	* @Description  : 추천 상품 목록 출력 Controller
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho
	* 2024.02.28		Taeho Cho	정렬 조건 추가
    * 2024.02.29		Taeho Cho	사진위에 상품 상태 테그 추가 적용
	*/
	@RequestMapping(value="viewMDList", method=RequestMethod.GET)
	private void getlistMdProduct (@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,				 
								@RequestParam(name = "searchType", defaultValue = "dateDecs") String searchType,
     							Model model) throws Exception {
		ProductSearchDTO searchDto = new ProductSearchDTO();
		searchDto.setSearchType(searchType);
				
		Map<String, Object> map = null;
		map = pService.getMdProductsList(pageNo, searchDto);
		
		
		model.addAttribute("productList", map.get("productList"));
		model.addAttribute("pagingInfo", map.get("pagingInfo"));
		model.addAttribute("productLikeLog", map.get("productLikeLog"));
		model.addAttribute("searchType", searchType);
		model.addAttribute("before14", before14);		
	}

	/**
	* @Method       : getProductsByOrigin
	* @PackageName  : com.cafe24.goott351.user.product.controller
	* @Return       : void
	* @Description  : 작품별 상품 목록 페이지 Controller
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.27        Taeho Cho
	* 2024.03.08        Taeho Cho	초기 화면 변경에 따른 구조 변경
	*/
	@RequestMapping(value="listAll", method=RequestMethod.GET)
	private void getProductsByOrigin (@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
								     @RequestParam(name="originalClass", defaultValue = "") String originalClass,
								     @RequestParam(name = "searchType", defaultValue = "dateDecs") String searchType,
								     Model model) throws Exception {
		ProductSearchDTO searchDto = new ProductSearchDTO();
		searchDto.setSearchType(searchType);
		if (!originalClass.isEmpty()) {
			searchDto.setOriginalClass(originalClass);
		}
		Map<String, Object> map = null;
		map = pService.getProductsListByOrigin(pageNo, searchDto);
		
		model.addAttribute("productList", map.get("productList"));
		model.addAttribute("pagingInfo", map.get("pagingInfo"));
		model.addAttribute("original", map.get("original"));		
		model.addAttribute("originals", map.get("originals"));
		model.addAttribute("productLikeLog", map.get("productLikeLog"));
		model.addAttribute("searchType", searchType);
		model.addAttribute("before14", before14);		
	}
	
	/**
	 * @Method		: getBsetProducts
	 * @PackageName	: com.cafe24.goott351.user.product.controller
	 * @Return		: void
	 * @Description	: 주문 수량이 많은 상품 목올 출력
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 15.		Taeho Cho
	 */
	@RequestMapping(value="viewBESTList", method=RequestMethod.GET)
	private void getBestProducts (Model model) throws Exception {
		Map<String, Object> map = null;
		map = pService.getBestProductList();
		
		model.addAttribute("productList", map.get("productList"));
		model.addAttribute("best30", map.get("best30"));
		model.addAttribute("productLikeLog", map.get("productLikeLog"));
		model.addAttribute("before14", before14);
	}
	
	/**
	* @Method       : getProductDetail
	* @PackageName  : com.cafe24.goott351.user.product.controller
	* @Return       : void
	* @Description  : 상품 상세 페이지 Controller
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho
	*/
	@RequestMapping(value="productDetail", method=RequestMethod.GET)
	private void getProductDetail (@RequestParam(name = "productNo") int productNo,
  							       Model model) throws Exception {
		Map<String, Object> map = null;

		map = pService.getProductDetail(productNo);
		
		model.addAttribute("product", map.get("product"));
		model.addAttribute("imageList", map.get("productImgList"));
		model.addAttribute("mdProductList", map.get("mdProductList"));
		model.addAttribute("productLikeLog", map.get("productLikeLog"));
		model.addAttribute("qna", map.get("qna"));
		model.addAttribute("reviews", map.get("reviews"));
		model.addAttribute("reviewImgList", map.get("reviewImgList"));
	}
	
	/**
	* @Method       : getProductBySearch
	* @PackageName  : com.cafe24.goott351.user.product.controller
	* @Return       : void
	* @Description  : 검색 페이지 Controller
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.01        Taeho Cho	1차 키워드 검색 및 정렬 기능 구현
	*/
	@RequestMapping(value="searchList", method=RequestMethod.GET)
	private void getProductBySearch (@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
									 @RequestParam(name = "searchWord", defaultValue = "") String searchWord,
								     @RequestParam(name = "searchType", defaultValue = "dateDecs") String searchType,
								     @RequestParam(name = "classNo", defaultValue = "0") int classNo,
								     @RequestParam(name = "searchCata", defaultValue = "productName") String searchCata,
								     Model model) throws Exception {
		ProductSearchDTO searchDto = new ProductSearchDTO(searchWord, searchType, searchCata, classNo, "", 0);
//		
		Map<String, Object> map = null;
		map = pService.getProductBySearch(pageNo, searchDto);
		
		model.addAttribute("productList", map.get("productList"));
		model.addAttribute("pagingInfo", map.get("pagingInfo"));
		model.addAttribute("productLikeLog", map.get("productLikeLog"));
		model.addAttribute("search", searchDto);
		model.addAttribute("before14", before14);		
	}
	
	/**
	 * @Method		: likedislikeCount
	 * @PackageName	: com.cafe24.goott351.user.product.controller
	 * @Return		: ResponseEntity<Object>
	 * @Description	: 좋아요 기능
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 3.		Taeho Cho
	 */
	@RequestMapping(value="likedislike", method=RequestMethod.POST)
	public ResponseEntity<Object> likedislikeCount(@RequestParam("productNo") int productNo,
												   @RequestParam("uuid") String uuid,
												   @RequestParam("behavior") String behavior,
												   Model model
												   ) {
		
		logger.info("좋아요 카운트 추가를 위해 왔어요");
		LikeCountDTO dto = new LikeCountDTO();
		dto.setUuid(uuid);
		dto.setProductNo(productNo);
		dto.setBehavior(behavior);
		dto.setN(dto.getBehavior());
		
		ResponseEntity<Object> result= null;
		boolean dbResult = false;
		try {
			if (behavior.equals("like")) {
				dbResult = pService.likeProduct(dto);
			} else if (behavior.equals("dislike")) {
				dbResult = pService.dislikeProduct(dto);
			}
			if (dbResult) {
				result = new ResponseEntity<Object>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<Object>("fail", HttpStatus.CONFLICT);
			e.printStackTrace();
		}

		return result;
		
	}
	
	/**
	* @Method       : productQnA
	* @PackageName  : com.cafe24.goott351.user.product.controller
	* @Return       : String
	* @Description  : 디테일페이지 Controller
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.14        Yeonji Kim	상품 문의하기
	*/
	@RequestMapping(value="productQna", method=RequestMethod.GET)
	public ResponseEntity<String> productQnA(ProductQnADTO qna) {
		ResponseEntity<String> result = null;
		
		boolean dbResult = false;
		try {
				dbResult = pService.addProductQnA(qna);
				if (dbResult) {
	                result = new ResponseEntity<String>("success", HttpStatus.OK);
	            } else {
	            	result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
	            }
	        } catch (Exception e) {
	            // 예외 발생 시 처리
	            result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
	            e.printStackTrace();
	        }
		return result;
	}
	
}