<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html lang="en" class="light-style layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr" data-theme="theme-default" data-assets-path="../../assets/" data-template="vertical-menu-template-no-customizer">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>admin | orderList</title>

<meta name="description" content="" />

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="../../resources/assets/images/icons/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap" rel="stylesheet" />

<!-- Icons -->
<link rel="stylesheet" href="../../resources/assets/vendor/fonts/fontawesome.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/fonts/tabler-icons.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/fonts/flag-icons.css" />

<!-- Core CSS -->
<link rel="stylesheet" href="../../resources/assets/vendor/css/rtl/core.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/css/rtl/theme-default.css" />
<link rel="stylesheet" href="../../resources/assets/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet" href="../../resources/assets/vendor/libs/node-waves/node-waves.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/typeahead-js/typeahead.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />

<!-- Page CSS -->

<!-- Helpers -->
<script src="../../resources/assets/vendor/js/helpers.js"></script>
<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="../../resources/assets/js/config.js"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>

<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
	
			<!-- Menu -->
			<jsp:include page="../admin/aside.jsp"></jsp:include>
			<!-- / Menu -->
	
		<div class="layout-container">

			<!-- Layout container -->
			<div class="layout-page">

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->

					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="py-3 mb-2">
							<span class="text-muted fw-light">주문관리 /</span> 주문내역
						</h4>

						<!-- Order List Widget -->

						<div class="card mb-4">
							<div class="card-widget-separator-wrapper">
								<div class="card-body card-widget-separator">
									<div class="row gy-4 gy-sm-1">
										<div class="col-sm-6 col-lg-3">
											<div class="d-flex justify-content-between align-items-start card-widget-1 border-end pb-3 pb-sm-0">
												<div>
													<h4 class="mb-2">${summary.pending}</h4>
													<p class="mb-0 fw-medium">입금 대기</p>
												</div>
												<span class="avatar me-sm-4"> <span class="avatar-initial bg-label-secondary rounded"> <i class="ti-md ti ti-calendar-stats text-body"></i>
												</span>
												</span>
											</div>
											<hr class="d-none d-sm-block d-lg-none me-4" />
										</div>
										<div class="col-sm-6 col-lg-3">
											<div class="d-flex justify-content-between align-items-start card-widget-2 border-end pb-3 pb-sm-0">
												<div>
													<h4 class="mb-2">${summary.completed}</h4>
													<p class="mb-0 fw-medium">결제 완료</p>
												</div>
												<span class="avatar p-2 me-lg-4"> <span class="avatar-initial bg-label-secondary rounded"><i class="ti-md ti ti-wallet text-body"></i></span>
												</span>
											</div>
											<hr class="d-none d-sm-block d-lg-none" />
										</div>
										<div class="col-sm-6 col-lg-3">
											<div class="d-flex justify-content-between align-items-start border-end pb-3 pb-sm-0 card-widget-3">
												<div>
													<h4 class="mb-2">${summary.confirmed}</h4>
													<p class="mb-0 fw-medium">구매 확정</p>
												</div>
												<span class="avatar p-2 me-sm-4"> <span class="avatar-initial bg-label-secondary rounded"><i class="ti-md ti ti-checks text-body"></i></span>
												</span>
											</div>
										</div>
										<div class="col-sm-6 col-lg-3">
											<div class="d-flex justify-content-between align-items-start">
												<div>
													<h4 class="mb-2">${summary.refund}</h4>
													<p class="mb-0 fw-medium">주문 취소 및 부분 취소</p>
												</div>
												<span class="avatar p-2"> <span class="avatar-initial bg-label-secondary rounded"><i class="ti-md ti ti-alert-octagon text-body"></i></span>
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Order List Table -->
						<div class="card">
							<div class="card-datatable table-responsive">
								<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
									<div class="card-header pb-md-2 d-flex flex-column flex-md-row align-items-start align-items-md-center">
										<div class="dataTables_length mt-0 mt-md-3 ms-n2" id="DataTables_Table_0_length">
											<form action="/admin/order/list" method="POST" id="filteringForm">
												<select aria-controls="DataTables_Table_0" class="form-select filteringSelect" id="orderType" name="orderType" >
													<option value="" selected>주문상태선택</option>
													<option value="completePayment">결제완료</option>
													<option value="waitingForDeposit">입금대기</option>
													<option value="preparingProduct">상품준비중</option>
													<option value="shipping">배송중</option>
													<option value="deliveryCompleted">배송완료</option>
												</select>
												<select class="form-select filteringSelect" id="viewCountPerPage" name="viewCountPerPage">
													<option value="10" selected>10</option>
													<option value="40">40</option>
													<option value="60">60</option>
													<option value="80">80</option>
													<option value="100">100</option>
												</select>
											</form>
										</div>
										<div class="d-flex align-items-md-center justify-content-md-end mt-2 mt-md-0 gap-2">
											
											
											
										</div>
									</div>
									<table class="datatables-order table border-top dataTable no-footer dtr-column" id="DataTables_Table_0" aria-describedby="DataTables_Table_0_info">
                    					<thead>
                      						<tr>
                      							<th class="control sorting_disabled dtr-hidden" rowspan="1" colspan="1" style="width: 12.5469px; display: none;" aria-label=""></th>
                      							<th class="sorting_disabled dt-checkboxes-cell dt-checkboxes-select-all" rowspan="1" colspan="1" style="width: 10.4531px;" data-col="1" aria-label="">
                      								<input type="checkbox" class="form-check-input" id="checkAll">
                      							</th>
                      							<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 74.6562px;" >주문번호</th>
                      							<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 81.6562px;" >주문상태</th>
                      							<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 126.125px;" >주문일/<br>결제일</th>
                      							<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 126.125px;" >주문명</th>
                      							<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 90.8594px;" >고객명</th>
                      							<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 90.8594px;" >결제수단</th>
<!--                       							<th class="sorting_disabled" rowspan="1" colspan="1" style="width: 90.9375px;" aria-label="Actions">Actions</th> -->
                      						</tr>
                    					</thead>
                    					<tbody>
	                    					<c:if test="${requestScope.orderList.size() gt 0 }">
												<c:forEach var="order" items="${requestScope.orderList }">
													<tr id="order_${order.orderNo }" >
														<td><input type="checkbox" class="form-check-input" id="order_${order.orderNo }" name="odRow" ></td>
														<td onclick="orderDetail(this)">${order.orderNo }</td>
 														<td> 
															<c:choose>
																<c:when test="${order.orderStatus eq '결제완료' or order.orderStatus eq 'completePayment' or order.orderStatus eq 'DONE' }">
																	<span class="badge bg-label-success">
																</c:when>
																<c:when test="${order.orderStatus eq '구매확정'}">
																	<span class="badge bg-label-success">
																</c:when>
																<c:when test="${order.orderStatus eq '입금대기' or order.orderStatus eq 'waitingForDeposit' or order.orderStatus eq 'WAITING_FOR_DEPOSIT'  }">
																	<span class="badge bg-label-info"> 
																</c:when>
																<c:when test="${order.orderStatus eq '상품준비중' or order.orderStatus eq 'preparingProduct'}">
																	<span class="badge bg-label-info"> 
																</c:when>
																<c:when test="${order.orderStatus eq '배송시작' or order.orderStatus eq 'preparingProduct'}">
																	<span class="badge bg-label-info"> 
																</c:when>
																<c:when test="${order.orderStatus eq '배송중' or order.orderStatus eq 'shipping' }">
																	<span class="badge bg-label-info"> 
																</c:when>
																<c:when test="${order.orderStatus eq '배송완료' or order.orderStatus eq 'deliveryCompleted' }">
																	<span class="badge bg-label-success"> 
																</c:when>
																<c:when test="${order.orderStatus eq '주문취소' or order.orderStatus eq 'CANCELED'}">
																	<span class="badge bg-label-danger"> 
																</c:when>
																<c:when test="${order.orderStatus eq '주문환불' }">
																	<span class="badge bg-label-danger"> 
																</c:when>
																<c:when test="${order.orderStatus eq '부분환불' or order.orderStatus eq 'partiallyRefunded'}">
																	<span class="badge bg-label-warning"> 
																</c:when>
																<c:when test="${order.orderStatus eq '부분취소' or order.orderStatus eq 'PARTIAL_CANCELED' or order.orderStatus eq 'EXPIRED' }">
																	<span class="badge bg-label-warning"> 
																</c:when>
																<c:otherwise>
																	<span>
																</c:otherwise>
															</c:choose>
															${order.orderStatus }</span> 
														</td>
														<td onclick="orderDetail(this)"><fmt:formatDate value="${order.orderTime }" pattern="yyyy-MM-dd" />/<br><fmt:formatDate value="${order.paymentDate }" pattern="yyyy-MM-dd" /></td>
														<td onclick="orderDetail(this)">${order.orderName }</td>
														<td onclick="orderDetail(this)"><c:if test="${order.customerName eq null}">비회원</c:if>${order.customerName }</td>
														<td onclick="orderDetail(this)">
															<c:choose>
																<c:when test="${order.payMethod eq '카드'}">
											                          <img src="../../resources/assets/images/icons/payments/mastercard-cc.png" class="img-fluid w-px-50 h-px-30" alt="master-card" data-app-light-img="icons/payments/master-light.png" data-app-dark-img="icons/payments/master-dark.png" style="margin:0 -10px;">
																</c:when>
																<c:otherwise>
																		${order.payMethod }
																</c:otherwise>
															</c:choose>
															
															${order.payAccountNo }
														</td>
													</tr>
												</c:forEach>
												
											</c:if>
											<c:if test="${requestScope.orderList.size() eq 0 }">
	                    						<tr class="odd">
	                    							<td valign="top" colspan="8" class="dataTables_empty">No data available in table</td>
	                    						</tr>
                    						</c:if>
                    					</tbody>
                  					</table>
									<div class="row mx-2">
										<div class="col-sm-12 col-md-6">
											<div class="dataTables_info" id="DataTables_Table_0_info" role="status" aria-live="polite">Displaying 31 to 40 of 100 entries</div>
										</div>
										<div class="col-sm-12 col-md-6">
											<div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate">
												<ul class="pagination">
													<c:choose>
														<c:when test="${param.pageNo == null || param.pageNo == 1}">
															<li class="page-item disabled"><a class="page-link" href="list?pageNo=${param.pageNo - 1}" tabindex="-1">Previous</a></li>	
														</c:when>
														<c:otherwise>
															<li class="page-item"><a class="page-link" href="list?pageNo=${param.pageNo - 1}" tabindex="-1">Previous</a></li>	
														</c:otherwise>
													</c:choose>
													<c:forEach var="i"  begin="${requestScope.pagingInfo.startNumOfCurrentPagingBlock }" end="${requestScope.pagingInfo.endNumOfCurrentPagingBlock }" >
														<c:choose>
															<c:when test="${requestScope.pagingInfo.pageNo eq i}">
																<li class="paginate_button page-item active"><a href="list?pageNo=${i}" aria-controls="DataTables_Table_0" role="link" aria-current="page" data-dt-idx="0" tabindex="0" class="page-link">${i}</a></li>
															</c:when>
															<c:otherwise>
																<li class="paginate_button page-item"><a href="list?pageNo=${i}" aria-controls="DataTables_Table_0" role="link" data-dt-idx="0" tabindex="0" class="page-link">${i}</a></li>
															</c:otherwise>
														</c:choose>
													</c:forEach>
													<c:choose>
														<c:when test="${requestScope.pagingInfo.pageBlockOfCurrentPage == requestScope.pagingInfo.totalPagingBlockCnt && param.pageNo == requestScope.pagingInfo.endNumOfCurrentPagingBlock}">
															<li class="page-item disabled"><a class="page-link" href="list?pageNo=${param.pageNo + 1}">Next</a></li>	
														</c:when>
														<c:otherwise>
															<li class="page-item"><a class="page-link" href="list?pageNo=${param.pageNo + 1}">Next</a></li>
														</c:otherwise>
													</c:choose>
												</ul>
											</div>
										</div>
									</div>




								</div>
							</div>
						</div>
					</div>
					<!-- / Content -->

					<!-- Footer -->
					<jsp:include page="../admin/footer.jsp"></jsp:include>
					<!-- / Footer -->

					<div class="content-backdrop fade"></div>
				</div>
				<!-- Content wrapper -->
			</div>
			<!-- / Layout page -->
		</div>

		<!-- Overlay -->
		<div class="layout-overlay layout-menu-toggle"></div>

		<!-- Drag Target Area To SlideIn Menu On Small Screens -->
		<div class="drag-target"></div>
	</div>
	<!-- / Layout wrapper -->

	<!-- Core JS -->
	<!-- build:js assets/vendor/js/core.js -->

	<script src="../../resources/assets/vendor/libs/jquery/jquery.js"></script>
	<script src="../../resources/assets/vendor/libs/popper/popper.js"></script>
	<script src="../../resources/assets/vendor/js/bootstrap.js"></script>
	<script src="../../resources/assets/vendor/libs/node-waves/node-waves.js"></script>
	<script src="../../resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
	<script src="../../resources/assets/vendor/libs/hammer/hammer.js"></script>
	<script src="../../resources/assets/vendor/libs/i18n/i18n.js"></script>
	<script src="../../resources/assets/vendor/libs/typeahead-js/typeahead.js"></script>
	<script src="../../resources/assets/vendor/js/menu.js"></script>

	<!-- endbuild -->

	<!-- Vendors JS -->
	<script src="../../resources/assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>

	<!-- Main JS -->
	<script src="../../resources/assets/js/main.js"></script>

	<!-- Page JS -->
	<script src="../../resources/assets/js/app-ecommerce-order-list.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			let orderType = '${orderType}'
			let payType = '${payType}'
			$("#orderType").val(orderType);
			$("#payType").val(payType);
			$("#viewCountPerPage").val(${viewCountPerPage});
			
			$("#checkAll").change(function(){
				if($(this).is(":checked")){
					$("input[name='odRow']").prop('checked', true)
				}else {
					$("input[name='odRow']").prop('checked', false)
				}
			})
			
			$(".filteringSelect").on("change", function(e){
				$("#filteringForm").submit()
			});
			
			$(".countingSelect").on("change", function(e){
				$("#countingForm").submit()
			});
		});
		
		function exportDropdownBtn(obj) {
			if($("#exportDropdownMenu").css("display") == "block"){
				$("#exportDropdownMenu").css("display", "none")
			} else{
				$("#exportDropdownMenu").css("display", "block")
			}
		}
		
		function search(){
			let type = $("#orderType").val();
			let value = $("#searchValue").val();
			let sql = new Array("or", "select", "insert", "update", "delete", "create", "drop","exec", "union", "fetch", "declare", "truncate", "alter");
			let expText = /[%=><]/;
			let regExp = "";
			let strParam = "";
			let param = location.search ? decodeURIComponent(location.search.slice(1).split('&')).split(',').map((item, index) => {
			    let obj = {}
			    
			    item.split('=').forEach((i, idx) => {
			        if(idx%2){
		                obj[Object.keys(obj)] = i    
			        } else {
			            obj[i] = "";
			        }
			    }) 

			    return obj;
			}) : "";

			strParam = JSON.stringify(param).replaceAll("[","").replaceAll("]","").replaceAll("{","").replaceAll("}","").replaceAll('\"', "").replaceAll(":","=").replaceAll(",","&")
			
			if(event.keyCode == 13){ // 엔터키를 눌렀을 때
				if(!value){
					alert("검색어를 입력하십시오.");
					return false;
				}
				if(expText.test(value)){
					alert("특수문자를 사용할 수 없습니다.");
					return false;
				}
				for(let i = 0 ; i < sql.length ; i++){
					regExp = new RegExp(sql[i], "gi");
					if(regExp.test(value) == true){
						alert("특정 문자로 검색할 수 없습니다.");
						return false;
					}
				}
				
				if(strParam){
					location.href=location.origin+location.pathname+"?orderType="+type+"&searchWord="+value+"&"+strParam;
					console.log('test!')
				} else {
					location.href="list?orderType="+type+"&searchWord="+value;
					console.log('test@')
					
				}
				
			}
		}
		
		function filtering(obj){
			if(obj == "orderType"){
				console.log("orderType")
				let value = $("#"+obj).val();
				let tmpObj = {};
				
				console.log("value : "+value)
				
				tmpObj.orderType = value; 
				tmpObj.payType = "test"; 
				
// 				getData("/admin/order/filtering", "POST", tmpObj, "json");
				
			} else if(obj == "payType"){
				console.log("payType")
				
			}
		}
		
		function getData(url, type, data, dataType, async){
			let result = false;
			$.ajax({
				url : url,
				type : type || "get",
				data : JSON.stringify(data) || null,
				dataType : dataType || "json",
				async : async || true, 
				headers : {
					"Content-Type" : "application/json",
				},
				success : function(data){
					console.log(data)
					
					
				},
			    error: function (request, status, error) {
			        console.log("code: " + request.status)
			        console.log("message: " + request.responseText)
			        console.log("error: " + error);
			    }
			})
			return result;
		}
		
		function orderDetail(target){
			location.href="detail?no="+$(target).parent().attr("id").split('_')[1];
		}
	</script>
</body>
</html>
