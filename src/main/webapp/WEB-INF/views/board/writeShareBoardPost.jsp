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
	<title>글쓰기</title>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/writeShareBoardPost.css">
  	<!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
</head>
<body>
	<!-- 로그인 하지 않은 유저는 로그인 페이지로 보내기 -->
	<c:if test="${sessionScope.loginCustomer == null }">
		<c:redirect url="${pageContext.request.contextPath }/customer/loginOpen?path=/board/writeShareBoard"/>	
	</c:if>
	
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container">
		<nav aria-label="breadcrumb" class="breadcrumb-nav mb-3">
	           <div class="container" style="margin-left: 15px;">
	               <ol class="breadcrumb">
	                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/">홈</a></li>
						<li class="breadcrumb-item" aria-current="page"><a href="${pageContext.request.contextPath }/board/shareBoardOpen">정보공유 게시판</a></li>
						<li class="breadcrumb-item active" aria-current="page">게시글 작성</li>
	               </ol>
	           </div><!-- End .container -->
        </nav><!-- End .breadcrumb-nav -->
		<form action="saveWrittenShareBoardPost" method="post">
			<table id="infoTable">
				<tr>
					<td id="postTitle" class="postTag">글 제목</td>
					<td id="postTitleInputTd"><input id="postTitleInput" type="text" name="title"></td>
					<td class="postTag">작성자</td>
					<td id="postWriterInputTd"><input id="postWriterInput" type="text" value="${sessionScope.loginCustomer.nickname }" readonly/>
					<input type="hidden" value="${sessionScope.loginCustomer.uuid }" name="writer"></td>
				</tr>
			</table>
			<textarea class="summernote" name="content" id="contentInput"></textarea>
			
			
<!-- 			<div class="input-group mb-3 mt-3"> -->
<!-- 			    <span class="input-group-text">첨부 파일</span> -->
<!-- 			    <div class="upFileArea" style="">업로드할 파일 끌어오기</div> -->
<!-- 			    <div class="uploadFiles"></div> -->
<!-- 			</div> -->
			
			
			<div id="savePostBtnBox">
				<button type="submit" id="savePostBtn" onclick="checkBlank(event);">작성</button>
				<button type="reset" id="resetPostBtn" onclick="location.href='shareBoardOpen';">취소</button>
			</div>
		</form>    
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<!-- summernote 관련 스크립트 -->
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
	<script src="https://kit.fontawesome.com/256bd7c463.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
  	<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
  	<script src="${pageContext.request.contextPath}/resources/js/board/writeShareBoardPost.js"></script>
</body>
</html>