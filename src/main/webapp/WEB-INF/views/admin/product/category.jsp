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

    <title>작품 카테고리 관리</title>

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
    <link rel="stylesheet" href="/resources/assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/select2/select2.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/@form-validation/umd/styles/index.min.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/quill/typography.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/quill/katex.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/quill/editor.css" />

    <!-- Page CSS -->

    <link rel="stylesheet" href="/resources/assets/vendor/css/pages/app-ecommerce.css" />

    <!-- Helpers -->
    <script src="/resources/assets/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->
    <script src="/resources/assets/vendor/js/template-customizer.js"></script>
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="/resources/js/product/config.js"></script>
    <!-- jquery -->
	  <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
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
              <h4 class="py-3 mb-2">카테고리 관리</h4>

                <div class="app-ecommerce-category row">
                <!-- Category List Table -->
                  <div class="card col-lg-7">
                    <div class="card-datatable table-responsive">
                      <table class="datatables-category-list table border-top">
                        <thead>
                          <tr>
                            <th class="text-nowrap text-sm-end">관리 코드</th>
                            <th class="text-nowrap text-sm-end">구분</th>
                            <th></th>
                          </tr>
                        </thead>
                      </table>
                    </div>
                  </div>
                  <!-- 카테고리 추가 / 수정 -->
                  <div class="col-12 col-lg-5">
                    <div class="card mb-4">
                      <div class="card-header py-4">
                      	<h5 class="offcanvas-title">신규 카테고리 추가</h5>
                      </div>
	                  <div class="card-body border-top">
	                    <form action="addCategory" class="pt-0" id="addCategory" method="post">
	                      <!-- Title -->
	                      <div class="mb-3">
	                        <label class="form-label" for="addOriginalClass">관리 코드</label>
	                        <input type="text" class="form-control" id="addOriginalClass" placeholder="ex) A000" name="originalClass" maxlength="4" onchange="checkOriginalClass('addOriginalClass');"/>
	                      </div>
	                      <div class="mb-3">
	                        <label class="form-label" for="addClassName">구분</label>
	                        <input type="text" class="form-control" id="addClassName" placeholder="ex) ㄱ > 카테고리 이름" name="className" onchange="checkOriginalClassName('addClassName');"/>
	                      </div>
	                      <!-- Submit and reset -->
	                      <div class="mb-3">
	                        <button type="submit" class="btn btn-primary me-sm-3 me-1 data-submit" onclick="return valicateAddCata('addOriginalClass', 'addClassName')">추가</button>
	                        <button type="reset" class="btn bg-label-danger">취소</button>
	                      </div>
	                    </form>
                    </div>
                    <div class="card-header py-4">
                    	<h5 class="offcanvas-title">카테고리 수정</h5>
				    </div>
                    <div class="card-body border-top">
                      <form action="updateCategory" class="pt-0" id="updateCategory" method="post">
                        <div class="mb-3 ecommerce-select2-dropdown">
                          <label class="form-label" for="originalClass">카테고리 이름</label>
                          <select id="originalClass" class="select2 form-select" data-placeholder="카테고리 이름" name="originalClass">
                            <option value="">카테고리 이름</option>
                            <c:forEach var="original" items="${originals }">
	                          <option value="${original.originalClass }">${original.className }</option>
                            </c:forEach>
                          </select>
                        </div>
                        <div class="mb-3">
                          <label class="form-label" for="updateClassName">변경할 이름</label>
                          <input type="text" id="updateClassName" class="form-control" placeholder="ex) ㄱ > 카테고리 이름" name="className" onchange="checkClassName('updateClassName');"/>
                        </div>
                        <!-- Submit and reset -->
                        <div class="mb-3">
                          <button type="submit" class="btn btn-primary me-sm-3 me-1 data-submit" onclick="return valicateAddCata('originalClass', 'updateClassName')">수정</button>
                          <button type="reset" class="btn bg-label-danger">취소</button>
                        </div>
                      </form>
                    </div>
                  </div>
				<!--/ 카테고리 추가 / 수정 -->
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
    <script src="/resources/assets/vendor/libs/moment/moment.js"></script>
    <script src="/resources/assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>
    <script src="/resources/assets/vendor/libs/select2/select2.js"></script>
    <script src="/resources/assets/vendor/libs/@form-validation/umd/bundle/popular.min.js"></script>
    <script src="/resources/assets/vendor/libs/@form-validation/umd/plugin-bootstrap5/index.min.js"></script>
    <script src="/resources/assets/vendor/libs/@form-validation/umd/plugin-auto-focus/index.min.js"></script>
    <script src="/resources/assets/vendor/libs/quill/katex.js"></script>
    <script src="/resources/assets/vendor/libs/quill/quill.js"></script>

    <!-- Main JS -->
    <script src="/resources/js/product/main.js"></script>

    <!-- Page JS -->
    <script src="/resources/js/product/category-list.js"></script>
    
  </body>
</html>