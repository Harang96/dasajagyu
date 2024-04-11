package com.cafe24.goott351.user.product.persistence.etc;

import com.cafe24.goott351.domain.ProductSearchDTO;

public interface ProductPagingDao {
	
	public int getTotalProductCnt(int classNo);

	public int getTotalProductCnt();

	public int getTotalProductCntOrigin(ProductSearchDTO searchDto);

	public int getTotalProductCnt(ProductSearchDTO searchDto);

	public int getTotalDCProductCnt();

	public int getTotalMDProductCnt();

	int getTotalProductCntBySearch(ProductSearchDTO searchDto);

	public int getTotalpdQnaCnt(String searchType);

}