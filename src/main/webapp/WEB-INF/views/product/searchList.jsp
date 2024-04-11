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
	<title>상품 검색</title>
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
	<c:set var="pageNo" value="${empty param.pageNo ? 1 : param.pageNo}" />
	
</head>
<body>
	<div class="page-wrapper">
		<!-- header 추가 -->
		<jsp:include page="../header.jsp"></jsp:include>
		
		<!-- 상품 출력 -->
		<main id="searchListWrap" class="main">
			<div class="page-content">
				<div class="container-fluid">
					<div class="toolbox">
						<div class="toolbox-left">
		                    <ol class="breadcrumb">
         		                <li class="breadcrumb-item">
         		                	<a href="/">홈</a>
         		                </li>
                		        <li class="breadcrumb-item active" aria-current="page">상품</li>
                    		</ol>
						</div><!-- End .toolbox-left -->
						<div class="toolbox-center">
							<div class="toolbox-info">
								<span class="point-color">${pagingInfo.totalProductCnt}</span> 개의 상품이 있습니다.
							</div><!-- End .toolbox-info -->
						</div><!-- End .toolbox-center -->

						<div class="toolbox-right">
							<div class="toolbox-sort">
								<div class="select-custom">
									<select name="searchType" id="searchType" class="form-control">
										<option id="dateDecs" value="dateDecs" <c:if test="${search.searchType == 'dateDecs'}">selected</c:if>>최신순</option>
										<option id="dateAcs" value="dateAcs" <c:if test="${search.searchType == 'dateAcs'}">selected</c:if>>오래된 등록일순</option>
										<option id="priceDecs" value="priceDecs" <c:if test="${search.searchType == 'priceDecs'}">selected</c:if>>높은가격순</option>
										<option id="priceAcs" value="priceAcs" <c:if test="${search.searchType == 'priceAcs'}">selected</c:if>>낮은가격순</option>
										<option id="disctountDecs" value="disctountDecs" <c:if test="${search.searchType == 'disctountDecs'}">selected</c:if>>높은할인율순</option>
										<option id="disctountAcs" value="disctountAcs" <c:if test="${search.searchType == 'disctountAcs'}">selected</c:if>>낮은할인율순</option>
									</select>
								</div>
							</div><!-- End .toolbox-sort -->
						</div><!-- End .toolbox-right -->
					</div><!-- End .toolbox -->
					
					 <!-- 검색 상자 추가할 부분 -->
					 <div class="ec-base-box searchbox" style="margin-bottom: 30px;">
						<fieldset>
							<legend class="gmarketFontStyle item text-center">상품 검색</legend>
							<form action="searchList">
					            <div class="d-flex row justify-content-md-center">
									<div class="select-custom col col-lg-2">
										<select id="classNo" name="classNo" class="form-control">
											<option value="" selected="selected">상품 구분</option>
											<option value="10" <c:if test="${search.classNo == '10'}">selected</c:if>>예약 상품</option>
											<option value="20" <c:if test="${search.classNo == '20'}">selected</c:if>>신규 상품</option>
											<option value="30" <c:if test="${search.classNo == '30'}">selected</c:if>>입고 완료</option>
										</select>
									</div>
									<div class="select-custom col col-lg-2" style="width : 900px;">	
										<select id="searchCata" name="searchCata" class="form-control">
											<option value="productName" <c:if test="${search.searchCata == 'productName'}">selected</c:if>>상품명</option>
											<option value="manufacturerName" <c:if test="${search.searchCata == 'manufacturerName'}">selected</c:if>>제조사</option>
											<option value="originalName" <c:if test="${search.searchCata == 'originalName'}">selected</c:if>>작품명</option>
										</select>
									</div>
								</div>
								
							<%-- 	<div class="d-none d-flex row justify-content-md-center search-small">
									<div class="input-group col col-md-4 search-style">
										<input id="searchWord" name="searchWord" class="searchWord" size="30" value="${search.searchWord }" type="text" placeholder="검색어를 입력해주세요.">
										<button class="btn btn-primary" type="submit">
											검색
										</button>
									</div>
								</div> --%>
								
								 <div class="header-center d-flex justify-content-md-center"><!-- 검색 -->
						            <div class="header-search header-search-visible header-search-no-radius d-none d-lg-block">
						              <a href="#" class="search-toggle" role="button">
						                <i class="icon-search"></i>
						              </a>
						                <div class="header-search-wrapper">
						                
						                  <label for="searchWord" class="sr-only">검색</label>
						                  <input type="search" class="form-control" name="searchWord" id="searchWord" placeholder="검색어를 입력해주세요." value="${search.searchWord}" required />
						                  <button class="btn btn-primary" type="submit">
						                    <i class="icon-search"></i>
						                  </button>
						                </div>
						            </div>
						          </div><!-- End .header-center -->
							</form>
						</fieldset>			 
	                 </div>
				 
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
														<a href="javascript:;" class="btn-product btn-cart icon-shopping-cart" id="${product.productNo}" onclick="askLogin(this.id);"><span>구매하기</span></a>
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
												<span>&lt;</span>
												${product.classType } 
												<span>&gt;</span>
												${product.classMonth } 
												<br>
												<a href="productDetail?productNo=${product.productNo }">${product.productName }</a>
											</h3><!-- End .product-title -->
											<div class="product-price">
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
					                        </span>Prev
					                    </a>
					                </li>
					            </c:when>
					            <c:otherwise>
					                <li class="page-item">
					                    <a class="page-link page-link-prev" href="searchList?pageNo=${pageNo - 1}&searchWord=${search.searchWord}&searchType=${search.searchType}&searchCata=${search.searchCata}" aria-label="Previous" tabindex="-1" aria-disabled="true">
					                        <span aria-hidden="true">
					                        	<i class="icon-long-arrow-left"></i>
					                        </span>Prev
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
					                        <a class="page-link" href="searchList?pageNo=${paging }&searchWord=${search.searchWord}&searchType=${search.searchType}&searchCata=${search.searchCata}">${paging}</a>
					                    </li>
					                </c:otherwise>
					            </c:choose>
					        </c:forEach>
					        <c:choose>
					            <c:when test="${pageNo < pagingInfo.totalPageCnt}">
					                <li class="page-item">
					                    <a class="page-link page-link-next" href="searchList?pageNo=${pageNo + 1}&searchWord=${search.searchWord}&searchType=${search.searchType}&searchCata=${search.searchCata}">Next
					                    	<span aria-hidden="true">
					                    		<i class="icon-long-arrow-right"></i>
					                    	</span>
					                    </a>
					                </li>
					            </c:when>
					            <c:otherwise>
					                <li class="page-item disabled">
					                    <a class="page-link" href="#">Next
					                    	<span aria-hidden="true">
					                    		<i class="icon-long-arrow-right"></i>
					                    	</span>
					                    </a>
					                </li>
					            </c:otherwise>
					        </c:choose>
					    </ul>
					</nav>
				</div>
			</div>
		</main>
		
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
	<button id="scroll-top" title="Back to Top"><i class="icon-arrow-up"></i></button>

	<script src="/resources/js/product/product-user.js"></script>
    <script type="text/javascript">
		let uuid = '${sessionScope.loginCustomer.uuid}';
        $(function (){
	        $("#searchType").change(function(){
	    	    location.href="/product/searchList?searchWord=" + '${search.searchWord}' + "&searchCata=" + '${search.searchCata}' + "&classNo=" + '${search.classNo}' + "&searchType=" + $(this).val();
	        })
        });

    </script>
</body>
</html>