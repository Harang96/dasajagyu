package com.cafe24.goott351.admin.product.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe24.goott351.admin.product.persistance.AdminProductDao;
import com.cafe24.goott351.domain.AddProductDTO;
import com.cafe24.goott351.domain.ManufacturersVO;
import com.cafe24.goott351.domain.OriginalsVO;
import com.cafe24.goott351.domain.ProductImgVO;
import com.cafe24.goott351.domain.ProductPagingVO;
import com.cafe24.goott351.domain.ProductQnADTO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.ProductSearchDTO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.domain.Product‫ImgDTO;
import com.cafe24.goott351.domain.UpdateProductDTO;
import com.cafe24.goott351.user.product.persistence.ProductDao;
import com.cafe24.goott351.user.product.persistence.etc.ProductPagingDao;
import com.cafe24.goott351.util.UploadProductImgProcess;

@Service
public class AdminProductServiceImpl implements AdminProductService {

	@Autowired
	private AdminProductDao apDao;
	@Autowired
	private ProductPagingDao pageDao;
	@Autowired
	private ProductDao pDao;
	
	/**
	 * @Method		: getAllProductList
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 관리자 상품 목록 출력 service
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 6.			Taeho Cho
	 * 2024. 3. 7.			Taeho Cho	정렬, 검색 기능 연동
	 */
	@Override
	public Map<String, Object> getAllProductList(int pageNo, int pageProductCnt, ProductSearchDTO psDto) throws Exception {
		Map<String, Object> productMap = new HashMap<>();
		
		ProductPagingVO pagingVo = getPagingInfo(pageNo, pageProductCnt, psDto);
		List<ProductVO> productList = apDao.selectAllProduct(pagingVo, psDto);
		List<ManufacturersVO> manufactureList = pDao.selectAllmanufacturers();
		List<OriginalsVO> originalList = pDao.selectAllOriginals();
		
		productMap.put("productList", productList);
		productMap.put("pagingInfo", pagingVo);
		productMap.put("manufacturerList", manufactureList);
		productMap.put("originalList", originalList);
		
		return productMap;
	}	
	
	
	/**
	 * @Method		: addNewProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 관리자 상품 신규 등록 (이미지 포함)
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 9.			Taeho Cho
	 */
	@Override
	@Transactional(rollbackFor = Exception.class) // 예외 발생 시 rollback
	public void addNewProduct(AddProductDTO pDto, List<Product‫ImgDTO> fileList) throws Exception {
		
		if (apDao.insertNewProduct(pDto) == 1) {
			int productNo = apDao.selectProductNo();
			
			if (fileList.size() > 0) { // 업로드한 파일이 있음	
				for (Product‫ImgDTO piDto : fileList) {
					piDto.setProductNo(productNo);
					apDao.insertImgFile(piDto);
				}
			}
		}
	}
	
	/**
	 * @Method		: getCategories
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 카테고리 데이터 (제조사, 작품 구분)
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 9.			Taeho Cho
	 */
	@Override
	public Map<String, Object> getCategories() throws Exception {
		
		Map<String, Object> catagoryMap = new HashMap<>();
		
		List<ManufacturersVO> manufactureList = pDao.selectAllmanufacturers();
		List<OriginalsVO> originalList = pDao.selectAllOriginals();
		catagoryMap.put("manufacturerList", manufactureList);
		catagoryMap.put("originalList", originalList);
		
		return catagoryMap;
	}
	
	
	/**
	 * @Method		: insertManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 신규 제조사 등록
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 14.			Taeho Cho
	 */
	@Override
	public boolean insertManufacturer(String manufacturerName) throws Exception {
		boolean result = false;
		
		if (apDao.insertManufacturer(manufacturerName) == 1) {
			result = true;
		}
		return result;
	}
	
	/**
	 * @Method		: updateManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 14.			Taeho Cho
	 */
	@Override
	public boolean updateManufacturer(int manufacturerNo, String manufacturerName) throws Exception {
		boolean result = false;
		
		if (apDao.updateManufacturer(manufacturerNo, manufacturerName) == 1) {
			result = true;
		}
		return result;
	}
	
	/**
	 * @Method		: insertCategory
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 15.			Taeho Cho
	 */
	@Override
	public boolean insertCategory(String originalClass, String className) throws Exception {
		boolean result = false;
		
		if (apDao.insertCategory(originalClass, className) == 1) {
			result = true;
		}
		return result;
	}


	/**
	 * @Method		: updateCategory
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 15.			Taeho Cho
	 */
	@Override
	public boolean updateCategory(String originalClass, String className) throws Exception {
		boolean result = false;
		
		if (apDao.updateCategory(originalClass, className) == 1) {
			result = true;
		}
		return result;
	}
	
	
	
	/**
	 * @Method		: updateProductInfo
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 관리자 상품 정보 수정 기능
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 7.			Taeho Cho
	 */
	@Override
	public boolean updateProductInfo(UpdateProductDTO updateDto) throws Exception {
		boolean result = false;
		
		if (apDao.updateProduct(updateDto) == 1){
			result = true;
		}		
		return result;
	}
	
	/**
	 * @Method		: deleteProductInfo
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 관리자 상품 판매 중지 설정
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 8.			Taeho Cho
	 */
	@Override
	public boolean deleteProductInfo(int productNo) throws Exception {
		boolean result = false;
		
		if (apDao.deleteProduct(productNo) == 1){
			result = true;
		}		
		return result;
	}

	
	/**
	 * @Method     : deleteProduct
	 * @PackageName: com.cafe24.goott351.admin.product.service
	 * @Description: 관리자 상품 삭제
	 * ===========================================================
	 * DATE            AUTHOR          MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 12.    Taeho Cho
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean deleteProduct(int productNo, String realPath) throws Exception {
		boolean result = false;
		List<ProductImgVO> productImages = apDao.getProductImagesByProductNo(productNo);
	    // 상품 정보 삭제
	    if (apDao.deleteProductTotally(productNo) == 1) {
	    	// 상품에 연결된 이미지 정보 가져오기
			// 데이터베이스에서 이미지 정보 삭제
			for (ProductImgVO productImage : productImages) {
				// 파일 시스템에서 이미지 파일 삭제
				File deleteFile = new File(realPath + productImage.getNewFilename());
				if (deleteFile.exists()) {
					deleteFile.delete();
				} 
				// 이미지 파일 및 정보 삭제
				apDao.deleteProductImage(productImage.getImgNo());

	    	}
			result = true;
	    	
	    } else {
	        System.out.println("상품 정보 삭제에 실패하였습니다.");

	    }
		return result;
	}

	
	
	
	
	/**
	 * @Method		: restoreProductInfo
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 관리자 상품 판매 재개 설정
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 8.			Taeho Cho
	 */
	@Override
	public boolean restoreProductInfo(int productNo) throws Exception {
		boolean result = false;
		
		if (apDao.restoreProduct(productNo) == 1){
			result = true;
		}		
		return result;
	}
	

	/**
	 * @Method		: deleteCategory
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 해당 카테고리 정보 완전 삭제
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 17.			Taeho Cho
	 */
	@Override
	public boolean deleteCategory(String originalClass) throws Exception {
		boolean result = false;

		if (apDao.deleteCategory(originalClass) == 1){
			result = true;
		}	
		return result;
	}


	/**
	 * @Method		: deleteManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 해당 제조사 정보 완전 삭제
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 17.			Taeho Cho
	 */
	@Override
	public boolean deleteManufacturer(int manufacturerNo) throws Exception {
		boolean result = false;

		if (apDao.deleteManufacturer(manufacturerNo) == 1){
			result = true;
		}		
		return result;
	}

	/**
	 * @Method		: getPagingInfo
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Return		: ProductPagingVO
	 * @Description	: 관리자 상품 검색 페이징
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 7.			Taeho Cho
	 */
	private ProductPagingVO getPagingInfo(int pageNo, int pageProductCnt, ProductSearchDTO psDto) {
		ProductPagingVO vo = new ProductPagingVO();
		vo.setPageNo(pageNo);
		
		vo.setPageProductCnt(pageProductCnt);	

		vo.setTotalProductCnt(pageDao.getTotalProductCntBySearch(psDto));
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
	 * @Method		: getPagingInfo
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Return		: ProductPagingVO
	 * @Description	: 상품 문의 페이징
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 27.			Taeho Cho
	 */
	private ProductPagingVO getPagingInfo(int pageNo, int pageProductCnt, String searchType) {
		ProductPagingVO vo = new ProductPagingVO();
		vo.setPageNo(pageNo);
		
		vo.setPageProductCnt(pageProductCnt);	
		
		vo.setTotalProductCnt(pageDao.getTotalpdQnaCnt(searchType));
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
	 * @Method		: selectAllPdQna
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 상품 문의 목록 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 27.			Taeho Cho
	 */
	@Override
	public Map<String, Object> selectAllPdQna(int pageNo, int pageProductCnt, String searchType) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		ProductSearchDTO psDto = new ProductSearchDTO();
		psDto.setSearchType(searchType);
				
		ProductPagingVO pagingVo = getPagingInfo(pageNo, pageProductCnt, searchType);		
		List<ProductQnAVO> pdQnaList = apDao.selectAllPdList(pagingVo, psDto);
		
		map.put("pagingInfo", pagingVo);
		map.put("pdQnaList", pdQnaList);
		
		
		return map;
	}


	/**
	 * @Method		: updatePdQna
	 * @PackageName	: com.cafe24.goott351.admin.product.service
	 * @Description	: 상품 문의 답변 내용 추가
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 27.			Taeho Cho
	 */
	@Override
	public boolean updatePdQna(ProductQnADTO updateDto) throws Exception {
		boolean result = false;
		
		if (apDao.updatePdQna(updateDto) == 1) {
			result = true;
		}
		return result;
	}	

}
