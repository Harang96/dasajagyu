<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA</title>
<meta name="keywords" content="HTML5 Template">
<meta name="description" content="Molla - Bootstrap eCommerce Template">
<meta name="author" content="p-themes">
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
<%!SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<c:set var="URL" value="${pageContext.request.requestURL}" />
<style>
.table-faq {
	background-color: red;
}
</style>
</head>
<body>
	<div class="page-wrapper">
		<jsp:include page="../header.jsp"></jsp:include>

		<main class="main mainFontStyle">
			<div class="page-header text-center">
				<!-- <div class="page-header text-center" style="background-image: url('assets/images/page-header-bg.jpg')"> -->
				<div class="container">
					<h1 class="page-title">QnA</h1>
				</div>
			</div>
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
												<c:choose>
													<c:when test="${qnaList != null }">
														<table class="table">
															<thead>
																<tr>
																	<th>글번호</th>
																	<th>제 목</th>
																	<th>작성자</th>
																	<th>작성일</th>
																	<th>답글</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach var="qna" items="${qnaList }">
																	<c:choose>
																		<c:when test="${qna.svIsDelete ne 'Y' and qna.svIsHidden ne 'Y' }">
																			<tr id='board${board.svBoardNo }' class='board' onclick="location.href='/contact/qna/detail?no=${qna.svBoardNo}'">
																				<td>${qna.svBoardNo }</td>
																				<td>${qna.svBoardTitle }</td>
																				<td><c:choose>
																						<c:when test="${qna.nickname != null }">${qna.nickname }</c:when>
																						<c:otherwise>비회원</c:otherwise>
																					</c:choose></td>
																				<td><fmt:formatDate value="${qna.svBoardRegiDate}" pattern="yyyy-MM-dd" /></td>
																				<td><c:if test="${qna.commentBoardNo ne null}">답변완료</c:if></td>
																			</tr>
																		</c:when>
																	</c:choose>
																</c:forEach>
															</tbody>
														</table>

													</c:when>
													<c:otherwise>
														<p>게시글이 없습니다.</p>
													</c:otherwise>
												</c:choose>
											</div>

											<c:if test="${sessionScope.loginCustomer.uuid != null }">
												<div id="modifyPostBtnBox">
													<a href="/contact/newWrite?svType=qna" class="btn btn-primary btn-round">글쓰기</a>
												</div>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End .container -->
					</div>
					<!-- End .page-content -->
				</div>
			</div>
		</main>

		<jsp:include page="../footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
		$(function() {
			// active 클래스 초기화
			$.each($("aside .nav-link"), function(i, nav) {
				$(nav).attr("class", "nav-link");
			});

			$("#tab-qna-link").addClass("active");
		});

	</script>
</body>
</html>