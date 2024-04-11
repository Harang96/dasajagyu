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
<title>게시글 수정</title>
<!-- Favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/256bd7c463.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/modifySharePost.css">

</head>
<body>
<!-- 로그인 하지 않은 유저는 로그인 페이지로 보내기 -->
<c:if test="${sessionScope.loginCustomer == null }">
	<c:redirect url="${pageContext.request.contextPath }/customer/loginOpen?path=/board/openModifyPost?boardNo=${post.boardNo }"/>	
</c:if>

<!-- 작성자와 다르면 원래 페이지로 돌리기 -->
<c:if test="${sessionScope.loginCustomer.uuid != post.uuid }">
	<c:redirect url="${pageContext.request.contextPath }/board/openSharePost?boardNo=${post.boardNo }&modifyDifference=diff"/>	
</c:if>

	<jsp:include page="../header.jsp"></jsp:include>
	<input type="hidden" id="modifyStatus" value="${modifyStatus }">
	
	<div class="container">
		<nav aria-label="breadcrumb" class="breadcrumb-nav mb-3">
	           <div class="container" style="margin-left: 15px;">
	               <ol class="breadcrumb">
	                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/">홈</a></li>
						<li class="breadcrumb-item" aria-current="page"><a href="${pageContext.request.contextPath }/board/shareBoardOpen">정보공유 게시판</a></li>
						<li class="breadcrumb-item active" aria-current="page">게시글 수정</li>
	               </ol>
	           </div><!-- End .container -->
        </nav><!-- End .breadcrumb-nav -->
        
        
		<form action="modifyShareBoardPost" method="post">
			<table id="infoTable">
				<tr>
					<td id="postTitle" class="postTag">글 제목</td>
					<td id="postTitleInputTd"><input id="postTitleInput" type="text" name="title" value="${post.boardTitle }"></td>
					<td class="postTag">작성자</td>
					<td id="postWriterInputTd"><input id="postWriterInput" type="text" value="${post.writer}" readonly/>
					<input type="hidden" name="boardNo" value="${post.boardNo }">
				</tr>
			</table>
			<textarea class="summernote" name="content" id="contentInput">${post.boardContent }</textarea>
			
			<div id="savePostBtnBox">
				<button type="submit" id="savePostBtn" onclick="checkBlank(event);">저장</button>
				<button type="reset" id="resetPostBtn" onclick="location.href='openSharePost?boardNo=${post.boardNo}';">취소</button>
			</div>
		</form>    
		<input type='hidden' value='${writeStatus }' id="writeStatus">
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
  	<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
  	<script src="${pageContext.request.contextPath}/resources/js/board/modifyShareBoard.js"></script>
</body>
</html>