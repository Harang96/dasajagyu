<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html lang="KO">
<!-- molla/blog-listing.html  22 Nov 2019 10:04:10 GMT -->
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>정보공유 게시판</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
	<link rel="stylesheet" href="../resources/css/board/listOfShareBoard.css">
</head>

<body>
<%-- 	<div>${sbList }</div> --%>
	<jsp:include page="../header.jsp"></jsp:include>
    <div class="page-wrapper">
        <main class="main">
        	<div class="page-header text-center" id="shareBoardHeader" style="background-image: url('assets/images/page-header-bg.jpg')">
        		<div class="container">
        			<h1 class="page-title">정보공유 게시판</h1>
        		</div><!-- End .container -->
        	</div><!-- End .page-header -->
            <nav aria-label="breadcrumb" class="breadcrumb-nav mb-3">
                <div class="container">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/">홈</a></li>
						<li class="breadcrumb-item active" aria-current="page">정보공유 게시판</li>
                    </ol>
                </div><!-- End .container -->
            </nav><!-- End .breadcrumb-nav -->

            <div class="page-content">
                <div class="container">
                	<div class="row">
                		<div class="col-lg-9">
                           	<!-- 게시글 리스트 -->
<%-- 								<div>${pagingInfo }</div> --%>
							<div id="listTable">
                            	<table>
                            		<thead>
                            			<tr class="listHead">
                            				<th class="boardNo">글 번호</th>
											<th class="boardTitle">제목</th>
											<th class="writer">작성자</th>
                            				<th class="writeTime">작성 시간</th>
                            				<th class="readCount">조회수</th>
                            				<th class="likeCount">좋아요</th>
                            			</tr>
                            		</thead>
                            		<tbody>
                            			<c:choose>
                            				<c:when test="${sbList.size() == 0 }">
                            					<tr>
                            						<td colspan="6" id="noListMsg">게시글이 존재하지 않습니다.</td>
                            					</tr>
                            				</c:when>
                            				<c:otherwise>
		                            			<c:forEach var="shareBoard" items="${sbList }" begin="${pagingInfo.startRowIndex }" end="${pagingInfo.startRowIndex + 19 }">
													<tr onclick="location.href='openSharePost?boardNo=${shareBoard.boardNo}'" class="listTag">
			                            				<td class="boardNo">${shareBoard.boardNo }</td>
			                            				<td class="boardTitle">${shareBoard.boardTitle }</td>
			                            				<td class="writer">${shareBoard.writer }</td>
			                            				<td class="writeTime">${shareBoard.writeDate }</td>
			                            				<td class="readCount">${shareBoard.boardRead }</td>
			                            				<td class="likeCount">${shareBoard.boardLike }</td>
			                            			</tr>
		                            			</c:forEach>
                            				</c:otherwise>
                            			</c:choose>
                            		</tbody>
                            	</table>
								<div id="writePostBtnBox">
									<button id="writePostBtn" onclick="location.href='writeShareBoard'">글쓰기</button>
								</div>
                           	</div>
                            <!-- 게시글 리스트 끝 -->
                                <nav aria-label="Page navigation">
							    <ul class="pagination">
							        <li class="page-item">
							        	<c:choose>
							        		<c:when test="${param.pageNo == 1 || param.pageNo == null || param.pageNo == ''}">
									            <a class="page-link page-link-prev ml-0 mr-0 disabled" href="#" aria-label="Previous" tabindex="-1" aria-disabled="true" onclick="return false;">처음으로</a>
									        </c:when>
									        <c:otherwise>
									            <a class="page-link page-link-prev ml-0 mr-0" href="shareBoardOpen?pageNo=1&searchWord=${param.searchWord}" aria-label="Previous" tabindex="-1" aria-disabled="true">처음으로</a>
									        </c:otherwise>
									    </c:choose>
									    
									    <c:choose>
							        		<c:when test="${param.pageNo == 1 || param.pageNo == null || param.pageNo == ''}">
									            <a class="page-link page-link-prev ml-0 mr-0 disabled" href="#" aria-label="Previous" tabindex="-1" aria-disabled="true" onclick="return false;">이전</a>
							            	</c:when>
							            	<c:otherwise>
									            <a class="page-link page-link-prev ml-0 mr-0" href="shareBoardOpen?pageNo=${param.pageNo - 1 }&searchWord=${param.searchWord}" aria-label="Previous" tabindex="-1" aria-disabled="true">이전</a>
							            	</c:otherwise>
							            </c:choose>
							        </li>
							        
									<c:forEach var="page" begin="${pagingInfo.startNumOfCurrentPagingBlock }" end="${pagingInfo.startNumOfCurrentPagingBlock + 9 }">
								        <c:if test="${page <= pagingInfo.totalPageCnt }">
								        	<c:choose>
								        		<c:when test="${param.pageNo == page || (param.pageNo == null && page == 1) || (param.pageNo == '' && page == 1)}">
								        			<li class="page-item ml-0 mr-0" aria-current="page"><a class="page-link" href="shareBoardOpen?pageNo=${page }&searchWord=${param.searchWord}&searchType=${param.searchType}" style="color:coral;" onclick="return false;">${page }</a></li>
								        		</c:when>
								        		<c:otherwise>
								        			<li class="page-item ml-0 mr-0" aria-current="page"><a class="page-link" href="shareBoardOpen?pageNo=${page }&searchWord=${param.searchWord}&searchType=${param.searchType}">${page }</a></li>
								        		</c:otherwise>
								        	</c:choose>
								        </c:if>
									</c:forEach>								        
							        
							        
							        <li class="page-item">
							        	<c:choose>
							        		<c:when test="${param.pageNo == pagingInfo.totalPageCnt || pagingInfo.totalPageCnt == 1}">
						            			<a class="page-link page-link-next ml-0 mr-0 disabled" href="#" aria-label="Next" onclick="return false;">다음</a>
							            	</c:when>
							            	<c:otherwise>
							            		<a class="page-link page-link-next ml-0 mr-0" href="shareBoardOpen?pageNo=${param.pageNo + 1 }&searchWord=${param.searchWord}&searchType=${param.searchType}" aria-label="Next">다음</a>
							            	</c:otherwise>
							            </c:choose>
							            
							            <c:choose>
							        		<c:when test="${param.pageNo == pagingInfo.totalPageCnt || pagingInfo.totalPageCnt == 1}">
							            		<a class="page-link page-link-next ml-0 mr-0 disabled" href="#" aria-label="Next" onclick="return false;">끝으로</a>
							            	</c:when>
							            	<c:otherwise>
							            		<a class="page-link page-link-next ml-0 mr-0" href="shareBoardOpen?pageNo=${pagingInfo.totalPageCnt }&searchWord=${param.searchWord}&searchType=${param.searchType}" aria-label="Next">끝으로</a>
							            	</c:otherwise>
							            </c:choose>
							        </li>
							    </ul>
							</nav>
                		</div><!-- End .col-lg-9 -->

                		<aside class="col-lg-3 rightAside">
                			<div class="sidebar mt-1">
                				<div class="widget widget-search">
                                    <h3 class="widget-title">검색 <span id="spanTotalPostCnt">총 게시글 수 : ${pagingInfo.totalPostCnt }</span>&nbsp;
                               			<select class="searchSelect" onchange="changeSearchType(this);">
	                                    	<c:choose>
	                                    		<c:when test="${param.searchType == null || param.searchType == '' || param.searchType == 'title' }">
	                                    			<option value="title" class="optionsOfSelect" selected>제목</option>
		                                    		<option value="writer" class="optionsOfSelect">작성자</option>
		                                    		<option value="content" class="optionsOfSelect">내용</option>
												</c:when>
	                                    		<c:when test="${param.searchType == 'writer' }">
	                                    			<option value="title" class="optionsOfSelect">제목</option>
		                                    		<option value="writer" class="optionsOfSelect" selected>작성자</option>
		                                    		<option value="content" class="optionsOfSelect">내용</option>
												</c:when>
	                                    		<c:otherwise>
	                                    			<option value="title" class="optionsOfSelect">제목</option>
		                                    		<option value="writer" class="optionsOfSelect">작성자</option>
		                                    		<option value="content" class="optionsOfSelect" selected>내용</option>
		                                   		</c:otherwise>
	                                    	</c:choose>
    									</select>                               		
                                    	<button id="searchResetBtn" onclick="location.href='/board/shareBoardOpen';">초기화</button>
                                   	</h3><!-- End .widget-title -->

                                    <form action="shareBoardOpen">
                                    	<input type="hidden" value="${param.pageNo }" name="pageNo">
										<c:choose>
	                                    	<c:when test="${param.searchType == null || param.searchType == ''}">
	                                    		<input type="hidden" value="title" id="formSearchType" name="searchType">
	                                    	</c:when>
	                                    	<c:otherwise>
	                                    		<input type="hidden" value="${param.searchType }" id="formSearchType" name="searchType">
	                                    	</c:otherwise>
                                    	</c:choose>
                                        <label for="ws" class="sr-only">검색할 단어를 입력하세요.</label>
                                        <input type="search" class="form-control" name="searchWord" id="ws" placeholder="검색할 단어를 입력하세요." required>
                                        <button type="submit" class="btn"><i class="icon-search"></i><span class="sr-only">Search</span></button>
                                    </form>
                				</div><!-- End .widget -->

<!--                                 <div class="widget widget-cats"> -->
<!--                                     <h3 class="widget-title">검색 조건</h3>End .widget-title -->

<!--                                     <ul> -->
<!--                                         <li><a href="#">Lifestyle<span>3</span></a></li> -->
<!--                                         <li><a href="#">Shopping<span>3</span></a></li> -->
<!--                                         <li><a href="#">Fashion<span>1</span></a></li> -->
<!--                                         <li><a href="#">Travel<span>3</span></a></li> -->
<!--                                         <li><a href="#">Hobbies<span>2</span></a></li> -->
<!--                                     </ul> -->
<!--                                 </div>End .widget -->

                                <div class="widget">
                                    <h3 class="widget-title">인기 게시글</h3><!-- End .widget-title -->
<%-- 									<div>${popPost }</div> --%>
                                    <ul class="posts-list">
                                        <c:forEach var="popP" items="${popPost }">
	                                        <li class="popPostLi" onclick="location.href='openSharePost?boardNo=${popP.boardNo}';">
                                                <table>
                                                	<tr>
                                                		<td class="span1st">제목</td>
                                                		<td class="spanTitle" colspan="3">${popP.boardTitle }</td>
                                                	</tr>
                                                	<tr>
                                                		<td class="span1st">작성자</td>
                                                		<td class="spanWriter">${popP.writer }</td>
                                                		<td class="span2nd">작성시간</td>
                                                		<td class="spanWriteTime">${popP.writeDate }</td>
                                                	</tr>
                                                	<tr>
                                                		<td class="span1st">조회</td>
                                                		<td class="spanRead">${popP.boardRead }</td>
                                                		<td class="span2nd">좋아요</td>
                                                		<td class="spanLike">${popP.boardLike }</td>
                                                	</tr>
                                                </table>
	                                        </li>
                                        </c:forEach>
                                    </ul><!-- End .posts-list -->
                                </div><!-- End .widget -->

                			</div><!-- End .sidebar -->
                		</aside><!-- End .col-lg-3 -->
                	</div><!-- End .row -->
                </div><!-- End .container -->
            </div><!-- End .page-content -->
        </main><!-- End .main -->

        
    </div><!-- End .page-wrapper -->
    <button id="scroll-top" title="Back to Top"><i class="icon-arrow-up"></i></button>
	<jsp:include page="../footer.jsp"></jsp:include>
    <!-- Plugins JS File -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/jquery.hoverIntent.min.js"></script>
    <script src="assets/js/jquery.waypoints.min.js"></script>
    <script src="assets/js/superfish.min.js"></script>
    <script src="assets/js/owl.carousel.min.js"></script>
    <!-- Main JS File -->
    <script src="assets/js/main.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/board/listOfShareBoard.js"></script>
</body>

<!-- molla/blog-listing.html  22 Nov 2019 10:04:12 GMT -->
</html>