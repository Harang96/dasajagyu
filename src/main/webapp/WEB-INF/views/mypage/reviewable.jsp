<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Insert title here</title>
<!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
<script>
$(function(){
	// active 클래스 초기화
	$.each($("aside .nav-link"), function(i, nav){
		$(nav).attr("class", "nav-link");
	});
	
	$("#tab-review-link").addClass("active");
});

	function toWriteReview(productNo, orderNo){
		location.href = `writeReview?productNo=\${productNo}&orderNo=\${orderNo}`
	}
</script>
<style>
	.bt2 {
		border-top: 2px solid;
		border-bottom: 2px solid;
	}
	
</style>
</head>
<body>
	<div class="page-wrapper">
		<jsp:include page="../header.jsp"></jsp:include>
		 <main class="main">
		  	<div class="page-content">
	            	<div class="dashboard">
		               <div class="container">
		                <div class="row">
							<jsp:include page="mypageAside.jsp"></jsp:include>
							<div class="col-md-8 col-lg-10">
							 	 <div class="tab-pane" id="tab-reviewable"  aria-labelledby="tab-reviewable-link">
									<div class="heading">
										<h2 class="title" style="font-weight: bolder;"> 리뷰 관리</h2>
									</div>
							 	 <ul class="nav nav-pills justify-content-center bt2 mb-3 pt-2 pb-2" id="tabs-6" role="tablist">
								    <li class="nav-item">
								        <a class="nav-link active" id="tab-21-tab" href="reviewable" aria-selected="true" ><b>리뷰 작성</b></a>
								    </li>
								    <li class="nav-item">
								        <a class="nav-link" id="tab-22-tab" href="wroteReviews">작성한 리뷰</a>
								    </li>
								</ul>
								<div><b>작성 가능한 리뷰 ${count} (구매확정 시 리뷰 작성 가능합니다)</b></div>
									    	<c:choose>
									    	<c:when test="${list != null && list.size() > 0 }">
									    		<table class="table table-wishlist table-mobile">
												<tbody>
												<c:forEach var="product" items="${list}" >
													<tr id="prd_${product.productNo}${product.orderNo}">
														<td class="product-col">
															<div class="product">
																<figure class="product-media">
																	<a href="../product/productDetail?productNo=${product.productNo }">
																		<img src="${product.thumbnailImg }" alt="Product image">
																	</a>
																</figure>
															</div><!-- End .product -->
														</td>
														<td class="">
														<div><b>${product.originalName}</b></div>
														<h3 class="product-title">
															<a href="../product/productDetail?productNo=${product.productNo }">${product.productName }</a>
														</h3>
														<div><fmt:formatDate value="${product.orderTime}"/> 주문</div>
														</td>
														<td class="action-col">
															<button class="btn btn-block btn-outline-primary-2" onclick="toWriteReview('${product.productNo}','${product.orderNo}')">리뷰 작성하기</button>
														</td>
													</tr>
												</c:forEach>
												</tbody>
											</table><!-- End .table table-wishlist -->
									    	</c:when>
									    	<c:otherwise>
									    		<div>리뷰 작성 가능한 상품이 없습니다.</div>
									    	</c:otherwise>
									    	</c:choose>
									    	<!-- <c:if test="${count>10}">
												<button class="btn btn btn-block btn-outline-primary-2 btn-round" onclick="getMoreList()">더보기</button>
											</c:if> -->
										</div><!-- .End .tab-pane -->
							 </div>
						</div>
					</div>
				</div>
			</div>
		</main>
		<jsp:include page="../footer.jsp"></jsp:include>
	</div>
</body>
</html>