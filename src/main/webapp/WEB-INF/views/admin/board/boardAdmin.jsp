<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html lang="KO"
	class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
	dir="ltr" data-theme="theme-default"
	data-assets-path="/resources/assets/"
	data-template="vertical-menu-template">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>게시판 관리</title>

<meta name="description" content="" />

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="../../resources/assets/images/icons/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap"
	rel="stylesheet" />

<!-- Icons -->
<link rel="stylesheet"
	href="/resources/assets/vendor/fonts/fontawesome.css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/fonts/tabler-icons.css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/fonts/flag-icons.css" />


<!-- Core CSS -->
<link rel="stylesheet" href="/resources/assets/vendor/css/rtl/core.css"
	class="template-customizer-core-css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/css/rtl/theme-default.css"
	class="template-customizer-theme-css" />
<link rel="stylesheet" href="/resources/assets/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet"
	href="/resources/assets/vendor/libs/node-waves/node-waves.css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/libs/typeahead-js/typeahead.css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/libs/select2/select2.css" />
<link rel="stylesheet"
	href="/resources/assets/vendor/libs/@form-validation/umd/styles/index.min.css" />

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">

<!-- Page CSS -->

<!-- Helpers -->
<script src="/resources/assets/vendor/js/helpers.js"></script>
<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->
<script src="/resources/assets/vendor/js/template-customizer.js"></script>
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="/resources/js/product/config.js"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<style>
.contentText {
 	display: block;
	overflow: hidden;
 	text-overflow: ellipsis;
  	white-space: nowrap;
  	width: 200px;
  	height: 20px;
}
.titleText{
	display: block;
	overflow: hidden;
 	text-overflow: ellipsis;
  	white-space: nowrap;
  	width: 150px;
  	height: 20px;
}
.upFileArea {
	width: 100%;
	height: 100px;
	border: 1px dotted #333;
	font-weight: bold;
	color: green;
	background-color: #eff9f7;
	text-align: center;
	line-height: 100px;
	margin-bottom: 10px;
}

</style>


</head>
<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
	
			<!-- Menu -->
			<jsp:include page="../aside.jsp"></jsp:include>
			<!-- / Menu -->
	
		<div class="layout-container">

			<!-- Layout container -->
			<div class="layout-page">

				<!-- Content wrapper -->
				<div class="content-wrapper">
						<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="py-3 mb-2">
							 게시판 관리
						</h4>
						
						<!-- Users List Table -->
						<div class="card">
							<div class="card-header border-bottom">
								
								<div
									class="d-flex justify-content-between align-items-center row pb-2 gap-3 gap-md-0">
									<div class="col-md-4 user_role">
									<h5 class="card-title mb-3">정렬 필터</h5>
									</div>
									<div class="col-md-4">
										<select id="colName" class="form-select text-capitalize">
											<option value="boardtitle" <c:if test="${colName eq 'boardtitle'}">selected</c:if>>제목</option>
											<option value="name" <c:if test="${colName eq 'name'}">selected</c:if>>이름</option>
											<option value="nickname" <c:if test="${colName eq 'nickname'}">selected</c:if>>닉네임</option>
											<option value="writedate" <c:if test="${colName eq 'writedate'}">selected</c:if>>작성일</option>
											<option value="boardlike" <c:if test="${colName eq 'boardlike'}">selected</c:if>>좋아요 수</option>
											<option value="boardread" <c:if test="${colName eq 'boardread'}">selected</c:if>>조회 수</option>
										</select>
									</div>
									
									<div class="col-md-4">
										<select id="colValue" class="form-select text-capitalize">
											<option value="asc" <c:if test="${colValue eq 'asc'}">selected</c:if>>오름차순</option>
											<option value="desc" <c:if test="${colValue eq 'desc'}">selected</c:if>>내림차순</option>
										</select>
									</div>
								</div>
							</div>
							<div class="card-datatable table-responsive">
								<div id="DataTables_Table_0_wrapper"
									class="dataTables_wrapper dt-bootstrap5 no-footer">
									<div class="row me-2">
										<div class="col-md-2">
											<div class="me-3">
												<div class="dataTables_length"
													id="DataTables_Table_0_length">
													<label>
														<select name="pageProductCnt" id="pageProductCnt" class="form-select">
															<option value="10" <c:if test="${pageProductCnt == 10}">selected</c:if>>10</option>
															<option value="25" <c:if test="${pageProductCnt == 25}">selected</c:if>>25</option>
															<option value="50" <c:if test="${pageProductCnt == 50}">selected</c:if>>50</option>
															<option value="100"<c:if test="${pageProductCnt == 100}">selected</c:if>>100</option>
														</select>
													</label>
												</div>
											</div>
										</div>
										<div class="col-md-10">
											<div
												class="dt-action-buttons text-xl-end text-lg-start text-md-end text-start d-flex align-items-center justify-content-end flex-md-row flex-column mb-3 mb-md-0">
												<div id="DataTables_Table_0_filter" class="dataTables_filter">
													<label>
														<select name="searchType" id ="searchType" class="form-select">
															<option value="boardtitle" <c:if test="${searchType eq 'boardtitle'}">selected</c:if>>제목</option>
															<option value="boardcontent" <c:if test="${searchType eq 'boardcontent'}">selected</c:if>>내용</option>
															<option value="name" <c:if test="${searchType eq 'name'}">selected</c:if>>이름</option>
															<option value="nickname" <c:if test="${searchType eq 'nickname'}">selected</c:if>>닉네임</option>
														</select>
													</label>
												
													<label>
														<input type="search" class="form-control"  id ="searchWord" placeholder="검색.." <c:if test="${not empty searchWord}">value="${searchWord}"</c:if> >
													</label>
												</div>
												<div class="dt-buttons">
													<button
														class="dt-button add-new btn btn-primary waves-effect waves-light"
														tabindex="0" type="button" style="margin-left: 15px;" onclick="adminWriteModal()">
														<span><i class="ti ti-pencil me-0 me-sm-1 ti-xs"></i>
														<span class="d-none d-sm-inline-block">관리자 글작성</span></span>
													</button>
												</div>
											</div>
										</div>
									</div>
									<table
										class="datatables-users table dataTable no-footer dtr-column"
										id="DataTables_Table_0">
										
										<thead class="border-top">
											<tr>
												<th class="control sorting_disabled dtr-hidden" rowspan="1"
													colspan="1" style="width: 61.9062px; text-align: center;">번호</th>
												<th class="sorting" tabindex="0"
													rowspan="1" colspan="1"
													style="width: 120.016px;">커뮤니티명</th>
												<th class="sorting sorting_desc" tabindex="0"
													rowspan="1" colspan="1"
													style="width: 200.625px;">제목</th>
												<th class="sorting" tabindex="0" rowspan="1" colspan="1"
													style="width: 146.266px;">내용</th>
												<th class="sorting" tabindex="0"
													 rowspan="1" colspan="1"
													style="width: 146.266px;">이름</th>
												<th class="sorting" tabindex="0"
													 rowspan="1" colspan="1"
													style="width: 192.016px;">닉네임</th>	
												<th class="sorting" tabindex="0"
													rowspan="1" colspan="1"
													style="width: 162.016px;">작성일</th>
												<th class="sorting" tabindex="0"
													rowspan="1" colspan="1"
													style="width: 162.016px;">좋아요 수</th>
												<th class="sorting" tabindex="0"
													rowspan="1" colspan="1"
													style="width: 162.016px;">조회 수</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 140px;" aria-label="Actions">수정</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="abList" items="${adminBoardList }">
										
											<tr class="odd">
												<td style="text-align: center;"><span class="fw-medium">${abList.boardno }</span></td>
												<td class="sorting_1">
												<div class="d-flex justify-content-start align-items-center user-name">
														<div class="d-flex flex-column">
															<c:choose>
																<c:when test="${abList.categoryno == 1}">
																	<a href="#" class="text-body text-truncate">
																	<span class="fw-medium">자유</span></a>
																</c:when>
																<c:when test="${abList.categoryno == 2}">
																	<a href="/board/shareBoardOpen" class="text-body text-truncate">
																	<span class="fw-medium">정보공유</span></a>
																</c:when>
																<c:when test="${abList.categoryno == 3}">
																	<a href="/board/originalBoard" class="text-body text-truncate">
																	<span class="fw-medium">작품별</span></a>
																</c:when>
																<c:when test="${abList.categoryno == 4}">
																	<a href="#" class="text-body text-truncate">
																	<span class="fw-medium">커뮤니티공지</span></a>
																</c:when>
																<c:when test="${abList.categoryno == 5}">
																	<a href="#" class="text-body text-truncate">
																	<span class="fw-medium">자랑</span></a>
																</c:when>
															</c:choose>
														</div>
													</div></td>
												<td>
												
													<c:choose>
														<c:when test="${abList.categoryno == 1}">
															<a href="#" class="text-body text-truncate">
															<span class="titleText">${abList.boardtitle }</span></a>
														</c:when>
														<c:when test="${abList.categoryno == 2}">
															<a href="/board/openSharePost?boardNo=${abList.boardno }" class="text-body text-truncate">
															<span class="titleText">${abList.boardtitle }</span></a>
														</c:when>
														<c:when test="${abList.categoryno == 3}">
															<a href="/board/originalViewboard?boardNo=${abList.boardno }" class="text-body text-truncate">
															<span class="titleText">${abList.boardtitle }</span></a>
														</c:when>
														<c:when test="${abList.categoryno == 4}">
															<a href="#" class="text-body text-truncate">
															<span class="titleText">${abList.boardtitle }</span></a>
														</c:when>
														<c:when test="${abList.categoryno == 5}">
															<a href="#" class="text-body text-truncate">
															<span class="titleText">${abList.boardtitle }</span></a>
														</c:when>
													</c:choose>
												
												</td>
												<td>
													<span class="contentText">${abList.boardcontent }</span>
												</td>
												<td><span class="fw-medium">${abList.name }</span></td>
												<td><span class="fw-medium">${abList.nickname }</span></td>
												<td>${abList.writedate }</td>
												<td>&nbsp;&nbsp;${abList.boardlike }</td>
												<td>&nbsp;&nbsp;${abList.boardread }</td>
												<td class="dtr-hidden" >
													<div class="d-flex align-items-center">
														<c:if test="${abList.categoryno == 2 }">
														<a href="javascript:;" class="text-body" onclick="editBoardModalWithSN(${abList.boardno})">
														<i class="ti ti-edit ti-sm me-2"></i>
														</a>
														</c:if>
														<c:if test="${abList.categoryno != 2  }">
														<a href="javascript:;" class="text-body" onclick="editBoardModal(${abList.boardno})">
														<i class="ti ti-edit ti-sm me-2"></i>
														</a>
														</c:if>
														<a href="javascript:;"class="text-body" onclick="delBoardModal(${abList.boardno})">
														<i class="ti ti-trash ti-sm mx-2"></i>
														</a> 
													</div>
												</td>
											</tr>
											</c:forEach>
											
										</tbody>
									</table>
									
				 <div class="row mx-2">
                <div class="col-sm-12 col-md-6">
                 <div class="dataTables_info" id="DataTables_Table_0_info" role="status" aria-live="polite">총 게시글 수 : ${pagingInfo.totalProductCnt}</div>
                </div>
                <div class="col-sm-12 col-md-6">
                  <div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate">
                    <ul class="pagination">
                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
                        <a href="/admin/board/boardAdmin?pageNo=1" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> 1 </a>
                      </li>
                      <c:choose>
                      <c:when test="${param.pageNo <= 10 or param.pageNo == null}">
	                      <li class="paginate_button page-item previous disabled" id="DataTables_Table_0_previous">
	                        <a aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> &lt;&lt; </a>
	                      </li>
                      </c:when>
                      <c:otherwise>
	                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
	                        <a href="/admin/board/boardAdmin?pageNo=${param.pageNo - 10}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> &lt;&lt; </a>
	                      </li>
                      </c:otherwise>
                      </c:choose>
                      <c:choose>
                      <c:when test="${param.pageNo == 1 or param.pageNo == null}">
	                      <li class="paginate_button page-item previous disabled" id="DataTables_Table_0_previous">
	                        <a aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> &lt; </a>
	                      </li>
                      </c:when>
                      <c:otherwise>
	                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
	                        <a href="/admin/board/boardAdmin?pageNo=${param.pageNo - 1}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> &lt; </a>
	                      </li>
                      </c:otherwise>
                      </c:choose>
					  <c:forEach var="paging" begin="${pagingInfo.startPageNum }" end="${pagingInfo.endPageNum}">
	                      <c:choose>
		                      <c:when test="${param.pageNo == null && paging == 1}">
			                      <li class="paginate_button page-item active">
			                        <a href="#" aria-controls="DataTables_Table_0" role="link" aria-current="page" class="page-link">${paging}</a>
			                      </li>
		                      </c:when>
		                      <c:when test="${param.pageNo == paging}">
			                      <li class="paginate_button page-item active">
			                        <a href="#" aria-controls="DataTables_Table_0" role="link" aria-current="page" class="page-link">${paging}</a>
			                      </li>
		                      </c:when>
		                      <c:otherwise>
			                      <li class="paginate_button page-item">
			                        <a href="/admin/board/boardAdmin?pageNo=${paging}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" role="link" aria-current="page" class="page-link">${paging}</a>
			                      </li>
	    	                  </c:otherwise>
	                      </c:choose>
					  </c:forEach>
                      <c:choose>
                      	<c:when test="${paran.pageNo != null or param.pageNo >= pagingInfo.totalPageCnt}">
	                      <li class="paginate_button page-item next disabled" id="DataTables_Table_0_next">
	                        <a href="/admin/board/boardAdmin?pageNo=${param.pageNo + 1}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> &gt; </a>
	                      </li>
                      	</c:when>
                      	<c:otherwise>
	                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
	                        <a href="#" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> &gt; </a>
	                      </li>
                      	</c:otherwise>
                      </c:choose>
                      <c:choose>
                      	<c:when test="${paran.pageNo != null or (pagingInfo.totalPageCnt - param.pageNo) < 10 or pagingInfo.totalPageCnt == param.pageNo}">
	                      <li class="paginate_button page-item next disabled" id="DataTables_Table_0_next">
	                        <a href="#" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> &gt;&gt; </a>
	                      </li>
                      	</c:when>
                      	<c:otherwise>
	                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
	                        <a href="/admin/board/boardAdmin?pageNo=${param.pageNo + 10}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> &gt;&gt; </a>
	                      </li>
                      	</c:otherwise>
                      </c:choose>
	                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
	                        <a href="/admin/board/boardAdmin?pageNo=${pagingInfo.totalPageCnt}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> ${pagingInfo.totalPageCnt} </a>
	                      </li>
                    </ul>
                  </div>
                </div>
              </div>
								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- / Content -->
				<!-- Footer -->
				<jsp:include page="../footer.jsp"></jsp:include>
				<!-- / Footer -->

				<!-- <div class="content-backdrop fade"></div> -->
			</div>
			<!-- Content wrapper -->
		</div>
		<!-- / Layout page -->
	</div>
	<!-- 글수정 모달 -->
	<div class="modal" id="editBoardModal" tabindex="-1" aria-modal="true" role="dialog">
                <div class="modal-dialog modal-lg modal-simple modal-enable-otp modal-dialog-centered">
                  <div class="modal-content p-3 p-md-5">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      <div class="text-center mb-4">
                        <h3 class="mb-2">게시글 수정 (<span id = "editBoardNo"></span>번)</h3>
                      </div>
                      <form id="enableOTPForm" class="row g-3 fv-plugins-bootstrap5 fv-plugins-framework" onsubmit="return false" novalidate="novalidate">
                        
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modaleditBoardName">이름 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardName" name="modaleditBoardName" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modaleditBoardNickName">닉네임 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardNickName" name="modaleditBoardNickName" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modaleditBoardDate">작성일 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardDate" name="modaleditBoardDate" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-3">
                          <label class="form-label" for="modaleditBoardLike">좋아요 수 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardLike" name="modaleditBoardLike" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-3">
                          <label class="form-label" for="modaleditBoardRead">조회 수 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardRead" name="modaleditBoardRead" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12">
                          <div class="col-12">
                           	<label class="form-label" for="modaleditBoardTitle">제목 </label>
                            <input type="text" class="form-control" id="modaleditBoardTitle" />
                          </div>
                        </div>
                        <!-- <div class="col-12">
                          <div class="col-12">
                           	<label class="form-label" for="modaleditBoardCategory">카테고리 </label>
                            <input type="text" class="form-control" id="modaleditBoardCategory" />
                          </div>
                        </div> -->
                        <div class="col-12">
            				<label class="form-label" for="modaleditBoardCategory">카테고리</label>
				            <div class="position-relative">
				            <select id="modaleditBoardCategory" name="modaleditBoardCategory" class="form-select"  tabindex="-1" aria-hidden="true" readOnly>
				              <option value="2">정보공유</option>
				              <option value="3">작품별</option>
				            </select>
				          </div>
				         </div>
                        <div class="col-12">
                          <div class="col-12">
                           	<label class="form-label" for="modaleditBoardContent">내용 </label>
                            <textarea id="modaleditBoardContent" name="editordata"></textarea>
                          </div>
                        </div>
                        
                         <div class="col-12" id="errDelet">
                         </div>
                        <div class="col-12">
                          <button type="submit" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light" onclick="editBoardAdmin(1)">전송</button>
                          <button type="reset" class="btn btn-label-secondary waves-effect modalClose" data-bs-dismiss="modal" aria-label="Close">
                            닫기
                          </button>
                        </div>
                      <input type="hidden"></form>
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- 관리자 글작성 -->
			<div class="modal" id="writeBoardModal" tabindex="-1" aria-modal="true" role="dialog">
                <div class="modal-dialog modal-lg modal-simple modal-enable-otp modal-dialog-centered">
                  <div class="modal-content p-3 p-md-5">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                      onclick="writeBoardClose()"></button>
                      <div class="text-center mb-4">
                        <h3 class="mb-2">관리자 게시글 작성</h3>
                        <input type="hidden" id= "modaleWriteUuid" value="${sessionScope.loginCustomer.uuid}" />
                      </div>
                     <form id="enableOTPForm" class="row g-3 fv-plugins-bootstrap5 fv-plugins-framework" onsubmit="return false" novalidate="novalidate">
                        
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modaleWriteName">이름 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleWriteName" name="modaleWriteName" class="form-control" value = "${sessionScope.loginCustomer.name }" readOnly>
                          </div>
                        </div>
                        
                         <div class="col-12 col-md-6">
                          <label class="form-label" for="modaleWriteNickName">닉네임 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleWriteNickName" name="modaleWriteNickName" class="form-control" value = "${sessionScope.loginCustomer.nickname }" readOnly>
                          </div>
                        </div>
                        
                         <div class="col-12">
                          <div class="col-12">
                           	<label class="form-label" for="modaleWriteTilte">제목 </label>
                            <input type="text" class="form-control" id="modaleWriteTilte" />
                          </div>
                        </div>
                        
                        <div class="col-12">
            				<label class="form-label" for="modaleWriteCategory">카테고리</label>
				            <div class="position-relative">
				            <select id="modaleWriteCategory" name="modaleWriteCategory" class="form-select"  tabindex="-1" aria-hidden="true">
				              <option value="2">정보공유</option>
				              <option value="3">작품별</option>
				            </select>
				          </div>
				         </div>
                        <div class="col-12">
                          <div class="col-12">
                           	<label class="form-label" for="modaleWriteContent">내용 </label>
                            <textarea id="modaleWriteContent" name="editordat"></textarea>
                          </div>
                        </div>
                        
                         <div class="col-12" id="errDelet">
                         </div>
                        <div class="col-12">
                          <button type="button" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light" onclick="writeBoardAdmin()">작성</button>
                          <button type="reset" class="btn btn-label-secondary waves-effect modalClose" data-bs-dismiss="modal" aria-label="Close" onclick="writeBoardClose()">
                            닫기
                          </button>
                        </div>
                      <input type="hidden"></form>
                      
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- no summernote modal -->
              <div class="modal" id="editBoardModalNoSN" tabindex="-1" aria-modal="true" role="dialog">
                <div class="modal-dialog modal-lg modal-simple modal-enable-otp modal-dialog-centered">
                  <div class="modal-content p-3 p-md-5">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      <div class="text-center mb-4">
                        <h3 class="mb-2">게시글 수정 (<span id = "editBoardNo2"></span>번)</h3>
                      </div>
                      <form id="enableOTPForm" class="row g-3 fv-plugins-bootstrap5 fv-plugins-framework" onsubmit="return false" novalidate="novalidate">
                        
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modaleditBoardName2">이름 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardName2" name="modaleditBoardName2" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modaleditBoardNickName2">닉네임 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardNickName2" name="modaleditBoardNickName2" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modaleditBoardDate2">작성일 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardDate2" name="modaleditBoardDate2" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-3">
                          <label class="form-label" for="modaleditBoardLike2">좋아요 수 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardLike2" name="modaleditBoardLike2" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-3">
                          <label class="form-label" for="modaleditBoardRead2">조회 수 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modaleditBoardRead2" name="modaleditBoardRead2" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12">
                          <div class="col-12">
                           	<label class="form-label" for="modaleditBoardTitle2">제목 </label>
                            <input type="text" class="form-control" id="modaleditBoardTitle2" />
                          </div>
                        </div>
                        <div class="col-12">
            				<label class="form-label" for="modaleditBoardCategory2">카테고리</label>
				            <div class="position-relative">
				            <select id="modaleditBoardCategory2" name="modaleditBoardCategory2" class="form-select"  tabindex="-1" aria-hidden="true" readOnly>
				              <option value="2">정보공유</option>
				              <option value="3">작품별</option>
				            </select>
				          </div>
				         </div>
                        <div class="col-12">
                          <div class="col-12">
                           	<label class="form-label" for="modaleditBoardContent2">내용 </label>
                            <textarea id="modaleditBoardContent2" name="editordata" class="form-control" rows="8"></textarea>
                          </div>
                        </div>
                         <div class="col-12" id="errDelet">
                         </div>
                        <div class="col-12">
                          <button type="submit" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light" onclick="editBoardAdmin(2)">전송</button>
                          <button type="reset" class="btn btn-label-secondary waves-effect modalClose" data-bs-dismiss="modal" aria-label="Close">
                            닫기
                          </button>
                        </div>
                      <input type="hidden"></form>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="modal" id="delBoardModal" tabindex="-1" aria-modal="true" role="dialog">
                <div class="modal-dialog modal-simple modal-enable-otp modal-dialog-centered">
                  <div class="modal-content">
                    <div class="modal-body" style="padding: 10px;">
                      <div class="text-center mb-4">
                        <h3 class="mb-2" id="delModalText"><span id="delBoardNo"></span>번 게시글을 삭제하시겠습니까?</h3>
                      </div>
                        <div class="col-12" style="text-align: center;">
                        	<button type="submit" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light" onclick="delBoardAdmin()">확인</button>
                          <button type="button" class="btn btn-label-secondary waves-effect modalClose">닫기</button>
                        </div>
                      <input type="hidden">
                    </div>
                  </div>
                </div>
              </div>
	<!-- Core JS -->
	<!-- build:js assets/vendor/js/core.js -->

	<script src="/resources/assets/vendor/libs/jquery/jquery.js"></script>
	<script src="/resources/assets/vendor/libs/popper/popper.js"></script>
	<script src="/resources/assets/vendor/js/bootstrap.js"></script>
	<script src="/resources/assets/vendor/libs/node-waves/node-waves.js"></script>
	<script
		src="/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
	<script src="/resources/assets/vendor/libs/hammer/hammer.js"></script>
	<script src="/resources/assets/vendor/libs/i18n/i18n.js"></script>
	<script src="/resources/assets/vendor/libs/typeahead-js/typeahead.js"></script>
	<script src="/resources/assets/vendor/js/menu.js"></script>

	<!-- endbuild -->

	<!-- Vendors JS -->
	<script src="/resources/assets/vendor/libs/moment/moment.js"></script>
	<script
		src="/resources/assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>
	<script src="/resources/assets/vendor/libs/select2/select2.js"></script>
	<script
		src="/resources/assets/vendor/libs/@form-validation/umd/bundle/popular.min.js"></script>
	<script
		src="/resources/assets/vendor/libs/@form-validation/umd/plugin-bootstrap5/index.min.js"></script>
	<script
		src="/resources/assets/vendor/libs/@form-validation/umd/plugin-auto-focus/index.min.js"></script>
	<script src="/resources/assets/vendor/libs/cleavejs/cleave.js"></script>
	<script src="/resources/assets/vendor/libs/cleavejs/cleave-phone.js"></script>

	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<!-- Main JS -->
	<script src="/resources/js/product/main.js"></script>

	<script type="text/javascript">
	$(function(){
		$("#searchWord").on('keypress', function(e){
			if(e.keyCode == '13'){
				location.href="/admin/board/boardAdmin?pageProductCnt=" +'${pageProductCnt}'+"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val(); 
			}
		});
		
		
		$("#pageProductCnt").change(function(){
			location.href="/admin/board/boardAdmin?pageProductCnt=" + $(this).val() +"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val(); 
		});
		
		
		$("#colName").change(function(){
			location.href="/admin/board/boardAdmin?pageProductCnt=" + '${pageProductCnt}' +"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() + "&colName=" + $(this).val() + "&colValue=" + $("#colValue").val(); 
		});
		
		$("#colValue").change(function(){
			location.href="/admin/board/boardAdmin?pageProductCnt=" + '${pageProductCnt}' +"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() + "&colName=" + $("#colName").val() + "&colValue=" + $(this).val(); 
		});
		
		$(".btn-close").click (function(){
			$('#editBoardModal').hide();
			$('#modaleditBoardContent').summernote('reset');
			$("#editBoardModalNoSN").hide();
			$("#writeBoardModal").hide();
			$('#modaleWriteContent').summernote('reset');
			
		});
		
		$(".modalClose").click (function(){
			$('#editBoardModal').hide();
			$('#modaleditBoardContent').summernote('reset');
			$("#editBoardModalNoSN").hide();
			$("#delBoardModal").hide();
			$("#writeBoardModal").hide();
			$('#modaleWriteContent').summernote('reset');
		});
		
		$('#modaleditBoardContent').summernote({
			// 에디터 크기 설정
			  height: 400,
			  // 에디터 한글 설정
			  lang: 'ko-KR',
			  toolbar: [
				    // 글자 [굵게, 기울임, 밑줄, 취소 선, 지우기]
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    // 서식 [글머리 기호, 번호매기기, 문단정렬]
				    ['para', ['ul', 'ol']]
				  ]
		});
		
		
		$('#modaleWriteContent').summernote({
			// 에디터 크기 설정
			  height: 400,
			  // 에디터 한글 설정
			  lang: 'ko-KR',
			  toolbar: [
				    // 글자 [굵게, 기울임, 밑줄, 취소 선, 지우기]
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    // 서식 [글머리 기호, 번호매기기, 문단정렬]
				    ['para', ['ul', 'ol']]
				  ]
		});
		
		
		
		
	});
	
	
	
	function editBoardModalWithSN(no){
		
		$.ajax({
			url: "getBoardDetail", // 데이터가 송수신될 서버의 주소
			data: {
				"no" : no
			},
			type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			success: function(data) {
				// 통신이 성공하면 수행할 함수
				$("#editBoardNo").text(data.abDetailInfo.boardno);
				$("#modaleditBoardName").val(data.abDetailInfo.name);
				$("#modaleditBoardNickName").val(data.abDetailInfo.nickname);
				
				
				var eDate = new Date(data.abDetailInfo.writedate);
				var year = eDate.getFullYear();
				var month = ('0' + (eDate.getMonth() + 1)).slice(-2);
				var day = ('0' + eDate.getDate()).slice(-2);
				
				var dateString = year + '-' + month + '-' + day;
				
				
				$("#modaleditBoardDate").val(dateString);
				$("#modaleditBoardLike").val(data.abDetailInfo.boardlike);
				$("#modaleditBoardRead").val(data.abDetailInfo.boardread);
				$("#modaleditBoardTitle").val(data.abDetailInfo.boardtitle);
				$("#modaleditBoardCategory").val(data.abDetailInfo.categoryno);
				$('#modaleditBoardContent').summernote('pasteHTML',data.abDetailInfo.boardcontent);
				
			},
			error: function() {
			},
			complete: function() {

			},
		}); 
		
		$("#editBoardModal").show();
		
		
		
	};
	
	
	
	
	
	function editBoardModal(no){
		
		$.ajax({
			url: "getBoardDetail", // 데이터가 송수신될 서버의 주소
			data: {
				"no" : no
			},
			type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			success: function(data) {
				// 통신이 성공하면 수행할 함수
				$("#editBoardNo2").text(data.abDetailInfo.boardno);
				$("#modaleditBoardName2").val(data.abDetailInfo.name);
				$("#modaleditBoardNickName2").val(data.abDetailInfo.nickname);
				
				
				var eDate = new Date(data.abDetailInfo.writedate);
				var year = eDate.getFullYear();
				var month = ('0' + (eDate.getMonth() + 1)).slice(-2);
				var day = ('0' + eDate.getDate()).slice(-2);
				
				var dateString = year + '-' + month + '-' + day;
				
				$("#modaleditBoardDate2").val(dateString);
				$("#modaleditBoardLike2").val(data.abDetailInfo.boardlike);
				$("#modaleditBoardRead2").val(data.abDetailInfo.boardread);
				$("#modaleditBoardTitle2").val(data.abDetailInfo.boardtitle);
				$("#modaleditBoardCategory2").val(data.abDetailInfo.categoryno);
				$('#modaleditBoardContent2').val(data.abDetailInfo.boardcontent);
				
			},
			error: function() {
			},
			complete: function() {

			},
		}); 
		
		
		
		$("#editBoardModalNoSN").show();
	};
	
	
	
	function editBoardAdmin(a){
		var boardno = "";
		var categoryno = "";
		var boardtitle = "";
		var boardcontent = "";
		if(a == 1){
			boardno = $("#editBoardNo").text();
			categoryno = $("#modaleditBoardCategory").val();
			boardtitle = $("#modaleditBoardTitle").val();
			boardcontent = $('#modaleditBoardContent').val();
		} else {
			boardno = $("#editBoardNo2").text();
			categoryno = $("#modaleditBoardCategory2").val();
			boardtitle = $("#modaleditBoardTitle2").val();
			boardcontent = $('#modaleditBoardContent2').val();
		}
		
		let qstr = "/admin/board/boardAdmin?pageProductCnt=" +'${pageProductCnt}'+"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() +"&colName=" + $("#colName").val() + "&colValue=" + $("#colValue").val() ; 
		$.ajax({
			url: "editBoard", // 데이터가 송수신될 서버의 주소
			data: {
				"boardno" : boardno,
				"categoryno" : categoryno,
				"boardtitle" : boardtitle,
				"boardcontent" : boardcontent
			},
			type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			success: function() {
				// 통신이 성공하면 수행할 함수
				$("#editBoardModal").hide();
				$("#editBoardModalNoSN").hide();
				location.replace(qstr);
			},
			error: function() {
			},
			complete: function() {

			},
		}); 
		
		
	};
	
	
	function adminWriteModal(){
		$("#writeBoardModal").show();
	};
	
	// 관리자 글작성 만들기!!!!(일요일)
	function writeBoardAdmin(){
		
		var uuid = $("#modaleWriteUuid").val();
		var title = $("#modaleWriteTilte").val();
		var category = $("#modaleWriteCategory").val();
		var content = $("#modaleWriteContent").val();
		let qstr = "/admin/board/boardAdmin?pageProductCnt=" +'${pageProductCnt}'+"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() +"&colName=" + $("#colName").val() + "&colValue=" + $("#colValue").val() ; 

		$.ajax({
			url: "writeBoardAdmin", // 데이터가 송수신될 서버의 주소
			data: {
				"uuid" : uuid,
				"title" : title,
				"category" : category,
				"content" : content
			},
			type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			success: function() {
				// 통신이 성공하면 수행할 함수
				
			},
			error: function() {
			},
			complete: function() {
				$("#writeBoardModal").hide();
				$("#modaleWriteContent").summernote('reset');
				location.replace(qstr);
			},
		}); 
		
		
		
	};
	
	
	
	function delBoardModal(no){
		
		$("#delBoardNo").text(no);
		$("#delBoardModal").show();
	}
	
	function delBoardAdmin(){
		console.log($("#delBoardNo").text());
		var boardNo = $("#delBoardNo").text();
		let qstr = "/admin/board/boardAdmin?pageProductCnt=" +'${pageProductCnt}'+"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() +"&colName=" + $("#colName").val() + "&colValue=" + $("#colValue").val() ; 
		$.ajax({
			url: "delBoard", // 데이터가 송수신될 서버의 주소
			data: {
				"no" : boardNo
			},
			type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			success: function() {
				// 통신이 성공하면 수행할 함수
			},
			error: function() {
			},
			complete: function() {
				$("#delBoardModal").hide();
				location.replace(qstr);
			},
		}); 
		 
		
		
	};
	
	
	function strToJson(str){
		var matchResult = str.match(/\(([^)]+)\)/);
		var contentInsideBrackets = matchResult ? matchResult[1] : null;
		var keyValuePairs = contentInsideBrackets.split(', ');
		var jsonObject = {};
			$.each(keyValuePairs, function (index, pair) {
			 var [key, value] = pair.split('=');
		jsonObject[key] = value;
			});
			
			return jsonObject;
	};
	</script>
	
	
	</body>
	</html>