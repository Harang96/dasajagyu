package com.cafe24.goott351.admin.product.service;

import java.util.List;
import java.util.Map;

import com.cafe24.goott351.domain.AddProductDTO;
import com.cafe24.goott351.domain.ManufacturersVO;
import com.cafe24.goott351.domain.ProductQnADTO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.ProductSearchDTO;
import com.cafe24.goott351.domain.Product‫ImgDTO;
import com.cafe24.goott351.domain.UpdateProductDTO;

public interface AdminProductService {

	Map<String, Object> getAllProductList(int pageNo, int pageProductCnt, ProductSearchDTO psDto) throws Exception;

	boolean updateProductInfo(UpdateProductDTO updateDto) throws Exception;

	boolean deleteProductInfo(int productNo) throws Exception;

	boolean restoreProductInfo(int productNo) throws Exception;

	void addNewProduct(AddProductDTO pDto, List<Product‫ImgDTO> fileList) throws Exception;

	Map<String, Object> getCategories() throws Exception;

	boolean insertManufacturer(String manufacturerName) throws Exception;

	boolean updateManufacturer(int manufacturerNo, String manufacturerName) throws Exception;

	boolean insertCategory(String originalClass, String className) throws Exception;

	boolean updateCategory(String originalClass, String className) throws Exception;

	boolean deleteCategory(String originalClass) throws Exception;

	boolean deleteManufacturer(int manufacturerNo) throws Exception;

	boolean deleteProduct(int productNo, String realPath) throws Exception;

	Map<String, Object> selectAllPdQna(int pageNo, int pageProductCnt, String searchType) throws Exception;

	boolean updatePdQna(ProductQnADTO updateDto) throws Exception;




}
