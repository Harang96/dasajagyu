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
<title>찜목록</title>
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
<script>

$(function(){
	// active 클래스 초기화
	$.each($("aside .nav-link"), function(i, nav){
		$(nav).attr("class", "nav-link");
	});
	
	$("#tab-wishList-link").addClass("active");
});
function closeBtn(){
	$("#info-modal").hide();
};

// 모달창 오픈 - start -
function openModal(msg){
	$("#modalText").text(msg);
	$("#info-modal").show();
};
//모달창 오픈 - end -

//찜목록 관련 - start -
function toCart(productNo, currentQty){
	   console.log("장바구니");
	if (currentQty != 0) {
		$.ajax({
			url: "/cart/addProduct", 
			data : {
				"productNo" : productNo,
				"qty" : "1"
			},
			type: "POST", 
			dataType : "text",
			success: function(data) {
				console.log(data);
				openModal("상품이 장바구니에 담겼습니다!");
			},
			error: function() {
			},
		}); 	    		
	} else {
		$.ajax({
			url: "/cart/addProduct", 
			data : {
				"productNo" : productNo,
				"qty" : "0"
			},
			type: "POST", 
			dataType : "text",
			success: function(data) {
				console.log(data);
				openModal("상품이 장바구니에 담겼습니다!");
			},
			error: function() {
			},
		}); 	    				    		
	}
} /* toCart */

function sendBehavior(behavior, productNo){
	let uuid = '${sessionScope.loginCustomer.uuid}';
	console.log(uuid, behavior, productNo);
	console.log();
	$.ajax({
		url : "/product/likedislike",
		type : "POST", // 통신방식 (GET, POST, PUT, DELETE)
		data : {
			"productNo" : productNo,
			"uuid" : uuid,
			"behavior" : behavior
		},
		dataType : "text", // MIME Type
		success : function (data){
			console.log(data);
			if (data == "success") {
				openModal("찜을 취소했습니다!");
				$("#wish_" + productNo).remove();
			}
		},
		error : function (){
			alert("Error")
		},
		complete : function (){},
	});
	
}
//찜목록 관련 - end -


</script>
<style>

.table th {
	z-index: 1;
 	position: sticky;
 	top : 0;
}

/* 스크롤바의 폭 너비 */
.scrollbar::-webkit-scrollbar {
    width: 10px;  
}

.scrollbar::-webkit-scrollbar-thumb {
    background: #000000; /* 스크롤바 색상 */
    border-radius: 10px; /* 스크롤바 둥근 테두리 */
}

.scrollbar::-webkit-scrollbar-track {
    background: #B7B8B7;  /*스크롤바 뒷 배경 색상*/
}


</style>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<main class="main">
	  <div class="page-content">
            	<div class="dashboard">
	              <div class="container">
	                <div class="row">
					<jsp:include page="mypageAside.jsp"></jsp:include>
						 <div class="col-md-8 col-lg-10">
						 	 <div class="tab-pane" id="tab-wishList" aria-labelledby="tab-wishList-link" >
								    	<div class="heading" >
								    		<h2 class="title" style="font-weight: bolder;"> 찜목록</h2>
								    	</div>
								    	<c:choose>
								    	<c:when test="${wishList != null && wishList.size() > 0 }">
								    	<div class="row align-items-center scrollbar" style="width:100%; overflow:auto; max-height:750px; overflow:auto; border-top: 2px solid;padding:0px 10px;">
								    		<table class="table table-wishlist table-mobile">
											<thead>
												<tr>
													<th>&nbsp;&nbsp;&nbsp;&nbsp;상품</th>
													<th>가격</th>
													<th>판매 정보</th>
													<th></th>
													<th></th>
												</tr>
											</thead>
					
											<tbody>
											<c:forEach var="wishProduct" items="${wishList }" >
												<tr id="wish_${wishProduct.productNo }">
													<td class="product-col" style="padding:10px 0px;">
														<div class="product">
															<figure class="product-media">
																<a href="../product/productDetail?productNo=${wishProduct.productNo }">
																	<img src="${wishProduct.thumbnailImg }" alt="Product image">
																</a>
															</figure>
					
															<h3 class="product-title">
																<a href="../product/productDetail?productNo=${wishProduct.productNo }">
																<c:if test="${wishProduct. classNo == 10 }">
																	<예약상품>
																	<${wishProduct.classMonth }>
																</c:if>
																${wishProduct.productName }
																</a>
															</h3><!-- End .product-title -->
														</div><!-- End .product -->
													</td>
													<td class="price-col">
													<c:choose>
													<c:when test="${wishProduct.discountRate != 0 }">
														<del>
															<fmt:formatNumber value="${wishProduct.salesCost }" type="currency" />
														</del> &#8594;
														<fmt:formatNumber value="${wishProduct.salesCost * (1 - (wishProduct.discountRate / 100))}" type="currency" /> 
													</c:when>
													<c:otherwise>
														<fmt:formatNumber value="${wishProduct.salesCost }" type="currency" />
													</c:otherwise>
													</c:choose>
													
													</td>
													<c:choose>
													<c:when test="${wishProduct.currentQty > 0 }">
														<td class="stock-col"><span class="in-stock">판매중</span></td>
													</c:when>
													<c:otherwise>
														<td class="stock-col"><span class="out-of-stock">재고없음</span></td>
													</c:otherwise>
													</c:choose>
													<td class="action-col">
														<button class="btn btn-block btn-outline-primary-2" onclick="toCart(${wishProduct.productNo},${wishProduct.currentQty} )"><i class="icon-cart-plus"></i>장바구니에 담기</button>
													</td>
													<td class="remove-col"><button class="btn-remove" onclick="sendBehavior('dislike', ${wishProduct.productNo})" ><i class="icon-close"></i></button></td>
												</tr>
											</c:forEach>
											</tbody>
										</table><!-- End .table table-wishlist -->
										</div>
								    	</c:when>
								    	<c:otherwise>
								    		<div class="row align-items-center scrollbar" style="width:100%; overflow:auto; max-height:750px; overflow:auto; border-top: 2px solid;padding:0px 10px;">
								    		<div class="pt-3">
									    		<h3>❌⛔찜한 상품이 없습니다❌⛔ </h3>
								    		</div>
								    		</div>
								    	</c:otherwise>
								    	</c:choose>
								    	
									</div><!-- .End .tab-pane -->
						 </div>
					</div>
				</div>
			</div>
		</div>
</main>

<div class="modal" id="info-modal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">마이페이지</span>
			</div>
			<div class="modal-body" style="text-align: center; padding : 0px 15px 15px 15px;">
			<span id="modalText" style="font-size: 15px; font-weight: bold;"></span>
			</div>
			<div style="text-align:center;">
			<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" onclick="closeBtn();" 
			style="margin-bottom:15px; width: 200px;"
			data-dismiss="modal" >확인</button>
			</div>
			</div>
		</div>
	</div> <!-- mypage Modal -->

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>