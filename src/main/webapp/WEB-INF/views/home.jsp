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
    <title>다사자규</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
    
    <meta name="keywords" content="HTML5 Template" />
    <meta name="description" content="FigureShop" />
    <meta name="author" content="p-themes" />
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include> <!-- header 파일 인클루드 -->
	<div id="homeJsp" class="container mainFontStyle">
            <div class="intro-slider-container">
                <div class="owl-carousel owl-simple owl-light owl-nav-inside" data-toggle="owl" data-owl-options='{"nav": false}'>
                	<!-- 첫번째 슬라이드 -->
                	<a href="/product/searchList?classNo=&searchCata=manufacturerName&searchWord=굿스마일컴퍼니">
                		<span class="intro-slide container intro-content mainSliderImg1"></span>
                    </a>
                
                	<!-- 두번째 슬라이드 -->
                	<a href="/product/searchList?classNo=&searchCata=manufacturerName&searchWord=굿스마일컴퍼니">
                		<span class="intro-slide container intro-content mainSliderImg2"></span>
                    </a>
                    
                    <!-- 세번째 슬라이드 -->
                    <a href="product/productDetail?productNo=55733">
	                    <span class="intro-slide mainSliderImg3"></span>           	
					</a>
					
					<!-- 네번째 슬라이드 -->
                    <a href="product/productDetail?productNo=55732">
                    	<span class="intro-slide container intro-content mainSliderImg4" style="">
                    	</span><!-- End .intro-slide -->
                    </a>
                </div><!-- End .owl-carousel owl-simple -->
                <span class="slider-loader text-white"></span><!-- End .slider-loader -->
            </div><!-- End .intro-slider-container -->

		  <!-- 브랜드사 제품 바로가기 -->
            <div class="brands-border owl-carousel owl-simple" data-toggle="owl" 
                data-owl-options='{
                    "nav": false, 
                    "dots": false,
                    "margin": 0,
                    "loop": false,
                    "responsive": {
                        "0": {
                            "items":2
                        },
                        "420": {
                            "items":3
                        },
                        "600": {
                            "items":4
                        },
                        "900": {
                            "items":5
                        },
                        "1024": {
                            "items":6
                        },
                        "1360": {
                            "items":7
                        }
                    }
                }'>
                <a href="/product/searchList?searchCata=manufacturerName&searchWord=반프레스토" class="brand">
                    <img src="/resources/productImg/banpresto.png" alt="반프레스토">
                </a>

                <a href="/product/searchList?searchCata=manufacturerName&searchWord=굿스마일컴퍼니" class="brand">
                    <img src="/resources/productImg/goodsmile.png" alt="굿스마일">
                </a>

                <a href="/product/searchList?searchCata=manufacturerName&searchWord=세가" class="brand">
                    <img src="/resources/productImg/sega.png" alt="세가">
                </a>

                <a href="/product/searchList?searchCata=manufacturerName&searchWord=후류" class="brand">
                    <img src="/resources/productImg/furyu.png" alt="후류">
                </a>

                <a href="/product/searchList?searchCata=manufacturerName&searchWord=메가하우스" class="brand">
                    <img src="/resources/productImg/megahouse.png" alt="메가하우스">
                </a>

                <a href="/product/searchList?searchCata=manufacturerName&searchWord=반다이스피릿" class="brand">
                    <img src="/resources/productImg/bandai.png" alt="반다이스피릿">
                </a>

                <a href="/product/searchList?searchCata=manufacturerName&searchWord=맥스팩토리" class="brand">
                    <img src="/resources/productImg/maxFactory.png" alt="맥스팩토리">
                </a>
            </div><!-- End .owl-carousel -->
            
            <div class="container mt-5 mb-5">
                <ul class="nav nav-pills nav-border-anim nav-big justify-content-center mb-3" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="products-featured-link" data-toggle="tab" href="#products-featured-tab" role="tab" aria-controls="products-featured-tab" aria-selected="true"># 마감임박! 종료예정 예약상품⏰</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="products-sale-link" data-toggle="tab" href="#products-sale-tab" role="tab" aria-controls="products-sale-tab" aria-selected="false"># 시선집중! NEW 상품🔥</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="products-top-link" data-toggle="tab" href="#products-top-tab" role="tab" aria-controls="products-top-tab" aria-selected="false"># 다팔자규 MD PICK!📌</a>
                    </li>
                </ul>
            </div><!-- End .container -->
            
            <!-- 메인페이지 예약상품/신상품/추천상품 -->
            <div class="container-fluid">
                <div class="tab-content tab-content-carousel">
                	<!-- 예약상품 탭 -->
                    <div class="tab-pane p-0 fade show active" id="products-featured-tab" role="tabpanel" aria-labelledby="products-featured-link">
                        <div class="owl-carousel owl-simple carousel-equal-height carousel-with-shadow" data-toggle="owl" 
                            data-owl-options='{
                                "nav": false, 
                                "dots": true,
                                "margin": 20,
                                "loop": false,
                                "responsive": {
                                    "0": {
                                        "items":2
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
                                        "items":5
                                    },
                                    "1600": {
                                        "items":6,
                                        "nav": true
                                    }
                                }
                            }'>
							
							<!-- 상품 이미지 없을 때 -->
							<c:if test="${empty revProductListRand}">
								<img class="nullImg" alt="해당 상품이 없습니다." src="/resources/assets/images/null.png" >
							</c:if>
							
							<!-- 예약 상품 슬라이드 -->
							 <c:forEach var="product" items="${revProductListRand}" begin="1" end="20">
	                            <div class="product product-11 text-center">
	                                <figure class="product-media">
	                                	<a href="/product/productDetail?productNo=${product.productNo }">
											<img src="${product.thumbnailImg }" alt="Product image" class="product-image">
										</a>
	
	                                    <div class="product-action-vertical">
	                                        <span class="btn-product-icon btn-wishlist" id="{product.productNo}"><span>찜하기</span></span>
	                                    </div><!-- End .product-action-vertical -->
	                                </figure><!-- End .product-media -->
	
	                                <div class="product-body">
	                                    <h3 class="product-title">
	                                    	<a href="javascript:;">${product.originalName}</a>
	                                    </h3><!-- End .product-title -->
	                                    <h3 class="product-title">
	                                    	<a href="/product/productDetail?productNo=${product.productNo }">${product.productName}</a>
	                                    </h3><!-- End .product-title -->
	                                    <div class="product-price">
                                        	<c:choose>
	                                    		<c:when test="${product.discountRate != 0 }">
			                                        <span class="new-price">
			                                        	<fmt:formatNumber value="${product.salesCost * (1 - (product.discountRate / 100))}"/>원 
			                                        </span>
			                                        <span class="old-price">
				                                        <fmt:formatNumber value="${product.salesCost }"/>원
			                                        </span>
	                                        	</c:when>
	                                        	<c:otherwise>
			                                        <span class="new-price">
			                                        	<fmt:formatNumber value="${product.salesCost}"/>원 
			                                        </span>
	                                        	</c:otherwise>
	                                        </c:choose>
	                                    </div><!-- End .product-price -->
	                                </div><!-- End .product-body -->
	                                <div class="product-action">
	                                    <a href="javascript:;" class="btn-product btn-cart" onclick="toCart(${product.productNo }, ${product.currentQty })"><span>장바구니</span></a>
	                                </div><!-- End .product-action -->
	                            </div><!-- End .product -->
                            </c:forEach>
                        </div><!-- End .owl-carousel -->
                    </div><!-- .End .tab-pane -->
                    
                    <!-- 신상품 탭 -->
                    <div class="tab-pane p-0 fade" id="products-sale-tab" role="tabpanel" aria-labelledby="products-sale-link">
                        <div class="owl-carousel owl-simple carousel-equal-height carousel-with-shadow" data-toggle="owl" 
                            data-owl-options='{
                                "nav": false, 
                                "dots": true,
                                "margin": 20,
                                "loop": false,
                                "responsive": {
                                    "0": {
                                        "items":2
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
                                        "items":5
                                    },
                                    "1600": {
                                        "items":6,
                                        "nav": true
                                    }
                                }
                            }'>
                            <!-- 상품 이미지 없을 때 -->
							<c:if test="${empty newProductListRand}">
								<img class="nullImg" alt="해당 상품이 없습니다." src="/resources/assets/images/null.png" >
							</c:if>
							<!-- 예약 상품 슬라이드 -->
							 <c:forEach var="product" items="${newProductListRand}" begin="1" end="20">
	                            <div class="product product-11 text-center">
	                                <figure class="product-media">
	                                	<a href="/product/productDetail?productNo=${product.productNo }">
											<img src="${product.thumbnailImg }" alt="Product image" class="product-image">
										</a>
	
	                                    <div class="product-action-vertical">
	                                        <a href="#" class="btn-product-icon btn-wishlist" id="{product.productNo}"><span>찜하기</span></a>
	                                    </div><!-- End .product-action-vertical -->
	                                </figure><!-- End .product-media -->
	
	                                <div class="product-body">
   	                                    <h3 class="product-title">
	                                    	<a href="javascript:;">${product.originalName}</a>
	                                    </h3><!-- End .product-title -->
	                                    <h3 class="product-title">
	                                    	<a href="/product/productDetail?productNo=${product.productNo }">${product.productName}</a>
	                                    </h3><!-- End .product-title -->
	                                    <div class="product-price">
                                        	<c:choose>
	                                    		<c:when test="${product.discountRate != 0 }">
			                                        <span class="new-price">
			                                        	<fmt:formatNumber value="${product.salesCost * (1 - (product.discountRate / 100))}"/>원 
			                                        </span>
			                                        <span class="old-price">
				                                        <fmt:formatNumber value="${product.salesCost }"/>원
			                                        </span>
	                                        	</c:when>
	                                        	<c:otherwise>
			                                        <span class="new-price">
			                                        	<fmt:formatNumber value="${product.salesCost}"/>원 
			                                        </span>
	                                        	</c:otherwise>
	                                        </c:choose>
	                                    </div><!-- End .product-price -->
	                                </div><!-- End .product-body -->
	                                <div class="product-action">
	                                    <a href="javascript:;" class="btn-product btn-cart" onclick="toCart(${product.productNo }, ${product.currentQty })"><span>장바구니</span></a>
	                                </div><!-- End .product-action -->
	                            </div><!-- End .product -->
                            </c:forEach>
                        </div><!-- End .owl-carousel -->
                    </div><!-- .End .tab-pane -->
                    
                    <!-- 추천 상품 탭 -->
                    <div class="tab-pane p-0 fade" id="products-top-tab" role="tabpanel" aria-labelledby="products-top-link">
                        <div class="owl-carousel owl-simple carousel-equal-height carousel-with-shadow" data-toggle="owl" 
                            data-owl-options='{
                                "nav": false, 
                                "dots": true,
                                "margin": 20,
                                "loop": false,
                                "responsive": {
                                    "0": {
                                        "items":2
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
                                        "items":5
                                    },
                                    "1600": {
                                        "items":6,
                                        "nav": true
                                    }
                                }
                            }'>
                         	<!-- 상품 이미지 없을 때 -->
							<c:if test="${empty mdProductListRand}">
								<img class="nullImg" alt="해당 상품이 없습니다." src="/resources/assets/images/null.png" >
							</c:if>
							<!-- 추천 상품 슬라이드 -->
							 <c:forEach var="product" items="${mdProductListRand}" begin="1" end="20">
	                            <div class="product product-11 text-center">
	                                <figure class="product-media">
	                                	<a href="/product/productDetail?productNo=${product.productNo }">
											<img src="${product.thumbnailImg }" alt="Product image" class="product-image">
										</a>
	
	                                    <div class="product-action-vertical">
	                                        <a href="#" class="btn-product-icon btn-wishlist" id="{product.productNo}"><span>찜하기</span></a>
	                                    </div><!-- End .product-action-vertical -->
	                                </figure><!-- End .product-media -->
	
	                                <div class="product-body">
										<h3 class="product-title">
	                                    	<a href="javascript:;">${product.originalName}</a>
	                                    </h3><!-- End .product-title -->
	                                    <h3 class="product-title">
	                                    	<a href="/product/productDetail?productNo=${product.productNo }">${product.productName}</a>
	                                    </h3><!-- End .product-title -->
	                                    <div class="product-price">
                                        	<c:choose>
	                                    		<c:when test="${product.discountRate != 0 }">
			                                        <span class="new-price">
			                                        	<fmt:formatNumber value="${product.salesCost * (1 - (product.discountRate / 100))}"/>원 
			                                        </span>
			                                        <span class="old-price">
				                                        <fmt:formatNumber value="${product.salesCost }"/>원
			                                        </span>
	                                        	</c:when>
	                                        	<c:otherwise>
			                                        <span class="new-price">
			                                        	<fmt:formatNumber value="${product.salesCost}"/>원 
			                                        </span>
	                                        	</c:otherwise>
	                                        </c:choose>
	                                    </div><!-- End .product-price -->
	                                </div><!-- End .product-body -->
	                                <div class="product-action">
	                                    <a href="javascript:;" class="btn-product btn-cart" onclick="toCart(${product.productNo }, ${product.currentQty })"><span>장바구니</span></a>
	                                </div><!-- End .product-action -->
	                            </div><!-- End .product -->
                            </c:forEach>
                        </div><!-- End .owl-carousel -->
                    </div><!-- .End .tab-pane -->
                </div><!-- End .tab-content -->
            </div><!-- End .container-fluid -->
            
            <div class="mb-5"></div><!-- End .mb-5 -->

			<!-- 예약상품 카운트 다운 -->
            <div class="deal-container pt-5 pb-3 mb-5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-9">
                        	<!-- 예약 상품 카운트 다운 -->
                            <div class="deal">
                                <div class="deal-content">
                                    <h4>${resPro.originalName }</h4>
                                    <h2>${resPro.productName }</h2>
                                    <h3 class="product-title">
                                    	<a href="/product/productDetail?productNo=${resPro.productNo }">
	                                    	${resPro.classMonth }
                                    	</a>
                                    </h3><!-- End .product-title -->
                                    <div class="product-price">
                                    	<c:choose>
                                    		<c:when test="${resPro.discountRate != 0 }">
		                                        <span class="new-price">
		                                        	<fmt:formatNumber value="${resPro.salesCost * (1 - (resPro.discountRate / 100))}"/>원 
		                                        </span>
		                                        <span class="old-price">
			                                        <fmt:formatNumber value="${resPro.salesCost }"/>원
		                                        </span>
                                        	</c:when>
                                        	<c:otherwise>
		                                        <span class="new-price">
		                                        	<fmt:formatNumber value="${resPro.salesCost}"/>원 
		                                        </span>
                                        	</c:otherwise>
                                        </c:choose>
                                    </div><!-- End .product-price -->
                                    <div class="deal-countdown" data-until=""></div><!-- End .deal-countdown -->
                                    <a href="javascript:;" class="btn btn-primary w-100" onclick="askLogin(${resPro.productNo});">
                                        <span>구매하기</span>
                                    </a>
                                </div><!-- End .deal-content -->
                                <div class="deal-image">
                                    <a href="/product/productDetail?productNo=${resPro.productNo }">
                                        <img src="${resPro.thumbnailImg }" alt="Product image" class="product-image">
                                    </a>
                                </div><!-- End .deal-image -->
                            </div><!-- End .deal -->
                        </div><!-- End .col-lg-9 -->
						<!-- 베스트 상품 -->
                        <div class="col-lg-3">
                            <div class="banner banner-overlay banner-overlay-light text-center d-none d-lg-block">
                                <a href="/product/productDetail?productNo=${bestProduct.productNo }">
									<img src="${bestProduct.thumbnailImg }" alt="베스트상품 이미지" class="product-image">
									<!-- <img class="nullImg" alt="해당 상품이 없습니다." src="/resources/assets/images/test.jpg" > -->
								</a>
                               	<c:if test="${empty bestProduct}">
									<img class="nullImg" alt="해당 상품이 없습니다." src="/resources/assets/images/null.png" >
								</c:if>
								<!--  베스트 상품 출력 부분 -->
                                <div class="banner-content banner-content-top banner-content-center">
                                    <h4 class="banner-subtitle">베스트 상품</h4><!-- End .banner-subtitle -->
                                    <c:if test="${bestProduct.currentQty == 0 }">
										<span class="product-label label-out">품절</span>
									</c:if>
                                    <h3 class="banner-title">${bestProduct.productName}</h3><!-- End .banner-title -->
                                    <div class="banner-text text-primary">
                                    	<c:choose>
                                    		<c:when test="${bestProduct.discountRate != 0 }">
		                                        <span class="new-price">
		                                        	<fmt:formatNumber value="${bestProduct.salesCost * (1 - (bestProduct.discountRate / 100))}"/>원 
		                                        </span>
		                                        <span class="old-price">
			                                        <fmt:formatNumber value="${bestProduct.salesCost }"/>원
		                                        </span>
                                        	</c:when>
                                        	<c:otherwise>
		                                        <span class="new-price">
		                                        	<fmt:formatNumber value="${bestProduct.salesCost}"/>원 
		                                        </span>
                                        	</c:otherwise>
                                        </c:choose>
                                    </div><!-- End .banner-text -->
                                    <a href="/product/viewBESTList" class="btn btn-outline-gray banner-link">바로가기<i class="icon-long-arrow-right"></i></a>
                                </div><!-- End .banner-content -->
                                
                            </div><!-- End .banner -->
                        </div><!-- End .col-lg-3 -->
                    </div><!-- End .row -->
                </div><!-- End .container -->
            </div><!-- End .bg-light -->
            

            <!-- <div class="mb-6"></div>End .mb-6 -->
	   		<div class="modal fade" id="order-modal" tabindex="-1" role="dialog" aria-hidden="true" >
				<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
					<div class="modal-content">
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

   	<script src="/resources/js/product/product-user.js"></script>	
    <script type="text/javascript">
		let uuid = '${sessionScope.loginCustomer.uuid}';
	</script>         
            
            <script type="text/javascript">
            	let now = new Date();
            	console.log(now);
            	
           		let classMonth = '${resPro.classMonth}';
           		
           		let tmpYear = parseInt(classMonth.split("-")[0]);
           		let tmpMonth = parseInt(classMonth.split("-")[1]) - 1;
           		let tmpDate = 1;
           		let tmpHours = 0;
           		let tmpMinutes = 0;
           		let tmpSeconds = 0;
           		
           		let tmpTime = new Date(tmpYear, tmpMonth, tmpDate, tmpHours, tmpMinutes, tmpSeconds);
           		console.log(tmpTime);
           		
            	// 두 날짜 사이의 시간 차이를 milliseconds로 계산
            	let timeDifference = tmpTime.getTime() - now.getTime();

            	// 시간 차이를 연, 월, 일, 시, 분, 초 단위로 변환
            	let diffYear = Math.floor(timeDifference / (1000 * 60 * 60 * 24 * 365));
            	let diffMonth = Math.floor((timeDifference % (1000 * 60 * 60 * 24 * 365)) / (1000 * 60 * 60 * 24 * 30));
            	let diffDate = Math.floor((timeDifference % (1000 * 60 * 60 * 24 * 30)) / (1000 * 60 * 60 * 24)) - 1;
            	let diffHours = Math.floor((timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            	let diffMinutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
            	let diffSeconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

            	
            	let result = "+" + diffYear + "y" + (diffMonth) + "o" + diffDate + "d" + diffHours + "h" + diffMinutes + "m" + diffSeconds + "s";
           		
				$(".deal-countdown").eq(0).attr("data-until", result);            		
            </script>
            
	</div>
	<jsp:include page="footer.jsp"></jsp:include> <!-- footer 파일 인클루드 -->

</body>
</html>