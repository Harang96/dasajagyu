package com.cafe24.goott351.admin.product.persistance;

import java.util.List;

import com.cafe24.goott351.domain.AddProductDTO;
import com.cafe24.goott351.domain.ProductImgVO;
import com.cafe24.goott351.domain.ProductPagingVO;
import com.cafe24.goott351.domain.ProductQnADTO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.ProductSearchDTO;
import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.domain.Product‫ImgDTO;
import com.cafe24.goott351.domain.UpdateProductDTO;

public interface AdminProductDao {

	List<ProductVO> selectAllProduct(ProductPagingVO pagingVo, ProductSearchDTO psDto) throws Exception;

	int updateProduct(UpdateProductDTO updateDto) throws Exception;

	int deleteProduct(int productNo) throws Exception;

	int restoreProduct(int productNo) throws Exception;

	int insertNewProduct(AddProductDTO pDto) throws Exception;

	int selectProductNo() throws Exception;

	int insertImgFile(Product‫ImgDTO piDto) throws Exception;

	int insertManufacturer(String manufacturerName) throws Exception;

	int updateManufacturer(int manufacturerNo, String manufacturerName) throws Exception;

	int insertCategory(String originalClass, String className) throws Exception;

	int updateCategory(String originalClass, String className) throws Exception;

	int deleteCategory(String originalClass) throws Exception;

	int deleteManufacturer(int manufacturerNo) throws Exception;

	List<ProductImgVO> getProductImagesByProductNo(int productNo) throws Exception;

	int deleteProductImage(int imgNo) throws Exception;

	int deleteProductTotally(int productNo) throws Exception;

	List<ProductQnAVO> selectAllPdList(ProductPagingVO pagingVo, ProductSearchDTO psDto) throws Exception;

	int updatePdQna(ProductQnADTO updateDto) throws Exception;
}
