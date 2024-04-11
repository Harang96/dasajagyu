<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA</title>
<script src="https://kit.fontawesome.com/256bd7c463.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/openSharePost.css">
<!-- Favicon -->
<link rel="apple-touch-icon" sizes="180x180" href="/resources/assets/images/icons/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="/resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/resources/assets/images/icons/favicon-16x16.png">
<link rel="manifest" href="/resources/assets/images/icons/site.html">
<link rel="mask-icon" href="/resources/assets/images/icons/safari-pinned-tab.svg" color="#666666">
<link rel="shortcut icon" href="/resources/assets/images/icons/favicon.ico">
<meta name="apple-mobile-web-app-title" content="Molla">

<meta name="application-name" content="Molla">
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<c:set var="URL" value="${pageContext.request.requestURL}" />
<style>
.table-wishlist {
	background-color: red;
}

#contentBox {
	white-space: pre-wrap;
	word-wrap: break-word;
}

.primaryBorderColor : {
	border: 1px solid #ef837b;
}

.contentArea {
	min-height: 200px;
	border: 1px solid #ef837b;
	padding: 5px 10px;
}
</style>
</head>
<body>
	<div class="page-wrapper">
		<jsp:include page="../header.jsp"></jsp:include>

		<main class="main mainFontStyle">
			<div class="page-header text-center">
				<div class="container">
					<h1 class="page-title">QnA</h1>
				</div>
				<!-- End .container -->
			</div>
			<!-- End .page-header -->
			<nav aria-label="breadcrumb" class="breadcrumb-nav">
				<div class="container">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="/">홈</a></li>
						<li class="breadcrumb-item"><a href="/">고객 서비스</a></li>
						<li class="breadcrumb-item active" aria-current="page">QnA</li>
					</ol>
				</div>
			</nav>
			<div class="page-content">
				<div class="container">
					<div class="row">
						<div class="form-tab">
							<div class="tab-content" id="tab-content-5">
								<div class="tab-pane fade show active" id="agree" role="tabpanel" aria-labelledby="agree-tab">
									<div class="form-group">
										<div id="termsStyle" class="col privacy">
											<div class="boardList">
												<table id="infoTable">
													<tr>
														<td class="postTag">글 번호</td>
														<td>${data.commentBoardNo }</td>
														<td class="postTag">글 제목</td>
														<td>${data.svBoardTitle }</td>
														<td class="postTag">작성시간</td>
														<td>${data.svBoardRegiDate }</td>
													</tr>
													<tr>
														<td class="postTag">작성자</td>
														<td id="postWriterInputTd">${data.nickname }</td>
														<td class="postTag">주문번호</td>
														<td id="postWriterInputTd">${data.orderNo }</td>
														<td class="postTag">상품번호</td>
														<td id="postWriterInputTd">${data.productNo }</td>
													</tr>
												</table>

												<div class="contentArea" id="contentBox">${data.svBoardContent }</div>
												<c:if test="${sessionScope.loginCustomer.uuid == data.uuid or (sessionScope.loginCustomer.isAdmin eq 'M' or sessionScope.loginCustomer.isAdmin eq 'A')}">
													<div id="modifyPostBtnBox">
														<button id="modifyPostBtn" onclick="location.href='/contact/editWrite?svType=qna&svBoardNo=${data.svBoardNo }'" class="btn btn-primary btn-round">수정</button>
														<button id="deletePostBtn" onclick="deleteWrite()" class="btn btn-primary btn-round">삭제</button>
													</div>
												</c:if>
												<c:if test="${data.commentBoardNo eq null }">
													<c:if test="${sessionScope.loginCustomer.isAdmin eq 'M' or sessionScope.loginCustomer.isAdmin eq 'A'}">
														<div id="modifyPostBtnBox">
															<button id="modifyPostBtn" onclick="location.href='/contact/newWrite?svType=qna&commentBoardNo=${data.svBoardNo}'" class="btn btn-primary btn-round">답글</button>
														</div>
													</c:if>
												</c:if>

											</div>
											<c:if test="${data.commentBoardNo ne null }">
												<div class="container">
													<table id="infoTable">
														<tr>
															<td class="postTag">답글 제목</td>
															<td colspan="8"><input id="postTitleInput" type="text" name="title" value="${commentBoard.svBoardTitle }" readonly></td>
															<td class="postTag">작성시간</td>
															<td><input id="writtenTime" class="postInput" type="text" name="title" value="${commentBoard.svBoardRegiDate }" readonly></td>
														</tr>
													</table>
													<div class="contentArea" id="contentBox">${requestScope.commentBoard.svBoardContent }</div>

												</div>
											</c:if>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			

		</main>
		<!-- End .main -->

		<script src="${pageContext.request.contextPath}/resources/js/board/openSharePost.js"></script>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>

	<script type="text/javascript">
	$(function(){
		// active 클래스 초기화
		$.each($("aside .nav-link"), function(i, nav){
			$(nav).attr("class", "nav-link");
		});
		
		$("#tab-qna-link").addClass("active");
	});

	function deleteWrite(){
		if(confirm("게시글을 삭제하시겠습니까?")){
			location.href='/contact/deleteWrite?svType=qna&svBoardNo='+${requestScope.data.svBoardNo }
		}
	}
	
</script>
</body>
</html>