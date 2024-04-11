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

    <title>상픔 문의 접수</title>

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
		.sorting_1 div {
			width: 42px !important;
			text-align: center;
		    
		}
		.sorting_1 div:nth-child(2) {
			width: 42px !important;
			text-align: center;
		    
		}
		.sorting_1 div:nth-child(8) {
			width: 42px !important;
			text-align: center;
		    
		}
		.table .border-top th {
			width: fit-content;
		}
		.table .border-top th:nth-child(10) {
			text-align: center;	
		}
		.odd td:nth-child(3) div {
		    width: 56px; 
    		text-align: center;
		}
		.odd td:nth-child(5) div {
    		text-align: center;
		}
		.odd td:nth-child(9) div {
		    width: 75px; 
    		text-align: center;
		}
		.odd td:nth-child(10) div {
    		text-align: center;
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
         	     <h4 class="py-3 mb-2">상품 문의 관리</h4>
	              <!-- Product List Table -->
  	              <div class="card">
	              
	                <div class="card-header border-top rounded-0 py-2" id="card-header-second">
	                   <div id="second-box">
		                   <div class="dataTables_length mt-2 mt-sm-0 mt-md-3 me-2" id="DataTables_Table_0_length" style="margin : 0 !important;">
		                      <label>
		                        <select name="searchType" aria-controls="DataTables_Table_0" class="form-select"  id="searchType">
									<option id="dateDecs" value="dateDecs" <c:if test="${searchType == 'dateDecs'}">selected</c:if>>최신순</option>
									<option id="dateAcs" value="dateAcs" <c:if test="${searchType == 'dateAcs'}">selected</c:if>>오래된 등록일순</option>
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
	                   </div>
	                </div>
	                <div class="card-datatable table-responsive">
	                  <div id="DataTables_Table_0_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
	                    <table class="datatables-products table dataTable no-footer dtr-column collapsed" id="DataTables_Table_0" aria-describedby="DataTables_Table_0_info" >
	                      <thead class="border-top">
	                        <tr>
	                          <th class="control sorting_disabled dtr-hidden" rowspan="1" colspan="1" style="width: 0px; display: none;" aria-label=""></th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1">글번호</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1">상품번호</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1">상품명</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1">작성자</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1">제목</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1">내용</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1">답글 (클릭 후 작성)</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1">삭제된 문의</th>
	                          <th class="sorting_disabled" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1">작성일</th>
	                          <th class="sorting_disabled" rowspan="1" colspan="1" style="width: 60px;" aria-label="Actions">등록</th>
	                        </tr>
	                      </thead>
	                      <tbody>
		                      <c:forEach var="pdQna" items="${pdQnaList }">
		                        <tr class="odd ">
		                          <td class="control dtr-hidden" tabindex="0" style="display: none;"></td>
		                          <td class="sorting_1" >
	                                <div id="svBoardNo${pdQna.svBoardNo}" class="text-body text-nowrap mb-0" >${pdQna.svBoardNo}</div>
		                          </td>
		                          <td>
	                            	<div class="text-body text-nowrap mb-0" id="productNo${pdQna.svBoardNo}" >${pdQna.productNo }</div>		                          
		                          </td>
		                          <td>
	                            	<div class="text-body text-nowrap mb-0" id="productName${pdQna.svBoardNo}"><a href="/product/productDetail?productNo=${pdQna.productNo}">${pdQna.productName }</a></div>		                          
		                          </td>
		                          <td>
	                            	<div class="text-body text-nowrap mb-0" id="productName${pdQna.svBoardNo}">${pdQna.nickname }</div>		                          
		                          </td>
		                          <td>
	                            	<div class="text-body text-nowrap mb-0" id="svBoardTitle${pdQna.svBoardNo}">${pdQna.svBoardTitle }</div>		                          
		                          </td>
		                          <td>
		                            <div class="text-body text-nowrap mb-0" id="svBoardContent${pdQna.svBoardNo}"> ${pdQna.svBoardContent}</div>
		                          </td>
		                          <td>
		                            <input type="text" name="currentQty" class="writeInput text-body text-nowrap mb-0" id="svBoardAnswer${pdQna.svBoardNo}" style="width : 500px;" value="${pdQna.svBoardAnswer}" >
		                          </td>
		                          <td>
		                            <div class="text-body text-nowrap mb-0" id="svIsDelete${pdQna.svBoardNo}">${pdQna.svIsDelete} </div>
		                          </td>
								  <td>
		                            <div class="writeInput text-body text-nowrap mb-0">${pdQna.svBoardRegiDate }</div>
		                          </td>
		                          <td class="" style="">
		                            <div class="d-inline-block text-nowrap">
		                              <button type="button" class="btn btn-sm btn-icon updateModal" onclick="updatePdQna(${pdQna.svBoardNo});">
		                                <i class="ti ti-edit"></i>
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
	                  <div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate">
	                    <ul class="pagination">
	                      <c:choose>
	                      <c:when test="${param.pageNo == 1 or param.pageNo == null}">
		                      <li class="paginate_button page-item previous disabled" id="DataTables_Table_0_previous">
		                        <a aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> < </a>
		                      </li>
	                      </c:when>
	                      <c:otherwise>
		                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
		                        <a href="/admin/product/pdQna?pageNo=${param.pageNo - 1}&pageProductCnt=${pageProductCnt}" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> < </a>
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
				                        <a href="/admin/product/pdQna?pageNo=${paging}&pageProductCnt=${pageProductCnt}" aria-controls="DataTables_Table_0" role="link" aria-current="page" class="page-link">${paging}</a>
				                      </li>
		    	                  </c:otherwise>
		                      </c:choose>
						  </c:forEach>
	                      <c:choose>
	                      	<c:when test="${param.pageNo != null or param.pageNo <= pagingInfo.totalPageCnt}">
		                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
		                        <a href="/admin/product/pdQna?pageNo=${param.pageNo + 1}&pageProductCnt=${pageProductCnt}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> > </a>
		                      </li>
	                      	</c:when>
	                      	<c:otherwise>
		                      <li class="paginate_button page-item next disabled" id="DataTables_Table_0_next">
		                        <a href="#" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> > </a>
		                      </li>
	                      	</c:otherwise>
	                      </c:choose>
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
    <script src="/resources/js/product/product-qna.js"></script>
	<script>
	    // JavaScript 파일에서 사용할 서버 측 데이터를 전역 변수에 할당
	    var pageProductCntJSP = ${pageProductCnt};
	</script>
  </body>
</html>