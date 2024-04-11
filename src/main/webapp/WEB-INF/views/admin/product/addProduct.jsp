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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>상품 등록</title>

    <meta name="description" content="" />

	 <!-- Favicon -->
	 <link rel="icon" type="image/x-icon" href="../../resources/assets/images/icons/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap" rel="stylesheet" />

    <!-- Icons -->
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/fontawesome.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/tabler-icons.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/flag-icons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="/resources/assets/vendor/css/rtl/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="/resources/assets/vendor/css/rtl/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="/resources/assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="/resources/assets/vendor/libs/node-waves/node-waves.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/typeahead-js/typeahead.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/quill/typography.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/quill/katex.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/quill/editor.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/select2/select2.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/dropzone/dropzone.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/flatpickr/flatpickr.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/tagify/tagify.css" />
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
          padding: 20px;
          width : 100px;
          border: none;
      }
      .writeInput:focus{
          outline:none;
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
	              <div class="app-ecommerce">
	                <!-- Add Product -->
					<form action="addProductDetail" class="addProduct" method="post">
		                <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-3">
		                  <div class="d-flex flex-column justify-content-center">
		                    <h4 class="py-3 mb-2">상품 등록</h4>
		                  </div>
		                  <div class="d-flex align-content-center flex-wrap gap-3">
		                    <div class="d-flex gap-3">
		                      <button class="btn btn-label-secondary" onclick="btnCancel()">취소</button>
		                      <!-- <button class="btn btn-label-primary">임시 저장</button> -->
		                    </div>
		                    <button type="submit" class="btn btn-primary insertProduct" onclick="return validateData();">상품 추가</button>
		                  </div>
		                </div>
		
		                <div class="row">
		                  <!-- First column-->
		                  <div class="col-12 col-lg-8">
		                    <!-- Product Information -->
		                    <div class="card mb-4">
		                      <div class="card-header">
		                        <h5 class="card-tile mb-0">상품 정보</h5>
		                      </div>
		                      <div class="card-body">
		                        <div class="d-flex align-items-start align-items-sm-center gap-4">
		                          <img src="/resources/productImg/box.png" alt="user-avatar" class="d-block w-px-100 h-px-100 rounded" id="uploadedThumbnail">
		                          <div class="button-wrapper">
		                          <label for="upload" class="btn btn-primary me-2 mb-3" tabindex="0">
		                            <span class="d-none d-sm-block">썸네일 등록</span>
		                            <i class="ti ti-upload d-block d-sm-none"></i>
		                            <input type="file" id="upload" class="account-file-input" name="thumbnailImg" hidden accept="image/png, image/jpeg" />
		                            <input type="hidden" id="thumbnailImg" name="thumbnailImg">
		                          </label>
		                            <button type="button" class="btn btn-label-secondary account-image-reset mb-3 cancelThumbnail">
		                              <i class="ti ti-refresh-dot d-block d-sm-none"></i>
		                              <span class="d-none d-sm-block">취소</span>
		                            </button>
		                            <div class="text-muted">(필수) JPG, GIF, PNG 만 가능</div>
		                          </div>
		                        </div>
							            </div>                       
			                  <hr class="my-0" />		
		
		                      <div class="card-body">
		                        <div class="mb-3">
		                          <label class="form-label" for="productName">상품명</label>
		                          <input type="text" class="form-control" id="productName" placeholder="상품명" name="productName" />
		                        </div>
		                        <div class="mb-3">
		                          <label class="form-label" for="originalName">작품명</label>
		                          <input type="text" class="form-control" id="originalName" placeholder="작품명" name="originalName" />
		                        </div>
		                        <div class="mb-3">
		                          <label class="form-label" for="materials">재질</label>
		                          <input type="text" class="form-control" id="materials" placeholder="재질" name="materials" value='-'/>
		                        </div>
		                        <div class="mb-3">
		                          <label class="form-label" for="size">크기</label>
		                          <input type="text" class="form-control" id="size" placeholder="크기" name="size" value=''/>
		                        </div>
		                        <div class="row mb-3">
		                          <div class="col">
		                            <label class="form-label" for="currentQty">입고 수량</label>
		                            <input type="number" class="form-control" id="currentQty" placeholder="입고 수량" name="currentQty" value='1'/>
		                          </div>
		                        </div>
		                      </div>
		                    </div>
		                    <!-- /Product Information -->
		                    <!-- Media -->
		
		                      <div class="card mb-4">
		                      <div class="card-header d-flex justify-content-between align-items-center">
		                        <h5 class="mb-0 card-title">상품 사진</h5>
		                      </div>
		                      <div class="card-body">
		                          <div class="dropzone needsclick dz-clickable dz-started"  tabindex="-1">
		                          			Drag and Drop Files 
		                          </div>
		                          <div>
		                          	<input type="file" class="detailImage" style="display:none;" accept="image/png, image/jpeg"/>
		                          </div>
		                      </div>
		                    </div>
		                      
		                    <!-- /Media -->
		                  </div>
		                  <!-- /Second column -->
		
		                  <!-- Second column -->
		                  <div class="col-12 col-lg-4">
		                    <!-- Pricing Card -->
		                    <div class="card mb-4">
		                      <div class="card-header">
		                        <h5 class="card-title mb-0">가격</h5>
		                      </div>
		                      <div class="card-body">
		                        <!-- 원가 -->
		                        <div class="mb-3">
		                          <label class="form-label" for="purchaseCost">구매 원가</label>
		                          <input type="number" class="form-control" id="purchaseCost" placeholder="구매 원가" name="purchaseCost" />
		                        </div>
		                        <!-- 판매가 -->
		                        <div class="mb-3">
		                          <label class="form-label" for="salesCost">판매가</label>
		                          <input type="number" class="form-control" id="salesCost" placeholder="판매가" name="salesCost"  />
		                        </div>
		                        <!-- 판매 유무 -->
		                        <div class="d-flex justify-content-between align-items-center border-top pt-3">
		                          <h6 class="mb-0">판매 유무</h6>
		                          <div class="w-25 d-flex justify-content-end">
		                            <label class="switch switch-primary switch-sm me-4 pe-2">
		                              <input type="checkbox" class="switch-input" name="isSales" checked value='Y'/>
		                              <span class="switch-toggle-slider">
		                                <span class="switch-on">
		                                  <span class="switch-off"></span>
		                                </span>
		                              </span>
		                            </label>
		                          </div>
		                        </div>
		                      </div>
		                    </div>
		                    <!-- /Pricing Card -->
		                    <!-- Organize Card -->
		                    <div class="card mb-4">
		                      <div class="card-header">
		                        <h5 class="card-title mb-0">카테고리 설정</h5>
		                      </div>
		                      <div class="card-body">
		                        <!-- 상품구분 -->
		                        <div class="mb-3 col ecommerce-select2-dropdown">
		                          <label class="form-label mb-1" for="collection">상품 구분 </label>
		                          <select id="classNo" class="select2 form-select" data-placeholder="상품 구분" name="classNo" >
		                            <option value="">상품 구분</option>
		                            <option value="10">예약 상품</option>
		                            <option value="20">신규 입고</option>
		                          </select>
		                        </div>
		                        <!-- 예약 상품 입고 월 기입-->
		                        <div class="mb-3">
		                          <label class="form-label" for="classMonth">예약 상품 입고 예정</label>
		                          <input type="text" class="form-control" id="classMonth" placeholder="00년 0월" name="classMonth"/>
		                        </div>
		                        <!-- 제조사 -->
		                        <div class="mb-3 col ecommerce-select2-dropdown">
		                          <label
		                            class="form-label mb-1 d-flex justify-content-between align-items-center"
		                            for="category-org">
		                            <span>제조사</span>
		                          </label>
		                          <select id="manufacturerNo" name="manufacturerNo" class="select2 form-select" data-placeholder="제조사 선택" >
		                            <option value="">제조사 선택</option>
		                            <c:forEach var="manufacturer" items="${manufacturers}">
		                              <option value="${manufacturer.manufacturerNo}">${manufacturer.manufacturerName}</option>
		                            </c:forEach>
		                            </select>
		                        </div>
		                        <!-- 작품별 구분 -->
		                        <div class="mb-3 col ecommerce-select2-dropdown">
		                          <label
		                            class="form-label mb-1 d-flex justify-content-between align-items-center"
		                            for="category-org">
		                            <span>작품 카테고리 구분</span>
		                          </label>
		                          <select id="originalClass" name="originalClass" class="select2 form-select" data-placeholder="작품 구분 선택" >
		                            <option value="">작품 카테고리 선택</option>
		                            <c:forEach var="original" items="${originals}">
		                              <option value="${original.originalClass}">${original.className}</option>
		                            </c:forEach>
		                          </select>
		                        </div>
		                      </div>
		                    </div>
		                    <!-- /Organize Card -->
		                  </div>
		                  <!-- /Second column -->
		                </div>
	                 </form>
	              </div>
	            </div>
	            <!-- / Content -->
	            <!-- Footer -->
	          </div>
          <!-- Content wrapper -->
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

    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="/resources/assets/vendor/libs/quill/katex.js"></script>
    <script src="/resources/assets/vendor/libs/quill/quill.js"></script>
    <script src="/resources/assets/vendor/libs/select2/select2.js"></script>
    <script src="/resources/assets/vendor/libs/dropzone/dropzone.js"></script>
    <script src="/resources/assets/vendor/libs/jquery-repeater/jquery-repeater.js"></script>
    <script src="/resources/assets/vendor/libs/flatpickr/flatpickr.js"></script>
    <script src="/resources/assets/vendor/libs/tagify/tagify.js"></script>
    <!-- Main JS -->
    <script src="/resources/js/product/main.js"></script>
    <!-- Page JS -->
    <script src="/resources/js/product/product-add.js"></script>

</body>
</html>