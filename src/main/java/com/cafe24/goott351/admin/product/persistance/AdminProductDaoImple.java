package com.cafe24.goott351.admin.product.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.AddProductDTO;
import com.cafe24.goott351.domain.ProductImgVO;
import com.cafe24.goott351.domain.ProductPagingVO;
import com.cafe24.goott351.domain.ProductQnADTO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.ProductSearchDTO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.domain.Product‫ImgDTO;
import com.cafe24.goott351.domain.UpdateProductDTO;

@Repository
public class AdminProductDaoImple implements AdminProductDao {
	
	@Autowired
	private SqlSession ses;	
	private static String ns = "com.cafe24.goott351.mappers.productMapper";
	
	/**
	 * @Method		: selectAllProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 목록 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 6.		Taeho Cho
	 * 2024. 3. 7.		Taeho Cho 	검색, 정렬 조건 연동
	 */
	@Override
	public List<ProductVO> selectAllProduct(ProductPagingVO pagingVo, ProductSearchDTO psDto) throws Exception {
		String query = ns + ".selectAllProducts";
			
		Map <String, Object> param = new HashMap<>();
			
		param.put("startRowIndex", pagingVo.getStartRowIndex());
		param.put("pageProductCnt", pagingVo.getPageProductCnt());
		param.put("searchWord", psDto.getSearchWord());
		param.put("searchType", psDto.getSearchType());
		param.put("classNo", psDto.getClassNo());
		param.put("originalClass", psDto.getOriginalClass());
		param.put("manufacturerNo", psDto.getManufacturerNo());
		
		return ses.selectList(query, param);
	}

	/**
	 * @Method		: updateProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 정보 변경
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 8.		Taeho Cho
	 */
	@Override
	public int updateProduct(UpdateProductDTO updateDto) throws Exception {
		String query = ns + ".updateProduct";
				
		return ses.update(query, updateDto);
	}

	/**
	 * @Method		: deleteProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 판매 상태 정보 변경 (판매 중지)
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 8.		Taeho Cho
	 */
	@Override
	public int deleteProduct(int productNo) throws Exception {
		String query = ns + ".deleteProduct";
		
		return ses.update(query, productNo);
	}

	/**
	 * @Method		: restoreProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 판매 상태 정보 변경 (판매 재개)
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 8.		Taeho Cho
	 */
	@Override
	public int restoreProduct(int productNo) throws Exception {
		String query = ns + ".restoreProduct";
		
		return ses.update(query, productNo);
	}

	/**
	 * @Method		: insertNewProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 신규 상품 등록
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 8.		Taeho Cho
	 */
	@Override
	public int insertNewProduct(AddProductDTO pDto) throws Exception {
		String query = ns + ".insertNewProduct";
		String thumnail = pDto.getThumbnailImg().substring(pDto.getThumbnailImg().indexOf(",") + 1);
		
		pDto.setThumbnailImg(thumnail);
		
		return ses.insert(query, pDto);
	}

	/**
	 * @Method		: selectProductNo
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 상세 사진 등록을 위한 상품 번호 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 9.		Taeho Cho
	 */
	@Override
	public int selectProductNo() throws Exception {
		String query = ns + ".getNo";
		
		return ses.selectOne(query);
	}

	/**
	 * @Method		: insertImgFile
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 상세 이미지 저장
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 9.		Taeho Cho
	 */
	@Override
	public int insertImgFile(Product‫ImgDTO piDto) throws Exception {
		String query = ns + ".insertProductImgFile";
		
		return ses.insert(query, piDto);
	}

	/**
	 * @Method		: insertManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 제조사 추가
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 14.		Taeho Cho
	 */
	@Override
	public int insertManufacturer(String manufacturerName) throws Exception {
		String query = ns + ".insertManufacturer";
		
		return ses.insert(query, manufacturerName);
	}

	/**
	 * @Method		: updateManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 제조사 수정
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 15.		Taeho Cho
	 */
	@Override
	public int updateManufacturer(int manufacturerNo, String manufacturerName) throws Exception {
		String query = ns + ".updateManufacturer";
		
		Map <String, Object> param = new HashMap<>();
		param.put("manufacturerNo", manufacturerNo);
		param.put("manufacturerName", manufacturerName);
		
		return ses.update(query, param);

	}

	/**
	 * @Method		: insertCategory
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 카테고리 추가
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 15.		Taeho Cho
	 */
	@Override
	public int insertCategory(String originalClass, String className) throws Exception {
		String query = ns + ".insertCategory";
		
		Map <String, Object> param = new HashMap<>();
		param.put("originalClass", originalClass);
		param.put("className", className);
		
		return ses.insert(query, param);
	}

	/**
	 * @Method		: updateCategory
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 카테고리 수정
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 15.		Taeho Cho
	 */
	@Override
	public int updateCategory(String originalClass, String className) throws Exception {
		String query = ns + ".updateCategory";
		
		Map <String, Object> param = new HashMap<>();
		param.put("originalClass", originalClass);
		param.put("className", className);
		
		return ses.update(query, param);
	}

	/**
	 * @Method		: deleteCategory
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 카테고리 삭제
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 17.			Taeho Cho
	 */
	@Override
	public int deleteCategory(String originalClass) throws Exception {
		String query = ns + ".deleteCategory";
		
		return ses.delete(query, originalClass);
	}

	/**
	 * @Method		: deleteManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 제조사 삭제
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 17.			Taeho Cho
	 */
	@Override
	public int deleteManufacturer(int manufacturerNo) throws Exception {
		String query = ns + ".deleteManufacturer";
		
		return ses.delete(query, manufacturerNo);
	}
	
	/**
	 * @Method		: deleteProductTotally
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 정보 지우기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 22.			Taeho Cho
	 */
	@Override
	public int deleteProductTotally(int productNo) throws Exception {
		String query = ns + ".deleteProductTotally";
		
		return ses.delete(query, productNo);
	}

	/**
	 * @Method		: getProductImagesByProductNo
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 이미지 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 22.			Taeho Cho
	 */
	@Override
	public List<ProductImgVO> getProductImagesByProductNo(int productNo) throws Exception {
		String query = ns + ".getProductImagesByProductNo";
		
		return ses.selectList(query, productNo);
	}

	/**
	 * @Method		: deleteProductImage
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 이미지 삭제
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 22.			Taeho Cho
	 */
	@Override
	public int deleteProductImage(int imgNo) throws Exception {
		String query = ns + ".deleteProductImage";
		
		return ses.delete(query, imgNo);		
	}

	/**
	 * @Method		: selectAllPdList
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 문의 리스트 가져오기
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 27.			Taeho Cho
	 */
	@Override
	public List<ProductQnAVO> selectAllPdList(ProductPagingVO pagingVo, ProductSearchDTO psDto) throws Exception {
		String query = ns + ".selectAllPdList";
		
		Map <String, Object> param = new HashMap<>();
		param.put("startRowIndex", pagingVo.getStartRowIndex());
		param.put("pageProductCnt", pagingVo.getPageProductCnt());
		param.put("searchType", psDto.getSearchType());
				
		return ses.selectList(query, param);
	}

	/**
	 * @Method		: updatePdQna
	 * @PackageName	: com.cafe24.goott351.admin.product.persistance
	 * @Description	: 상품 문의 내용 등록
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 27.			Taeho Cho
	 */
	@Override
	public int updatePdQna(ProductQnADTO updateDto) throws Exception {
		String query = ns + ".updatePdQna";
		
		return ses.update(query, updateDto);
	}
}
