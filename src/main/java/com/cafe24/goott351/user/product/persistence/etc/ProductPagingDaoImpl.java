package com.cafe24.goott351.user.product.persistence.etc;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.ProductSearchDTO;

@Repository
public class ProductPagingDaoImpl implements ProductPagingDao {

	@Inject
	private SqlSession ses;
	private static String ns = "com.cafe24.goott351.mappers.productMapper";

	/**
	* @Method       : getTotalProductCnt
	* @PackageName  : com.cafe24.goott351.user.product.persistence.etc
	* @Description  : 상품 구분 시 페이징을 위한 상품 총 수
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho       
	*/
	@Override
	public int getTotalProductCnt(int classNo) {
		String q = ns + ".selectTotalProductCntByClass";
		return ses.selectOne(q, classNo);
	}

	/**
	* @Method       : getTotalProductCnt
	* @PackageName  : com.cafe24.goott351.user.product.persistence.etc
	* @Description  : 할인 상품 페이징을 위한 상품 총 수
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho       
	*/
	@Override
	public int getTotalDCProductCnt() {
		String q = ns + ".selectDCProductCnt";
		return ses.selectOne(q);
	}
	/**
	 * @Method       : getTotalProductCnt
	 * @PackageName  : com.cafe24.goott351.user.product.persistence.etc
	 * @Description  : 할인 상품 페이징을 위한 상품 총 수
	 * ===========================================================
	 * DATE              AUTHOR             Memo
	 * -----------------------------------------------------------
	 * 2024.02.25        Taeho Cho       
	 */
	@Override
	public int getTotalMDProductCnt() {
		String q = ns + ".selectMDProductCnt";
		return ses.selectOne(q);
	}

	/**
	* @Method       : getTotalProductCnt
	* @PackageName  : com.cafe24.goott351.user.product.persistence.etc
	* @Description  : 할인 상품 페이징을 위한 상품 총 수
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.25        Taeho Cho       
	*/
	@Override
	public int getTotalProductCnt() {
		String q = ns + ".selectAllProductCnt";
		return ses.selectOne(q);
	}
	
	/**
	* @Method       : getTotalProductCnt
	* @PackageName  : com.cafe24.goott351.user.product.persistence.etc
	* @Description  : 작품 카테고리에 따른 상품 총 수 
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.28        Taeho Cho       
	*/
	@Override
	public int getTotalProductCntOrigin(ProductSearchDTO searchDto) {
		String q = ns + ".selectProductListByOrigin";

		return ses.selectOne(q, searchDto);
	}

	/**
	* @Method       : getTotalProductCnt
	* @PackageName  : com.cafe24.goott351.user.product.persistence.etc
	* @Description  : 검색 조건에 따른 작품 총 수
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.03.01        Taeho Cho       
	*/
	@Override
	public int getTotalProductCnt(ProductSearchDTO searchDto) {
		String q = ns + ".getTotalProductCntBySearch";
		return ses.selectOne(q, searchDto);
	}

	/**
	 * @Method       : getTotalProductCnt
	 * @PackageName  : com.cafe24.goott351.user.product.persistence.etc
	 * @Description  : 검색 조건에 따른 작품 총 수
	 * ===========================================================
	 * DATE              AUTHOR             Memo
	 * -----------------------------------------------------------
	 * 2024.03.01        Taeho Cho       
	 */
	@Override
	public int getTotalProductCntBySearch(ProductSearchDTO searchDto) {
		String q = ns + ".selectAllProductsCntBySearch";
		return ses.selectOne(q, searchDto);
	}

	/**
	 * @Method		: getTotalpdQnaCnt
	 * @PackageName	: com.cafe24.goott351.user.product.persistence.etc
	 * @Description	: 상품 문의 총 수
	 * ===========================================================
	 * DATE				AUTHOR			MEMO
	 * -----------------------------------------------------------
	 * 2024. 3. 27.			Taeho Cho
	 */
	@Override
	public int getTotalpdQnaCnt(String searchType) {
		String q = ns + ".getTotalPdQnACnt";
	
		return ses.selectOne(q, searchType);
	}


}