<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html
  lang="KO"
  class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="/resources/assets/"
  data-template="vertical-menu-template">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>상픔 관리</title>

    <meta name="description" content="" />

	 <!-- Favicon -->
	 <link rel="icon" type="image/x-icon" href="../../resources/assets/images/icons/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap"
      rel="stylesheet" />

    <!-- Icons -->
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/fontawesome.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/tabler-icons.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/flag-icons.css" />
    
    <!-- Core CSS -->
<!--     <link rel="stylesheet" href="/resources/assets/vendor/css/rtl/core.css" class="template-customizer-core-css" /> -->
    <link rel="stylesheet" href="/resources/assets/vendor/css/rtl/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="/resources/assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="/resources/assets/vendor/libs/node-waves/node-waves.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/typeahead-js/typeahead.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/select2/select2.css" />
    <c:set var="pageNo" value="${empty param.pageNo ? 1 : param.pageNo}" />
    

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="/resources/assets/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->
    <script src="/resources/assets/vendor/js/template-customizer.js"></script>
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="/resources/js/product/config.js"></script>
	  <!-- jquery -->
	  <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    
    <style>
	    .writeInput{
	        font-size:0.9375rem;
	        width : 100px;
	        border: none;
	    }
	    
	    .writeInput:focus{
	        outline:none;
	    }
	    
		select {
		    border: none; /* 테두리 없애기 */
		}
		
		#card-header-second, #second-box {
			display : flex;
			flex-direction: row;		
		}
		#card-header-second {
		    justify-content: space-between;
		}
		
		#second-box>div {
			padding : 0 10px;
		}
		
		input:hover, select:hover{
			cursor: pointer;
		}
  </style>
</head>
<body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- Menu -->
        <jsp:include page="../aside.jsp"></jsp:include>
        <!-- / Menu -->  
        <!-- Layout container -->
        <div class="layout-page">
        <!-- Content wrapper -->
	          <div class="content-wrapper">
	            <!-- Content -->
	            <div class="container-xxl flex-grow-1 container-p-y">
         	     <h4 class="py-3 mb-2">상품 관리 목록</h4>
	              <!-- Product List Table -->
	              <div class="card">
	                <div class="card-header">
	                  <h5 class="card-title mb-0">Filter</h5>
	                  <div class="justify-content-between align-items-center row py-3 gap-3 gap-md-0">
	                    <div class="col-md-4 product_status">
	                      <select name="classNo" class="form-select text-capitalize classNo">
	                        <option value="0" > 상품 구분 </option>
	                        <option value="10" <c:if test="${classNo == 10}">selected</c:if>>예약상품</option>
	                        <option value="20" <c:if test="${classNo == 20}">selected</c:if>>신규입고</option>
	                        <option value="30" <c:if test="${classNo == 30}">selected</c:if>>입고완료</option>
	                      </select>
	                    </div>
	                    <div class="col-md-4 product_category">
	                      <select name="originalClass" class="form-select text-capitalize originalClass">
	                        <option value=""> 작품별 </option>
	                        <c:forEach var="original" items="${originals }">
		                        <option value="${original.originalClass}" <c:if test="${original.originalClass == originalClass}">selected</c:if>>${original.className}</option>
							</c:forEach>
	                      </select>
	                    </div>
	                    <div class="col-md-4 product_stock">
	                      <select name="manufacturerNo" class="form-select text-capitalize manufacturerNo">
	                        <option value="0"> 제조사 </option>
	                        <c:forEach var="manufacturer" items="${manufacturers }">
		                        <option value="${manufacturer.manufacturerNo}"<c:if test="${manufacturer.manufacturerNo == manufacturerNo}">selected</c:if>>${manufacturer.manufacturerName}</option>
	                        </c:forEach>
	                      </select>
	                    </div>
	                  </div>
	                </div>
	                <div class="card-header border-top rounded-0 py-2" id="card-header-second">
	                   <div id="DataTables_Table_0_filter" class="dataTables_filter">
	                     <label>
	                       <input type="search" class="form-control searchWord" placeholder="상품 검색" aria-controls="DataTables_Table_0"<c:if test="${not empty searchWord}">value="${searchWord}"</c:if>>
	                     </label>
	                   </div>
	                   <div id="second-box">
		                   <div class="dataTables_length mt-2 mt-sm-0 mt-md-3 me-2" id="DataTables_Table_0_length" style="margin : 0 !important;">
		                      <label>
		                        <select name="searchType" aria-controls="DataTables_Table_0" class="form-select"  id="searchType">
									<option id="dateDecs" value="dateDecs" <c:if test="${searchType == 'dateDecs'}">selected</c:if>>최신순</option>
									<option id="dateAcs" value="dateAcs" <c:if test="${searchType == 'dateAcs'}">selected</c:if>>오래된 등록일순</option>
									<option id="priceDecs" value="priceDecs" <c:if test="${searchType == 'priceDecs'}">selected</c:if>>높은가격순</option>
									<option id="priceAcs" value="priceAcs" <c:if test="${searchType == 'priceAcs'}">selected</c:if>>낮은가격순</option>
									<option id="disctountDecs" value="disctountDecs" <c:if test="${searchType == 'disctountDecs'}">selected</c:if>>높은할인율순</option>
									<option id="disctountAcs" value="disctountAcs" <c:if test="${searchType == 'disctountAcs'}">selected</c:if>>낮은할인율순</option>
									<option id="currentQtyDecs" value="currentQtyDecs" <c:if test="${searchType == 'currentQtyDecs'}">selected</c:if>>많은재고순</option>
									<option id="currentQtyAcs" value="currentQtyAcs" <c:if test="${searchType == 'currentQtyAcs'}">selected</c:if>>적은재고순</option>
								</select>
		                      </label>
		                   </div>
		                   <div class="dataTables_length mt-2 mt-sm-0 mt-md-3 me-2" id="DataTables_Table_0_length" style="margin : 0 !important;">
		                      <label>
		                        <select name="productsPerPage" aria-controls="DataTables_Table_0" class="form-select productsPerPage">
		                          <option value="20" <c:if test="${pageProductCnt == 20}">selected</c:if>>20</option>
		                          <option value="50" <c:if test="${pageProductCnt == 50}">selected</c:if>>50</option>
		                          <option value="100" <c:if test="${pageProductCnt == 100}">selected</c:if>>100</option>
		                        </select>
		                      </label>
		                   </div>
		                   <div class="dt-action-buttons align-items-start align-items-md-center justify-content-sm-center mb-3 mb-md-0 pt-0 gap-4 gap-sm-0 flex-sm-row" style="margin : 0 !important;">
		                      <div class="dt-buttons btn-group">
		                        <button class="btn btn-secondary add-new btn-primary ms-2 ms-sm-0 waves-effect waves-light" tabindex="0" aria-controls="DataTables_Table_0" type="button">
		                          <span>
		                            <i class="ti ti-plus me-0 me-sm-1 ti-xs"></i>
		                            <span class="d-none d-sm-inline-block" onclick="location.href='/admin/product/addProduct'">상품 추가</span>
		                          </span>
		                        </button>
		                      </div>
		                   </div>
	                   </div>
	                </div>
	                <div class="card-datatable table-responsive">
	                  <div id="DataTables_Table_0_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
	                    <table class="datatables-products table dataTable no-footer dtr-column collapsed" id="DataTables_Table_0" aria-describedby="DataTables_Table_0_info" style="width: 1396px;">
	                      <thead class="border-top">
	                        <tr>
	                          <th class="control sorting_disabled dtr-hidden" rowspan="1" colspan="1" style="width: 0px; display: none;" aria-label=""></th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 400px;">상품명</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 100px;">상품구분</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 100px;">제조사</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 100px;">작품명</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 120px;">작품구분</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 120px;">원가</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 120px;">판가/할인가</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 60px;">할인 (%)</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 60px;">마진 (%)</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 60px;">재고</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 60px;">판매</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 60px;">추천</th>
	                          <th class="sorting_disabled" rowspan="1" colspan="1" style="width: 60px;" aria-label="Actions">Actions</th>
	                        </tr>
	                      </thead>
	                      <tbody>
	                      <c:forEach var="product" items="${productList }">
	                        <tr class="odd ">
	                          <td class="control dtr-hidden" tabindex="0" style="display: none;"></td>
	                          <td class="sorting_1">
	                            <div class="d-flex justify-content-start align-items-center product-name">
	                              <div class="avatar-wrapper">
	                                <div class="sorting avatar avatar me-2 rounded-2 bg-label-secondary">
	          	                     <c:choose>
		          	                     <c:when test="${product.isSales == 'N' }">
		                                 	<a href="javascript:;"><img src="${product.thumbnailImg }" alt="Product-9" class="rounded-2"></a>
		          	                     </c:when>
		          	                     <c:otherwise>
		                                	<a href="/product/productDetail?productNo=${product.productNo }" target="_blank"><img src="${product.thumbnailImg }" alt="Product-9" class="rounded-2"></a>
		          	                     </c:otherwise>
	          	                     </c:choose>
	                                </div>
	                              </div>
	                              <div class="d-flex flex-column" >
	        	                    <input type="hidden" name="productNo" value='${product.productNo}'/>
	                                <input type="text" name="productName" id="productName${product.productNo }" class="writeInput text-body text-nowrap mb-0" style="width : 200px;" value="${product.productName}">
	                              </div>
	                            </div>
	                          </td>
	                          <td>
	                            <span class="text-truncate d-flex align-items-center">
	                            	<select class="form-select-sm" id="classNo${product.productNo}" data-allow-clear="true" name="classNo">
				                        <option value="10" <c:if test="${product.classNo == 10}">selected</c:if>>예약상품</option>
				                        <option value="20" <c:if test="${product.classNo == 20}">selected</c:if>>신규입고</option>
				                        <option value="30" <c:if test="${product.classNo == 30}">selected</c:if>>입고완료</option>
		                            </select>                            
	                          	</span>                        	
	                          </td>
	                          <td>
	                            <span class="text-truncate d-flex align-items-center">
	                            	<select class="form-select-sm" id="manufacturerNo${product.productNo}" data-allow-clear="true" name="manufacturerNo">
				                        <c:forEach var="manufacturer" items="${manufacturers }">
					                        <c:if test="${manufacturer.manufacturerNo == product.manufacturerNo}">
			   			                        <option value="${manufacturer.manufacturerNo}" selected>${manufacturer.manufacturerName}</option>
					                        </c:if>
					                        <c:if test="${manufacturer.manufacturerNo != product.manufacturerNo}">
			   			                        <option value="${manufacturer.manufacturerNo}">${manufacturer.manufacturerName}</option>
					                        </c:if>
				                        </c:forEach>
		                            </select>
		                        </span>
	                          </td>
	                          <td>
	                            <span class="text-truncate d-flex align-items-center">
	                              <input type="text" name="originalName" class="writeInput text-body text-nowrap mb-0" id="originalName${product.productNo}" style="width : 150px;" value="${product.originalName}">
	                            </span>
	                          </td>
	                          <td>
	                            <span class="text-truncate d-flex align-items-center">
	                         		<select class="form-select-sm " data-allow-clear="true" name="originalClass" id="originalClass${product.productNo}">
				                        <c:forEach var="original" items="${originals }">
					                        <c:if test="${original.originalClass == product.originalClass}">
			   			                        <option value="${original.originalClass}" selected>${original.className}</option>
					                        </c:if>
					                        <c:if test="${original.originalClass != product.originalClass}">
			   			                        <option value="${original.originalClass}">${original.className}</option>
					                        </c:if>
				                        </c:forEach>
		                            </select>
	                            </span>
	                          </td>
	                          <td>
	                            <div class="writeInput text-body text-nowrap mb-0" style="width : 120px;"><fmt:formatNumber value="${product.purchaseCost }" type="currency" /></div>
	                          </td>
	                          <td>
	                            <c:if test="${product.discountRate != 0 }">
	                            	<input type="text" class="writeInput text-body text-nowrap mb-0" id="salesCost${product.productNo}" style="width : 120px;" value="<fmt:formatNumber value="${product.salesCost}" type="currency" />">
	                            	<input type="text" name="salesCost" class="writeInput text-body text-nowrap mb-0" disabled style="width : 120px;" value="<fmt:formatNumber value="${product.salesCost * (1 - (product.discountRate / 100)) }" type="currency" />">	
								</c:if>
	                          	<c:if test="${product.discountRate == 0 }">
	                            	<input type="text" name="salesCost" class="writeInput text-body text-nowrap mb-0" id="salesCost${product.productNo}" style="width : 120px;" value="<fmt:formatNumber value="${product.salesCost}" type="currency" />">	
								</c:if>
	                          
	                          </td>
	                          <td>
	                            <input type="text" name="discountRate" class="writeInput text-body text-nowrap mb-0" id="discountRate${product.productNo}" style="width : 80px;" value="${product.discountRate}%">
	                          </td>
	                          <td>
	                          	<c:if test="${product.discountRate != 0 }">
									<fmt:parseNumber var="percent" value="${(1-(product.purchaseCost/(product.salesCost * (1 - (product.discountRate / 100))))) * 100 }" />
									<fmt:formatNumber value="${percent}" type="number" pattern=".0"/>%
								</c:if>
	                          	<c:if test="${product.discountRate == 0 }">
									<fmt:parseNumber var="percent" value="${(1-(product.purchaseCost/product.salesCost)) * 100 }" />
									<fmt:formatNumber value="${percent}" type="number" pattern=".0"/>%
								</c:if>
	            			  </td>
	                          <td>
	                            <input type="text" name="currentQty" class="writeInput text-body text-nowrap mb-0" id="currentQty${product.productNo}" style="width : 80px;" value="${product.currentQty}">
	                          </td>
	                          <td class="" style="">
	                            <span class="text-truncate">
	                              <label class="switch switch-primary switch-sm">
	                              <c:if test="${product.isSales == 'Y' }">
	                                <input type="checkbox" class="switch-input" id="isSales${product.productNo}" value="Y" checked disabled>
	                              </c:if>
	                                <span class="switch-toggle-slider">
	                                  <span class="switch-off"></span>
	                                </span>
	                              </label>
	                            </span>
	                          </td>
	                          <td class="" style="">
	                            <span class="text-truncate">
	                              <label class="switch switch-primary switch-sm">
	                              <c:if test="${product.isRecommend == 'Y' }">
	                                <input type="checkbox" name="isRecommend" class="switch-input" id="isRecommend${product.productNo}" id="switch" name="isRecommend" checked value="Y">
								  </c:if>
	                              <c:if test="${product.isRecommend == 'N' }">
	                                <input type="checkbox" name="isRecommend" class="switch-input" id="isRecommend${product.productNo}" id="switch" name="isRecommend" value="N">
								  </c:if>
	                              <span class="switch-toggle-slider">
	                                <span class="switch-off"></span>
	                              </span>
	                              </label>
	                            </span>
	                          </td>
	                          <td class="" style="">
	                            <div class="d-inline-block text-nowrap">
	                              <button type="button" class="btn btn-sm btn-icon updateModal" onclick="updateProductModal(${product.productNo});">
	                                <i class="ti ti-edit"></i>
	                              </button>
	                              <button type="button" class="btn btn-sm btn-icon" onclick="deleteProductTmp(${product.productNo});">
	                                <i class="ti ti-trash"></i>
	                              </button>
	                              <button type="button" class="btn btn-sm btn-icon" onclick="restoreProduct(${product.productNo});">
									<i class="fa-solid fa-trash-can-arrow-up"></i>
	                              </button>
	                              <button type="button" class="btn btn-sm btn-icon" onclick="deleteProduct(${product.productNo});">
									<i class="fa-solid fa-eraser"></i>
	                              </button>
	                            </div>
	                          </td>
	                        </tr>
	                      </c:forEach>                   
	                      </tbody>
	                    </table>
	                  </div>
	                </div>
	              </div>
	              <!-- 페이지 네이션 -->
	              <div class="row mx-2">
	                <div class="col-sm-12 col-md-6">
	                  <div class="dataTables_info" id="DataTables_Table_0_info" role="status" aria-live="polite">총 상품 수 : ${pagingInfo.totalProductCnt}</div>
	                </div>
	                <div class="col-sm-12 col-md-6">
	                  <div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate">
	                    <ul class="pagination">
	                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
	                        <a href="/admin/product/productList?pageNo=1" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> 1 </a>
	                      </li>
	                      <c:choose>
	                      <c:when test="${param.pageNo <= 10 or param.pageNo == null}">
		                      <li class="paginate_button page-item previous disabled" id="DataTables_Table_0_previous">
		                        <a aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> << </a>
		                      </li>
	                      </c:when>
	                      <c:otherwise>
		                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
		                        <a href="/admin/product/productList?pageNo=${param.pageNo - 10}&pageProductCnt=${pageProductCnt}&classNo=${classNo}&manufacturerNo=${manufacturerNo}&originalClass=${originalClass}&searchWord=${searchWord}" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> << </a>
		                      </li>
	                      </c:otherwise>
	                      </c:choose>
	                      <c:choose>
	                      <c:when test="${param.pageNo == 1 or param.pageNo == null}">
		                      <li class="paginate_button page-item previous disabled" id="DataTables_Table_0_previous">
		                        <a aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> < </a>
		                      </li>
	                      </c:when>
	                      <c:otherwise>
		                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
		                        <a href="/admin/product/productList?pageNo=${param.pageNo - 1}&pageProductCnt=${pageProductCnt}&classNo=${classNo}&manufacturerNo=${manufacturerNo}&originalClass=${originalClass}&searchWord=${searchWord}" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> < </a>
		                      </li>
	                      </c:otherwise>
	                      </c:choose>
						  <c:forEach var="paging" begin="${pagingInfo.startPageNum }" end="${pagingInfo.endPageNum}">
		                      <c:choose>
			                      <c:when test="${param.pageNo == null && paging == 1}">
				                      <li class="paginate_button page-item active">
				                        <a href="#" aria-controls="DataTables_Table_0" role="link" aria-current="page" class="page-link">${paging}</a>
				                      </li>
			                      </c:when>
			                      <c:when test="${param.pageNo == paging}">
				                      <li class="paginate_button page-item active">
				                        <a href="#" aria-controls="DataTables_Table_0" role="link" aria-current="page" class="page-link">${paging}</a>
				                      </li>
			                      </c:when>
			                      <c:otherwise>
				                      <li class="paginate_button page-item">
				                        <a href="/admin/product/productList?pageNo=${paging}&pageProductCnt=${pageProductCnt}&classNo=${classNo}&manufacturerNo=${manufacturerNo}&originalClass=${originalClass}&searchWord=${searchWord}" aria-controls="DataTables_Table_0" role="link" aria-current="page" class="page-link">${paging}</a>
				                      </li>
		    	                  </c:otherwise>
		                      </c:choose>
						  </c:forEach>
	                      <c:choose>
	                      	<c:when test="${param.pageNo != null or param.pageNo <= pagingInfo.totalPageCnt}">
		                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
		                        <a href="/admin/product/productList?pageNo=${param.pageNo + 1}&pageProductCnt=${pageProductCnt}&classNo=${classNo}&manufacturerNo=${manufacturerNo}&originalClass=${originalClass}&searchWord=${searchWord}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> > </a>
		                      </li>
	                      	</c:when>
	                      	<c:otherwise>
		                      <li class="paginate_button page-item next disabled" id="DataTables_Table_0_next">
		                        <a href="#" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> > </a>
		                      </li>
	                      	</c:otherwise>
	                      </c:choose>
	                      <c:choose>
	                      	<c:when test="${param.pageNo != null or (pagingInfo.totalPageCnt - param.pageNo) < 10 or pagingInfo.totalPageCnt == param.pageNo}">
		                      <li class="paginate_button page-item next disabled" id="DataTables_Table_0_next">
		                        <a href="#" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> >> </a>
		                      </li>
	                      	</c:when>
	                      	<c:otherwise>
		                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
		                        <a href="/admin/product/productList?pageNo=${param.pageNo + 10}&pageProductCnt=${pageProductCnt}&classNo=${classNo}&manufacturerNo=${manufacturerNo}&originalClass=${originalClass}&searchWord=${searchWord}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> >> </a>
		                      </li>
	                      	</c:otherwise>
	                      </c:choose>
		                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
		                        <a href="/admin/product/productList?pageNo=${pagingInfo.totalPageCnt}&pageProductCnt=${pageProductCnt}&classNo=${classNo}&manufacturerNo=${manufacturerNo}&originalClass=${originalClass}&searchWord=${searchWord}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> ${pagingInfo.totalPageCnt} </a>
		                      </li>
	                    </ul>
	                  </div>
	                </div>
	              </div>
	            </div>                              
	            <!-- / Content -->
	          </div>
          <!-- Content wrapper -->
          <!-- Footer -->
          <jsp:include page="../footer.jsp"></jsp:include>
            <!-- / Footer -->
        </div>
        <!-- / Layout page -->
      </div>

      <!-- Overlay -->
      <div class="layout-overlay layout-menu-toggle"></div>

      <!-- Drag Target Area To SlideIn Menu On Small Screens -->
      <div class="drag-target"></div>
    </div>
    <!-- / Layout wrapper -->
    
    
	<!-- 상품 정보 수정 modal -->
	<div class="modal" id="updateModal" tabindex="-1" aria-hidden="true">
	  <div class="modal-dialog modal-lg modal-simple modal-enable-otp modal-dialog-centered">
	    <div class="modal-content p-3 p-md-5">
	      <div class="modal-body">
	        <button type="button" class="btn-close modalClose" data-bs-dismiss="modal" aria-label="Close"></button>
	        <div class="text-center mb-4">
	          <h3 class="mb-3">상품 정보 수정</h3>
	          <p class="text-muted">해당 내용으로 수정합니다.</p>
	        </div>
	        <div
	          class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between border-bottom pb-3 mb-3">
	          <h6 class="m-0 mb-2 mb-sm-0 me-5">상품번호</h6>
	          <div class="d-flex flex-wrap gap-2" id="productNo">
	
	          </div>
	        </div>
	        <div
	          class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between border-bottom pb-3 mb-3">
	          <h6 class="m-0 mb-2 mb-sm-0 me-5">상품명</h6>
	          <div class="d-flex flex-wrap gap-2" id="productName">
	
	          </div>
	        </div>
	        <div
	          class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between border-bottom pb-3 mb-3">
	          <h6 class="m-0 mb-2 mb-sm-0">제조사</h6>
	          <div class="d-flex flex-wrap gap-2" id="manufacturerNo">
	
	          </div>
	        </div>
	        <div
	          class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between border-bottom pb-3 mb-3">
	          <h6 class="m-0 mb-2 mb-sm-0">작품명</h6>
	          <div class="d-flex flex-wrap gap-2" id="originalName">
	
	          </div>
	        </div>
	        <div
	          class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between border-bottom pb-3 mb-3">
	          <h6 class="m-0 mb-2 mb-sm-0">작품구분</h6>
	
	          <div class="d-flex flex-wrap gap-2" id="originalClass">
	
	          </div>
	        </div>
	        <div
	          class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between border-bottom pb-3 mb-3">
	          <h6 class="m-0 mb-2 mb-sm-0">판가</h6>
	
	          <div class="d-flex flex-wrap gap-2" id="salesCost">
	
	          </div>
	        </div>
	        <div
	          class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between border-bottom pb-3 mb-3">
	          <h6 class="m-0 mb-2 mb-sm-0">할인(%)</h6>
	
	          <div class="d-flex flex-wrap gap-2" id="discountRate">
	
	          </div>
	        </div>
	        <div
	          class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between border-bottom pb-3 mb-3">
	          <h6 class="m-0 mb-2 mb-sm-0">재고</h6>
	
	          <div class="d-flex flex-wrap gap-2" id="currentQty">
	
	          </div>
	        </div>
	        <div
	          class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between border-bottom pb-3">
	          <h6 class="m-0 mb-2 mb-sm-0">추천</h6>
	          <div class="d-flex flex-wrap gap-2" id="isRecommend">
	
	          </div>
	        </div>
             <button type="submit" class="btn btn-primary me-sm-3 me-1 updateProduct" onclick="updateProduct();">수정</button>
             <button type="reset" class="btn btn-label-secondary modalClose" data-bs-dismiss="modal" aria-label="Close">취소</button>	
	      </div>
	    </div>
	  </div>
	</div>
    
    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->

    <script src="/resources/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="/resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="/resources/assets/vendor/js/bootstrap.js"></script>
    <script src="/resources/assets/vendor/libs/node-waves/node-waves.js"></script>
    <script src="/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="/resources/assets/vendor/libs/hammer/hammer.js"></script>
    <script src="/resources/assets/vendor/libs/i18n/i18n.js"></script>
    <script src="/resources/assets/vendor/libs/typeahead-js/typeahead.js"></script>
    <script src="/resources/assets/vendor/js/menu.js"></script>
    <script src="https://kit.fontawesome.com/acb94ab00c.js" crossorigin="anonymous"></script>

    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="/resources/assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>
    <script src="/resources/assets/vendor/libs/select2/select2.js"></script>
    <script src="/resources/assets/vendor/libs/tagify/tagify.js"></script>
    <script src="/resources/assets/vendor/libs/bootstrap-select/bootstrap-select.js"></script>
	<script src="/resources/assets/vendor/libs/typeahead-js/typeahead.js"></script>
	<script src="/resources/assets/vendor/libs/bloodhound/bloodhound.js"></script>
    <!-- Main JS -->
    <script src="/resources/js/product/main.js"></script>
    <!-- Page JS -->
    <script src="/resources/js/product/forms-selects.js"></script>
    <script src="/resources/js/product/forms-tagify.js"></script>
    <script src="/resources/js/product/forms-typeahead.js"></script>
    <script src="/resources/js/product/product-list.js"></script>
	<script>
	    // JavaScript 파일에서 사용할 서버 측 데이터를 전역 변수에 할당
	    var pageProductCntJSP = ${pageProductCnt};
	</script>
  </body>
</html>