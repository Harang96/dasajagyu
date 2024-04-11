<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>aside</title>
 
    <meta name="description" content="" />

	 <!-- Favicon -->
	 <link rel="icon" type="image/x-icon" href="../../resources/assets/images/icons/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
<!--     <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin /> -->
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap" rel="stylesheet" />

    <!-- Icons -->
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/fontawesome.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/tabler-icons.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/flag-icons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="/resources/assets/vendor/css/rtl/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="/resources/assets/vendor/css/rtl/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="/resources/assets/css/demo.css" />

    <!-- Helpers -->
    <script src="/resources/assets/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->
    <script src="/resources/assets/vendor/js/template-customizer.js"></script>
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="/resources/js/product/config.js"></script>
    
    <script type="text/javascript">
	  	$(function() {
	  	    // 현재 페이지 URL 가져오기
	  	    var currentUrl = window.location.href;
	
	  	    // "/admin/board/boardAdmin" 부분만 남기기
	  	    var baseUrl = currentUrl.replace("http://goott351.cafe24.com", "");
	
	  	    // 모든 <a> 태그 순회
	  	    $("a").each(function() {
	  	        // 링크의 href 속성 값 가져오기
	  	        var linkUrl = $(this).attr("href");
	
	  	        // 현재 URL과 링크의 URL이 일치하는 경우
	  	        if (baseUrl === linkUrl) {
	  	            // 부모 요소에 .active 클래스 추가
	  	            $(this).parent().addClass("active");
	  	        }
	  	    });
	  	});
    </script>

</head>

<body>
	<input type="hidden" value="${sessionScope.loginCustomer.isAdmin }" id="login">
    <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
        <div class="app-brand demo">
            <a href="/admin" class="app-brand-link"> <span class="app-brand-logo demo"> <img src="/resources/assets/images/icons/apple-touch-icon.png" style="width : 30px"></span>
            <span class="app-brand-text demo menu-text fw-bold">다사자규</span></a>
            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto"> <i class="ti menu-toggle-icon d-none d-xl-block ti-sm align-middle"></i>
            <i class="ti ti-x d-block d-xl-none ti-sm align-middle"></i></a>
        </div>




        <ul class="menu-inner py-1">
            <li class="menu-item open">
            	<a href="javascript:void(0);" class="menu-link menu-toggle">
                    <div data-i18n="상품 관리">상품 관리</div>
                </a>
                <ul class="menu-sub">
                    <li class="menu-item">
                    	<a href="/admin/product/productList" class="menu-link">
                            <div data-i18n="상품 관리 목록">상품 관리 목록</div>
                        </a>
                    </li>
                    <li class="menu-item">
                    	<a href="/admin/product/addProduct" class="menu-link">
                            <div data-i18n="상품 등록">상품 등록</div>
                        </a>
                    </li>
                    <li class="menu-item">
                    	<a href="/admin/product/manufacturer" class="menu-link">
                            <div data-i18n="제조사 관리">제조사 관리</div>
                        </a>
                    </li>
                    <li class="menu-item">
                    	<a href="/admin/product/category" class="menu-link">
                            <div data-i18n="카테고리 관리">카테고리 관리</div>
                        </a>
                    </li>
                    <li class="menu-item">
                    	<a href="/admin/product/pdQna" class="menu-link">
                            <div data-i18n="상품 문의 관리">상품 문의 관리</div>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="menu-item open">
            	<a href="javascript:void(0);" class="menu-link menu-toggle">
                    <div data-i18n="주문 관리">주문 관리</div>
                </a>
                <ul class="menu-sub">
                    <li class="menu-item">
                    	<a href="/admin/order/list" class="menu-link">
                            <div data-i18n="주문 내역">주문 내역</div>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="menu-item open">
            	<a href="javascript:void(0);" class="menu-link menu-toggle">
                    <div data-i18n="고객 관리">고객 관리</div>
                </a>
                <ul class="menu-sub">
                    <li class="menu-item">
                    	<a href="/admin/customer/customerAdmin" class="menu-link">
                        	<div data-i18n="고객 목록">고객 목록</div>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="menu-item open">
            	<a href="javascript:void(0);" class="menu-link menu-toggle">
                    <div data-i18n="게시판 관리">게시판 관리</div>
                </a>
                <ul class="menu-sub">
                    <li id="boardAside" class="menu-item">
                    	<a href="/admin/board/boardAdmin" class="menu-link">
                            <div data-i18n="게시판 목록">게시판 목록</div>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="menu-item">
            	<a href="/" class="menu-link">
                    <div data-i18n="다사자규 홈">다사자규 홈</div>
                </a>
            </li>
        </ul>
    </aside>

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

    <script src="/resources/js/admin/aside.js"></script>
    <!-- endbuild -->

</body>

</html>