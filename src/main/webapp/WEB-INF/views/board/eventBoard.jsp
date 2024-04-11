<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>이벤트 게시판</title>
<!-- Favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
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
<link rel="stylesheet"
	href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css">
<!-- Main CSS File -->
<link rel="stylesheet" href="/resources/assets/css/style.css">
<title>메인페이지</title>
<style>
.listNum {
	border-bottom: 2px solid;
}

.button:hover, .button.active {
	color: #000000;
}

.button:visited {
	color: #000000;
}

.button {
	font-weight: bold;
	font-size: 25px;
	border: 0;
	float: left
}

.row {
	padding-bottom: 30px !important;
}         

h5 {
	font-weight: bold !important;
}
.banner banner-cat {
	width: 636px !important;
	height: 333.14px !important;
	display: flex !important;
    justify-content: !important;
    align-items: center !important; /* 수직 가운데 정렬 */
}

.img-fluid {
	max-width: 47vw !important;	
	height: 23vw !important;
/* 	max-width: 580px !important; */
	object-fit: contain;
/* 	object-fit: fill; */
	background-color: white;
}

.tabContainer {
    margin: 10px auto;
    width: fit-content;
}

.ingevent {
	 display: flex;
}
.ritBtn {
    float: right;
    margin-right: 200px;
}
.product-title a {
        font-weight: bolder !important;
		font-size: 20px;       
}

</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<!-- header 파일 인클루드 -->
                      
	<div class="tabContainer">
		<h2>기획전/이벤트</h2>
	</div>
	<jsp:useBean id="today" class="java.util.Date" />
	<fmt:formatDate value="${today}" pattern="yyyy-MM-dd HH mm:ss" var="nowDate" />
	<div class="btns">
		<c:if test="${loginCustomer.isAdmin == 'A'}">
		<button type="button" class="btn btn-success ritBtn btn-outline-primary-2"
			onclick="location.href='writeEventBoard'">글쓰기</button>
		</c:if>
		
		<c:if test="${loginCustomer.isAdmin != 'A'}">
		<button type="button" class="btn btn-success ritBtn btn-outline-primary-2" style ="display : none;"
			onclick="location.href='writeEventBoard'">글쓰기</button>
		</c:if>
		
	</div>
	
<c:set var="ongoingEventCount" value="0" />
<c:set var="endedEventCount" value="0" />

<c:forEach var="event" items="${eventList}" varStatus="status">
    <c:choose>
        <c:when test="${nowDate lt event.endDate}">
           
            <c:set var="ongoingEventCount" value="${ongoingEventCount + 1}" />
        </c:when>
        <c:otherwise>
            <c:set var="endedEventCount" value="${endedEventCount + 1}" />
        </c:otherwise>
    </c:choose>
</c:forEach>
	<div class="page-content">
    <div class="container-fluid" style="padding-top: 50px;">
        <div class="ingevent"> 
            <h3 class="button active" id="ing">진행중인 이벤트(${ongoingEventCount })</h3> 
        </div>
        <div class="tab-content tab-content-carousel">
            <div class="owl-carousel owl-simple owl-height carousel-with-shadow" id="mainImg" data-toggle="owl" 
                data-owl-options='{
                    "nav": false, 
                    "dots": true,
                    "margin": 20,
                    "loop": false,
                    "responsive": {
                        "1600": {
                            "items":2,
                            "nav": true
                        }
                    }
                }'>
                <!-- 진행중인 이벤트 -->
                <c:forEach var="event" items="${eventList}" varStatus="status">
                    <c:choose>
                        <c:when test="${nowDate lt event.endDate}">
                        <c:set var="eventCount" value="${eventCount + 1}" />
                            <!-- 종료된 이벤트 -->
                            <div class="product product-11 text-center">
                                <figure class="product-media">
                                    <a href="/board/detailViewEventBoard?no=${event.eventNo}">
                                        <img src="data:image;base64,${event.imgUrl}" alt="Product image" class="product-image">
                                    </a>
                                </figure><!-- End .product-media -->
                                <div class="product-body">
                                    <h3 class="product-title">
                                        <a href="/board/detailViewEventBoard?no=${event.eventNo}">${event.title}</a>
                                    </h3><!-- End .product-title -->
                                    <div class="product-price">
                                    	<c:choose>
                                    		<c:when test="${formattedDates[status.index] == '3010-03-26 00:00 ~ 3010-03-26 00:00'}">
		                                        <p>상시</p>
                                    		</c:when>
                                    		<c:otherwise>
		                                        <p>${formattedDates[status.index]}</p>
                                    		</c:otherwise>
                                   		</c:choose>
                                    </div><!-- End .product-price -->
                                </div><!-- End .product-body -->
                            </div><!-- End .product -->
                        </c:when>
                    </c:choose>
                </c:forEach>
            </div><!-- End .owl-carousel -->
        </div><!-- End .tab-content -->
    </div><!-- End .container-fluid -->
   
    
    
  
    <!-- 종료된 이벤트 -->
    <div class="container-fluid" style="padding-top: 50px;">
        <div class="ingevent"> 
            <h3 class="button active" id="ending">종료된 이벤트(${endedEventCount })</h3> 
        </div>
        <div class="tab-content tab-content-carousel">
            <div class="owl-carousel owl-simple owl-height carousel-with-shadow" id="mainImgEnding" data-toggle="owl" 
                data-owl-options='{
                    "nav": false, 
                    "dots": true,
                    "margin": 20,
                    "loop": false,
                    "responsive": {
                        "1600": {
                            "items":2,
                            "nav": true
                        }
                    }
                }'>
                <!-- 종료된 이벤트 -->
                <c:forEach var="event" items="${eventList}" varStatus="status">
                    <c:choose>
                        <c:when test="${nowDate gt event.endDate}">
                            <!-- 종료된 이벤트 -->
                            <div class="product product-11 text-center">
                                <figure class="product-media">
                                    <a href="/board/detailViewEventBoard?no=${event.eventNo}">
                                        <img src="data:image;base64,${event.imgUrl}" alt="Product image" class="product-image">
                                    </a>
                                </figure><!-- End .product-media -->
                                <div class="product-body">
                                    <h3 class="product-title">
                                        <a href="/board/detailViewEventBoard?no=${event.eventNo}">${event.title}</a>
                                    </h3><!-- End .product-title -->
                                    <div class="product-price">
                                        <p>
										    <span id="eventPeriod" class="formattedDate">${formattedDates[status.index]}</span>
										</p>
                                    </div><!-- End .product-price -->
                                </div><!-- End .product-body -->
                            </div><!-- End .product -->
                        </c:when>
                    </c:choose>
                </c:forEach>
            </div><!-- End .owl-carousel -->
        </div><!-- End .tab-content -->
    </div><!-- End .container-fluid -->
</div><!-- End .page-content -->

	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- footer 파일 인클루드 -->
	<!-- Plugins JS File -->
	<script src="/resources/assets/js/jquery.min.js"></script>
	<script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
	<script src="/resources/assets/js/jquery.waypoints.min.js"></script>
	<script src="/resources/assets/js/superfish.min.js"></script>
	<script src="/resources/assets/js/owl.carousel.min.js"></script>
	<!-- Main JS File -->
	<script src="/resources/assets/js/main.js"></script>
<script>
</script>
</body>
</html>
