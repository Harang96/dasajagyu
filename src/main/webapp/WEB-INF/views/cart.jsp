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
<title>장바구니</title>
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
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
$( document ).ready( function() {
	
	
	$("#sa10").on("click", function(){
		if($("#sa99").is(":checked") == false){
		if($(this).is(":checked")){
			$("input[name=pdCheck]").each(function(){
				var pdcartNo = $(this).prev().val().split("_")[2];
				if(pdcartNo == 10){
					if($(this).is(":checked") == false){
						$(this).prop("checked",true);
						updateInfo($(this).attr('id'));
					}
				} else {
					if($(this).is(":checked") == true){
					$(this).prop("checked",false);
					updateInfo($(this).attr('id'));
					}
				}
			});
		} else {
			$("input[name=pdCheck]").each(function(){
				var pdcartNo = $(this).prev().val().split("_")[2];
				if(pdcartNo == 10){
					if($(this).is(":checked") == true){
						$(this).prop("checked",false);
						updateInfo($(this).attr('id'));
					}
				}
			});
			}
			}else{
				$("#sa10").prop("checked",false);
				openModal("예약상품과 일반상품은 같이 결제할 수 없습니다!");
			}
		});
	
	$("#sa99").on("click", function(){
		if($("#sa10").is(":checked") == false){
		if($(this).is(":checked")){
			$("input[name=pdCheck]").each(function(){
				var pdcartNo = $(this).prev().val().split("_")[2];
				if(pdcartNo == 20 || pdcartNo == 30){
					if($(this).is(":checked") == false){
						$(this).prop("checked",true);
						updateInfo($(this).attr('id'));
					}
				}else {
					if($(this).is(":checked") == true){
					$(this).prop("checked",false);
					updateInfo($(this).attr('id'));
					}
				}
			});
		} else {
			$("input[name=pdCheck]").each(function(){
				var pdcartNo = $(this).prev().val().split("_")[2];
				if(pdcartNo == 20 || pdcartNo == 30){
					if($(this).is(":checked") == true){
						$(this).prop("checked",false);
						updateInfo($(this).attr('id'));
					}
				}
			});
			}
		}else{
			$("#sa99").prop("checked",false);
			openModal("예약상품과 일반상품은 같이 결제할 수 없습니다!");
		}
		});
		
	
	$(".icon-minus").click(function(){
		
		var pdNo = $(this).parent().attr("class").split("_")[1];
		var qty = "-1";
		var nowQty = $(this).next().text();
		var newQty = parseInt(qty) + parseInt(nowQty);
		var cost = parseInt($(this).parent().attr("class").split("_")[2]);
		/* console.log(pdNo);
		console.log(newQty * cost); */
		if(nowQty == 1){
			openModal("최소 수량은 1개 입니다!");
		} else {
			
		$.ajax({
			url: "/cart/updateQty", // 데이터가 송수신될 서버의 주소
			type: "GET", // 통신 방식 (GET, POST, PUT, DELETE)
			data: {
				"pdNo" : pdNo,
				"qty" : qty
			},
			
			success: function() {
				// 통신이 성공하면 수행할 함수
				$("#total-col_" + pdNo).text("￦" + (newQty * cost).toLocaleString()+"");
				$("#pdQty_" + pdNo).text(newQty+"");
				updateAllList();
			},
			error: function() {
			},
			complete: function() {
				
			},
		});
		}
		
	});
	$(".icon-plus").click(function(){
		
		var pdNo = $(this).parent().attr("class").split("_")[1];
		var qty = "1";
		var nowQty = $(this).prev().text();
		var maxQty = $(this).attr("id");
		var newQty = parseInt(qty) + parseInt(nowQty);
		var cost = parseInt($(this).parent().attr("class").split("_")[2]);
		/* console.log(pdNo);
		console.log(qty); */
		if(nowQty == 5){
			//alert("최대 수량은 5개 입니다!");
			openModal("최대 수량은 5개 입니다!");
		}else if (maxQty == nowQty){
			openModal("남은 수량이 " + maxQty + "개 입니다!");
		} else {
		
		 $.ajax({
			url: "/cart/updateQty", // 데이터가 송수신될 서버의 주소
			type: "GET", // 통신 방식 (GET, POST, PUT, DELETE)
			data: {
				"pdNo" : pdNo,
				"qty" : qty
			},
			success: function() {
				// 통신이 성공하면 수행할 함수
				$("#total-col_" + pdNo).text("￦" + (newQty * cost).toLocaleString()+"");
				$("#pdQty_" + pdNo).text(newQty+"");
				updateAllList();
			},
			error: function() {
			},
			complete: function() {
				
			},
		}); 
		}
		
	});
	
	$(".btn-remove").click(function(){
		var pdNo = $(this).val();
		$.ajax({
				url: "/cart/removeCart?productNo=" + pdNo, // 데이터가 송수신될 서버의 주소
				type: "GET", // 통신 방식 (GET, POST, PUT, DELETE)
				success: function() {
					// 통신이 성공하면 수행할 함수
					$("#total-col_"+pdNo).parents('tr').remove();
					updateAllList();
					tableSearch();
				},
				error: function() {
				},
				complete: function() {
					
				},
			}); 
		
	}); 
	
	console.log($("#tbody-com >tbody tr").length);
	console.log($("#tbody-res >tbody tr").length);
	console.log($("#tbody-soldout >tbody tr").length);
	tableSearch();
	
});

function tableSearch(){
	var comPd = $("#tbody-com >tbody tr").length;
	var resPd = $("#tbody-res >tbody tr").length;
	var solPd = $("#tbody-soldout >tbody tr").length;
	/* console.log($("#tbody-com >tbody tr").length);
	console.log($("#tbody-res >tbody tr").length);
	console.log($("#tbody-soldout >tbody tr").length); */
	if(comPd == 0){
		$("#tbody-com").remove();
	}
	if(resPd == 0){
		$("#tbody-res").remove();
	}
	if(solPd == 0){
		$("#tbody-soldout").remove();
	}
	
	
};

function askDel(){
	$("#delete-modal").modal();
};


function delAllList(){
	console.log("삭제하자");
	$(".btn-remove").each(function(){
		//var pdNo = $(this).prev().val().split("_")[0];
		var pdNo = $(this).val();
		console.log(pdNo);
		
	 $.ajax({
			url: "/cart/removeCart?productNo=" + pdNo, // 데이터가 송수신될 서버의 주소
			type: "GET", // 통신 방식 (GET, POST, PUT, DELETE)
			success: function() {
				// 통신이 성공하면 수행할 함수
				
			},
			error: function() {
			},
			complete: function() {
				$("#total-col_"+pdNo).parents('tr').remove();
			},
		}); 
	}); 
	
	setTimeout(function(){window.location.reload();},400);
	//window.location.reload() ;
	
};

// 예약_입고 상품 구분
function checkedPdClass(no,thisId){
	var result = true;
	$("input[name=pdCheck]:checked").each(function(){
		var pdcartNo = $(this).prev().val().split("_")[2];
		if(no == "10"){
			if(pdcartNo != "10"){
				result = false;
			}
		} else if(no == "20" || no == "30") {
			if(pdcartNo == "10"){
				result = false;
			}
			
		}
		
	});
	
	if(result){
		updateInfo(thisId);
	}else{
		openModal("예약상품과 일반상품은 같이 결제할 수 없습니다!");
	}
	
	return result;
};


	

// 결제 정보란 업데이트
function updateInfo(thisId){
	var fullVal = $("#"+thisId).prev().val().split("_");
	
	var pdPrice = Number($(".totPrice").attr('id'));
	var pdQty = Number($('.totQty').text());
	updateAllList();
};

function updateAllList(){
	var totCost = 0;
	var totQty = 0;
	$("input[name=pdCheck]:checked").each(function(){
		var pdVal = $(this).prev().val().split("_");
		var pdNo = pdVal[0];
		
		totQty += parseInt($("#pdQty_" + pdNo).text());
		totCost += parseInt($("#pdQty_" + pdNo).parent().attr("class").split("_")[2]) * parseInt($("#pdQty_" + pdNo).text());
		
	});
	
	/* console.log(totCost);
	console.log(totQty); */
	
	$(".totPrice").attr('id', totCost);
	$(".totPrice").text((totCost).toLocaleString()+"");
	$(".totQty").text(totQty+"");
	
	if(totCost >= 50000){
		$(".postPrice").text("0원(무료배송)");
		$(".lastPrice").text((totCost).toLocaleString()+"");
	} else if (totCost < 50000 && totCost > 0) {
		$(".postPrice").text("3,000원");
		$(".lastPrice").text((totCost + 3000).toLocaleString()+"");
	} else {
		$(".postPrice").text("- 원");
		$(".lastPrice").text((totCost).toLocaleString()+"");
	}
	
	
};

function openModal(msg){
	$("#modalText").text(msg);
	$("#info-modal").modal();
};


function askLogin(){
	if('${sessionScope.loginCustomer == null}' == "true"){
		$("#order-modal").modal();
	} else {
		goToOrder();
	}
}


function goToOrder(){
	console.log("가자 계산하러~~~")
	
	var orderList = new Array();
	var sesId = null;
	if('${sessionScope.loginCustomer == null}' == "true"){
		sesId = '${cookie.cartId.value }';
	}
	$("input[name=pdCheck]:checked").each(function(){
		var pdVal = $(this).prev().val().split("_");
		var pdNo = pdVal[0];
		var pdQty = $("#pdQty_" + pdNo).text();
		/* console.log(pdNo, pdQty); */
		var data = new Object();
		
		data.productNo = pdNo;
		data.qty = pdQty;
		data.sessionId = sesId;
		
		orderList.push(data);
	});
	if(orderList.length == 0){
		openModal("상품을 선택해 주세요!");
	} else {
		console.log(orderList);
		console.log(JSON.stringify(orderList));
		window.location.href = "/order?products=" + encodeURIComponent(JSON.stringify(orderList));
	}
	
};


</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<!-- header 파일 인클루드 -->
	<main class="main">
		<div class="page-header text-center">
			<div class="container">
				<h1 class="page-title">
					장바구니
				</h1>
			</div>
			<!-- End .container -->
		</div>
		<!-- End .page-header -->

		<div class="page-content">
			<!-- 테스ㅡ -->
			<%-- <div>${cartList }</div> --%>
			<div class="cart" id="cart">
				<div class="container">
					<div class="row">
						<div class="col-lg-9">
							<c:choose>
								<c:when test="${cartList != null && cartList.size() > 0}">
								<div class="cart-bottom" style="margin-bottom:10px; position: relative; height: 50px;">
								
								<div class="custom-control custom-checkbox" style="position: absolute;">
									<input type="checkbox" class="custom-control-input" id="sa10" />
									<label class="custom-control-label" for="sa10">예약상품 전체
										선택</label>
								</div>
								<div class="custom-control custom-checkbox" style="position: absolute; margin-left: 10px; left: 150px;">
									<input type="checkbox" class="custom-control-input" id="sa99" />
									<label class="custom-control-label" for="sa99">일반상품 전체
										선택</label>
								</div>
								<div class="custom-control" style="right: 0; position: absolute;">
									<input type="button" class="btn btn-outline-dark" value="전체 삭제" onclick="askDel()" />								
								</div>
							</div>
								<!-- 일반 상품 td -->
									<table class="table table-cart table-mobile" id="tbody-com">
									
										<thead>
											<tr>
												<th style="width: 80px;">선택</th>
												<th>일반 상품</th>
												<th>가격</th>
												<th>수량</th>
												<th>상품 총 금액</th>
												<th></th>
											</tr>
										</thead>

										<tbody>
											<c:forEach var="product" items="${cartList }">
												
												<c:if
													test="${product.discountrate != 0 && product.currentqty > 0 && product.classno != 10}">

													<tr>
														<td class="cartChek" style="padding: 10px 5px 10px 5px;">
															<input type="hidden"
															value="${product.productno }_${product.quantity}_${product.classno}"
															name="pdInfo" /> <input type="checkbox"
															id="pdCheck${product.productno }" name="pdCheck"
															value="${product.discountcost * product.quantity }"
															onclick="return checkedPdClass(${product.classno}, this.id)">
														</td>
														<td class="product-col"
															style="padding: 10px 5px 10px 5px;">
															<div class="product">
																<figure class="product-media">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<img src="${product.thumbnailimg }"
																		alt="Product image">
																	</a>
																</figure>
																<h3 class="product-title">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<${product.classtype }> ${product.classmonth }
																		${product.productname }</a>
																</h3>
																<!-- End .product-title -->
															</div>
														</td>
														<td class="price-col" style="padding: 10px 5px 10px 5px;"><s><fmt:formatNumber
																	value="${product.salescost }" type="currency" /></s> →<span
															class="sale-price"> <fmt:formatNumber
																	value="${product.discountcost }" type="currency" /></span></td>
														<td class="quantit-col"
															style="width: 100px; padding: 10px 5px 10px 5px;">
															<div
																class="qty_${product.productno }_${product.discountcost}">
																<i class="icon-minus"></i> <span
																	id="pdQty_${product.productno }"
																	style="padding: 0px 10px 0px 10px;">${product.quantity }</span>
																<i class="icon-plus" id="${product.currentqty }"></i>
															</div>
														</td>
														<td class="total-col" id="total-col_${product.productno }"
															style="padding: 10px 5px 10px 5px;"><fmt:formatNumber
																value="${product.discountcost * product.quantity }"
																type="currency" /></td>
														<td class="remove-col" style="padding: 10px 5px 10px 5px;"><button
																class="btn-remove" value="${product.productno }">
																<i class="icon-close"></i>
															</button></td>
													</tr>
												</c:if>
												<c:if
													test="${product.discountrate == 0 && product.currentqty > 0 && product.classno != 10}">
													<tr>
														<td class="cartChek" style="padding: 10px 5px 10px 5px;">
															<input type="hidden"
															value="${product.productno }_${product.quantity}_${product.classno}"
															name="pdInfo" /> <input type="checkbox"
															id="pdCheck${product.productno }" name="pdCheck"
															value="${product.salescost * product.quantity }"
															onclick="return checkedPdClass(${product.classno}, this.id)">
														</td>
														<td class="product-col"
															style="padding: 10px 5px 10px 5px;">
															<div class="product">
																<figure class="product-media">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<img src="${product.thumbnailimg }"
																		alt="Product image">
																	</a>
																</figure>
																<h3 class="product-title">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<${product.classtype }> ${product.classmonth }
																		${product.productname }</a>
																</h3>
																<!-- End .product-title -->
															</div>
														</td>
														<td class="price-col" style="padding: 10px 5px 10px 5px;"><span
															class="sale-price"><fmt:formatNumber
																	value="${product.salescost }" type="currency" /></span></td>
														<td class="quantity-col"
															style="width: 100px; padding: 10px 5px 10px 5px;">
															<div
																class="qty_${product.productno }_${product.discountcost}">
																<i class="icon-minus"></i> <span
																	id="pdQty_${product.productno }"
																	style="padding: 0px 10px 0px 10px;">${product.quantity }</span>
																<i class="icon-plus" id="${product.currentqty }"></i>
															</div>
														</td>
														<td class="total-col" id="total-col_${product.productno }"
															style="padding: 10px 5px 10px 5px;"><fmt:formatNumber
																value="${product.salescost * product.quantity }"
																type="currency" /></td>
														<td class="remove-col" style="padding: 10px 5px 10px 5px;"><button
																class="btn-remove"  value="${product.productno }">
																<i class="icon-close"></i>
															</button></td>
													</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</table>

									<!-- 예약 상품 td -->
									<table class="table table-cart table-mobile" id="tbody-res">
										<thead>
											<tr>
												<th style="width: 80px;">선택</th>
												<th>예약 상품</th>
												<th>가격</th>
												<th>수량</th>
												<th>상품 총 금액</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="product" items="${cartList }">
											<c:if test="${product.discountrate != 0 && product.currentqty > 0 && product.classno == 10}">

													<tr>
														<td class="cartChek" style="padding: 10px 5px 10px 5px;">
															<input type="hidden"
															value="${product.productno }_${product.quantity}_${product.classno}"
															name="pdInfo" /> <input type="checkbox"
															id="pdCheck${product.productno }" name="pdCheck"
															value="${product.discountcost * product.quantity }"
															onclick="return checkedPdClass(${product.classno}, this.id)">
														</td>
														<td class="product-col"
															style="padding: 10px 5px 10px 5px;">
															<div class="product">
																<figure class="product-media">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<img src="${product.thumbnailimg }"
																		alt="Product image">
																	</a>
																</figure>
																<h3 class="product-title">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<${product.classtype }> ${product.classmonth }
																		${product.productname }</a>
																</h3>
																<!-- End .product-title -->
															</div>
														</td>
														<td class="price-col" style="padding: 10px 5px 10px 5px;"><s><fmt:formatNumber
																	value="${product.salescost }" type="currency" /></s> →<span
															class="sale-price"> <fmt:formatNumber
																	value="${product.discountcost }" type="currency" /></span></td>
														<td class="quantit-col"
															style="width: 100px; padding: 10px 5px 10px 5px;">
															<div
																class="qty_${product.productno }_${product.discountcost}">
																<i class="icon-minus"></i> <span
																	id="pdQty_${product.productno }"
																	style="padding: 0px 10px 0px 10px;">${product.quantity }</span>
																<i class="icon-plus" id="${product.currentqty }"></i>
															</div>
														</td>
														<td class="total-col" id="total-col_${product.productno }"
															style="padding: 10px 5px 10px 5px;"><fmt:formatNumber
																value="${product.discountcost * product.quantity }"
																type="currency" /></td>
														<td class="remove-col" style="padding: 10px 5px 10px 5px;"><button
																class="btn-remove"  value="${product.productno }">
																<i class="icon-close"></i>
															</button></td>
													</tr>
												</c:if>
												<c:if
													test="${product.discountrate == 0 && product.currentqty > 0 && product.classno == 10}">
													<tr>
														<td class="cartChek" style="padding: 10px 5px 10px 5px;">
															<input type="hidden"
															value="${product.productno }_${product.quantity}_${product.classno}"
															name="pdInfo" /> <input type="checkbox"
															id="pdCheck${product.productno }" name="pdCheck"
															value="${product.salescost * product.quantity }"
															onclick="return checkedPdClass(${product.classno}, this.id)">
														</td>
														<td class="product-col"
															style="padding: 10px 5px 10px 5px;">
															<div class="product">
																<figure class="product-media">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<img src="${product.thumbnailimg }"
																		alt="Product image">
																	</a>
																</figure>
																<h3 class="product-title">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<${product.classtype }> ${product.classmonth }
																		${product.productname }</a>
																</h3>
																<!-- End .product-title -->
															</div>
														</td>
														<td class="price-col" style="padding: 10px 5px 10px 5px;"><span
															class="sale-price"><fmt:formatNumber
																	value="${product.salescost }" type="currency" /></span></td>
														<td class="quantity-col"
															style="width: 100px; padding: 10px 5px 10px 5px;">
															<div
																class="qty_${product.productno }_${product.discountcost}">
																<i class="icon-minus"></i> <span
																	id="pdQty_${product.productno }"
																	style="padding: 0px 10px 0px 10px;">${product.quantity }</span>
																<i class="icon-plus" id="${product.currentqty }"></i>
															</div>
														</td>
														<td class="total-col" id="total-col_${product.productno }"
															style="padding: 10px 5px 10px 5px;"><fmt:formatNumber
																value="${product.salescost * product.quantity }"
																type="currency" /></td>
														<td class="remove-col" style="padding: 10px 5px 10px 5px;"><button
																class="btn-remove" value="${product.productno }">
																<i class="icon-close"></i>
															</button></td>
													</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</table>
									<!-- 재고 없는 상품 td -->
									
									<table class="table table-cart table-mobile" id="tbody-soldout">
										<thead>
											<tr>
												<th style="width: 80px;">선택</th>
												<th>품절 상품</th>
												<th>가격</th>
												<th>수량</th>
												<th>상품 총 금액</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="product" items="${cartList }">
												<c:if test="${product.currentqty  < 1 }">
													<tr>
														<td class="cartChek" style="padding: 10px 5px 10px 5px;"></td>
														<td class="product-col"
															style="padding: 10px 5px 10px 5px;">
															<div class="product">
																<figure class="product-media">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<img src="${product.thumbnailimg }"
																		alt="Product image">
																	</a>
																</figure>
																<h3 class="product-title">
																	<a
																		href="/product/productDetail?productNo=${product.productno }">
																		<${product.classtype }> ${product.classmonth }
																		${product.productname }</a>
																</h3>
																<!-- End .product-title -->
															</div>
														</td>
														<td class="price-col" style="padding: 10px 5px 10px 5px;"><span
															class="sale-price"><fmt:formatNumber
																	value="${product.salescost }" type="currency" /></span></td>
														<td class="quantity-col"
															style="width: 100px; padding: 10px 5px 10px 5px;">"Sold
															Out"</td>
														<td class="total-col" id="total-col_${product.productno }" style="padding: 10px 5px 10px 5px;"><fmt:formatNumber
																value="${product.salescost }"
																type="currency" /></td>
														<td class="remove-col" style="padding: 10px 5px 10px 5px;"><button
																class="btn-remove" value="${product.productno }">
																<i class="icon-close"></i>
															</button></td>
													</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</table>
								</c:when>
								<c:when test="${cartList != null && cartList.size() == 0 }">
									<tr>
										<td>상품이 없습니다! 로그인을 하거나 상품을 담아주세요!</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td>상품이 없습니다! 로그인을 하거나 상품을 담아주세요!</td>
									</tr>
								</c:otherwise>

							</c:choose>
							
							<!-- End .table table-wishlist -->

							
						</div>
						<!-- End .col-lg-9 -->
						<aside class="col-lg-3">
							<div class="summary summary-cart" style="background-color: #FFFFFF; border: 1px solid lightgray; margin-top: 10px;">
								<h3 class="summary-title">결제 정보</h3>
								<!-- End .summary-title -->

								<table class="table table-summary">
									<tbody>
										<tr class="summary-subtotal">
											<td>선택 상품 총 금액 :</td>
											<td><span class="totPrice" id="0">0</span>원</td>
										</tr>
										<!-- End .summary-subtotal -->
										<tr class="summary-shipping">
											<td>결제 세부 정보</td>
											<td>&nbsp;</td>
										</tr>

										<tr class="summary-shipping-row">
											<td>총 수량 :</td>
											<td><span class="totQty">0</span>개</td>
										</tr>
										<!-- End .summary-shipping-row -->

										<tr class="summary-shipping-row">
											<td>배송비 :</td>
											<td><span class="postPrice">- 원</span></td>
										</tr>
										<!-- End .summary-shipping-row -->


										<tr class="summary-total">
											<td>총 금액 :</td>
											<td><span class="lastPrice" id="0">0</span>원</td>
										</tr>
										<!-- End .summary-total -->
									</tbody>
								</table>
								<!-- End .table table-summary -->

								<a href="javascript: askLogin()"
									class="btn btn-outline-primary-2 btn-order btn-block">결제하기</a>


							</div>
							<!-- End .summary -->

						</aside>
						<!-- End .col-lg-3 -->
					</div>
					<!-- End .row -->
				</div>
				<!-- End .container -->
			</div>
			<!-- End .cart -->
		</div>
		<!-- End .page-content -->
	</main>
	<!-- End .main -->

	<!-- cart modal  -->
	<div class="modal fade" id="info-modal" tabindex="-1" role="dialog"
		aria-hidden="true" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-body modalStyle" style="text-align: center; padding : 0px 15px 15px 15px;">
				<span id="modalText" style="font-size: 15px; font-weight: bold;"></span>
			</div>
			<div style="text-align:center;">
			<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
			style="margin-bottom:15px; width: 200px;"
			data-dismiss="modal" aria-label="Close">확인</button>
			</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="order-modal" tabindex="-1" role="dialog"
		aria-hidden="true" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">장바구니</span>
			</div>
			<div class="modal-body modalStyle" style="text-align: center; padding : 0px 15px 15px 15px;">
				<span style="font-size: 15px; font-weight: bold;">비회원으로 구입하시겠습니까?</span>
			</div>
			<div style="text-align:center;">
			<button class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
			style="margin:0px 5px 15px 0px; width: 150px;"
			data-dismiss="modal" aria-label="Close" onclick="goToOrder()">비회원 구매</button>
			<button class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
			style="margin:0px 0px 15px 5px; width: 150px;"
			data-dismiss="modal" aria-label="Close" onclick="location.href='${contextPath }/customer/loginOpen?path=/cart/viewCart'">로그인</button>
			</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog"
		aria-hidden="true" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-body modalStyle" style="text-align: center; padding : 0px 15px 15px 15px;">
				<span style="font-size: 15px; font-weight: bold;">상품을 모두 삭제 하시겠습니까?</span>
			</div>
			<div style="text-align:center;">
			<button class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
			style="margin:0px 5px 15px 0px; width: 150px;"
			data-dismiss="modal" aria-label="Close" onclick="delAllList()">네</button>
			<button class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
			style="margin:0px 0px 15px 5px; width: 150px;"
			data-dismiss="modal" aria-label="Close">아니요</button>
			</div>
			</div>
		</div>
	</div>
	

	<jsp:include page="footer.jsp"></jsp:include>
	<!-- footer 파일 인클루드 -->
</body>
</html>