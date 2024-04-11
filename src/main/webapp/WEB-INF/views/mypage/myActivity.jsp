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
<title>나의 활동내역</title>
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
<!-- <link rel="manifest" href="/resources/assets/images/icons/site.html"> -->
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
<script type="text/javascript">
$(function(){
	
	// active 클래스 초기화
	$.each($("aside .nav-link"), function(i, nav){
		$(nav).attr("class", "nav-link");
	});

	$("#tab-active-link").addClass("active");
});


function redirectToLink(categoryNo, boardNo) {
    switch (categoryNo) {
        case 1:
            window.location.href = '${pageContext.request.contextPath}/board/openSharePost?boardNo=' + boardNo;
            break;
        case 2:
            window.location.href = '${pageContext.request.contextPath}/board/openSharePost?boardNo=' + boardNo;
            break;
        case 3:
            window.location.href = '${pageContext.request.contextPath}/board/originalViewboard?boardNo=' + boardNo;
            break;
        case 4:
            window.location.href = '${pageContext.request.contextPath}/board/#?boardNo=' + boardNo;
            break;
        case 5:
            window.location.href = '${pageContext.request.contextPath}/board/listAllBoast?boardNo=' + boardNo;
            break;
        case 6:
            window.location.href = '${pageContext.request.contextPath}/board/eventBoard?boardNo=' + boardNo;
            break;
        default:
            // 기타 처리
            break;
    }
}
</script>
<style type="text/css">
h4 {
	font-weight: bold !important;
	margin-bottom: 50px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 0;
	border-bottom: 1px solid #dddddd text-align: left;
	padding: 8px;
}

/* th {
	background-color: #f2f2f2;
} */
th,td {
	 border-bottom: 1px solid lightgray !important;
     transition: background-color 0.3s ease;
}
tbody tr:hover {
     background-color: lightgray;
}
.comulist {
  border-top: 2px solid #222 !important;
  margin-bottom: 80px;
}
.replylist {  
  border-top: 2px solid #222 !important;
  margin-bottom: 80px;
}
.replyContent{
	padding: 8px;
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
  	width: 500px;
  	height: 43px;
}
.replyBoardTitle{
	padding: 8px;
	display: block;
	overflow: hidden;
 	text-overflow: ellipsis;
  	white-space: nowrap;
  	width: 300px;
  	height: 43px;
}


#adboard:hover {
	cursor: pointer;
	
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
								<div>
									<h4>내가 쓴 커뮤니티 글</h4>
								
									<table class="comulist">
										<thead>
										<tr>
											<th>글번호</th>
											<th>게시판</th>
											<th>제목</th>
											<th>닉네임</th>
											<th>작성일</th>
											<th>조회수</th>
											<th>좋아요</th>
											</tr>
										</thead>
										<tbody>
										
										<c:forEach items="${adboard}" var="adboard">
											 <tr id= "adboard" onclick="redirectToLink(${adboard.categoryno}, ${adboard.boardno})">
											 	<td>${adboard.boardno}</td>

												<td>
												  <c:choose>
       												 <c:when test="${adboard.categoryno == 1}">
            											자유
											        </c:when>
											        <c:when test="${adboard.categoryno == 2}">
											            정보공유
											        </c:when>
											        <c:when test="${adboard.categoryno == 3}">
											            작품별
											        </c:when>
											        <c:when test="${adboard.categoryno == 4}">
											            커뮤니티공지
											        </c:when>
											        <c:when test="${adboard.categoryno == 5}">
											            자랑
											        </c:when>
											        <c:when test="${adboard.categoryno == 6}">
											            이벤트
											        </c:when>
											        
											      </c:choose>
												</td>
												<td>${adboard.boardtitle}</td>
												<td>${adboard.nickname}</td>
												<td>${adboard.writedate}</td>
												<td>${adboard.boardread}</td>
												<td>${adboard.boardlike}</td>
												
											</tr>
										</c:forEach>
										</tbody>
									</table>
									
									
									<h4>내가 쓴 댓글</h4>
										<table class="replylist">
										<thead>
										<tr>
											<th>댓글번호</th>
											<th>댓글내용</th>
											<th>작성시간</th>
											<th>글제목</th>
											<th>게시판</th>
											</tr>
										</thead>
										<tbody>
										
										<c:forEach items="${reply}" var="replyItem">
											<tr id= "adboard" onclick="redirectToLink(${replyItem.categoryno}, ${replyItem.boardNo})"> 
											
												<td>${replyItem.replyNo}</td>
												<td><span class="replyContent">${replyItem.replyContent}</span></td>
												<%-- <td>${replyItem.replyDate}</td>		 --%>						
												<td><fmt:formatDate value="${replyItem.replyDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>								
											 	<td><span class="replyBoardTitle">${replyItem.boardtitle}</span></td>

												<td>
												  <c:choose>
       												 <c:when test="${replyItem.categoryno == 1}">
            											자유
											        </c:when>
											        <c:when test="${replyItem.categoryno == 2}">
											            정보공유
											        </c:when>
											        <c:when test="${replyItem.categoryno == 3}">
											            작품별
											        </c:when>
											        <c:when test="${replyItem.categoryno == 4}">
											            커뮤니티공지
											        </c:when>
											        <c:when test="${replyItem.categoryno == 5}">
											            자랑
											        </c:when>
											        <c:when test="${replyItem.categoryno == 6}">
											            이벤트
											        </c:when>
											        
											      </c:choose>
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
																  
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- footer 파일 인클루드 -->
  </div>
</body>
</html>