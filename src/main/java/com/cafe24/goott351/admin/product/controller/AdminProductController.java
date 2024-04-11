package com.cafe24.goott351.admin.product.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Predicate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.goott351.admin.product.service.AdminProductService;
import com.cafe24.goott351.domain.AddProductDTO;
import com.cafe24.goott351.domain.ProductQnADTO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.ProductSearchDTO;
import com.cafe24.goott351.domain.Product‫ImgDTO;
import com.cafe24.goott351.domain.UpdateProductDTO;
import com.cafe24.goott351.util.UploadProductImgProcess;

@Controller
@RequestMapping("/admin/product/*")
public class AdminProductController {
	private static final Logger logger = LoggerFactory.getLogger(AdminProductController.class);

	@Autowired
	private AdminProductService apService;
	private List<Product‫ImgDTO> fileList = new ArrayList<>();
	String thumbnail = "";
	
	/**
	 * @Method		: selectProductList
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: void
	 * @Description	: 관리자 페이지 상품 목록 출력
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 6.			Taeho Cho
	 * 2024. 3. 7.			Taeho Cho   검색 기능 및 정렬 기능 구현 및
	 * 									각 조건에 대한 페이징 연동
	 */
	@RequestMapping(value="productList", method = RequestMethod.GET)
	private void selectProductList (@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
									@RequestParam(name = "pageProductCnt", defaultValue = "20") int pageProductCnt,								
									@RequestParam(name = "searchWord", defaultValue = "") String searchWord,
									@RequestParam(name = "searchType", defaultValue = "dateDecs") String searchType,
									@RequestParam(name = "classNo", defaultValue = "0") int classNo,
									@RequestParam(name = "originalClass", defaultValue = "") String originalClass,
									@RequestParam(name = "manufacturerNo", defaultValue = "0") int manufacturerNo,
									Model model
									) throws Exception {
		ProductSearchDTO psDto = new ProductSearchDTO();
		psDto.setClassNo(classNo);
		psDto.setOriginalClass(originalClass);
		psDto.setManufacturerNo(manufacturerNo);
		psDto.setSearchWord(searchWord);
		psDto.setSearchType(searchType);
		Map<String, Object> map = apService.getAllProductList(pageNo, pageProductCnt, psDto);
		
		model.addAttribute("productList", map.get("productList"));
		model.addAttribute("pagingInfo", map.get("pagingInfo"));
		model.addAttribute("manufacturers", map.get("manufacturerList"));
		model.addAttribute("originals", map.get("originalList"));
		model.addAttribute("pageProductCnt", pageProductCnt);
		model.addAttribute("classNo", classNo);
		model.addAttribute("originalClass", originalClass);
		model.addAttribute("manufacturerNo", manufacturerNo);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchType", searchType);
	}
	
	/**
	 * @Method		: insertProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: void
	 * @Description	: 상품 등록 페이지 열기
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 8.			Taeho Cho
	 */
	@RequestMapping(value="addProduct", method = RequestMethod.GET)
	private void viewAddProduct (Model model) throws Exception {
		
		Map<String, Object> map = apService.getCategories();
		
		model.addAttribute("manufacturers", map.get("manufacturerList"));
		model.addAttribute("originals", map.get("originalList"));
		fileList.clear();
	}
	
	/**
	 * @Method		: jsonCategory
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: ResponseEntity<Object>
	 * @Description	: 카테고리 데이터 Json으로 반환
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 13.		Taeho Cho
	 * 2024. 3. 14.		Taeho Cho	JSON 데이터 없을 경우 통신 에러 코드 부여
	 * 								기존 select 코드 사용
	 */
	@ResponseBody
	@RequestMapping(value="jsonCategory", method = RequestMethod.GET)
	private ResponseEntity<Object> jsonCategory() {
	    try {
	        // apService.getCategories()에서 데이터를 가져옴
	        Map<String, Object> catagoryMap = apService.getCategories();
	        // 데이터가 존재하는지 확인
	        if (catagoryMap != null && !catagoryMap.isEmpty()) {
	            // ResponseEntity를 사용하여 JSON 데이터와 HTTP 상태코드 200 반환
	            return ResponseEntity.ok(catagoryMap);
	        } else {
	            // 데이터가 없는 경우, HTTP 상태코드 404 반환
	            return ResponseEntity.notFound().build();
	        }
	    } catch (Exception e) {
	        // 예외 발생 시, HTTP 상태코드 500 반환
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	    }
	}
	
	/**
	 * @Method		: viewManufacturers
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: void
	 * @Description	: 제조사 관리 페이지 열기
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 12.			Taeho Cho
	 */
	@RequestMapping(value="manufacturer", method = RequestMethod.GET)
	private void viewManufacturers (Model model) throws Exception {
		
		Map<String, Object> map = apService.getCategories();		
		model.addAttribute("manufacturers", map.get("manufacturerList"));	
	}
	
	/**
	 * @Method		: addManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: String
	 * @Description	: 신규 제조사 등록
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 14.			Taeho Cho
	 */
	@RequestMapping(value="addManufacturer", method = RequestMethod.POST)
	private String addManufacturer (@RequestParam("manufacturerName") String manufacturerName) throws Exception {
		
		String redirect = "";
		if (apService.insertManufacturer(manufacturerName)) {
			redirect = "/admin/product/manufacturer?status=success";
		} else {
			redirect = "/admin/product/manufacturer?status=fail";
		}
		return "redirect:" + redirect;
	}
	
	/**
	 * @Method		: updateManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: String
	 * @Description	: 제조사 업데이트
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 15.			Taeho Cho
	 */
	@RequestMapping(value="updateManufacturer", method = RequestMethod.POST)
	private String updateManufacturer (@RequestParam("manufacturerNo") int manufacturerNo,
									   @RequestParam("manufacturerName") String manufacturerName
									   ) throws Exception {
		
		String redirect = "";
		if (apService.updateManufacturer(manufacturerNo, manufacturerName)) {
			redirect = "/admin/product/manufacturer?status=success";
		} else {
			redirect = "/admin/product/manufacturer?status=fail";

		}
		return "redirect:" + redirect;
	}	
	/**
	 * @Method		: addManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: String
	 * @Description	: 신규 제조사 등록
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 14.			Taeho Cho
	 */
	@RequestMapping(value="addCategory", method = RequestMethod.POST)
	private String addCategory (@RequestParam("originalClass") String originalClass,
								@RequestParam("className") String className) throws Exception {
		
		String redirect = "";
		if (apService.insertCategory(originalClass, className)) {
			redirect = "/admin/product/category?status=success";
		} else {
			redirect = "/admin/product/category?status=fail";
		}
		return "redirect:" + redirect;
	}
	
	/**
	 * @Method		: updateManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: String
	 * @Description	: 제조사 업데이트
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 15.			Taeho Cho
	 */
	@RequestMapping(value="updateCategory", method = RequestMethod.POST)
	private String updateCategory (@RequestParam("originalClass") String originalClass,
								   @RequestParam("className") String className) throws Exception {
		
		String redirect = "";
		if (apService.updateCategory(originalClass, className)) {
			redirect = "/admin/product/category?status=success";
		} else {
			redirect = "/admin/product/category?status=fail";
		}
		return "redirect:" + redirect;
	}	

	
	/**
	 * @Method		: viewOriginals
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: void
	 * @Description	: 작품 카테고리 관리 페이지 열기
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 12.			Taeho Cho
	 */
	@RequestMapping(value="category", method = RequestMethod.GET)
	
	private void viewOriginals (Model model) throws Exception {
		
		Map<String, Object> map = apService.getCategories();
		model.addAttribute("originals", map.get("originalList"));
	}
	
	/**
	 * @Method		: addProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: String
	 * @Description	: 상품 신규 등록 Controller
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 8.			Taeho Cho
	 */
	@RequestMapping(value="addProductDetail", method = RequestMethod.POST)
	private String addProduct (AddProductDTO pDto, HttpSession sess) {
		logger.info("상품 등록 : " + pDto.toString());
		
		String redirect = "";
		
		try {
			apService.addNewProduct(pDto, fileList);
			redirect = "/admin/product/productList?status=success";

		} catch (Exception e) {
			e.printStackTrace();
			redirect = "/admin/product/addProduct?status=fail";
		}
		return "redirect:" + redirect;
	}
	
	/**
	 * @Method		: uploadFile
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: List<ProductImgDTO>
	 * @Description	: upload된 파일에 대한 정보를 LIST로 반환
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 12.			Taeho Cho
	 */
	@RequestMapping (value="uploadFile", method=RequestMethod.POST)
	public @ResponseBody List<Product‫ImgDTO> uploadFile(@RequestBody MultipartFile uploadFile, HttpServletRequest req) {
		logger.info("파일을 업로드 함");
		
	    if (uploadFile == null) {
	        // 파일이 없을 경우 처리
	        logger.error("업로드할 파일이 없습니다.");
	        return Collections.emptyList(); // 빈 리스트 반환 또는 적절한 처리
	    }
		
		// 파일이 실제로 저장될 경로 realPath
		String realPath = req.getSession().getServletContext().getRealPath("resources/productImg");
		
		// 파일처리
		Product‫ImgDTO piDto = null;
		try {
		    if (uploadFile != null && !uploadFile.isEmpty()) {
		        piDto = UploadProductImgProcess.fileUpload(uploadFile, realPath);
		        if (piDto != null) {
		            fileList.add(piDto);
		        }
		    } else {
		        System.out.println("업로드 파일이 비어 있습니다.");
		    }
	    } catch (Exception e) {
	        // 예외 처리
	        logger.error("파일 업로드 중 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	        // 적절한 예외 처리
	    }
		return fileList;
	}
	
	
	/**
	 * @Method		: removeFile
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: ResponseEntity<String>
	 * @Description	: upload된 파일 삭제
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 12.			Taeho Cho
	 */
	@RequestMapping (value="removeFile", method=RequestMethod.GET)
	public ResponseEntity<String> removeFile(@RequestParam("removeFile") String removeFile,
						   HttpServletRequest req) {
		
		ResponseEntity<String> result = null;
		String realPath = req.getSession().getServletContext().getRealPath("resources/productImg");

		boolean fileRemoved = UploadProductImgProcess.deleteFile(fileList, removeFile, realPath);
		
	    if (fileRemoved) {
	        fileList.removeIf(new Predicate<Product‫ImgDTO>() {
	            @Override
	            public boolean test(Product‫ImgDTO dto) {
	                return removeFile.equals(dto.getNewFilename());
	            }
	        });
	        System.out.println("파일이 제거되었습니다.");
	    } else {
	        System.out.println("파일을 제거하는 중에 문제가 발생했습니다.");
	    }
		result = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return result;
	}
	
	
	/**
	 * @Method		: removeAllFile
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: ResponseEntity<String>
	 * @Description	: upload된 파일 전체 삭제
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 12.			Taeho Cho
	 */
	@RequestMapping("removeAllFile")
	public ResponseEntity<String> removeAllFile(HttpServletRequest req){

		ResponseEntity<String> result = null;
		
		String realPath = req.getSession().getServletContext().getRealPath("resources/productImg");
		UploadProductImgProcess.deleteAllFile(fileList, realPath);
		
		fileList.clear();
		if (fileList.isEmpty()) {
			result = new ResponseEntity<String>("success", HttpStatus.ACCEPTED);			
		}
		return result;	
	}
	
	
	/**
	 * @Method		: updateProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: ResponseEntity<Object>
	 * @Description	: 관리자 페이지 상품 정보 업데이트
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 7.			Taeho Cho
	 */
	@RequestMapping(value="updateProduct", method = RequestMethod.POST)
	public ResponseEntity<Object> updateProduct(@RequestBody UpdateProductDTO updateDto,
												@RequestParam(name = "pageProductCnt", defaultValue = "20") int pageProductCnt						
												) throws Exception {
		ResponseEntity<Object> result= null;
		boolean updateResult = false;

		try {
			updateResult = apService.updateProductInfo(updateDto);
			if (updateResult) {
				result = new ResponseEntity<Object>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<Object>("fail", HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * @Method		: deleteProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: ResponseEntity<Object>
	 * @Description	: 상품 판매 중지 기능 구현
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 8.			Taeho Cho
	 */
	@RequestMapping(value="deleteProductTemp", method = RequestMethod.GET)
	public ResponseEntity<Object> deleteProductTemp(@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
												    @RequestParam(name = "pageProductCnt", defaultValue = "20") int pageProductCnt,								
												    @RequestParam(name = "searchWord", defaultValue = "") String searchWord,
												    @RequestParam(name = "classNo", defaultValue = "0") int classNo,
												    @RequestParam(name = "originalClass", defaultValue = "") String originalClass,
												    @RequestParam(name = "manufacturerNo", defaultValue = "0") int manufacturerNo,
												    @RequestParam("productNo") int productNo) throws Exception {
		ResponseEntity<Object> result= null;
		boolean updateResult = false;
		
		try {
			updateResult = apService.deleteProductInfo(productNo);
			if (updateResult) {
				result = new ResponseEntity<Object>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<Object>("fail", HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * @Method     : deleteProduct
	 * @PackageName: com.cafe24.goott351.admin.product.controller
	 * @Return     : String
	 * @Description: 상품 삭제 Controller
	 * ==========================================================
	 * DATE            AUTHOR          MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 12.    Taeho Cho
	 */
	@RequestMapping(value = "deleteProduct", method = RequestMethod.GET)
	private ResponseEntity<Object> deleteProduct(@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
												 @RequestParam(name = "pageProductCnt", defaultValue = "20") int pageProductCnt,								
												 @RequestParam(name = "searchWord", defaultValue = "") String searchWord,
												 @RequestParam(name = "classNo", defaultValue = "0") int classNo,
												 @RequestParam(name = "originalClass", defaultValue = "") String originalClass,
												 @RequestParam(name = "manufacturerNo", defaultValue = "0") int manufacturerNo,
												 @RequestParam("productNo") int productNo,
												 HttpServletRequest req) throws Exception {
		String realPath = req.getSession().getServletContext().getRealPath("resources/productImg");

	    
		ResponseEntity<Object> result= null;
		boolean updateResult = false;
		
		try {
			updateResult = apService.deleteProduct(productNo, realPath);
;
			if (updateResult) {
				result = new ResponseEntity<Object>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<Object>("fail", HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	
	}

	
	
	/**
	 * @Method		: restoreProduct
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: ResponseEntity<Object>
	 * @Description	: 상품 재판매 기능 구현
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 8.			Taeho Cho
	 */
	@RequestMapping(value="restoreProduct", method = RequestMethod.GET)
	public ResponseEntity<Object> restoreProduct(@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
												 @RequestParam(name = "pageProductCnt", defaultValue = "20") int pageProductCnt,								
											 	 @RequestParam(name = "searchWord", defaultValue = "") String searchWord,
												 @RequestParam(name = "classNo", defaultValue = "0") int classNo,
												 @RequestParam(name = "originalClass", defaultValue = "") String originalClass,
												 @RequestParam(name = "manufacturerNo", defaultValue = "0") int manufacturerNo,
												 @RequestParam("productNo") int productNo) throws Exception {
		ResponseEntity<Object> result= null;
		boolean updateResult = false;
		
		try {
			updateResult = apService.restoreProductInfo(productNo);
			if (updateResult) {
				result = new ResponseEntity<Object>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<Object>("fail", HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * @Method		: deleteCategory
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: String
	 * @Description	: 카테고리 삭제
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 14.		Taeho Cho
	 */
	@RequestMapping(value="deleteCategory", method = RequestMethod.GET)
	public String deleteCategory(@RequestParam("originalClass") String originalClass) throws Exception {
		String redirect = "";
		boolean deleteResult = false;
		
		try {
			deleteResult = apService.deleteCategory(originalClass);
			if (deleteResult) {
				redirect = "/admin/product/category?status=success";
			} else {
				redirect ="/admin/product/category?status=fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			redirect = "/admin/product/category?status=fail";
		}
		return "redirect:" + redirect;
	}
	
	/**
	 * @Method		: deleteManufacturer
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: String
	 * @Description	: 제조사 삭제
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 14.		Taeho Cho
	 */
	@RequestMapping(value="deleteManufacturer", method = RequestMethod.GET)
	public String deleteManufacturer(@RequestParam("manufacturerNo") int manufacturerNo) throws Exception {
		String redirect = "";
		boolean deleteResult = false;
		
		try {
			deleteResult = apService.deleteManufacturer(manufacturerNo);
			if (deleteResult) {
				redirect = "/admin/product/manufacturer?status=success";
			} else {
				redirect ="/admin/product/category?status=fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			redirect = "/admin/product/manufacturer?status=fail";
		}
		return "redirect:" + redirect;
	}
	
	
	/**
	 * @Method		: getPdQnaList
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: void
	 * @Description	: 상품 문의 관리 페이지 출력
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 27.			Taeho Cho
	 */
	@RequestMapping(value="pdQna", method = RequestMethod.GET)
	public void getPdQnaList(@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
							 @RequestParam(name = "pageProductCnt", defaultValue = "20") int pageProductCnt,								
							 @RequestParam(name = "searchType", defaultValue = "dateDecs") String searchType,
							 Model model) throws Exception {
		
		Map <String, Object> map = apService.selectAllPdQna(pageNo, pageProductCnt, searchType);
		
		model.addAttribute("pdQnaList", map.get("pdQnaList"));
		model.addAttribute("pagingInfo", map.get("pagingInfo"));
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageProductCnt", pageProductCnt);
		model.addAttribute("searchType", searchType);
	}
	
	/**
	 * @Method		: updatePdQna
	 * @PackageName	: com.cafe24.goott351.admin.product.controller
	 * @Return		: ResponseEntity<Object>
	 * @Description	: 상품 문의 답변 등록
	 * ==========================================================
	 * DATE				AUTHOR			MEMO
	 * ----------------------------------------------------------
	 * 2024. 3. 27.			Taeho Cho
	 */
	@RequestMapping(value="updatePdQna", method = RequestMethod.POST)
	public ResponseEntity<Object> updatePdQna(@RequestBody ProductQnADTO updateDto) throws Exception {
		ResponseEntity<Object> result= null;
		boolean updateResult = false;
		System.out.println(updateDto);
		try {
			updateResult = apService.updatePdQna(updateDto);
			if (updateResult) {
				result = new ResponseEntity<Object>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<Object>("fail", HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}
	

}