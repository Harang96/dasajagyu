<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr" data-theme="theme-default" data-assets-path="../../resources/assets/" data-template="vertical-menu-template">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>admin | order detail</title>

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
<link rel="stylesheet" href="../../resources/assets/vendor/css/rtl/core.css" class="template-customizer-core-css" />
<link rel="stylesheet" href="../../resources/assets/vendor/css/rtl/theme-default.css" class="template-customizer-theme-css" />
<link rel="stylesheet" href="../../resources/assets/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet" href="../../resources/assets/vendor/libs/node-waves/node-waves.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/typeahead-js/typeahead.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/select2/select2.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/@form-validation/umd/styles/index.min.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/quill/typography.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/quill/katex.css" />
<link rel="stylesheet" href="../../resources/assets/vendor/libs/quill/editor.css" />
<link rel="stylesheet" href="../../assets/vendor/libs/toastr/toastr.css" />
<link rel="stylesheet" href="../../assets/vendor/libs/animate-css/animate.css" />
<!-- Page CSS -->

<link rel="stylesheet" href="../../resources/assets/vendor/css/pages/app-ecommerce.css" />

<!-- Helpers -->
<script src="../../resources/assets/vendor/js/helpers.js"></script>
<script src="../../resources/assets/vendor/js/template-customizer.js"></script>
<script src="../../resources/assets/js/config.js"></script>
<%
	request.setAttribute("costFormat", new DecimalFormat("###,###"));
%>
</head>
<style>
.cs-button{
	display: flex;
}
</style>

<body>

	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->
			<jsp:include page="../admin/aside.jsp"></jsp:include>
			<!-- / Menu -->

			<!-- Layout container -->
			<div class="layout-page">

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->

					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="py-3 mb-2">
							<span class="text-muted fw-light">주문관리 /</span> 주문상세	
						</h4>

						<div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-3">
							<div class="d-flex flex-column justify-content-center gap-2 gap-sm-0">
								<h5 class="mb-1 mt-3 d-flex flex-wrap gap-2 align-items-end">
									주문번호 ${requestScope.order.orderNo } 
									
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
								</h5>
								<p class="text-body">주문일시 <fmt:formatDate value="${requestScope.order.orderTime }" pattern="yyyy-MM-dd HH:mm:ss" />
								</p>
							</div>
							<c:if test="${order.orderStatus != '구매확정'}">
								<div class="d-flex align-content-center flex-wrap gap-2">
									<button class="btn btn-label-danger delete-order waves-effect" id="orderCancelBtn">Delete Order</button>
								</div>
							</c:if>
						</div>
						
						<div class="app-ecommerce-category">
							<div class="row">
				                <div class="col-12 col-lg-8">
				                  <div class="card mb-4">
				                    <div class="card-header d-flex justify-content-between align-items-center">
				                      <h5 class="card-title m-0">주문품목 상세내역</h5>
				                      <c:if test="${order.orderStatus != '구매확정'}">
				                      	<div class="cs-button">
				                      		<h6 class="m-0"><a id="cancelBtn" href=" javascript:void(0)">취소</a></h6>
				                     	 	</div>
			                     	 	</c:if>
									</div>
				                    <div class="card-datatable table-responsive">
										<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
											<table class="datatables-order-details table border-top dataTable no-footer dtr-column" id="DataTables_Table_0">
												<thead>
													<tr>
														<th class="sorting_disabled dt-checkboxes-cell dt-checkboxes-select-all" data-col="1" aria-label=""><input name="productAll" type="checkbox" class="form-check-input"></th>
														<th class="w-50 sorting_disabled" aria-label="products">상품</th>
														<th class="w-25 sorting_disabled" aria-label="price">가격</th>
														<th class="w-25 sorting_disabled" aria-label="qty">수량</th>
														<th class="sorting_disabled" aria-label="total">상품총가격</th>
														<th class="w-25 sorting_disabled" aria-label="status">상태</th>
													</tr>
												</thead>
												<tbody>
													<c:choose>
														<c:when test="${orderProductList.size() != 0 }">
															<c:forEach var="product" items="${requestScope.orderProductList}">
															<c:set var="price" value="${product.orderPrice }"></c:set>
															<c:set var="quantity" value="${product.quantity }"></c:set>
																<c:choose>
																		<c:when test="${product.orderCancel eq 'Y' }">
																			<tr name="productRow" style="background-color: #dddddd;">
																				<td><input type="checkbox" class="form-check-input" id="product_${product.productNo }" name="product" disabled></td>
																				<td><del>${product.productName }</del></td>
																				<td><del>${price ne null ? costFormat.format(Integer.parseInt(price)) : price }</del></td>
																				<td><del>${quantity }</del></td>
																				<td><del>${price ne null or quantity ne null ? costFormat.format(Integer.parseInt(price * quantity)) : price * quantity }</del></td>
																				<td style="color:red;">취소됨</td>
																			</tr>
																		</c:when>
																		<c:otherwise>
																			<tr name="productRow">
																				<td><input type="checkbox" class="form-check-input chkPrd" id="product_${product.productNo }" name="product"></td>
																				<td>${product.productName }</td>
																				<td>${price ne null ? costFormat.format(Integer.parseInt(price)) : price }</td>
																				<td>${quantity }</td>
																				<td>${price ne null or quantity ne null ? costFormat.format(Integer.parseInt(price * quantity)) : price * quantity }</td>
																				<td></td>
																			</tr>
																		</c:otherwise>
																</c:choose>
															</c:forEach>
														</c:when>
														<c:otherwise>
			                    							<td valign="top" colspan="6" class="dataTables_empty">No data available in table</td>
														</c:otherwise>
													</c:choose>
												</tbody>
											</table>
										</div>
										<div class="d-flex justify-content-end align-items-center m-3 mb-2 p-1">
				                        <div class="order-calculations">
					                          <div class="d-flex justify-content-between mb-2">
					                            <span class="w-px-100 text-heading">원금:</span>
					                            <h6 class="mb-0">${requestScope.orderBilling.productAmount ne null ? costFormat.format(requestScope.orderBilling.productAmount) : requestScope.orderBilling.productAmount }</h6>
					                          </div>
					                          <div class="d-flex justify-content-between mb-2">
					                            <span class="w-px-100 text-heading">할인:</span>
					                            <c:choose>
					                            <c:when test="${requestScope.orderBilling.productDiscount gt 0}"><h6 class="mb-0" style="color:red">-${costFormat.format(Integer.parseInt(requestScope.orderBilling.productDiscount)) }</h6></c:when>
					                            <c:otherwise><h6 class="mb-0">${requestScope.orderBilling.productDiscount }</h6></c:otherwise> 
					                          	</c:choose>
					                          </div>
					                          <div class="d-flex justify-content-between mb-2">
					                            <span class="w-px-100 text-heading">사용 포인트:</span>
					                            <c:choose>
					                            <c:when test="${requestScope.orderBilling.pointDiscount gt 0}"><h6 class="mb-0" style="color:red">-${costFormat.format(Integer.parseInt(requestScope.orderBilling.pointDiscount)) }</h6></c:when>
					                            <c:otherwise><h6 class="mb-0">${requestScope.orderBilling.pointDiscount }</h6></c:otherwise> 
					                          	</c:choose>
					                          </div>
					                          <div class="d-flex justify-content-between mb-2">
					                            <h6 class="w-px-100 text-heading">배송비:</h6>
					                            <c:choose>
					                            <c:when test="${requestScope.orderBilling.shippingCost gt 0}"><h6 class="mb-0" style="color:blue">+${costFormat.format(Integer.parseInt(requestScope.orderBilling.shippingCost)) }</h6></c:when>
					                            <c:otherwise><h6 class="mb-0">${requestScope.orderBilling.shippingCost }</h6></c:otherwise> 
					                          	</c:choose>
					                          </div>
					                          
					                          <div class="d-flex justify-content-between mb-2">
					                            <h6 class="w-px-100 text-heading">총 결제금액:</h6>
					                            <h6 class="mb-0">${ costFormat.format(Integer.parseInt(requestScope.orderBilling.orderCost)) }</h6>
					                          </div>
					                          
					                          <div class="d-flex justify-content-between mb-2">
					                            <h6 class="w-px-100 text-heading">적립 포인트:</h6>
					                            <c:choose>
					                            <c:when test="${requestScope.orderBilling.orderPoint gt 0}"><h6 class="mb-0" style="color:blue">+${costFormat.format(Integer.parseInt(requestScope.orderBilling.orderPoint)) }</h6></c:when>
					                            <c:otherwise><h6 class="mb-0">${requestScope.orderBilling.orderPoint }</h6></c:otherwise> 
					                          	</c:choose>
					                          </div>
				                        </div>
				                      </div>
				                    </div>
				                  </div>
				                  
				                  <div class="card mb-4">
				                    <div class="card-header">
				                      <h5 class="card-title m-0">반품/교환 신청 내역</h5>
				                    </div>
				                    <div class="card-body">
<%-- 				                    <div>csProcessedYn : ${csProcessedYn eq null }</div> --%>
<%-- 				                    <div>csProcessedYn : ${csProcessedYn }</div> --%>
<%-- 				                    <div>csProcessedYn : ${csLst.get(0).csType}</div> --%>
<%-- 															<div>${csLst }</div> --%>
<%-- 															<div>${image}</div> --%>
				                    	<c:choose>
				                    		<c:when test="${!csLst.isEmpty() and (csProcessedYn eq null or csProcessedYn eq 'N') and csLst.get(0).csType ne '취소'}">
						                    <c:set var="csProcessedYn" value="${csLst.get(0).csProcessed}" />
								                    			
								                    			
								                    			<c:if test="${csProcessedYn eq null }">
									                    			<div class="bs-toast toast fade show" role="alert" aria-live="assertive" aria-atomic="true" style="width : 100%;">
											                        <div class="toast-header">
											                          <div class="me-auto fw-medium">🔔고객이 교환/환불요청하였습니다.</div>
											                          <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
											                        </div>
											                        <div class="toast-body">
																								<div style="text-align: right;">
											                    				<button type="button" id="confirm" class="btn btn-label-primary delete-order waves-effect" onclick="csProc(this.id)">승인</button>
											                    				<button type="button" id="reject" class="btn btn-label-danger delete-order waves-effect" onclick="csProc(this.id)">반려</button>
											                    			</div>
																							</div>
											                      </div>
											                      <br>
								                    			
								                    			</c:if>
								                    			
								                    			<c:if test="${csProcessedYn eq 'Y' }">
								                    				<div class="bs-toast toast fade show" role="alert" aria-live="assertive" aria-atomic="true" style="width : 100%;">
											                        <div class="toast-header">
											                          <div class="me-auto fw-medium">❌⛔이미 교환/환불요청을 이미 처리하였습니다.</div>
											                          <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
											                        </div>
											                      </div>
											                      <br>
								                    			</c:if>
								                    			
								                    			<c:if test="${csProcessedYn eq 'N' }">
								                    			<div class="bs-toast toast fade show" role="alert" aria-live="assertive" aria-atomic="true" style="width : 100%;">
											                        <div class="toast-header">
											                          <div class="me-auto fw-medium">❌⛔이미 교환/환불요청을 거절하였습니다.</div>
											                          <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
											                        </div>
											                      </div>
											                      <br>
								                    			</c:if>
								                    			
								                    			<div class="card-datatable table-responsive">
																		<div id="DataTables_Table_0_wrapper"
																			class="dataTables_wrapper dt-bootstrap5 no-footer">
																			<table class="datatables-order-details table border-top dataTable no-footer dtr-column" id="DataTables_Table_0">
																					<div>
																						<c:forEach var="imgSrc" items="${image }" >
																								<img src="${imgSrc }" style="width : 242px;">
																						</c:forEach>
																					</div>
																					<div>
																						신청분류 : ${csLst.get(0).reasonType }
																					</div>
																					<div>
																						신청사유 : ${csLst.get(0).reason }
																					</div>
																					<thead>
																					<tr>
																						<th  aria-label="products" style="width: 40%">상품명</th>
																						<th  aria-label="price" style="width: 10%">가격</th>
																						<th  aria-label="qty" style="width: 15%">수량</th>
																						<th  aria-label="total"style="width: 15%">타입</th>
																						<th  aria-label="total"style="width: 15%">일시</th>
																					</tr>
																				</thead>
																				<tbody>
																							
																					<c:forEach var="cs" items="${csLst }" >
																					<tr>
																						<td>${cs.productName }</td>
																						<td>${costFormat.format(cs.salesCost) }</td>
																						<td>${cs.productQuantity }</td>
																						<td>${cs.csType }</td>
																						<td><fmt:formatDate value="${cs.csDate }" pattern="yyyy-MM-dd" /></td>
																					</tr>
																					</c:forEach>
																				</tbody>
																			</table>
																		</div>
																	</div>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<p>	고객이 신청한 CS내역이 없습니다.</p> 
				                    		</c:otherwise>
				                    	</c:choose>
				                    </div>
				                  </div>
				                </div>
				                <div class="col-12 col-lg-4">
				                
				                <c:if test="${order.orderStatus != '구매확정'}">
					                <div class="card mb-4">
					                    <div class="card-header d-flex justify-content-between">
					                      <h6 class="card-title m-0">배송상태 변경</h6>
					                    </div>
	           				            <select class="form-select filteringSelect" id="changeDeliveryStatus" name="changeDeliveryStatus">
																	<option>배송상태선택</option>
																	<option value="start">배송시작</option>
																	<option value="ing">배송중</option>
																	<option value="finish">배송완료</option>
																</select>
													</div>
												</c:if>
				          	      <c:if test="${customerInfo ne null }">
				                  <div class="card mb-4">
				                    <div class="card-header">
				                      <h6 class="card-title m-0">주문 고객 정보</h6>
				                    </div>
				                    <div class="card-body">
				                      <div class="d-flex justify-content-start align-items-center mb-4">
				                        <div class="avatar me-2">
				                        <c:choose>
				                        	<c:when test="${requestScope.customerInfo.userImg != null }">
						                          <img src="${requestScope.customerInfo.userImg}" alt="${requestScope.customerInfo.nickname}" class="rounded-circle">
				                        	</c:when>
				                        	<c:otherwise>
						                          <img src="../../resources/assets/images/products/details/basic.png" alt="Avatar" class="rounded-circle">
				                        	</c:otherwise>
				                        </c:choose>
				                        </div>
				                        <div class="d-flex flex-column">
				                            <h6 class="mb-0">${requestScope.customerInfo.name}</h6>
				                        </div>
				                      </div>
				                      <p class="mb-1">Email: ${requestScope.customerInfo.email }</p>
				                      <p class="mb-0">Mobile: ${requestScope.customerInfo.phoneNumber }</p>
				                    </div>
				                  </div>
				                  </c:if>
				                  
				                  <div class="card mb-4">
				                    <div class="card-header d-flex justify-content-between">
				                      <h6 class="card-title m-0">배송지 정보</h6>
				                    </div>
				                    <div class="card-body">
				                      <p class="mb-0">수신인 : <span class="mb-0">${shippingInfo.reciever }</span></p>
				                      <p class="mb-0">전화번호 : <span class="mb-0">${shippingInfo.phone }</span></p>
				                      <p class="mb-0">우편번호 : <span class="mb-0">${shippingInfo.zipCode }</span></p>
				                      <p class="mb-0">주소 : <span class="mb-0">${shippingInfo.address }</span></p>
				                      <p class="mb-0">요구사항 : <span class="mb-0">${shippingInfo.request}</span></p>
				                    </div>
				                  </div>
				
				                  
				                </div>
				              </div>
							
						</div>
					</div>
					
					<!-- modal -->
					<div class="modal fade" id="orderProductModal" role="dialog" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="modalLabel">취소/환불 처리</h5>
								</div>
								<div class="modal-body">
									<table class="datatables-order-details table border-top dataTable no-footer dtr-column" id="DataTables_Table_0">
										<thead>
											<tr>
												<th aria-label="No" style="width:15%">상품번호</th>
												<th aria-label="products" style="width:70%">상품명</th>
												<th aria-label="qty" style="width:15%">주문수량</th>
											</tr>
										</thead>
										<tbody id="infoPasteArea">
										</tbody>
									</table>

									<div class="input-group">
										<div class="input-group-text">
											<span>취소사유</span><br>
											<span id="reasonCount">0/100</span>
										</div>
										<textarea id="cancelReasonTA" class="form-control" aria-label="With textarea" placeholder="취소사유를 입력해주십시오. 입력하지 않을 경우 재고부족으로 처리됩니다. " style="height: 128px; resize: none;" ></textarea>
									</div>
									<div id="shippingCheck" class="form-check mt-3" style="display:none;">
			                          <input class="form-check-input" type="checkbox" value="" id="isShippingRefund">
			                          <label class="form-check-label" for="isShippingRefund"> 배송비 </label>
			                        </div>
									<br> 해당 주문건에 대한 취소/환불처리를 진행하시겠습니까?
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">아니오</button>
									<button type="button" id="gotoLogic" class="btn btn-primary" onclick="cancelProc()">예</button>
								</div>
							</div>
						</div>
					</div>
					
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
	<script src="../../resources/assets/vendor/libs/moment/moment.js"></script>
	<script src="../../resources/assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js"> </script> 
	<script src="../../resources/assets/vendor/libs/select2/select2.js"></script> 
	<script src="../../resources/assets/vendor/libs/@form-validation/umd/bundle/popular.min.js"></script> 
	<script src="../../resources/assets/vendor/libs/@form-validation/umd/plugin-bootstrap5/index.min.js"></script> 
	<script src="../../resources/assets/vendor/libs/@form-validation/umd/plugin-auto-focus/index.min.js"></script> 
	<script src="../../resources/assets/vendor/libs/quill/katex.js"></script> 
	<script src="../../resources/assets/vendor/libs/quill/quill.js"></script> 
	<!-- Main JS --> 
	<script src="../../resources/assets/js/main.js"></script> 
	<!-- Page JS --> 
	<script src="../../resources/assets/js/app-ecommerce-category-list.js"></script>
	
	<script>
	$('#cancelReasonTA').keydown(function(){
		  let content = $(this).val();
		  $('#reasonCount').html(content.length+"/100");
		  if (content.length > 100){
		    alert("최대 100자까지 입력 가능합니다.");
		    $(this).val(content.substring(0, 99));
		    $('#cancelReasonTA').html(100);
		  }
	});
	</script>
	
	<script type="text/javascript">
		let productNoArray = [];
		let allChecked = true;
		
		$(document).ready(function(){
			
			// 배송상태를 조회하여 업데이트
			getData("/admin/order/selectDeliveryState?no="+location.search.split('=')[1], "", "GET", false)
			
			// 전체 선택 시 이벤트
			$("[name=productAll]").on('change', function() {
				if($("[name=productAll]").is(':checked')) {
					$(".chkPrd").prop('checked', true)
				} else {
					$(".chkPrd").prop('checked', false)
				}
			})
			
			// 취소 버튼 클릭시 이벤트
			$("#cancelBtn").on('click', function() {
				let chkYn = false;

				$("input[name=product]").each(function(){ 
				    if($(this).prop("checked"))  chkYn = true;
				})
				
				if(chkYn){
					let html = ''; 
					
					// 선택한 상품이 해당 주문건에서 상품을 모두 취소하기위해서 선택된 것인지 체크
					if(compareToDB()){
						$("#shippingCheck").css("display", "block");
					} else {
						$("#shippingCheck").css("display", "none");
					}
					
					if("${requestScope.order.orderStatus }" == "입금대기" || "${requestScope.order.orderStatus }" == "WAITING_FOR_DEPOSIT"){
						alert("입금대기일 때 취소/환불할 수 없습니다.")
					} else {
						$("#orderProductModal").modal("show")
						$("#cancelBtn").data("bsToggle","orderProductModal")
						$("#cancelBtn").data("bsTarget","modal")
						$("#infoPasteArea").html()
						
						
						for(let i of productNoArray  ){
							html += `<tr>
									 <td id="productno_\${i.no}">\${i.no}</td>
								     <td>\${i.name}</td>
								     <td>\${i.quantity}</td>
								     </tr>`;
						}
						
						$("#gotoLogic").attr("onclick", "cancelProc('partCancel')");
						$("#infoPasteArea").html(html);		
						
					}
					
				} else {
					alert("취소/환불할 상품을 선택하십시오.")
				}
			})
			
			// 주문 취소 버튼 클릭시 이벤트
			$("#orderCancelBtn").on('click', function() {
				let productArr = [];
				$("[name=productRow]").each(function(i, item){
					let obj = {};

					$(item.children).each(function(idx, tem){
				        if(idx == 0) obj.no = $(tem.children).attr('id').split('_')[1]
				        if(idx == 1) obj.name = $(tem).text()
				        if(idx == 2) obj.price = $(tem).text()
				        if(idx == 3) obj.quantity = $(tem).text()
				        if(idx == 4) obj.totalPrice = $(tem).text()
				    });
					
					productArr.push(obj);
				})
				
				if("${requestScope.order.orderStatus }" == "입금대기"){
					alert("입금대기일 때 취소/환불할 수 없습니다.")
				} else {
					$("#orderProductModal").modal("show")
					$("#cancelBtn").data("bsToggle","orderProductModal")
					$("#cancelBtn").data("bsTarget","modal")
					$("#infoPasteArea").html()
					
					productNoArray = productArr;
					
					let html = '';
					
					for(let i of productArr  ){
						html += `<tr>
								 <td id="productno_\${i.no}">\${i.no}</td>
							     <td>\${i.name}</td>
							     <td>\${i.quantity}</td>
							     </tr>`;
					}
					
					$("#gotoLogic").attr("onclick", "cancelProc('allCancel')");
					$("#infoPasteArea").html(html);	
				}
			})
			
			$("input[name=product]").on('change', function(e) {
				let tmp = true;
				let tmpObj = {};
				
				if($(e.target).is(':checked')){
					if(productNoArray.indexOf($(this).attr("id").split("_")[1]) == -1){
						tmpObj.no = $(this).attr("id").split("_")[1];
						tmpObj.name = $(e.target).parent().next().text();
						tmpObj.price = Number($(e.target).parent().next().next().next().next().text().replace(",", ""))
						tmpObj.quantity = Number($(e.target).parent().next().next().next().text())
						tmpObj.totalPrice = Number($(e.target).parent().next().next().next().next().text().replace(",",""))
						
					    productNoArray.push(tmpObj);
					}
				} else {
					productNoArray.forEach(item => {
						if(item.no == $(this).attr("id").split("_")[1]){
							productNoArray = productNoArray.filter(prd => prd !== item)
						}
					})
				}
				
				$('input[name=product]').each(function() {
			        (!$(this).prop('checked')) ? tmp = false : "";
			    });
				if(tmp == true) $('input[name=productAll]').prop('checked', true);
				else $('input[name=productAll]').prop('checked', false); 
			})
			
			$("input[name=productAll]").on('change', function(e) {
				if($(e.target).is(':checked')){
					let tmpArr = [];
					$("input[name='product']").each(function(idx, item) {
						let tmpObj = {};
							if($(item).attr("disabled") !== "disabled"){
								console.log("this :: " + $(this).attr('id').split('_')[1] + ", " + $(item).parent().next().text() )
								tmpObj.no = $(this).attr('id').split('_')[1];
								tmpObj.name = $(item).parent().next().text();
								tmpObj.price = Number($(item).parent().next().next().next().next().text().replace(",", ""));
								tmpObj.quantity = Number($(item).parent().next().next().next().next().next().text())
								tmpObj.totalPrice = Number($(item).parent().next().next().next().next().next().next().text().replace(",",""))
								
								tmpArr.push(tmpObj)
							}
					})
					productNoArray = tmpArr
				} else {
					productNoArray = []
				}
			})
			
			$('#cancelReasonTA').keydown(function(){
				  let content = $(this).val();
				  $('#reasonCount').html(content.length+"/100");
				  if (content.length > 100){
				    alert("최대 100자까지 입력 가능합니다.");
				    $(this).val(content.substring(0, 99));
				    $('#cancelReasonTA').html(100);
				  }
			});
			
			$("#changeDeliveryStatus").on("change", function() {
				let orderNo = location.search.split('=')[1];
				let status = $(this).val();
				let url = "/admin/order/updateDeliveryState?no="+orderNo+"&deliveryStatus="+status;
				
				getData(url, "", "GET", false)
			})
			

		})

		function cancelProc(target) {
			let prdNoArr = []
			
			$(productNoArray).each(function(idx, item) {
				prdNoArr.push(item)
			})
			
			let data = {
				orderNo : "${requestScope.order.orderNo }",
				productArr : prdNoArr,
				cancelReason : $("#cancelReasonTA").val() || "재고부족",
				reason : $("#cancelReasonTA").val() || "재고부족",
				csType : "취소",
// 				cancelAmount : ,
				adminYn : "Y", 
				paymentKey : "${requestScope.paymentKey }",
				isShippingRefund : $("#isShippingRefund").prop("checked"),
				bank : "${customerInfo.bankName}" || "새마을",
				accountNumber : "${customerInfo.refundAccount}" || "9003217047061",
				holderName : "${customerInfo.name}" || "김수혁"
			}
			
			if(target == 'partCancel'){
				getData("/admin/order/cancel", JSON.stringify(data), "POST", false);
			} else if (target == 'allCancel'){
			    let form = $("<form>").attr({
			        method: "post",
			        action: "/admin/order/orderCancel"
			    });

			    $.each(data, function(key, value) {
			        $("<input>").attr({
			            type: "hidden",
			            name: key,
			            value: value
			        }).appendTo(form);
			    });

			    form.appendTo("body");
			    
			    form.submit();
			}
		}
		
		function csProc(yn){
			let cs = JSON.parse('${strCs}');
			
			if(yn == "confirm"){ // 승인

				if(cs.csProcessed == null){
					getData("/admin/order/csProc", JSON.stringify(cs), "POST", false);
				}
				
			} else { // 거절
				getData("/admin/order/csReject", JSON.stringify(cs), "POST", false);
			}
		}
		
		function getData(url, data, type, async){
			let result = "";
			$.ajax({
				url : url,
				type : type || "GET",
				data : data || null,
				headers : {
					"Content-Type" : "application/json"
				},
				async: async || true,
				success : function(data){
					if(data.type == "cancel"){
						if(data.result == "success"){
							console.log("조회 성공!")
							location.reload()
						}
					} else if(data.type == "checkOrder"){
						if(data.result == "결제완료"){
							result = data.result;
							return "test"; 
						}
					} else if(data.type == "changeDeliveryStatus"){
						if(data.result == "success"){
							alert("배송상태가 변경되었습니다.")
							location.reload()
							
						}
					} else if(data.type == "selectDeliveryStatus"){
						if(data.result == "success"){
							$("#changeDeliveryStatus").val(data.deliveryStatus)
						}
					} else if(data.type == "csProcess"){
						if(data.result == "success"){
							alert("cs 신청이 승인처리되었습니다.")
							reload();
						}
					} else if(data.type == "csReject"){
						if(data.result == "success"){
							alert("cs 신청이 거절처리되었습니다.")
							reload();
						}
					}
					
					
				},
			    error: function (request, status, error) {
			        console.log("code: " + request.responseJSON)
			        console.log("message: " + request.responseJSON)
			        console.log("error: " + error)
			        

					$("#orderProductModal").modal("show")
					$("#modalLabel").text(request.responseJSON)
					$(".modal-body").html(`<div id="errorMessage">\${request.responseJSON.message}</div>`)
					$(".modal-footer").html(`<button type="button" class="btn btn-label-primary" data-bs-dismiss="modal" onclick="initModal()">확인</button>`)
			    },
			    complete : function() {
			    	return result;
			    }
			    
			})
		}
		
		function compareToDB() {
			let orderProductList = JSON.parse('${requestScope.orderNotCanceledProductList}').map(v=> v.productNo);
			let chkProductList = productNoArray.map(v=>Number(v.no));
			
			return orderProductList.every((element, index) => element === chkProductList[index])
		}
		
		function initModal(){
			$(".modal-content").html(rtOriginModal());
		}
		
		function rtOriginModal(){
			return `<div class="modal-header">
			<h5 class="modal-title" id="modalLabel">취소/환불 처리</h5>
			</div>
			<div class="modal-body">
				<table class="datatables-order-details table border-top dataTable no-footer dtr-column" id="DataTables_Table_0">
							<thead>
								<tr>
									<th class="w-50 sorting_disabled" aria-label="No">No</th>
									<th class="w-50 sorting_disabled" aria-label="products">Products</th>
									<th class="w-25 sorting_disabled" aria-label="qty">Status</th>
								</tr>
							</thead>
							<tbody id="infoPasteArea">
							</tbody>
						</table>
						
						<div class="input-group">
							<div class="input-group-text"><span>취소사유</span><br><span id="reasonCount">0/100</span></div>
							<textarea id="cancelReasonTA" class="form-control" aria-label="With textarea" placeholder="취소사유를 입력해주십시오." style="height: 128px; resize:none;"></textarea>
						</div>
						<br>
						해당 주문건에 대한 취소/환불처리를 진행하시겠습니까? 
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">아니오</button>
				<button type="button" id="gotoLogic" class="btn btn-primary" onclick="cancelProc()">예</button>
			</div>`;
		}
		
		function init(){
		}
		
		
	</script>
</body>
</html>
