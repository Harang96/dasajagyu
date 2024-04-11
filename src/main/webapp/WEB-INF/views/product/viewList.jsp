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
	<title>상품 목록</title>
	<meta name="keywords" content="HTML5 Template">
	<meta name="description" content="FigureShop">
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
	<style type="text/css">	
		.nullImg {
			width : fit-content !important;
			margin : 0 auto;
		}
	</style>
	<c:set var="pageNo" value="${empty param.pageNo ? 1 : param.pageNo}" />
	
</head>
<body>
	<div id="viewList" class="page-wrapper">
		<!-- header -->
		<jsp:include page="../header.jsp"></jsp:include>
		
		<!-- 상품 출력 -->
		<main class="main category-list">
			<div class="page-content">
				<div class="container-fluid">
					<div class="toolbox">
						<div class="toolbox-left">
		                    <ol class="breadcrumb">
         		                <li class="breadcrumb-item"><a href="/">홈</a></li>
                		        <li class="breadcrumb-item active" aria-current="page">상품</li>
                		        <c:choose>
	                		        <c:when test="${classNo == 10}">
	                		        	<li class="breadcrumb-item active" aria-current="page">예약상품</li>	
	                		        </c:when>
	                		        <c:when test="${classNo == 20}">
	                		        	<li class="breadcrumb-item active" aria-current="page">신규상품</li>
	                		        </c:when>
	                		        <c:when test="${classNo == 30}">
	                		        	<li class="breadcrumb-item active" aria-current="page">입고완료</li>
	                		        </c:when>
                		        </c:choose>
                    		</ol>
						</div><!-- End .toolbox-left -->
						<div class="toolbox-center">
							<div class="toolbox-info">
								<span class="point-color">${pagingInfo.totalProductCnt }</span> 개의 상품이 있습니다.
							</div><!-- End .toolbox-info -->
						</div><!-- End .toolbox-center -->
						<div class="toolbox-right">
							<div class="toolbox-sort">
								<!-- <label for="sortby">Sort by:</label> -->
								<div class="select-custom">
									<select name="searchType" id="searchType" class="form-control">
										<!-- <option value="" selected="selected">정렬하기</option> -->
										<option id="dateDecs" value="dateDecs" <c:if test="${searchType == 'dateDecs'}">selected</c:if>>최신순</option>
										<option id="dateAcs" value="dateAcs" <c:if test="${searchType == 'dateAcs'}">selected</c:if>>오래된 등록일순</option>
										<option id="priceDecs" value="priceDecs" <c:if test="${searchType == 'priceDecs'}">selected</c:if>>높은가격순</option>
										<option id="priceAcs" value="priceAcs" <c:if test="${searchType == 'priceAcs'}">selected</c:if>>낮은가격순</option>
									</select>
								</div>
							</div><!-- End .toolbox-sort -->
						</div><!-- End .toolbox-right -->
					</div><!-- End .toolbox -->

					<div class="container justify-content-md-center category-style">
	                    <div>
	            	        <div class="category-dropdown col-md-auto resContent">
		                        <div class="col header-dropdown">
		                            <a href="viewList?pageNo=${paging}&classNo=10">예약상품</a>
		                        </div><!-- End .header-dropdown -->
		                        <div class="col header-dropdown">
		                            <a href="viewList?pageNo=${paging}&classNo=20">신규입고</a>
		                        </div><!-- End .header-dropdown -->
		                        <div class="col header-dropdown">
		                            <a href="viewList?pageNo=${paging}&classNo=30">입고완료</a>
		                        </div><!-- End .header-dropdown -->      		                    
		                    </div><!-- End .category-dropdown -->
						</div>
					</div><!-- End .container -->	
		
					<div class="products">
						<div class="row">
							<c:if test="${empty productList}">
								<img class="nullImg" alt="해당 상품이 없습니다." src="/resources/assets/images/null.png" >
							</c:if>
							<!--  각 상품 출력 부분 -->
							<c:forEach var="product" items="${productList }">
								<div class="col-6 col-md-4 col-lg-4 col-xl-3 col-xxl-2">
									<div class="product">
										<figure class="product-media">
										
											<c:if test="${product.regDate > before14 }">
												<span class="product-label label-new">New</span>
											</c:if>
											<c:if test="${product.discountRate != 0 }">
												<span class="product-label label-sale">${product.discountRate }% 할인</span>
											</c:if>
											<c:if test="${product.currentQty == 0 }">
												<span class="product-label label-out">품절</span>
											</c:if>
											<c:if test="${product.isRecommend == 'Y' }">
												<span class="product-label label-top">MD 추천</span>
											</c:if>
											
											<a href="productDetail?productNo=${product.productNo }">
												<img src="${product.thumbnailImg }" alt="Product image" class="product-image">
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
											</div><!-- End .product-action -->
	
											<div class="product-action action-icon-top">
												<c:choose>
													<c:when test="${product.currentQty == 0 }">
														<a class="btn-product btn-cart icon-shopping-cart"><span class="sold-out">품절</span>	</a>
														<a href="javascript:;" class="btn-product btn-cart" onclick="toCart(${product.productNo }, ${product.currentQty })"><span>장바구니</span></a>
													</c:when>
													<c:otherwise>
														<a href="#" class="btn-product btn-cart icon-shopping-cart" id="${product.productNo}" onclick="askLogin(this.id);"><span>구매하기</span></a>
														<a href="javascript:;" class="btn-product btn-cart" onclick="toCart(${product.productNo }, ${product.currentQty })"><span>장바구니</span></a>
												</c:otherwise>
												</c:choose>
											</div><!-- End .product-action -->
										</figure><!-- End .product-media -->
										
										<div class="product-body">
											<div class="product-cat">
												<div>${product.originalName }</div>
											</div>
											<h3 class="product-title">
												<span class="point-color">
													<span>&lt;</span>
													${product.classType }
													<span>&gt;</span>
													${product.classMonth }
												</span>
												<br>
												<a href="productDetail?productNo=${product.productNo }">${product.productName }</a>
											</h3><!-- End .product-title -->
											<div class="product-price mb-0">
												<c:choose>
													<c:when test="${product.discountRate != 0 }">
														<del>
															<fmt:formatNumber value="${product.salesCost }"/>원
														</del>
														 &#8594;
														<fmt:formatNumber value="${product.salesCost * (1 - (product.discountRate / 100))}"/>원
													</c:when>
													<c:otherwise>
														<fmt:formatNumber value="${product.salesCost }"/>원
													</c:otherwise>
												</c:choose>
											</div><!-- End .product-price -->
											<div class="ratings-container">
												<div class="ratings">
													<div class="ratings-val" style="width: ${(product.productRate / 5 * 100)}%;"></div><!-- End .ratings-val -->
												</div><!-- End .ratings -->
											</div><!-- End .rating-container -->
										</div><!-- End .product-body -->
									</div><!-- End .product -->
								</div><!-- End .col-sm-6 col-lg-4 col-xl-3 -->
							</c:forEach>
						</div><!-- End .row -->
					</div><!-- End .products -->
				
					<nav aria-label="Page navigation">
					    <ul class="pagination justify-content-center">
					        <c:choose>
					            <c:when test="${pageNo == 1 or pageNo == null}">
					                <li class="page-item disabled">
					                    <a class="page-link page-link-prev" href="#" aria-label="Previous" tabindex="-1" aria-disabled="true">
					                        <span aria-hidden="true">
					                        	<i class="icon-long-arrow-left"></i>
					                        </span>
					                        이전
					                    </a>
					                </li>
					            </c:when>
					            <c:otherwise>
					                <li class="page-item">
					                    <a class="page-link page-link-prev" href="viewList?pageNo=${pageNo - 1}&classNo=${classNo}" aria-label="Previous" tabindex="-1" aria-disabled="true">
					                        <span aria-hidden="true">
					                        	<i class="icon-long-arrow-left"></i>
					                        </span>
					                        이전
					                    </a>
					                </li>
					            </c:otherwise>
					        </c:choose>
					        <c:forEach var="paging" begin="${pagingInfo.startPageNum}" end="${pagingInfo.endPageNum}">
					            <c:choose>
					                <c:when test="${pageNo == paging}">
					                    <li class="page-item active" aria-current="page">
					                        <a class="page-link" href="#">${paging}</a>
					                    </li>
					                </c:when>
					                <c:otherwise>
					                    <li class="page-item" aria-current="page">
					                        <a class="page-link" href="viewList?pageNo=${paging}&classNo=${classNo}">${paging}</a>
					                    </li>
					                </c:otherwise>
					            </c:choose>
					        </c:forEach>
					        <c:choose>
					            <c:when test="${pageNo < pagingInfo.totalPageCnt}">
					                <li class="page-item">
					                    <a class="page-link page-link-next" href="viewList?pageNo=${pageNo + 1}&classNo=${classNo}">
						                    다음
						                    <span aria-hidden="true">
						                    	<i class="icon-long-arrow-right"></i>
						                    </span>
					                    </a>
					                </li>
					            </c:when>
					            <c:otherwise>
					                <li class="page-item disabled">
					                    <a class="page-link" href="#">
					                    	다음
						                    <span aria-hidden="true">
						                    	<i class="icon-long-arrow-right"></i>
						                    </span>
					                    </a>
					                </li>
					            </c:otherwise>
					        </c:choose>
					    </ul>
					</nav><!-- End nav -->
				</div><!-- End .container-fluid -->
			</div><!-- End .page-content -->
		</main><!-- End main -->
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
		<!-- footer -->
		<jsp:include page="../footer.jsp"></jsp:include>
		
	</div><!-- End .page-wrapper -->
	
	<!-- 최상단으로 이동 -->
	<button id="scroll-top" title="Back to Top">
		<i class="icon-arrow-up"></i>
	</button>
  
	<script src="/resources/js/product/product-user.js"></script>
    <script type="text/javascript">
		let uuid = '${sessionScope.loginCustomer.uuid}';
	    $(function () {
	        $("#searchType").change(function() {
	          location.href="/product/viewList?classNo="+ '${classNo}' + "&searchType=" + $(this).val();
	        });
	        
	     	// 품절상품 그레이스케일 (흑백) 처리
            let labels = document.querySelectorAll('.product-media .label-out');

            // 품절 라벨 찾기
            labels.forEach(function(label) {
                // 상위 요소 찾기
                let productMedia = label.closest('.product-media');

                // 상위 요소 내부의 .product-image 요소 찾기
                let productImage = productMedia.querySelector('.product-image');

                // 그레이스케일 클래스 추가
                productImage.classList.add('grayscale');
            });
	
	    });
	</script>

</body>
</html>