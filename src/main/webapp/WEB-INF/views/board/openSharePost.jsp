<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글</title>
<script src="https://kit.fontawesome.com/256bd7c463.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/openSharePost.css">
<!-- Favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container">
	    <nav aria-label="breadcrumb" class="breadcrumb-nav mb-3">
	           <div class="container" style="margin-left: 15px;">
	               <ol class="breadcrumb">
	                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/">홈</a></li>
						<li class="breadcrumb-item" aria-current="page"><a href="${pageContext.request.contextPath }/board/shareBoardOpen">정보공유 게시판</a></li>
						<li class="breadcrumb-item active" aria-current="page">게시글</li>
	               </ol>
	           </div><!-- End .container -->
        </nav><!-- End .breadcrumb-nav -->
		
<%-- 		${post } --%>
<%-- 		${postImg } --%>
		<input type="hidden" id="modifyOpenStatus" value="${modifyOpenStatus }"> <!-- 글 수정 페이지가 열리지 않을 때 기록 -->
		<input type="hidden" id="modifyDifference" value="${param.modifyDifference }"> <!-- 글 수정 페이지가 열리지 않을 때 기록 -->
		<input type="hidden" id="loginCustomerUuid" value="${sessionScope.loginCustomer.uuid }"> <!-- 로그인 한 유저의 uuid -->
		<input type="hidden" id="postBoardNo" value="${post.boardNo }"> <!-- 게시글 번호 -->
		
		<table id="infoTable">
			<tr>
				<td id="postTitle" class="postTag">글 제목</td>
				<td id="postTitleInputTd" colspan="5"><input id="postTitleInput" type="text" name="title" value="${post.boardTitle }" readonly></td>
			</tr>
			<tr>
				<td class="postTag">작성자</td>
				<td id="postWriterInputTd"><input id="postWriterInput" class="postInput" type="text" value="${post.writer }" readonly/>
				<input type="hidden" value="${post.uuid }" name="writer"></td>
				<td id="writeTime" class="postTag">작성시간</td>
				<td id="writtenTimeTd"><input id="writtenTime" class="postInput" type="text" name="title" value="${post.writeDate }" readonly></td>
				<td class="postTag">조회수</td>
				<td id="readCountTd"><input id="readCount" class="postInput" type="text" value="${post.boardRead }" readonly/>		
			</tr>
		</table>
		
		<div id="postContentDiv">
			<div id="contentDiv">
				${post.boardContent }
			</div>

			<div id="likeDiv">
				<c:choose>
					<c:when test="${sessionScope.loginCustomer == null }"> 
						<button id="noLoginLikeBtn" class="likeBtn" onclick="alert('로그인 후 좋아요가 가능합니다.');">좋아요 <span id="likeCount">${post.boardLike }</span></button>
					</c:when>
					<c:otherwise>
						<button id="likeBtn" class="likeBtn">좋아요 <span id="likeCount">${post.boardLike }</span></button>
					</c:otherwise>
				</c:choose>
			</div>		
		</div>
		
		<div id="modifyPostBtnBox">
			<button id="listPageBtn" onclick="location.href='${pageContext.request.contextPath }/board/shareBoardOpen';">목록</button>
			<c:if test="${sessionScope.loginCustomer.uuid == post.uuid }">
					<button id="modifyPostBtn" onclick="location.href='${pageContext.request.contextPath }/board/openModifyPost?boardNo=${post.boardNo}';">수정</button>
					<button id="deletePostBtn">삭제</button>
			</c:if>
		</div>
		
		<!-- 댓글 -->
		<div id="replyDiv">
<%-- 			${postReply } --%>
<%-- 			${replyPaging } --%>
			<div id="replyTitle">댓글<span id="replyCount">(${replyPaging.totalPostCnt }개)</span></div>
			<div id="replyInputContainer">
				<c:choose>
					<c:when test="${sessionScope.loginCustomer != null }">
							<textarea id="replyInput" class="replyInput" placeholder="댓글은 300자까지 입력 가능합니다."></textarea>
							<button id="replyInputBtn" onclick="writeReply(event, '${sessionScope.loginCustomer.uuid}');">댓글 입력</button>
					</c:when>
					<c:otherwise>
						<div id="noIdReplyInput" class="replyInput">
							로그인 후 댓글 작성이 가능합니다.
							<a href="${pageContext.request.contextPath}/customer/loginOpen?path=/board/openSharePost?boardNo=${post.boardNo }">로그인 하러 가기</a>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			
			<table id="replyTable">
				<c:forEach var="reply" items="${postReply }" begin="${replyPaging.startNumOfCurrentPagingBlock - 1}" end="${replyPaging.startNumOfCurrentPagingBlock + 8 }">
					<tbody class="replyBody">
						<tr class="replyWriterTr">
							<td class="replyWriterImgTd" rowspan="3">
								<c:choose>
									<c:when test="${reply.userImg != null }">
										<img class="replyWriterImg" src="${reply.userImg }" />
									</c:when>
									<c:otherwise>
										<img class="replyWriterImg" src="${pageContext.request.contextPath }/resources/assets/images/products/details/basic.png">
									</c:otherwise>
								</c:choose>
							</td>
							<td class="replyWriterTd" colspan="2">${reply.writer }<input type="hidden" value="${reply.uuid }"></td>
						</tr>
						<tr class="replyContentTr">
							<td class="replyContentTd" colspan='2'>${reply.replyContent }</td>
						</tr>
						<tr class="writeTimeTr">
							<td class="writeTime">${reply.replyDate }</td>
							<td>
							<c:if test="${sessionScope.loginCustomer.uuid == reply.uuid }">
								<button class="modifyReplyBtn" onclick="openModifyReply(${reply.replyNo}, `${reply.replyContent }`)">수정</button>/<button class="removeReplyBtn" onclick="openRemoveModal(${reply.replyNo});">삭제</button>
							</c:if>
							</td>
						</tr>
					</tbody>
				</c:forEach>	
			</table>
			
			 <nav aria-label="Page navigation">
			    <ul class="pagination">
			        <li class="page-item">
			        	<c:choose>
			        		<c:when test="${replyPaging.pageNo == 1 || replyPaging.pageNo == null || replyPaging.pageNo == ''}">
					            <a class="page-link page-link-prev ml-0 mr-0 disabled" href="#" aria-label="Previous" tabindex="-1" aria-disabled="true" onclick="return false;">처음으로</a>
					        </c:when>
					        <c:otherwise>
					            <a class="page-link page-link-prev ml-0 mr-0" href="#" onclick="return getReplyWithPage(1);" aria-label="Previous" tabindex="-1" aria-disabled="true">처음으로</a>
					        </c:otherwise>
					    </c:choose>
					    
					    <c:choose>
			        		<c:when test="${replyPaging.pageNo == 1 || replyPaging.pageNo == null || replyPaging.pageNo == ''}">
					            <a class="page-link page-link-prev ml-0 mr-0 disabled" href="#" aria-label="Previous" tabindex="-1" aria-disabled="true" onclick="return false;">이전</a>
			            	</c:when>
			            	<c:otherwise>
					            <a class="page-link page-link-prev ml-0 mr-0" href="#" onclick="return getReplyWithPage(${replyPaging.pageNo - 1 });" aria-label="Previous" tabindex="-1" aria-disabled="true">이전</a>
			            	</c:otherwise>
			            </c:choose>
			        </li>
			        
					<c:forEach var="page" begin="${replyPaging.startNumOfCurrentPagingBlock }" end="${replyPaging.startNumOfCurrentPagingBlock + 9 }">
				        <c:if test="${page <= replyPaging.totalPageCnt }">
				        	<c:choose>
				        		<c:when test="${replyPaging.pageNo == page || (replyPaging.pageNo == null && page == 1) || (replyPaging.pageNo == '' && page == 1)}">
				        			<li class="page-item ml-0 mr-0" aria-current="page"><a class="page-link" id="nowPage" href="#" style="color:coral;" onclick="return false;">${page }</a></li>
				        		</c:when>
				        		<c:otherwise>
				        			<li class="page-item ml-0 mr-0" aria-current="page"><a class="page-link" href="#" onclick="return getReplyWithPage(${page });">${page }</a></li>
				        		</c:otherwise>
				        	</c:choose>
				        </c:if>
					</c:forEach>		
					
			        
			        <li class="page-item">
			        	<c:choose>
			        		<c:when test="${replyPaging.pageNo == replyPaging.totalPageCnt || replyPaging.totalPageCnt == 1}">
			            		<a class="page-link page-link-next ml-0 mr-0 disabled" href="#" aria-label="Next" onclick="return false;">다음</a>
			            	</c:when>
			            	<c:otherwise>
			            		<a class="page-link page-link-next ml-0 mr-0" href="#" onclick="return getReplyWithPage(${replyPaging.pageNo + 1 });" aria-label="Next">다음</a>
			            	</c:otherwise>
			            </c:choose>
			            
			            <c:choose>
			        		<c:when test="${replyPaging.pageNo == replyPaging.totalPageCnt || replyPaging.totalPageCnt == 1}">
			            		<a class="page-link page-link-next ml-0 mr-0 disabled" href="#" aria-label="Next" onclick="return false;">끝으로</a>
			            	</c:when>
			            	<c:otherwise>
			            		<a class="page-link page-link-next ml-0 mr-0" href="#" onclick="return getReplyWithPage(${replyPaging.totalPageCnt });" aria-label="Next">끝으로</a>
			            	</c:otherwise>
			            </c:choose>
			        </li>
			    </ul>
			</nav>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<div class="modal" id="deleteCheck">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">정말 삭제하시겠습니까?</h4>
					<button type="button" class="btn-close close"
						data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">${post.boardNo}번 글을 삭제합니다.</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal"
						onclick="location.href='/board/removeSharePost?boardNo=${post.boardNo}';">삭제</button>
					<button type="button" class="btn btn-danger close"
						data-bs-dismiss="modal">취소</button>
				</div>

			</div>
		</div>
		
	</div>
	
	<div class="modal" id="deleteReply">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="btn-close close"
						data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">정말 댓글을 삭제하시겠습니까?</div>
				<input type="hidden" value="" id="removeModalReplyNo">

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal"
						onclick="removeReply();">삭제</button>
					<button type="button" class="btn btn-danger close"
						data-bs-dismiss="modal">취소</button>
				</div>

			</div>
		</div>
	</div>
	
	<div class="modal" id="modifyReply">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="btn-close close"
						data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<textarea id="modifyInput" class="replyInput" placeholder="댓글은 300자까지 입력 가능합니다."></textarea>
				</div>
				<input type="hidden" value="" id="modifyModalReplyNo">

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal"
						onclick="modifyReply(event);">수정</button>
					<button type="button" class="btn btn-danger close"
						data-bs-dismiss="modal">취소</button>
				</div>

			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/board/openSharePost.js"></script>
</body>
</html>