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
<title>나의 고객센터</title>
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
<!-- <link rel="mask-icon" -->
<!-- 	href="/resources/assets/images/icons/safari-pinned-tab.svg" -->
<!-- 	color="#666666"> -->
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
<style>

table th {
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

.orderNameSpan{
	padding: 8px;
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
  	width: 400px;
  	height: 43px;
}

</style>


</head>
<body>
<div class="page-wrapper">
	<jsp:include page="../header.jsp"></jsp:include>
	<!-- header 파일 인클루드 -->
 		<main class="main">
            <div class="page-content">
            	<div class="dashboard">
	              <div class="container">
	                <div class="row">
						 	<jsp:include page="mypageAside.jsp"></jsp:include>
	                		<div class="col-md-8 col-lg-10">
								    <div>
										<!-- CS메인 페이지 시작 -->
										<div class="heading">
								    			<h2 class="title" style="font-weight: bolder;">나의 CS신청</h2>
								    	</div>
										<c:choose>
								    			<c:when test="${empty csInfoList }">
								    			<div class="row align-items-center" style="padding-left: 20px; height:150px; border-top: 2px solid; margin-left: 8px;">
								    					<div>
									    					<h3>❌⛔CS 내역이 없습니다❌⛔ </h3>
								    					</div>
								    			</div>
								    			</c:when>
								    			<c:otherwise>
												<div class="row align-items-center scrollbar" style="padding-left: 5px; max-height:400px; overflow:auto; border-top: 2px solid; margin-left: 8px;">
								    			<table class="table table-wishlist table-mobile" style=" padding: 0px 10px;">
													<thead>
														<tr>
															<th>CS번호</th>
															<th class="pl-5">주문번호</th>
															<th>상품</th>
															<th></th>
															<th>CS신청일</th>
															<th>CS타입</th>
															<th>처리상태</th>
															<th></th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${csInfoList }" var="list">
															<tr>
																<td>${list.oCsVo.csNo }</td>															
																<td>${list.oCsVo.orderNo}</td>
																<td style="width: 50px; padding-right: 10px;">
																	<figure class="product-media">
																		<a href="../product/productDetail?productNo=${list.oCsVo.productNo }">
																			<img src="${list.oPdVo.thumbnailImg }" alt="Product image">
																		</a>
																	</figure>
																</td>
																<td><span class="orderNameSpan">${list.oPdVo.productName }</span></td>
																<td><fmt:formatDate value="${list.oCsVo.csDate }" pattern="yyyy-MM-dd HH:mm"/></td>
																<td>${list.oCsVo.csType }</td>
																<td>
																	<c:if test="${list.oCsVo.csProcessed == 'Y' }">
																		승인
																	</c:if>
																	<c:if test="${list.oCsVo.csProcessed == 'N' }">
																		반려
																	</c:if>
																	<c:if test="${list.oCsVo.csProcessed == null }">
																		
																	</c:if>
																</td>
																<td class="pt-1 pb-1"><a href="javascript:;" onclick="openDetailModal(${list.oCsVo.csNo })"class='btn btn-link d-flex'>상세보기</a></td>
															</tr>
														</c:forEach>
								    				</tbody>
								    			</table>
								    			</div>
								    			</c:otherwise>
								    	</c:choose>
										
										<!-- CS메인 페이지 끝 -->
									</div>
									
									 <div class="pt-3">
										<!-- QnA메인 페이지 시작 -->
										<div class="heading">
								    			<h2 class="title" style="font-weight: bolder;">나의 QnA</h2>
								    	</div>
										<c:choose>
								    			<c:when test="${empty svInfoList }">
								    			<div class="row align-items-center" style="padding-left: 20px; height:150px; border-top: 2px solid; margin-left: 8px;">
								    					<div>
									    					<h3>❌⛔QnA 내역이 없습니다❌⛔ </h3>
								    					</div>
								    			</div>
								    			</c:when>
								    			<c:otherwise>
												<div class="row align-items-center scrollbar" style="padding-left: 5px; max-height:400px; overflow:auto; border-top: 2px solid; margin-left: 8px;">
								    			<table class="table table-wishlist table-mobile" style=" padding: 0px 10px;">
													<thead>
														<tr>
															<th>QnA번호</th>
															<th class="pl-5">제목</th>
															<th> 작성자</th>
															<th>작성일</th>
															<th>답글상태</th>
															<th></th>
															<th></th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${svInfoList }" var="svList">
														<c:if test="${svList.svIsDelete eq 'N' }">
															<tr>
																<td>${svList.svBoardNo }</td>															
																<td><span class="orderNameSpan">${svList.svBoardTitle}</span></td>
																<td>${sessionScope.loginCustomer.nickname }</td>
																<td><fmt:formatDate value="${svList.svBoardRegiDate }" pattern="yyyy-MM-dd HH:mm"/></td>
																<td>
																	<c:if test="${svList.commentBoardNo == null }">
																		미답변
																	</c:if>
																	<c:if test="${svList.commentBoardNo != null  }">
																		답변완료
																	</c:if>
																</td>
																<td class="pt-1 pb-1"><a href="/contact/qna/detail?no=${svList.svBoardNo }" class='btn btn-link d-flex'>상세보기</a></td>
																<td></td>
															</tr>
														</c:if>
														</c:forEach>
								    				</tbody>
								    			</table>
								    			</div>
								    			</c:otherwise>
								    	</c:choose>
										
										<!-- QnA메인 페이지 끝 -->
									</div>
									
									 <div class="pt-3">
										<!-- 상품문의 메인 페이지 시작 -->
										<div class="heading">
								    			<h2 class="title" style="font-weight: bolder;">나의 상품문의</h2>
								    	</div>
										<c:choose>
								    			<c:when test="${empty pdQnAList }">
								    			<div class="row align-items-center" style="padding-left: 20px; height:150px; border-top: 2px solid; margin-left: 8px;">
								    					<div>
									    					<h3>❌⛔상품 문의 내역이 없습니다❌⛔ </h3>
								    					</div>
								    			</div>
								    			</c:when>
								    			<c:otherwise>
												<div class="row align-items-center scrollbar" style="padding-left: 5px; max-height:400px; overflow:auto; border-top: 2px solid; margin-left: 8px;">
								    			<table class="table table-wishlist table-mobile" style=" padding: 0px 10px;">
													<thead>
														<tr>
															<th>상품번호</th>
															<th class="pl-5">상품명</th>
															<th>작성일</th>
															<th>답변상태</th>
															<th></th>
															<th></th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${pdQnAList }" var="pdQnAList">
														<c:if test="${pdQnAList.svIsDelete eq 'N' }">
															<tr>
																<td>${pdQnAList.productNo}</td>															
																<td><span class="orderNameSpan">${pdQnAList.productName}</span></td>
																<td><fmt:formatDate value="${pdQnAList.svBoardRegiDate }" pattern="yyyy-MM-dd HH:mm"/></td>
																<td>
																	<c:if test="${pdQnAList.svBoardAnswer == null }">
																		미답변
																	</c:if>
																	<c:if test="${pdQnAList.svBoardAnswer != null  }">
																		답변완료
																	</c:if>
																</td>
																<td class="pt-1 pb-1"><a href="/product/productDetail?productNo=${pdQnAList.productNo }" class='btn btn-link d-flex'>상품보기</a></td>
																<td class="pt-1 pb-1"><button class='btn btn-link d-flex' onclick='delPdQnA(${pdQnAList.svBoardNo})'>삭제</button></td>
															</tr>
														</c:if>
														</c:forEach>
								    				</tbody>
								    			</table>
								    			</div>
								    			</c:otherwise>
								    	</c:choose>
										
										<!-- 메인 페이지 끝 -->
									</div>
							</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<div class="modal fade" id="info-modal" tabindex="-1" role="dialog" aria-hidden="true" >
			<div class="modal-dialog modal-lg modal-dialog-centered" style="max-width: 1000px;">
				<div class="modal-content">
				 
				<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
					<span style="font-size: 20px; font-weight: bold;">CS신청 상세</span>
				</div>
				<div class="modal-body" style="text-align: center; padding : 0px 15px 15px 15px;" style="width: 800px;">
					<div class="row pt-1 pb-1">
						<div class="col"> 
							CS번호 : <span id="modalCsNo"></span>
						</div>
						<div class="col"> 
							주문번호 : <span id="modalCsOrderNo"></span>
						</div>
						<div class="col"> 
							신청일 : <span id="modalCsDate"></span>
						</div>
					</div>
					<div class="row pt-1 pb-1">
						<div class="col-6"> 
							상품명 :
							 <span id="modalCsPdName"></span>
						</div>
						<div class="col-3"> 
							상품갯수 : 
							 <span id="modalCsPdQty"></span>개
						</div>
						<div class="col-3"> 
							상품가격 :
							 <span id="modalCsPdCost"></span>원
						</div>
					</div>
					<div class="row pt-1 pb-1">
						<div class="col"> 
							CS타입 : <span id="modalCsType"></span>
						</div>
						<div class="col"> 
							사유 : <span id="modalCsReason"></span>
						</div>
						<div class="col-4"> 
							처리상태 : <span id="modalCsProcessed"></span>
						</div>
					</div>
					<div class="row pt-1 pb-1">
						<div class="col-3">
						</div>
						<div class="col"> 
							CS이미지 <br/> 
							<img src="" id="modalCsImg" style="width: 300px;"/>
						</div>
						<div class="col-3">
						</div>
					</div>
					
				</div>
				<div style="text-align:center;">
				<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
				style="margin-bottom:15px; width: 200px;"
				data-dismiss="modal" aria-label="Close">확인</button>
				</div>
				</div>
			</div>
	</div> 
	<jsp:include page="../footer.jsp"></jsp:include>
</div>
<script type="text/javascript">
$(function(){
	$("#closeBtn").click(function(){
		$("#info-modal").hide();
	});
	
	// active 클래스 초기화
	$.each($("aside .nav-link"), function(i, nav){
		$(nav).attr("class", "nav-link");
	});
	
	$("#tab-cs-link").addClass("active");
	
});

function openDetailModal(csNo){
	
	$.ajax({
		url : "getDetailCs", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		data : {
			"csNo" : csNo
		}, // 데이터 보내기
		dataType : "json", // 수신받을 데이터 타입 (MINE TYPE)
		success : function(data) {
			console.log(data);
			$("#modalCsNo").text(data.csInfo.csNo);
			$("#modalCsOrderNo").text(data.csInfo.orderNo);
			
			var eDate = new Date(data.csInfo.csDate);
			var year = eDate.getFullYear();
			var month = ('0' + (eDate.getMonth() + 1)).slice(-2);
			var day = ('0' + eDate.getDate()).slice(-2);
			var dateString = year + '-' + month + '-' + day;
			
			$("#modalCsDate").text(dateString);
			$("#modalCsPdName").text(data.csInfo.productName);
			$("#modalCsPdQty").text(data.csInfo.productQuantity);
			$("#modalCsPdCost").text(data.csInfo.salesCost.toLocaleString('ko-KR'));
			$("#modalCsType").text(data.csInfo.csType);
			$("#modalCsReason").text(data.csInfo.reason);
			$("#modalCsImg").attr("src", data.csImg);
			$("#modalCsProcessed").text(data.csInfo.csProcessed);
		
		},
		error : function() {},
		complete : function() {
			$("#info-modal").modal();
		},
	});
	
	
};

function delPdQnA(svBNo){
	$.ajax({
		url : "delPdQnA", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		data : {
			"svBNo" : svBNo
		}, // 데이터 보내기
		dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
		success : function(data) {
			if(data == "success"){
				window.location.reload();
			} else {
				alert("삭제 에러");
			}
			
		},
		error : function() {},
		complete : function() {
		},
	});
	
};

</script>
<style>
.dashboard .btn {
		min-width : 40px;
	}
</style>
</body>
</html>