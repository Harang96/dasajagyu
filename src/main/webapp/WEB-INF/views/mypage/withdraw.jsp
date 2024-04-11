<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<meta name="keywords" content="HTML5 Template">
<meta name="description" content="Molla - Bootstrap eCommerce Template">
<meta name="author" content="p-themes">
<!-- Favicon -->
<link rel="apple-touch-icon" sizes="180x180"
	href="/resources/assets/images/icons/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="/resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="/resources/assets/images/icons/favicon-16x16.png">
<link rel="manifest" href="/resources/assets/images/icons/site.html">
<link rel="mask-icon"
	href="/resources/assets/images/icons/safari-pinned-tab.svg"
	color="#666666">
<link rel="shortcut icon"
	href="/resources/assets/images/icons/favicon.ico">
<meta name="apple-mobile-web-app-title" content="Molla">

<meta name="application-name" content="Molla">
<meta name="msapplication-TileColor" content="#cc9966">
<meta name="msapplication-config"
	content="/resources/assets/images/icons/browserconfig.xml">
<meta name="theme-color" content="#ffffff">
<!-- Plugins CSS File -->
<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
<!-- Main CSS File -->
<link rel="stylesheet" href="/resources/assets/css/style.css">
<link rel="stylesheet"
	href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css">
<link rel="stylesheet"
	href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css">
<link rel="stylesheet"
	href="/resources/assets/css/plugins/nouislider/nouislider.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<c:set var="URL" value="${pageContext.request.requestURL}" />
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<main class="main">
	  <div class="page-content">
            	<div class="dashboard">
	              <div class="container" style="margin: 10px 205px;">
	                <div class="row">
					<jsp:include page="mypageAside.jsp"></jsp:include>
						 <div class="col-md-8 col-lg-10">
						 	 <div class="tab-pane" id="tab-withdraw" >
								    	<div class="heading">
								    		<h2 class="title"> 회원 탈퇴</h2>
								    	</div>
								    	<table class="table table-wishlist table-mobile" style="border-top: 2px solid;">
								    	 <tr>
								    	 
								    	 </tr>
								    	</table>
								    	
									</div><!-- .End .tab-pane -->
						 
						 </div>
					</div>
				</div>
			</div>
		</div>
</main>
</body>
</html>