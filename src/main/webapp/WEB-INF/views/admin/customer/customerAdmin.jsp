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

<title>회원 관리</title>

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
</head>
<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->
			<jsp:include page="../aside.jsp"></jsp:include>
			<!-- / Menu -->

			<!-- Layout container -->
			<div class="layout-page">

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="py-3 mb-2">
							고객 관리
						</h4>
						
						<!-- test -->
						<%-- <div>${pagingInfo } </div>
						<div>${customerInfo }</div> --%>
						<!-- customer top card  -->

						<div class="row g-4 mb-4">
							<div class="col-sm-6 col-xl-3">
								<div class="card">
									<div class="card-body">
										<div class="d-flex align-items-start justify-content-between">
											<div class="content-left">
												<span>총 회원 수</span>
												<div class="d-flex align-items-center my-2">
													<h3 class="mb-0 me-2"><span id="totalCus">${customerInfo.totCustomer }</span></h3>
												</div>
												<p class="mb-0">다사자규 전체 회원</p>
											</div>

											<div class="avatar">
												<span class="avatar-initial rounded bg-label-primary">
													<i class="ti ti-user ti-sm"></i>
												</span>
											</div>
										</div>
									</div>

								</div>
							</div>
							<div class="col-sm-6 col-xl-3">
								<div class="card">
									<div class="card-body">
										<div class="d-flex align-items-start justify-content-between">
											<div class="content-left">
												<span>남성 / 여성 회원 수</span>
												<div class="d-flex align-items-center my-2">
													<h3 class="mb-0 me-2"><span id="malePop">${customerInfo.totMale }</span> / <span id="femalePop">${customerInfo.totFemale }</span></h3>
												</div>
												<p class="mb-0" id="perOfGender"></p>
											</div>
											<div class="avatar">
												<span class="avatar-initial rounded bg-label-danger">
													<i class="ti ti-users-group ti-sm"></i>
												</span>
												
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-xl-3">
								<div class="card">
									<div class="card-body">
										<div class="d-flex align-items-start justify-content-between">
											<div class="content-left">
												<span>최근 한달 동안 가입한 회원 수</span>
												<div class="d-flex align-items-center my-2">
													<h3 class="mb-0 me-2"><span id="monthSignUp">${customerInfo.regCustomer }</span></h3>
												</div>
												<p class="mb-0" id="perOfMonthSignUp"></p>
											</div>
											<div class="avatar">
												<span class="avatar-initial rounded bg-label-success">
													<i class="ti ti-user-up ti-sm"></i>
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-xl-3">
								<div class="card">
									<div class="card-body">
										<div class="d-flex align-items-start justify-content-between">
											<div class="content-left">
												<span>탈퇴한 회원 수</span>
												<div class="d-flex align-items-center my-2">
													<h3 class="mb-0 me-2"><span id="withDrawCus">${customerInfo.withdraw }</span></h3>
												</div>
												<p class="mb-0" id="perOfWithDrawCus"></p>
											</div>
											<div class="avatar">
												<span class="avatar-initial rounded bg-label-warning">
													<i class="ti ti-user-exclamation ti-sm"></i>
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
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
											<option value="name" <c:if test="${colName eq 'name'}">selected</c:if>>이름</option>
											<option value="email" <c:if test="${colName eq 'email'}">selected</c:if>>이메일</option>
											<option value="nickname" <c:if test="${colName eq 'nickname'}">selected</c:if>>닉네임</option>
											<option value="registerDate" <c:if test="${colName eq 'registerDate'}">selected</c:if>>가입일</option>
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
															<option value="name" <c:if test="${searchType eq 'name'}">selected</c:if>>이름</option>
															<option value="email" <c:if test="${searchType eq 'email'}">selected</c:if>>이메일</option>
															<option value="nickname" <c:if test="${searchType eq 'nickname'}">selected</c:if>>닉네임</option>
															<option value="phoneNumber" <c:if test="${searchType eq 'phoneNumber'}">selected</c:if>>전화번호</option>
														</select>
													</label>
												
													<label>
														<input type="search" class="form-control"  id ="searchWord" placeholder="검색.." <c:if test="${not empty searchWord}">value="${searchWord}"</c:if> >
													</label>
												</div>
												<div class="dt-buttons">
													<button
														class="dt-button btn btn-label-secondary mx-3 waves-effect waves-light"
														tabindex="0" type="button" id = "exportExcel">
														<span><i class="ti ti-screen-share me-1 ti-xs"></i>엑셀출력</span>
													</button>
													<button
														class="dt-button add-new btn btn-primary waves-effect waves-light"
														tabindex="0" type="button" onclick="givePointModal()">
														<span><i class="ti ti-coins me-0 me-sm-1 ti-xs"></i>
														<span class="d-none d-sm-inline-block">포인트 부여</span></span>
													</button>
													<button
														class="dt-button add-new btn btn-primary waves-effect waves-light"
														tabindex="0" type="button" onclick="sendEmail()">
														<span><i class="ti ti-send me-0 me-sm-1 ti-xs"></i>
														<span class="d-none d-sm-inline-block">이메일 전송</span></span>
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
													colspan="1" style="width: 61.9062px; text-align: center;">선택</th>
												<th class="sorting sorting_desc" tabindex="0"
													rowspan="1" colspan="1"
													style="width: 200.625px;">이메일</th>
												<th class="sorting" tabindex="0" rowspan="1" colspan="1"
													style="width: 146.266px;">이름</th>
												<th class="sorting" tabindex="0"
													 rowspan="1" colspan="1"
													style="width: 146.266px;">닉네임</th>
												<th class="sorting" tabindex="0"
													 rowspan="1" colspan="1"
													style="width: 192.016px;">전화번호</th>	
												<th class="sorting" tabindex="0"
													rowspan="1" colspan="1"
													style="width: 162.016px;">가입일</th>
												<th class="sorting" tabindex="0"
													rowspan="1" colspan="1"
													style="width: 120.016px;">보유포인트</th>
												<th class="sorting" tabindex="0"
													rowspan="1" colspan="1"
													style="width: 100.016px;">등급</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 140px;" aria-label="Actions">회원 설정</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="cList" items="${customerList }">
										
											<tr class="odd">
												<td class="checkUser" tabindex="0" style="text-align: center;">
													<input class="form-check-input mt-0" type="checkbox" value="${cList.email }_${cList.msgAgree }_${cList.name }" name="csCheck"/>
												</td>
												<td class="sorting_1">
												<div class="d-flex justify-content-start align-items-center user-name">
														<div class="avatar-wrapper">
															<div class="avatar me-3">
															<c:if test="${cList.userImg == null }">
																<img src="/resources/assets/images/products/details/basic.png" alt="Avatar"
																	class="rounded-circle">
															</c:if>
															<c:if test="${cList.userImg != null }">
																<img src="${cList.userImg }" alt="Avatar"
																	class="rounded-circle">
															</c:if>
															</div>
														</div>
														<div class="d-flex flex-column">
																<span class="fw-medium">${cList.email }</span>
																<c:if test="${cList.msgAgree == 'N' }">
																	<small class="text-muted">수신미동의</small>
																</c:if>
														</div>
													</div></td>
												<td>
													<span>${cList.name }</span>
												</td>
												<td><span class="fw-medium">${cList.nickname }</span></td>
												<td><span class="fw-medium">${cList.phoneNumber }</span></td>
												<td>${cList.registerDate }</td>
												<td>${cList.userPoint }점</td>
												<td>
													<c:choose>
														<c:when test="${cList.isAdmin eq 'U' }">
															<span class="badge bg-label-success" >일반회원</span>
														</c:when>
														
														<c:when test="${cList.isAdmin eq 'M' }">
															<span class="badge bg-label-warning" >게시판 매니저</span>
														</c:when>
														
														<c:otherwise>
															<span class="badge bg-label-danger" >관리자</span>
														</c:otherwise>
													</c:choose>
												
												</td>
												<td class="dtr-hidden" >
													<div class="d-flex align-items-center">
														<a href="javascript:;" class="text-body" onclick="editModal('${cList}')">
														<i class="ti ti-edit ti-sm me-2"></i>
														</a>
														<a href="javascript:;"class="text-body" onclick="deleteModal('${cList}')">
														<i class="ti ti-trash ti-sm mx-2"></i>
														</a>
														<a href="javascript:;"class="text-body" onclick="passwordReset('${cList}')">
														<i class="ti ti-refresh ti-sm mx-2"></i>
														</a>
													</div>
												</td>
											</tr>
											</c:forEach>
											
										</tbody>
									</table>
									
				 <div class="row mx-2">
                <div class="col-sm-12 col-md-6">
                 <div class="dataTables_info" id="DataTables_Table_0_info" role="status" aria-live="polite">총 회원 수 : ${pagingInfo.totalProductCnt}</div>
                </div>
                <div class="col-sm-12 col-md-6">
                  <div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate">
                    <ul class="pagination">
                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
                        <a href="/admin/customer/customerAdmin?pageNo=1" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> 1 </a>
                      </li>
                      <c:choose>
                      <c:when test="${param.pageNo <= 10 or param.pageNo == null}">
	                      <li class="paginate_button page-item previous disabled" id="DataTables_Table_0_previous">
	                        <a aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> << </a>
	                      </li>
                      </c:when>
                      <c:otherwise>
	                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
	                        <a href="/admin/customer/customerAdmin?pageNo=${param.pageNo - 10}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> << </a>
	                      </li>
                      </c:otherwise>
                      </c:choose>
                      <c:choose>
                      <c:when test="${param.pageNo == 1 or param.pageNo == null}">
	                      <li class="paginate_button page-item previous disabled" id="DataTables_Table_0_previous">
	                        <a aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> < </a>
	                      </li>
                      </c:when>
                      <c:otherwise>
	                      <li class="paginate_button page-item previous " id="DataTables_Table_0_previous">
	                        <a href="/admin/customer/customerAdmin?pageNo=${param.pageNo - 1}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" aria-disabled="true" role="link" data-dt-idx="previous" tabindex="-1" class="page-link"> < </a>
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
			                        <a href="/admin/customer/customerAdmin?pageNo=${paging}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" role="link" aria-current="page" class="page-link">${paging}</a>
			                      </li>
	    	                  </c:otherwise>
	                      </c:choose>
					  </c:forEach>
                      <c:choose>
                      	<c:when test="${paran.pageNo != null or param.pageNo >= pagingInfo.totalPageCnt}">
	                      <li class="paginate_button page-item next disabled" id="DataTables_Table_0_next">
	                        <a href="/admin/customer/customerAdmin?pageNo=${param.pageNo + 1}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> > </a>
	                      </li>
                      	</c:when>
                      	<c:otherwise>
	                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
	                        <a href="#" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> > </a>
	                      </li>
                      	</c:otherwise>
                      </c:choose>
                      <c:choose>
                      	<c:when test="${paran.pageNo != null or (pagingInfo.totalPageCnt - param.pageNo) < 10 or pagingInfo.totalPageCnt == param.pageNo}">
	                      <li class="paginate_button page-item next disabled" id="DataTables_Table_0_next">
	                        <a href="#" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> >> </a>
	                      </li>
                      	</c:when>
                      	<c:otherwise>
	                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
	                        <a href="/admin/customer/customerAdmin?pageNo=${param.pageNo + 10}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> >> </a>
	                      </li>
                      	</c:otherwise>
                      </c:choose>
	                      <li class="paginate_button page-item next" id="DataTables_Table_0_next">
	                        <a href="/admin/customer/customerAdmin?pageNo=${pagingInfo.totalPageCnt}&pageProductCnt=${pageProductCnt}&colName=${colName}&colValue=${colValue}&searchWord=${searchWord}&searchType=${searchType}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="next" tabindex="0" class="page-link"> ${pagingInfo.totalPageCnt} </a>
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

	<!-- Overlay -->
	<div class="layout-overlay layout-menu-toggle"></div>

	<!-- Drag Target Area To SlideIn Menu On Small Screens -->
	<div class="drag-target"></div>
	
	<!-- / Layout wrapper -->
	
	<!-- editUser modal -->	
	<div class="modal" id="editUser" tabindex="-1" aria-modal="true" role="dialog">
  	<div class="modal-dialog modal-lg modal-simple modal-edit-user modal-dialog-centered">
    <div class="modal-content p-3 p-md-5">
      <div class="modal-body">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        <div class="text-center mb-4">
          <h3 class="mb-2">회원 상세 정보</h3>
        </div>
        <form id="editUserForm" class="row g-3 fv-plugins-bootstrap5 fv-plugins-framework" onsubmit="return false" novalidate="novalidate">
        
        
          
          
           <div class="col-12 col-md-6 fv-plugins-icon-container">
            <label class="form-label" for="modalEditUserName">이름</label>
            <input type="text" id="modalEditUserName" name="modalEditUserName" class="form-control" placeholder="john.doe.007" readOnly>
          <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div></div>
          
         
         
         <div class="col-12 col-md-6">
            <label class="form-label" for="modalEditUserPhone">전화번호</label>
            <div class="input-group">
              <span class="input-group-text">KR (+82)</span>
              <input type="text" id="modalEditUserPhone" name="modalEditUserPhone" class="form-control phone-number-mask" placeholder="202 555 0111" readOnly>
            </div>
          </div>
          
          
          
          <div class="col-12 fv-plugins-icon-container">
            <label class="form-label" for="modalEditUserUuid">회원 고유번호(uuid)</label>
            <input type="text" id="modalEditUserUuid" name="modalEditUserUuid" class="form-control" readOnly>
          <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div></div>
          
          <div class="col-12 col-md-6 fv-plugins-icon-container">
            <label class="form-label" for="modalEditUserEmail">이메일</label>
             <input type="text" id="modalEditUserEmail" name="modalEditUserEmail" class="form-control" readOnly>
          <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div></div>
          
          <div class="col-12 col-md-6">
            <label class="form-label" for="modalEditGender">성별</label>
            <input type="text" id="modalEditGender" name="modalEditGender" class="form-control" readOnly>
          </div>
          
           <div class="col-12 col-md-6">
            <label class="form-label" for="modalEditBrithday">생일</label>
            <input type="text" id="modalEditBrithday" name="modalEditBrithday" class="form-control" readOnly>
          </div>
          
          <div class="col-12 col-md-6">
            <label class="form-label" for="modalEditRegisterDate">가입일</label>
            <input type="text" id="modalEditRegisterDate" name="modalEditRegisterDate" class="form-control" readOnly>
          </div>
          
          
          <div class="col-12 col-md-4">
            <label class="form-label" for="modalEditBankName">환불계좌(은행명)</label>
            <input type="text" id="modalEditBankName" name="modalEditBankName" class="form-control" readOnly>
          </div>
          <div class="col-12 col-md-8">
            <label class="form-label" for="modalEditAccount">환불계좌(계좌번호)</label>
            <input type="text" id="modalEditAccount" name="modalEditAccount" class="form-control" readOnly>
          </div>
          <div class="text-center">
          <h5 style="margin-bottom: 0px">수정 가능한 정보 ▼</h5>
        </div>
           <div class="col-12 col-md-6 fv-plugins-icon-container">
            <label class="form-label" for="modalEditUserNickName">닉네임</label>
            <input type="text" id="modalEditUserNickName" name="modalEditUserNickName" class="form-control" placeholder="Doe">
          <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div></div>
          
          <div class="col-12 col-md-6">
            <label class="form-label" for="modalEditUserStatus">등급</label>
            <div class="position-relative">
            <select id="modalEditUserStatus" name="modalEditUserStatus" class="form-select"  tabindex="-1" aria-hidden="true">
              <option value="U">일반회원</option>
              <option value="M">게시판 매니저</option>
              <option value="A">관리자</option>
            </select>
          </div>
          </div>
          
          <div class="col-12" id = "valchecktext">
            <div class="form-check form-check-danger">
                 <input class="form-check-input" type="checkbox" id="customCheckDanger">
                 <label class="form-check-label" for="customCheckDanger">회원정보를 수정하시겠습니까?</label>
            </div>
          </div>
          <div class="col-12 text-center">
            <button type="submit" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light" onclick="editCustomerInfo()">수정</button>
            <button type="reset" class="btn btn-label-secondary waves-effect modalClose" data-bs-dismiss="modal" aria-label="Close">닫기</button>
          </div>
        <input type="hidden"></form>
      </div>
    </div>
  </div>
</div>

	<div class="modal" id="pointInput" tabindex="-1" aria-modal="true" role="dialog">
                <div class="modal-dialog modal-simple modal-enable-otp modal-dialog-centered">
                  <div class="modal-content p-3 p-md-5">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      <div class="text-center mb-4">
                        <h3 class="mb-2">고객 포인트 부여</h3>
                      </div>
                      <p>선택한 <span id="pCnt"></span>고객에게 포인트를 부여합니다.</p>
                      <form id="enableOTPForm" class="row g-3 fv-plugins-bootstrap5 fv-plugins-framework" onsubmit="return false" novalidate="novalidate">
                        <div class="col-12 col-md-3" style="padding-top: 20px;">
                          <div class="input-group has-validation">
                            <input type="radio" id="modalPointPlusMinus" name="modalPointPlusMinus" class="form-check-input" value="plus">
                            <label class="form-label" for="modalPointPlus">&nbsp 주기 </label>
                          </div>
                           <div class="input-group has-validation">
                            <input type="radio" id="modalPointPlusMinus" name="modalPointPlusMinus" class="form-check-input" value="minus">
                            <label class="form-label" for="modalPointMinus">&nbsp 뺏기 </label>
                          </div>
                        </div>
                        <div class="col-12 col-md-9">
                          <label class="form-label" for="modalPointHowmuch">포인트 점수 </label>
                          <div class="input-group has-validation">
                            <input type="number" id="modalPointHowmuch" name="modalPointHowmuch" class="form-control" placeholder="숫자만 입력.."
                            onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');">
                          </div>
                        </div>
                         <div class="col-12" id="errPoint">
                         </div>
                        <div class="col-12">
                          <button type="submit" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light" onclick="savePoint()">저장</button>
                          <button type="reset" class="btn btn-label-secondary waves-effect modalClose" data-bs-dismiss="modal" aria-label="Close">
                            닫기
                          </button>
                        </div>
                      <input type="hidden"></form>
                    </div>
                  </div>
                </div>
              </div>
	
			<div class="modal" id="emailInputModal" tabindex="-1" aria-modal="true" role="dialog">
                <div class="modal-dialog modal-lg modal-simple modal-enable-otp modal-dialog-centered">
                  <div class="modal-content p-3 p-md-5">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      <div class="text-center mb-4">
                        <h3 class="mb-2">이메일 전송</h3>
                      </div>
                      <p>선택한 <span id="eCnt"></span>고객에게 이메일을 발송합니다.(수신미동의 :<span id="noECnt"></span>명 제외)</p>
                      <form id="enableOTPForm" class="row g-3 fv-plugins-bootstrap5 fv-plugins-framework" onsubmit="return false" novalidate="novalidate">
                        
                        <div class="col-12 ">
                          <label class="form-label" for="modalPointHowmuch">이메일 제목 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modalEmailTitle" name="modalEmailTitle" class="form-control" placeholder="제목 입력.." >
                          </div>
                        </div>
                        <div class="col-12">
                          <div class="summernote">
                            <textarea id="summernote" name="editordata"></textarea>
                          </div>
                        </div>
                         <div class="col-12" id="errPoint2">
                         </div>
                        <div class="col-12">
                          <button type="submit" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light" onclick="goUserToEmail()">전송</button>
                          <button type="reset" class="btn btn-label-secondary waves-effect modalClose" data-bs-dismiss="modal" aria-label="Close">
                            닫기
                          </button>
                        </div>
                      <input type="hidden"></form>
                    </div>
                  </div>
                </div>
              </div>
              
              
			<div class="modal" id="deleteUserModal" tabindex="-1" aria-modal="true" role="dialog">
                <div class="modal-dialog modal-lg modal-simple modal-enable-otp modal-dialog-centered">
                  <div class="modal-content p-3 p-md-5">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      <div class="text-center mb-4">
                        <h3 class="mb-2">회원 탈퇴</h3>
                      </div>
                      <form id="enableOTPForm" class="row g-3 fv-plugins-bootstrap5 fv-plugins-framework" onsubmit="return false" novalidate="novalidate">
                        
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modalDelUserName">회원 이름 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modalDelUserName" name="modalDelUserName" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modalDelUserEmail">이메일 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modalDelUserEmail" name="modalDelUserEmail" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modalDelUserRegdate">가입일 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modalDelUserRegdate" name="modalDelUserRegdate" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12 col-md-6">
                          <label class="form-label" for="modalDelUserIsAdmin">등급 </label>
                          <div class="input-group has-validation">
                            <input type="text" id="modalDelUserIsAdmin" name="modalDelUserIsAdmin" class="form-control" readOnly>
                          </div>
                        </div>
                        <div class="col-12">
                          <div class="col-12">
                           	<label class="form-label" for="modalDelUserIsReason">사유 </label>
                            <textarea class="form-control" id="modalDelUserIsReason" maxlength="400" rows="5" ></textarea>
                          </div>
                        </div>
                        <div class="col-12" id="delValCheck">
           					 <div class="form-check form-check-danger">
                				 <input class="form-check-input" type="checkbox" id="delValchecktext">
                 				 <label class="form-check-label" for="delValchecktext">회원탈퇴를 진행합니까?</label>
           					 </div>
          				</div>
                         <div class="col-12" id="errDelet">
                         </div>
                        <div class="col-12">
                          <button type="submit" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light" onclick="deleteUser()">전송</button>
                          <button type="reset" class="btn btn-label-secondary waves-effect modalClose" data-bs-dismiss="modal" aria-label="Close">
                            닫기
                          </button>
                        </div>
                      <input type="hidden"></form>
                    </div>
                  </div>
                </div>
              </div>
              
              
              <!-- 에러 모달 -->
              <div class="modal" id="errorModal" tabindex="-1" aria-modal="true" role="dialog">
                <div class="modal-dialog modal-sm modal-simple modal-enable-otp modal-dialog-centered">
                  <div class="modal-content" style="padding: 20px;">
                    <div class="modal-body" style="padding: 10px;">
                      <div class="text-center mb-4">
                        <h3 class="mb-2" id="eModalText"></h3>
                      </div>
                        <div class="col-12" style="text-align: center;">
                          <button type="button" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light modalClose">닫기</button>
                        </div>
                      <input type="hidden">
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- 비밀번호 초기화 -->
              <div class="modal" id="resetPwdModal" tabindex="-1" aria-modal="true" role="dialog">
                <div class="modal-dialog  modal-simple modal-enable-otp modal-dialog-centered">
                  <div class="modal-content p-3 p-md-5">
                    <div class="modal-body">
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      <div class="text-center mb-4">
                        <h3 class="mb-2">비밀번호 초기화</h3>
                      </div>
                      <p>선택한 <span id="pwdModalName"></span>고객의 비밀번호를 초기화합니다.</p>
                      <form id="enableOTPForm" class="row g-3 fv-plugins-bootstrap5 fv-plugins-framework" onsubmit="return false" novalidate="novalidate">
                        
                        <div class="col-12 ">
                          비밀번호를 초기화 후 자동으로 고객에게 메일이 발송됩니다! <br/>
                          email : <span id="pwdModalEmail"></span>
                        </div>
                        
                         <div class="col-12" id="errPoint2">
                         </div>
                        <div class="col-12" style="text-align: center;">
                          <button type="submit" class="btn btn-primary me-sm-3 me-1 waves-effect waves-light" onclick="resetPwdBtn()">변경</button>
                          <button type="reset" class="btn btn-label-secondary waves-effect modalClose" data-bs-dismiss="modal" aria-label="Close">
                            닫기
                          </button>
                        </div>
                      <input type="hidden"></form>
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
	
	<!-- Sheet JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
	<!--FileSaver savaAs 이용 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

	<!-- Page JS -->
	<script type="text/javascript">
		$(function(){
			setPerOfGender();
			
			setPerOfMonthSignUp();

			setPerOfWithDrawCus();
	
			$("#searchWord").on('keypress', function(e){
				if(e.keyCode == '13'){
					location.href="/admin/customer/customerAdmin?pageProductCnt=" +'${pageProductCnt}'+"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val(); 
				}
			});
			
			
			$("#pageProductCnt").change(function(){
				location.href="/admin/customer/customerAdmin?pageProductCnt=" + $(this).val() +"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val(); 
			});
			
			
			$("#colName").change(function(){
				location.href="/admin/customer/customerAdmin?pageProductCnt=" + '${pageProductCnt}' +"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() + "&colName=" + $(this).val() + "&colValue=" + $("#colValue").val(); 
			});
			
			$("#colValue").change(function(){
				location.href="/admin/customer/customerAdmin?pageProductCnt=" + '${pageProductCnt}' +"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() + "&colName=" + $("#colName").val() + "&colValue=" + $(this).val() ; 
			});
			
			$(".btn-close").click (function(){
				$("#editUser").hide();
				$("#pointInput").hide();
				$('#emailInputModal').hide();
				$('#summernote').summernote('reset');
				$("#deleteUserModal").hide();
				$('#errorModal').hide();
				$("#resetPwdModal").hide();
			});
			
			$(".modalClose").click (function(){
				$("#editUser").hide();
				$("#pointInput").hide();
				$('#emailInputModal').hide();
				$('#summernote').summernote('reset');
				$("#deleteUserModal").hide();
				$('#errorModal').hide();
				$("#resetPwdModal").hide();
			});
			
			
			$('#summernote').summernote({
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
		
		
		
		function editModal(cList){
			
			let csInfo = strToJson(cList);

  			console.log(csInfo);
			
  			$("#modalEditUserName").val(csInfo.name);
  			$("#modalEditUserNickName").val(csInfo.nickname);
  			$("#modalEditUserPhone").val(csInfo.phoneNumber);
  			$("#modalEditUserStatus").val(csInfo.isAdmin);
  			$("#modalEditUserUuid").val(csInfo.uuid);
  			$("#modalEditUserEmail").val(csInfo.email);
  			
  			
  			if(csInfo.gender == "male"){
  				$("#modalEditGender").val("남성");
  			} else {
  				$("#modalEditGender").val("여성");
  			}
  			
  			$("#modalEditBrithday").val(csInfo.birthday);
  			$("#modalEditRegisterDate").val(csInfo.registerDate);
  			
  			if(csInfo.refundAccount == 'null'){
  				$("#modalEditBankName").val("-");
  	  			$("#modalEditAccount").val("-");
  			} else {
  				$("#modalEditBankName").val(csInfo.bankName);
  	  			$("#modalEditAccount").val(csInfo.refundAccount);
  			}
  			
			
			$("#editUser").show();
		};
		
		
		function editCustomerInfo(){
			let uuid = $("#modalEditUserUuid").val();
			let nickname = $("#modalEditUserNickName").val();
			let isAdmin = $("#modalEditUserStatus").val();
			let validCheck = $("#customCheckDanger").is(':checked');
			let qstr = "/admin/customer/customerAdmin?pageProductCnt=" +'${pageProductCnt}'+"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() +"&colName=" + $("#colName").val() + "&colValue=" + $("#colValue").val() ;  
			if(validCheck){
				
				$.ajax({
					url: "editCsInfo", // 데이터가 송수신될 서버의 주소
					data: {
						"nickname" : nickname,
						"isAdmin" : isAdmin,
						"uuid" : uuid
					},
					type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
					success: function() {
						// 통신이 성공하면 수행할 함수
					},
					error: function() {
					},
					complete: function() {
						$("#editUser").hide();
						location.replace(qstr);
					},
				}); 
				
			} else {
				$("#valchecktext").css("background-color" , "#F4DAD6");
			}
			
		};
		
		
		function givePointModal(){
			var csCnt = 0;
			$("input[name=csCheck]:checked").each(function(){
				csCnt++;
			});
			if(csCnt != 0){
				$("#pCnt").text(csCnt+ "명의 ");
				$("#pointInput").show();
			} else {
				errModalOpen("고객을 선택해주세요!");
			}
			
		};
		
		function savePoint(){
			var userList = new Array();
			var plusminus = $("input[name=modalPointPlusMinus]:checked").val();
			var howmuch = $("#modalPointHowmuch").val();
			let qstr = "/admin/customer/customerAdmin?pageProductCnt=" +'${pageProductCnt}'+"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() +"&colName=" + $("#colName").val() + "&colValue=" + $("#colValue").val() ;
			if(plusminus != null && howmuch != ""){
				$("input[name=csCheck]:checked").each(function(){
					userList.push($(this).val().split("_")[0]);	
				});
				var point = "";
				if(plusminus == "plus"){
					point = ""+ howmuch;
				} else if (plusminus == "minus"){
					point = "-" + howmuch;
				}
				
				
				$.ajax({
					url: "updatePoint", // 데이터가 송수신될 서버의 주소
					data: {
						"point" : point,
						"userList" : userList
					},
					type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
					success: function() {
						// 통신이 성공하면 수행할 함수
					},
					error: function() {
					},
					complete: function() {
						$("#pointInput").hide();
						location.replace(qstr);
					},
				}); 
				
			} else {
				$("#errPoint").text("값을 모두 입력해주세요!").css("color", "red");
			}
			
		}
		
		function sendEmail(){
			var etCnt = 0;
			var noEtCnt = 0;
			$("input[name=csCheck]:checked").each(function(){
				if($(this).val().split("_")[1] == 'Y'){
				 	etCnt++;
				} else {
					noEtCnt++;
				}
			});
			if(etCnt != 0){
				$("#eCnt").text(etCnt+ "명의 ");
				$("#noECnt").text(noEtCnt);
				$('#emailInputModal').show();
			} else {
				errModalOpen("고객을 선택해주세요!");
			}
			
		};
		
		function goUserToEmail(){
			var userList = new Array();
			var title = $("#modalEmailTitle").val();
			var content = $("#summernote").val();
			let qstr = "/admin/customer/customerAdmin?pageProductCnt=" +'${pageProductCnt}'+"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() +"&colName=" + $("#colName").val() + "&colValue=" + $("#colValue").val() ;  
			
			if(title != '' && content != null){
				$("input[name=csCheck]:checked").each(function(){
					if($(this).val().split("_")[1] == 'Y'){
						userList.push($(this).val().split("_")[0]);	
					}
				});
				
				$.ajax({
					url: "sendEmail", // 데이터가 송수신될 서버의 주소
					data: {
						"title" : title,
						"content" : content,
						"userList" : userList
					},
					type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
					success: function() {
						// 통신이 성공하면 수행할 함수
					},
					error: function() {
					},
					complete: function() {
						$("#emailInputModal").hide();
						location.replace(qstr);
					},
				}); 
				
			} else {
				$("#errPoint2").text("제목 내용을 모두 입력해주세요!").css("color", "red");
			}
			console.log(title);
			console.log(content);
			
		};
		
		function deleteModal(cList){
			
			let csInfo = strToJson(cList);

  			console.log(csInfo);
  			
  			$("#modalDelUserName").val(csInfo.name);
  			$("#modalDelUserEmail").val(csInfo.email);
  			$("#modalDelUserRegdate").val(csInfo.registerDate);
  			
  			if(csInfo.isAdmin == "U"){
  				$("#modalDelUserIsAdmin").val("일반회원");
  			} else if(csInfo.isAdmin == "A"){
  				$("#modalDelUserIsAdmin").val("관리자");
  			} else if(csInfo.isAdmin == "M"){
  				$("#modalDelUserIsAdmin").val("게시판관리자");
  			}
  			
  			
  			$("#deleteUserModal").show();
			
		};
		
		function deleteUser(){
			
			let email = $("#modalDelUserEmail").val();
			let reason = $("#modalDelUserIsReason").val();
			let delValcheck = $("#delValchecktext").is(':checked');
			let qstr = "/admin/customer/customerAdmin?pageProductCnt=" +'${pageProductCnt}'+"&searchType=" + $("#searchType").val() + "&searchWord=" + $("#searchWord").val() +"&colName=" + $("#colName").val() + "&colValue=" + $("#colValue").val() ;  
			if(reason != ""){
				if(delValcheck){
					
					$.ajax({
						url: "delCsInfo", // 데이터가 송수신될 서버의 주소
						data: {
							"email" : email,
							"reason" : reason
						},
						type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
						success: function() {
							// 통신이 성공하면 수행할 함수
						},
						error: function() {
						},
						complete: function() {
							$("#deleteUserModal").hide();
							location.replace(qstr);
						},
					}); 
					
					
				} else {
					$("#delValCheck").css("background-color" , "#F4DAD6");
				}
			} else {
				$("#errDelet").text("내용을 전부 입력해주세요!").css("color","red");
			}
			
			
			
			
		};
		
		function passwordReset(cList){
			
			let csInfo = strToJson(cList);
			
			$("#pwdModalName").text(csInfo.name);
			$("#pwdModalEmail").text(csInfo.email);
			
			$("#resetPwdModal").show();
			
		};
		
		function resetPwdBtn(){
			
			var email = $("#pwdModalEmail").text();
			
			$.ajax({
				url: "resetCustomerPwd", // 데이터가 송수신될 서버의 주소
				data: {
					"email" : email
				},
				type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
				success: function() {
					// 통신이 성공하면 수행할 함수
				},
				error: function() {
				},
				complete: function() {
					$("#resetPwdModal").hide();
					location.replace(qstr);
				},
			}); 
			
		};
		
		function errModalOpen(msg){
			$("#eModalText").text(msg);
			$("#errorModal").show();
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
		
		function setPerOfWithDrawCus() {
			let total = parseInt($("#totalCus").html());
			let withDrawCus = parseInt($("#withDrawCus").html());
			
			let result = "전체 대비 " + (Math.round(withDrawCus / total * 1000) / 10) + "%";
			
			$("#perOfWithDrawCus").html(result);
		}

		function setPerOfMonthSignUp() {
			let total = parseInt($("#totalCus").html());
			let monthSignUp = parseInt($("#monthSignUp").html());
			
			let result = "전체 대비 " + (Math.round(monthSignUp / total * 1000) / 10) + "%";
			
			$("#perOfMonthSignUp").html(result);
		}

		function setPerOfGender() {
			let male = parseInt($("#malePop").html());
			let female = parseInt($("#femalePop").html());
			let total = male + female;
			
			let malePer = Math.round(male / total * 1000) / 10;
			let femalePer = 100 - malePer;
			
			let result = malePer + "% / " + femalePer + "%";
			
			$("#perOfGender").html(result);
		}
		
		
		
		
		
		
		// 파일 엑셀 변환 
		const excelDownload = document.querySelector('#exportExcel');
		
		document.addEventListener('DOMContentLoaded', ()=>{
		    excelDownload.addEventListener('click', exportExcel);
		});

		function exportExcel(){ 
		  // step 1. workbook 생성
		  var wb = XLSX.utils.book_new();

		  // step 2. 시트 만들기 
		  var newWorksheet = excelHandler.getWorksheet();

		  // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
		  XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

		  // step 4. 엑셀 파일 만들기 
		  var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

		  // step 5. 엑셀 파일 내보내기 
		  saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
		}

		var excelHandler = {
		    getExcelFileName : function(){
		        return 'Customers_List.xlsx';	//파일명
		    },
		    getSheetName : function(){
		        return 'Customers';	//시트명
		    },
		    getExcelData : function(){
		        return document.getElementById('DataTables_Table_0'); 	//TABLE id
		    },
		    getWorksheet : function(){
		        return XLSX.utils.table_to_sheet(this.getExcelData());
		    }
		}

		function s2ab(s) { 
		  var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
		  var view = new Uint8Array(buf);  //create uint8array as viewer
		  for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
		  return buf;    
		}
		
	</script>


	
</body>
</html>