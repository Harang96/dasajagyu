<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>상품 상세 정보</title>
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
    <link rel="stylesheet" href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css">
    <link rel="stylesheet" href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css">

    <!-- Main CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/style.css">
    <link rel="stylesheet" href="/resources/assets/css/plugins/nouislider/nouislider.css">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.0/kakao.min.js" integrity="sha384-l+xbElFSnPZ2rOaPrU//2FF5B4LB8FiX5q4fXYTlfcG4PGpMkE1vcL7kNXI6Cci0" crossorigin="anonymous"></script>
    <script>
        Kakao.init('38d5453c4c3fec43700ff6695a2d5b81');
    </script>
</head>

<body>
    <div class="page-wrapper">
        <!-- header -->
        <jsp:include page="../header.jsp"></jsp:include>

        <!-- 상품 상세페이지 출력 -->
        <main class="main">
            <nav aria-label="breadcrumb" class="breadcrumb-nav border-0 mb-0">
                <div class="container d-flex align-items-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">홈</a></li>
                        <li class="breadcrumb-item"><a href="/product/listAll">상품</a></li>
                        <li class="breadcrumb-item active" aria-current="page">상품 상세정보</li>
                    </ol>
                </div><!-- End .container -->
            </nav><!-- End .breadcrumb-nav -->
            <div class="page-content">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-9">
                            <div class="product-details-top">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="product-gallery">
                                            <figure class="product-main-image">
                                                <img id="product-zoom" src="${product.thumbnailImg }" data-zoom-image="${product.thumbnailImg }" alt="product image" />
                                                <a href="#" id="btn-product-gallery" class="btn-product-gallery">
                                                    <i class="icon-arrows"></i>
                                                </a>
                                            </figure><!-- End .product-main-image -->
                                        </div><!-- End .product-gallery -->
                                    </div><!-- End .col-md-6 -->

                                    <div class="col-md-6">
                                        <div class="product-details product-details-sidebar">
                                            <h1 class="product-title">
                                                ${product.productName}
                                            </h1><!-- End .product-title -->

                                            <div class="ratings-container">
                                                <div class="ratings">
                                                    <div class="ratings-val" style="width: ${product.productRate / 5 * 100}%;"></div>
                                                </div><!-- End .ratings -->
                                                <a class="ratings-text" href="#product-review-link" id="review-link">리뷰 (${reviews.size()}건)</a>
                                            </div><!-- End .rating-container -->

                                            <div id="salesCost" class="product-price">
                                                <!-- 정상가 -->
                                                <c:choose>
                                                    <c:when test="${product.discountRate != 0 }">
                                                        <!-- 할인될 경우 -->
                                                        <del>
                                                            <fmt:formatNumber value="${product.salesCost }" />원
                                                        </del>
                                                        &#8594;
                                                        <span class="discounted-price">
                                                            <fmt:formatNumber value="${product.salesCost * (1 - (product.discountRate / 100))}" />원
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- 할인되지 않을 경우 -->
                                                        <span class="original-price">
                                                            <fmt:formatNumber value="${product.salesCost }" />원
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div><!-- End .product-price -->

                                            <div class="product-content">
                                                <!-- <div class="product-cat"> -->
                                                <div class="product-cat details-row-size">
                                                    <span class="product-cat">원작명</span>
                                                    <span class="product-cat">${product.originalName }</span>
                                                </div>
                                                <div class="product-cat details-row-size">
                                                    <span class="product-cat">제조사</span>
                                                    <span class="product-cat">${product.manufacturerName }</span>
                                                </div>
                                                <div class="product-cat details-row-size">
                                                    <span class="product-cat">재&nbsp;&nbsp;&nbsp;질</span>
                                                    <span class="product-cat">${product.materials }</span>
                                                </div>
                                                <div class="product-cat details-row-size">
                                                    <span class="product-cat">크&nbsp;&nbsp;&nbsp;기</span>
                                                    <span class="product-cat">${product.size }</span>
                                                </div>
                                                <div class="product-cat details-row-size">
                                                    <span class="product-cat">배송비</span>
                                                    <span class="product-cat">3,000원</span>
                                                </div>
                                                <div class="product-cat details-row-size">
                                                    <span>적립금</span>
                                                    <span>
                                                        <c:choose>
                                                            <c:when test="${product.discountRate != 0 }">
                                                                <fmt:formatNumber value="${(product.salesCost * (1 - (product.discountRate / 100)) * 0.01) - ((product.salesCost * (1 - (product.discountRate / 100)) * 0.01)%1) }" />원&nbsp;(1%)
                                                            </c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${(product.salesCost * 0.01) - ((product.salesCost * 0.01) % 1)}" />원&nbsp;(1%)
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                            </div><!-- End .product-content -->

                                            <div class="product-details-action">
                                                <div class="details-action-col">
                                                    <label for="qty">수량:</label>
                                                    <div class="product-details-quantity">
                                                        <!-- 수량 정보 받아와서 정리하는 부분 추가 고민 후 적용 필요 -->
                                                        <c:choose>
                                                            <c:when test="${product.currentQty == 0}">
                                                                품절
                                                            </c:when>
                                                            <c:when test="${product.classNo != 10 && (product.currentQty < 5  && product.currentQty > 0)}">
                                                                <input type="number" id="qty" class="form-control" value="1" min="1" max="${product.currentQty }" step="1" data-decimals="0" onchange="updateTotalPrice()" required>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input type="number" id="qty" class="form-control" value="1" min="1" max="5" step="1" data-decimals="0" onchange="updateTotalPrice()" required>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div><!-- End .product-details-quantity -->

                                                    <div class="d-flex">
                                                        <c:choose>
                                                            <c:when test="${not empty sessionScope.loginCustomer.uuid and not empty productLikeLog and productLikeLog.contains(product.productNo)}">
                                                                <a href="#">
                                                                    <span class="btn-product btn-wishlist like" id=${product.productNo }></span>
                                                                </a>
                                                                <a href="#">
                                                                    <span class="material-symbols-outlined btn-product btn-share">share</span>
                                                                </a>
                                                            </c:when>
                                                            <c:when test="${not empty sessionScope.loginCustomer.uuid and not empty productLikeLog and not productLikeLog.contains(product.productNo)}">
                                                                <a href="#">
                                                                    <span class="btn-product btn-wishlist" id=${product.productNo }></span>
                                                                </a>
                                                                <a href="#">
                                                                    <span class="material-symbols-outlined btn-product btn-share">share</span>
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="#">
                                                                    <span class="btn-product btn-wishlist" id=${product.productNo }></span>
                                                                </a>
                                                                <a href="#">
                                                                    <span class="material-symbols-outlined btn-product btn-share">share</span>
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>

                                                <div class="totalContent product-price details-action-col">
                                                    <c:choose>
                                                        <c:when test="${product.currentQty != 0 }">
                                                            <span class="totalColor">합계&nbsp;</span>
                                                            <span id="totalPrice"></span><!-- 총 합계를 표시할 요소 -->
                                                            <span>원</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span>품절된 상품입니다.</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="details-action-col">
                                                    <div class="details-action-col">
                                                        <c:choose>
                                                            <c:when test="${product.currentQty != 0 }">
                                                                <a href="#" class="btn-product btn-cart icon-shopping-cart border-right-0" onclick="askLogin(${product.productNo})">
                                                                    <span class='toPurchase'>구매하기</span></a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="#" class="btn-product btn-cart icon-shopping-cart border-right-0"><span class='toPurchase'>품절</span></a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <a href="javascript:;" class="btn-product btn-cart" onclick="toCart(${product.productNo}, ${product.currentQty})">
                                                            <span>장바구니</span>
                                                        </a>
                                                    </div>
                                                </div><!-- End details-action-col -->
                                            </div><!-- End .product-details-action -->
                                        </div><!-- End .product-details -->
                                    </div><!-- End .col-md-6 -->
                                </div><!-- End .row -->
                            </div><!-- End .product-details-top -->

                            <div class="product-details-tab">
                                <ul class="nav nav-pills justify-content-center" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="product-desc-link" data-toggle="tab" href="#product-desc-tab" role="tab" aria-controls="product-desc-tab" aria-selected="true">상세보기</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="product-info-link" data-toggle="tab" href="#product-info-tab" role="tab" aria-controls="product-info-tab" aria-selected="false">주의사항</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="product-shipping-link" data-toggle="tab" href="#product-shipping-tab" role="tab" aria-controls="product-shipping-tab" aria-selected="false">상품문의<small>(${qna.size()})</small></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="product-review-link" data-toggle="tab" href="#product-review-tab" role="tab" aria-controls="product-review-tab" aria-selected="false">상품리뷰<small>(${reviews.size()})</small></a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="product-desc-tab" role="tabpanel" aria-labelledby="product-desc-link">
                                        <div class="product-desc-content">
                                            <c:if test="${empty imageList}">
                                                <div class="product-desc-row bg-image" style="background-image: url('${product.thumbnailImg}')">
                                                    <div class="container">
                                                        <div class="row justify-content-end"></div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty imageList}">
                                                <c:forEach var="image" items="${imageList}">
                                                    <c:choose>
                                                        <c:when test="${not empty image.newFilename}">
                                                            <div class="product-desc-row bg-image" style="background-image: url('data:image/${image.imgExt};base64,${image.imgUrl}')">
                                                                <div class="container">
                                                                    <div class="row justify-content-end"></div>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${empty image.imgExt}">
                                                            <div class="product-desc-row bg-image" style="background-image: url('${image.imgUrl}')">
                                                                <div class="container">
                                                                    <div class="row justify-content-end"></div>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                    </c:choose>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="product-info-tab" role="tabpanel" aria-labelledby="product-info-link">
                                        <div class="product-desc-content">
                                            <div class="container">
                                                <img class="cautionImg" src="../../../resources/assets/images/products/details/caution.png" alt="주의사항 이미지" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="product-shipping-tab" role="tabpanel" aria-labelledby="product-shipping-link">
                                        <div class="product-desc-content">
                                            <div class="container">
                                                <span class="qnA_Style">상품 문의</span>
                                                <a href="#qnA-modal" data-toggle="modal">
                                                    <button id="qnA_btn" class="btn btn-outline-primary-2 float-end" data-toggle="modal" aria-haspopup="true" aria-expanded="false">문의하기</button>
                                                </a>
                                                <!-- 문의하기 -->

                                                <main class="main">
                                                    <div class="page-content">
                                                        <div class="container">
                                                            <table id="accordion-5" class="table table-wishlist table-mobile mt-4 mb-auto">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="col-md-1">답변상태</th>
                                                                        <th class="col-md-7">제목</th>
                                                                        <th class="col-md-2">작성자</th>
                                                                        <th class="col-md-2 text-center">작성일</th>
                                                                        <th></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="qnaTbody">
                                                                    <c:forEach var="qa" items="${qna}" varStatus="i">
                                                                        <tr>
                                                                            <td class="product">
                                                                                <h3 class="product-title">
                                                                                    <c:choose>
                                                                                        <c:when test="${empty qa.svBoardAnswer}">
                                                                                            <span>
                                                                                                <span class="total-col"><img width="70" class="reviewImg" src="../../../resources/assets/images/products/details/waiting.png" alt="답변대기 아이콘" /></span>
                                                                                            </span>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <span class="total-col"><img width="70" class="reviewImg" src="../../../resources/assets/images/products/details/answer.png" alt="답변완료 아이콘" /></span>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </h3>
                                                                            </td>
                                                                            <td class="product">
                                                                                <h3 class="product-title w-100">
                                                                                    <a class="collapsed" role="button" data-toggle="collapse" href="#collapse${i.index}" aria-expanded="false" aria-controls="collapse${i.index}">
                                                                                        Q. ${qa.svBoardTitle}
                                                                                    </a>
                                                                                </h3>
                                                                                <div id="collapse${i.index}" class="collapse" aria-labelledby="heading${i.index}" data-parent="#accordion-5">
                                                                                    <div class="card-body">
                                                                                        <a href="#">${qa.svBoardContent}</a>
                                                                                    </div>
                                                                                    <c:if test="${qa.svBoardAnswer != null }">
                                                                                        <%-- <div> ㄴ ${qa.svBoardAnswer}</div> --%>
                                                                                        <div class="answer-style">
                                                                                            <!-- 답변내용 이미지 -->
                                                                                            <img width="70" class="reviewImg" src="../../../resources/assets/images/products/details/answer.png" alt="답변완료 아이콘" />
                                                                                            ${qa.svBoardAnswer}
                                                                                        </div>
                                                                                    </c:if>
                                                                                </div>
                                                                            </td> <!-- 문의 제목 -->
                                                                            <td class="product">
																				<ul class="contact-list">
																					<li class="d-flex ps-0">
					                                                                    <!-- 리뷰 작성한 유저 이미지 -->
					                                                                   <c:choose>
						                                                                   <c:when test ="${qa.userImg != null}">
						    	                                                               <img width="30" class="reviewImg" src="${qa.userImg }" alt="유저 이미지" />
						                                                                   </c:when>
						                                                                   <c:otherwise>
							                                                                   <img width="30" class="reviewImg" src="../../../resources/assets/images/products/details/test.png" alt="유저 이미지" />
						                                                                   </c:otherwise>
					                                                                   </c:choose>
					                                                                   <span class="product-title user-style">
		                                                                                    <a href="#">${qa.nickname}</a>
		                                                                                </span>
				                                                                   </li>
				                                                                </ul>
                                                                            </td>
                                                                            <td class="stock-col text-center">
                                                                                <span class="product-title qna-regidate">${qa.svBoardRegiDate}</span>
                                                                            </td> <!-- 문의 작성일 -->
                                                                            <td class="remove-col">
                                                                            <c:if test="${loginCustomer.uuid == qa.uuid }">
                                                                                <button class="btn-remove" onclick ="delPdQnA(${qa.svBoardNo});">
                                                                                    <i class="icon-close"></i>
                                                                                </button>
                                                                            </c:if>
                                                                            </td> <!-- 문의 삭제 -->
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table><!-- End table -->
                                                        </div><!-- End .container -->
                                                    </div><!-- End .page-content -->
                                                </main><!-- End .main -->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="product-review-tab" role="tabpanel" aria-labelledby="product-review-link">
                                        <div class="reviews">
                                            <div class="container">
                                                <h3>상품리뷰(${reviews.size() })</h3>
                                                <c:forEach var="review" items="${reviews}">
                                                    <div class="review">
                                                        <div class="row no-gutters">
                                                            <div class="reviewImages" style="display : flex;">
                                                                <c:forEach var="reviewImg" items="${review.reviewImages }">
	                                                               	<img src="${reviewImg.base64}" style="width : 100px;"/>
                                                                </c:forEach>
                                                            </div>                                                        
                                                            <div class="col-auto">
                                                                <p>
                                                                    <!-- 리뷰 작성한 유저 이미지 -->
                                                                   <!-- <img width="30" class="reviewImg" src="../../../resources/assets/images/products/details/basic.png" alt="유저 이미지" /> -->
                                                                   <c:choose>
	                                                                   <c:when test ="${review.userImg != null}">
	    	                                                               <img width="30" class="reviewImg" src="${review.userImg }" alt="유저 이미지" />
	                                                                   </c:when>
	                                                                   <c:otherwise>
		                                                                   <img width="30" class="reviewImg" src="../../../resources/assets/images/products/details/test.png" alt="유저 이미지" />
	                                                                   </c:otherwise>
                                                                   </c:choose>
                                                                </p>
                                                            </div>
                                                            <div class="col-auto">
                                                                <h4 class="review-userImg">
                                                                    <!-- 유저 닉네임 -->
                                                                    <a href="#">${review.nickname }</a>
                                                                </h4>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="ratings-container">
                                                                    <!-- 리뷰 별점 -->
                                                                    <div class="ratings">
                                                                        <div class="ratings-val" style="width: ${review.reviewStar / 5 * 100}%;"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-auto">
                                                                <span class="review-date">${review.reviewDate }</span> <!-- 리뷰 작성일 -->
                                                            </div>

                                                        </div>
                                                        <div class="col review-style">
                                                            <!-- 리뷰 내용 -->
                                                            <div class="review-content">
                                                                <p>${review.reviewContent}</p>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- End .tab-content -->
                            </div><!-- End .product-details-tab -->
                            <h2 class="title text-center mb-4">추천 상품</h2><!-- End .title text-center -->
                            <div class="owl-carousel owl-simple carousel-equal-height carousel-with-shadow" data-toggle="owl" data-owl-options='{
                                   "nav": false, 
                                   "dots": true,
                                   "margin": 20,
                                   "loop": false,
                                   "responsive": {
                                       "0": {
                                           "items":1
                                       },
                                       "480": {
                                           "items":2
                                       },
                                       "768": {
                                           "items":3
                                       },
                                       "992": {
                                           "items":4
                                       },
                                       "1200": {
                                           "items":4,
                                           "nav": true,
                                           "dots": false
                                       }
                                   }
                               }'>
                                <c:forEach var="mdProduct" items="${mdProductList }">
                                    <div class="product product-7 text-center">
                                        <figure class="product-media">
                                            <c:if test="${mdProduct.regDate > before14 }">
                                                <span class="product-label label-new">New</span>
                                            </c:if>
                                            <c:if test="${mdProduct.discountRate != 0 }">
                                                <span class="product-label label-sale">${mdProduct.discountRate }% 할인</span>
                                            </c:if>
                                            <c:if test="${mdProduct.currentQty == 0 }">
                                                <span class="product-label label-out">품절</span>
                                            </c:if>
                                            <c:if test="${mdProduct.isRecommend == 'Y' }">
                                                <span class="product-label label-top">MD 추천</span>
                                            </c:if>
                                            <a href="productDetail?productNo=${mdProduct.productNo }">
                                                <img src="${mdProduct.thumbnailImg }" alt="Product image" class="product-image">
                                            </a>
                                            <div class="product-action-vertical">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.loginCustomer.uuid and not empty productLikeLog and productLikeLog.contains(product.productNo)}">
                                                        <span class="btn-product-icon btn-wishlist btn-expandable like" id="${product.productNo }">
                                                            <span>찜</span>
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${not empty sessionScope.loginCustomer.uuid and not empty productLikeLog and not productLikeLog.contains(product.productNo)}">
                                                        <span class="btn-product-icon btn-wishlist btn-expandable" id="${product.productNo }">
                                                            <span>찜</span>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="btn-product-icon btn-wishlist btn-expandable" id="${product.productNo }">
                                                            <span>찜</span>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div><!-- End .product-action-vertical -->
                                            <div class="product-action action-icon-top">
                                                <c:choose>
                                                    <c:when test="${mdProduct.currentQty == 0 }">
                                                        <a class="btn-product btn-cart icon-shopping-cart">
                                                            <span class="sold-out">품절</span>
                                                        </a>
                                                        <a href="javascript:;" class="btn-product btn-cart" onclick="toCart(${product.productNo })">
                                                            <span>장바구니</span>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>

                                                        <a href="#" class="btn-product btn-cart icon-shopping-cart" onclick="askLogin(${mdProduct.productNo })">
                                                            <span>구매하기</span>
                                                        </a>

                                                        <a href="javascript:;" class="btn-product btn-cart" onclick="toCart(${mdProduct.productNo })">
                                                            <span>장바구니</span>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </figure><!-- End .product-media -->
                                        <div class="product-body">
                                            <div class="product-cat">
                                                <a href="#">${mdProduct.originalName }</a>
                                            </div><!-- End .product-cat -->
                                            <h3 class="product-title">
                                                < ${mdProduct.classType }> ${mdProduct.classMonth }
                                                    <br>
                                                    <a href="productDetail?productNo=${mdProduct.productNo }">${mdProduct.productName }</a>
                                            </h3>
                                            <div class="product-price">
                                                <c:choose>
                                                    <c:when test="${mdProduct.discountRate != 0 }">
                                                        <!-- 할인될 경우 -->
                                                        <del>
                                                            <fmt:formatNumber value="${mdProduct.salesCost }" />원
                                                        </del> &#8594;
                                                        <fmt:formatNumber value="${mdProduct.salesCost * (1 - (mdProduct.discountRate / 100))}" />원
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- 정상가일 경우 -->
                                                        <fmt:formatNumber value="${mdProduct.salesCost }" />원
                                                    </c:otherwise>
                                                </c:choose>
                                            </div><!-- End .product-price -->
                                            <div class="ratings-container">
                                                <div class="ratings">
                                                    <div class="ratings-val" style="width: ${mdProduct.productRate / 5 * 100}%;"></div><!-- End .ratings-val -->
                                                </div>
                                            </div>
                                        </div><!-- End .product-body -->
                                    </div><!-- End .product -->
                                </c:forEach>
                            </div><!-- End .owl-carousel -->
                        </div><!-- End .col-lg-9 -->
                    </div><!-- End .row -->
                </div><!-- End .container -->
            </div><!-- End .page-content -->
        </main><!-- End .main -->

        <!-- footer -->
        <jsp:include page="../footer.jsp"></jsp:include>

    </div><!-- End .page-wrapper -->

    <!-- 문의 등록 모달 -->
    <div class="modal fade" id="qnA-modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close"></i></span>
                    </button>

                    <div class="form-box notosanskr">
                        <div class="form-tab">
                            <ul class="nav nav-pills nav-fill" role="">
                                <li class="">
                                    <a class="nav-link" id="" data-toggle="" href="" role="" aria-controls="" aria-selected="">문의 작성</a>
                                </li>
                            </ul>
                            <div class="tab-content" id="tab-content-5">
                                <div class="tab-pane fade show active" id="qna" role="" aria-labelledby="qna">
                                    <div>
                                        <div class="form-group product-content">
                                            <div class="float-start w-25">
                                                <img id="qna-img" src="${product.thumbnailImg}" alt="product image" />
                                            </div>
                                            <div class="product-name">
                                                <p class="qnA-originalName">${product.originalName}</p>
                                                <p class="qnA-productName">${product.productName}</p>
                                            </div>
                                        </div>

                                        <div class="form-group clearboth">
                                            <label for="qna-userName">작성자</label>
                                            <input type="text" class="form-control" id="qna-userName" name="qna-userName" placeholder="작성자 이름" value="${loginCustomer.nickname}" disabled>
                                            <input type="hidden" id="qna-uuid" value="${sessionScope.loginCustomer.uuid}">
                                        </div><!-- End .form-group -->

                                        <div class="form-group clearboth">
                                            <label for="qna-title">문의 제목</label>
                                            <input type="text" class="form-control" id="qna-title" name="qna-title" placeholder="문의 제목" maxlength="30">
                                        </div><!-- End .form-group -->

                                        <div class="form-group">
                                            <label for="qna-textarea">문의 내용</label><br>
                                            <textarea id="qna-textarea" name="qna-textarea" cols="30" rows="5" placeholder="문의 내용을 입력하세요." maxlength="300"></textarea>
                                            <!-- <input type="password" class="form-control" id="qna-content" name="qna-content" > -->
                                        </div><!-- End .form-group -->

                                        <div class="form-footer">
                                            <button type="button" class="btn btn-primary btn-rounded" onclick="qna_input();">등록하기</button>
                                            <!-- <button type="submit" class="btn btn-outline-primary-2"> -->
                                            <button type="button" class="btn btn-outline-primary-2" data-dismiss="modal" aria-label="Close">취소하기</button>
                                        </div><!-- End .form-footer -->
                                    </div>
                                </div><!-- .End .tab-pane -->
                            </div><!-- End .tab-content -->
                        </div><!-- End .form-tab -->
                    </div><!-- End .form-box -->
                </div><!-- End .modal-body -->
            </div><!-- End .modal-content -->
        </div><!-- End .modal-dialog -->
    </div><!-- End .modal -->
    <!-- 문의 등록 모달 끝 -->
    <!-- 회원 비회원 구매 여부 문의 모달 시작-->
    <div class="modal fade" id="order-modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" style="width: 450px;">
            <div class="modal-content modal-style">
                <div class="modal-body modalStyle" style="text-align: center; padding : 0px 15px 15px 15px;">
                    <span style="font-size: 15px;">비회원으로 구입하시겠습니까?</span>
                </div>
                <div style="text-align:center;">
                    <button class="btn btn-outline-primary-2 btn-order btn-block memberBtn" id="" style="margin:0px 5px 15px 0px; width: 150px;" data-dismiss="modal" aria-label="Close" onclick="toPurchase(this.id)">비회원 구매</button>
                    <button class="btn btn-outline-primary-2 btn-order btn-block nonMemberBtn" id="" style="margin:0px 0px 15px 5px; width: 150px;" data-dismiss="modal" aria-label="Close" onclick="toLogin(this.id)">로그인</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 회원 비회원 구매 여부 문의 모달 끝-->
	<!-- 장바구니 모달 시작 -->
	<div class="modal fade" id="cart-modal" tabindex="-1" role="dialog" aria-hidden="true" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
				<div class="modal-body modalStyle" style="text-align: center; padding : 0px 15px 15px 15px;">
					<span style="font-size: 15px;">상품이 장바구니에 담겼습니다!</span>
				</div>
				<div style="text-align:center;">
					<button class="btn btn-outline-primary-2 btn-order btn-block okBtn" id="" style="margin:0px 5px 15px 0px; width: 150px;" data-dismiss="modal" aria-label="Close" >확인</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 장바구니 모달 시작 -->
    <!-- 문의하기 제목 글자 수 팝업 -->
    <div id="qna-popup-title" class="popup" style="display: none;">
        입력된 글자 수가 최대 제한을 초과하였습니다. 최대 30자까지 입력 가능합니다.
    </div>

    <!-- 문의하기 내용 글자 수 팝업 -->
    <div id="qna-popup-content" class="popup" style="display: none;">
        <!-- 문의 내용은 300자를 초과할 수 없습니다. -->
        입력된 글자 수가 최대 제한을 초과하였습니다. 최대 300자까지 입력 가능합니다.
    </div>

    <!-- 최상단으로 이동 -->
    <button id="scroll-top" title="Back to Top">
        <i class="icon-arrow-up"></i>
    </button>

    <script src="/resources/js/product/product-detail.js"></script>
    <script type="text/javascript">
        let uuid = '${sessionScope.loginCustomer.uuid}';
        let productNo = '${product.productNo}';

        // 카카오 공유하기

        Kakao.Share.createDefaultButton({
            container: '.material-symbols-outlined',
            objectType: 'feed',
            content: {
                title: '${product.productName}',
                description: '#다사쟈규 #피규어 #' + '${product.originalName}',
                imageUrl: '${product.thumbnailImg }',
                link: {
                    // [내 애플리케이션] > [플랫폼] 에서 등록한 사이트 도메인과 일치해야 함
                    mobileWebUrl: "http://goott351.cafe24.com/product/productDetail?productNo=" + productNo,
                    webUrl: "http://goott351.cafe24.com/product/productDetail?productNo=" + productNo,
                },
            },
            buttons: [{
                    title: '웹으로 보기',
                    link: {
                        mobileWebUrl: "http://goott351.cafe24.com/product/productDetail?productNo=" + productNo,
                        webUrl: "http://goott351.cafe24.com/product/productDetail?productNo=" + productNo ,
                    },
                },
                {
                    title: '앱으로 보기',
                    link: {
                        mobileWebUrl: "http://goott351.cafe24.com/product/productDetail?productNo=" + productNo,
                        webUrl: "http://goott351.cafe24.com/product/productDetail?productNo=" + productNo,
                    },
                },
            ],
        });

        // 리뷰 작성일 - 를 . 으로 변환

        // HTML 요소에 접근하여 텍스트를 가져옵니다.
        let reviewDateElements = document.querySelectorAll('.review-date');
        let qnaDateElements = document.querySelectorAll('.qna-regidate');

        // NodeList를 배열로 변환합니다.
        let reviewElementsArray = Array.from(reviewDateElements);
        let qnaElementsArray = Array.from(qnaDateElements);

        // 변환된 배열을 반복하며 각 요소의 텍스트를 변경합니다.
        reviewElementsArray.forEach(element => {
            let reviewDate = element.innerText;

            // '-'를 '.'로 변경합니다.
            let modifiedReviewDate = reviewDate.replace(/-/g, '.');

            // 변경된 텍스트를 HTML 요소에 새로운 값으로 설정합니다.
            element.innerText = modifiedReviewDate;
        });

        qnaElementsArray.forEach(element => {
            let qnaDate = element.innerText;

            // '-'를 '.'로 변경합니다.
            let modifiedQnaDate = qnaDate.replace(/-/g, '.');

            // 변경된 텍스트를 HTML 요소에 새로운 값으로 설정합니다.
            element.innerText = modifiedQnaDate;
        });
        
        $(function() {
        	 // 모달을 감추는 함수
            function hideModal() {
                $('#qnA-modal').modal('hide');
            }

            // 모달이 숨겨질 때 발생하는 이벤트 핸들러
            $('#qnA-modal').on('hidden.bs.modal', function (e) {
                // 모달이 닫히면 뒤로가기 이벤트 리스너를 제거합니다.
                window.removeEventListener('popstate', hideModal);
            });

            // 뒤로가기 버튼을 클릭하면 실행되는 이벤트 핸들러
            window.onpopstate = function(event) {
                // 모달을 닫습니다.
                hideModal();
            };

            // 뒤로가기 이벤트 리스너 등록
            window.addEventListener('popstate', hideModal);
            
        });
        
    </script>

</body>

</html>