<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html lang="KO">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>오시는 길</title>
	<meta name="keywords" content="HTML5 Template">
	<meta name="description" content="FigureShop" />
	<meta name="author" content="p-themes">
	
	<!-- Favicon -->
	<link rel="apple-touch-icon" sizes="180x180" href="/resources/assets/images/icons/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="/resources/assets/images/icons/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="/resources/assets/images/icons/favicon-16x16.png">
	<link rel="manifest" href="/resources/assets/images/icons/site.html">
	<link rel="shortcut icon" href="/resources/assets/images/icons/favicon.ico">
	<meta name="apple-mobile-web-app-title" content="FigureShop">
	<meta name="application-name" content="FigureShop">
	<meta name="msapplication-TileColor" content="#cc9966">
	<meta name="msapplication-config" content="/resources/assets/images/icons/browserconfig.xml">
	<meta name="theme-color" content="#ffffff">
	
	<!-- Plugins CSS File -->
	<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
	
	<!-- Main CSS File -->
	<link rel="stylesheet" href="/resources/assets/css/style.css">
	<link rel="stylesheet" href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css">
	<link rel="stylesheet" href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css">
	<link rel="stylesheet" href="/resources/assets/css/plugins/nouislider/nouislider.css">
	
	<!-- 지도 라이브러리 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bd678920b4446aa83f3b6fe572172571"></script>
</head>
	
<body>
	<!-- header 추가 -->
	<jsp:include page="../header.jsp"></jsp:include>
		<main class="main">
			<div class="page-header text-center">
	            <!-- <div class="page-header text-center" style="background-image: url('assets/images/page-header-bg.jpg')"> -->
	            <div class="container">
	                <h1 class="page-title">오시는 길
	                    <!-- <span> 이용약관</span> -->
	                </h1>
	            </div><!-- End .container -->
	        </div><!-- End .page-header -->
		
	        <nav aria-label="breadcrumb" class="breadcrumb-nav border-0 mb-0">
	            <div class="container">
	                <ol class="breadcrumb">
	                    <li class="breadcrumb-item">
	                        <a href="/">홈</a>
	                    </li>
	                    <li class="breadcrumb-item active" aria-current="page">오시는 길</li>
	                </ol>
	            </div><!-- End .container -->
	        </nav><!-- End .breadcrumb-nav -->
            
            <div class="container mb-5">
            	<div id="map"></div>
            <!-- <div class="page-header page-header-big text-center" > -->
       		<!-- </div> -->
	        		
        			<!-- <h1 class="page-title text-white">오시는 길<span class="text-white">keep in touch with us</span></h1> -->
            </div><!-- End .container -->

            <div class="page-content pb-0 location-style">
                <div class="container">
                	<div class="row">
                		<div class="col-lg-8 mb-2 mb-lg-0 mx-auto locationWrap">
                			<h2 class="title mb-1 text-center">오시는 길</h2><!-- End .title mb-2 -->
                			<p class="mb-3 text-center">
                				서울특별시 구로구 시흥대로 163길 33, 주호타워 구트아카데미 3층
                			</p>
                			<div class="row locationInfo">
                				<div class="col-sm-8">
                					<div class="contact-info">
                						<h3>구트아카데미</h3>

                						<ul class="contact-list">
                							<li>
                								<i class="icon-map-marker"></i>
	                							서울특별시 구로구 시흥대로 163길 33, 주호타워 구트아카데미 3층
	                						</li>
                							<li>
                								<i class="icon-phone"></i>
                								<a href="tel:02-837-9922">02-837-9922</a>
                							</li>
                							<li>
                								<i class="icon-envelope"></i>
                								<a href="mailto:#">goott_job@naver.com</a>
                							</li>
                						</ul><!-- End .contact-list -->
                					</div><!-- End .contact-info -->
                				</div><!-- End .col-sm-7 -->
                				<div class="col-sm-4">
                					<div class="contact-info ml-0">
                						<h3>운영시간</h3>

                						<ul class="contact-list">
                							<li>
                								<i class="icon-clock-o"></i>
	                							<span class="text-dark">월 - 금</span> 
	                							<br>09:30 ~ 22:00
	                							<!-- <p>운영시간 : 09:30 ~ 22:00</p> -->
	                						</li>
                							<li>
                								<i class="icon-calendar"></i>
                								<span class="text-dark">주말/공휴일</span> <br>휴일
                							</li>
                						</ul><!-- End .contact-list -->
                					</div><!-- End .contact-info -->
                				</div><!-- End .col-sm-5 -->
                			</div><!-- End .row -->
                		</div><!-- End .col-lg-6 -->
                	</div><!-- End .row -->

                	<hr class="mt-4 mb-5">

                </div><!-- End .container -->
            	<!-- <div id="map"></div>End #map -->
            </div><!-- End .page-content -->
        </main><!-- End .main -->
	
	<!-- footer -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
    <!-- jquery library -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
		// 메인페이지 맵 map api
		
		// map start
		$(function () {
		  let lat = 37.481986600989586;
		  let lon = 126.8980968127896;
		  kakaoMap(lat, lon);
		  // resizeMap();
		});
		
		function kakaoMap(lat, lon) {
		  // 지도
		  var mapContainer = document.getElementById("map"), // 지도를 표시할 div
		    mapOption = {
		      center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
		      level: 4, // 지도의 확대 레벨
		    };
	
		  // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		  var map = new kakao.maps.Map(mapContainer, mapOption);
	
		  var imageSrc = "/resources/assets/images/mainMarker.png", // 마커이미지의 주소입니다
		    imageSize = new kakao.maps.Size(50, 50), // 마커이미지의 크기입니다
		    imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	
		  // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		  var markerImage = new kakao.maps.MarkerImage(
		      imageSrc,
		      imageSize,
		      imageOption
		    ),
		    markerPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치입니다
	
		  // 마커를 생성합니다
		  var marker = new kakao.maps.Marker({
		    position: markerPosition,
		    image: markerImage, // 마커이미지 설정
		  });
	
		  // 마커가 지도 위에 표시되도록 설정합니다
		  marker.setMap(map);
		}
	</script>
</body>
</html>