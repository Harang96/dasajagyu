<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>작품별 게시판</title>
<!-- Favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
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


    <!-- Bootstrap v4.3.1 -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    />
    <!-- Bootstrap v5.3.2 -->
    <link rel="stylesheet" href="/resources/assets/css/skins/skin-demo-2.css" />
    <link rel="stylesheet" href="/resources/assets/css/demos/demo-2.css" />
    <link rel="stylesheet" href="/resources/css/product.css" />
<!-- Plugins CSS File -->
<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
<!-- Main CSS File -->
<link rel="stylesheet" href="/resources/assets/css/style.css">
    <!-- Plugins Js File -->
    <script src="/resources/assets/js/jquery.min.js"></script>
    <script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
    <script src="/resources/assets/js/jquery.waypoints.min.js"></script>
    <script src="/resources/assets/js/superfish.min.js"></script>
    <script src="/resources/assets/js/owl.carousel.min.js"></script>
    <script src="/resources/assets/js/jquery.plugin.min.js"></script>
    <script src="/resources/assets/js/bootstrap-input-spinner.js"></script>
    <script src="/resources/assets/js/jquery.elevateZoom.min.js"></script>
    <script src="/resources/assets/js/jquery.magnific-popup.min.js"></script>
    <script src="/resources/assets/js/jquery.countdown.min.js"></script>

    <!-- Main JS File -->
    <script src="/resources/assets/js/main.js"></script>
    <script src="/resources/assets/js/demos/demo-2.js"></script>
    <script src="/resources/js/header.js"></script>
    <!-- 로그인 -->
</head>
<style>


select {
    width: 250px; /* 너비 설정 */
    height: 36px; /* 높이 설정 */
    border: 1px solid #ccc; /* 테두리 설정 */
    border-radius: 5px; /* 테두리 둥글기 설정 */
    padding: 5px; /* 안쪽 여백 설정 */
    background-color: #f8f9fa; /* 배경색 설정 */
    color: #333; /* 텍스트 색상 설정 */
    font-size: 16px; /* 폰트 크기 설정 */
    float: right;
    
}

/* .container { */
/*     display: flex; /* 자식 요소를 행으로 배치하는 flex 컨테이너로 설정 */ */
/*     align-items: center; /* 자식 요소를 수직 가운데 정렬 */ */
/* } */

/* .container select { */
/*     margin-left: auto; /* 왼쪽 여백을 자동으로 지정하여 오른쪽으로 이동 */ */
/* } */



.boardlist {
 background-color: #f8f9fa; 
 color: #333;
 

}
#headerno {

float : right;

}

#sidebar {

float : right;

}

.tabContainer {
    margin: 10px auto;
    width: fit-content;
}

</style>

<script type="text/javascript">
	
</script>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	
	<div class="tabContainer">
		<h2>작품별 게시판</h2>
	</div>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
	<div class="header-search-wrapper search-wrapper-wide">
		<nav aria-label="breadcrumb" class="breadcrumb-nav mb-2">
			<div class="container">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">다사자규</a></li>
					<li class="breadcrumb-item"><a href="#">커뮤니티</a></li>
					<li class="breadcrumb-item active" aria-current="page">작품별 게시판</li>
				</ol>
				<select id="boardCategoryNo" style=" margin-top: 40px;">
				<c:forEach var="category" items="${categoryList }">
					<option value="${category.boardCategoryNo }" <c:if test="${originalCategory eq category.boardCategoryNo}">selected</c:if>>${category.boardCategoryName }</option>
				</c:forEach>
				</select>
			</div>
			<!-- End .container -->
		</nav>
		<!-- End .breadcrumb-nav -->
	</div>
	
	<div class="container">
		<div class="boardList">
		<c:choose>
			<c:when test="${boardList != null }">
				<table class="table table-hover table-striped">
				    <thead>
				      <tr>
				        <th>글번호</th>
				        <th>제 목</th>
				        <th>내 용</th>
				        <th>작성자</th>
				        <th>작성일</th>
				        <th>조회수</th>
				      	<th>카테고리명</th>
				      </tr>
				    </thead>
			    	<tbody>
			    		<c:forEach var="board" items="${boardList}" >
			    					<tr class="boardlist" id='board${board.boardNo }' class='board' onclick="location.href='originalViewboard?boardNo=${board.boardNo}'">
					    				<td>${board.boardNo }</td>
					    				<td>${board.boardTitle }</td>	
					    				<td>${board.boardContent }</td>
					    				<td>${board.nickname }</td>
					    				<td>${board.writeDate }</td>
					    				<td>${board.boardRead }</td>
					    				<td>${board.boardCategoryName }</td>
			    		</c:forEach>
    				</tbody>
			  </table>
			</c:when>
			<c:otherwise>
				<div style="font-size : 150px;">텅~~!</div>
			</c:otherwise>
		</c:choose>
	</div>
<!-- 	<aside class="col-lg-3"> -->
<!-- 		<div class="sidebar"> -->
<!-- 			<div class="widget widget-cats"> -->
<!-- 				<h3 class="widget-title">인기 카테고리</h3> -->
<!-- 				<ul> -->
<!-- 					<li><a href="#">윈피스<span></span></a></li> -->
<!-- 					<li><a href="#">나루토<span></span></a></li> -->
<!-- 					<li><a href="#">블리츠<span></span></a></li> -->
<!-- 					<li><a href="#">귀멸의 칼날<span></span></a></li> -->
<!-- 				</ul> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<!-- End .sidebar --> 
<!-- 	</aside> -->
		<%-- 	<div>${param}</div> --%>
		<%-- 	<div>${param.pageNo == null }</div> --%>

		<div class="mt-3 paging">
			<ul class="pagination">
				<c:if test="${pagingInfo.pageNo == 1 }">
					<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
				</c:if>

				<c:if test="${param.pageNo > 1 }">
					<li class="page-item"><a class="page-link"
						href="originalBoard.bo?pageNo=${param.pageNo - 1}&searchType=${param.searchType}&searchWord=${param.searchWord}">Previous</a></li>
				</c:if>

				<c:forEach var="i"
					begin="${requestScope.pagingInfo.startNumOfCurrentPagingBlock}"
					end="${requestScope.pagingInfo.endNumOfCurrentPagingBlock}">

					<c:choose>
						<c:when test="${pagingInfo.pageNo == i}">
							<li class="page-item"><a class="page-link active"
								href="originalBoard?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="originalBoard?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when
						test="${pagingInfo.pageNo < requestScope.pagingInfo.totalPageCnt }">
						<li class="page-item"><a class="page-link"
							href="originalBoard?pageNo=${pagingInfo.pageNo + 1}&searchType=${param.searchType}&searchWord=${param.searchWord}">Next</a></li>
					</c:when>
					<c:when
						test="${pagingInfo.pageNo == requestScope.pagingInfo.totalPageCnt}">
						<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
					</c:when>
				</c:choose>
			</ul>

			<c:if test="${sessionScope.loginCustomer != null}">
				<input type="button" value="글쓰기" class="btn btn-primary"
					id="writeBoard"
					onclick="location.href='/board/originalWriteboard?boardNo=${board.boardNo}'">
			</c:if>

		</div>

</div>
<jsp:include page="../footer.jsp"></jsp:include>

	<!-- Plugins JS File -->
	<script src="/resources/assets/js/jquery.min.js"></script>
	<script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
	<script src="/resources/assets/js/jquery.waypoints.min.js"></script>
	<script src="/resources/assets/js/superfish.min.js"></script>
	<script src="/resources/assets/js/owl.carousel.min.js"></script>
	<!-- Main JS File -->
	<script src="/resources/assets/js/main.js"></script>
	<script>
		$("#boardCategoryNo").change(function(){
			location.href = "originalBoard?categoryNo=3&originalCategory=" + $(this).val()
		})
	
	</script>
	
	
</body>
</html>