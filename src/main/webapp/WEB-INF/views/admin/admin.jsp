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
	<meta charset="UTF-8">
	<title>관리자 메인 페이지</title>
	
	 <!-- Favicon -->
	 <link rel="icon" type="image/x-icon" href="../resources/assets/images/icons/favicon.ico" />
	 
    <!-- link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
    <link rel="icon" href="../../resources/assets/images/icons/favicon.ico" /> -->
	
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap" rel="stylesheet" />

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
    <link rel="stylesheet" href="/resources/assets/vendor/libs/apex-charts/apex-charts.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/swiper/swiper.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/libs/datatables-checkboxes-jquery/datatables.checkboxes.css" />

    <!-- Page CSS -->
    <link rel="stylesheet" href="/resources/assets/vendor/css/pages/cards-advance.css" />

    <!-- Helpers -->
    <script src="/resources/assets/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->
    <script src="/resources/assets/vendor/js/template-customizer.js"></script>
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="/resources/js/product/config.js"></script>

</head>
<body>
	<div class="layout-wrapper layout-content-navbar">
	      <div class="layout-container">
	        <!-- Menu -->
	        <jsp:include page="aside.jsp"></jsp:include>
	        <!-- / Menu -->
	        <!-- Layout container -->
	        <div class="layout-page">
	          <!-- Content wrapper -->
	          <div class="content-wrapper">






 			<!-- / Content -->

	          </div>
	          <!-- Content wrapper -->
            <!-- Footer -->
            <jsp:include page="footer.jsp"></jsp:include>

            <!-- / Footer -->

            <div class="content-backdrop fade"></div>
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
    
        <!-- Vendors JS -->
    <script src="/resources/assets/vendor/libs/apex-charts/apexcharts.js"></script>
    <script src="/resources/assets/vendor/libs/swiper/swiper.js"></script>
    <script src="/resources/assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>

    <!-- Main JS -->
    <script src="/resources/js/product/main.js"></script>

    <!-- Page JS -->
    <script src="/resources/assets/js/dashboards-analytics.js"></script>
    
</body>
</html>