<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html
  lang="en"
  class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="${pageContext.request.contextPath }/resources/assets/"
  data-template="vertical-menu-template">
<head>
<meta charset="UTF-8">
<meta
  name="viewport"
  content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<title>관리</title>
 <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="/resources/assets/images/icons/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap"
      rel="stylesheet" />

    <!-- Icons -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/fonts/fontawesome.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/fonts/tabler-icons.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/fonts/flag-icons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/rtl/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/rtl/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/node-waves/node-waves.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/typeahead-js/typeahead.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/apex-charts/apex-charts.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />

    <!-- Page CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />

    <!-- Helpers -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/admin/sales/salesMain.css"/>
    
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/js/template-customizer.js"></script>
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/config.js"></script>
	<script src="https://kit.fontawesome.com/256bd7c463.js" crossorigin="anonymous"></script>
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
              <div class="row">
                <!-- 전체 기간 매출, 이익 -->
                <div class="col-xl-4 mb-4 col-lg-5 col-12">
                  <div class="card">
                    <div class="d-flex align-items-end row" id="TotalSalesDiv">
                      <div class="col-7">
                        <div class="card-body text-nowrap">
                          <h5 class="mainSalesH5">총매출</h5>
                          <p class="mb-2">다사자규 전체 매출</p>
                          <h4 class="text-primary mb-1 formatNum">${sales.totalSales }원</h4>
                          <a href="javascript:;" class="btn btn-primary" onclick="showNetProfit();">순이익 보기</a>
                        </div>
                      </div>
                    </div>
                    
                    <div class="d-flex align-items-end row" id="TotalNetProfitsDiv" style="display: none !important;">
                      <div class="col-7">
                        <div class="card-body text-nowrap">
                          <h5 class="mainSalesH5">순이익</h5>
                          <p class="mb-2">다사자규 전체 순이익</p>
                          <h4 class="text-primary mb-1 formatNum">${netProfits.totalNetProfit }원</h4>
                          <a href="javascript:;" class="btn btn-primary" onclick="showSales();">총매출 보기</a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 전체 기간 매출, 이익 -->

                <!-- 최근 매출 -->
                <div class="col-xl-8 mb-4 col-lg-7 col-12">
                  <div class="card h-100">
                    <div class="card-header">
                      <div class="d-flex justify-content-between mb-3">
                        <h5 class="card-title mb-0" id="infoH5">최근 매출</h5>
<!--                         <small class="text-muted">Updated 1 month ago</small> -->
							<a href="javascript:;" class="btn btn-primary" id="changeInfoBtn" onclick="showNetProfitInfo();">순이익 보기</a>
                      </div>
                    </div>
                    <div class="card-body" id="salesInfo">
                      <div class="row gy-3">
                        <div class="col-md-3 col-6">
                          <div class="d-flex align-items-center">
                            <div class="badge rounded-pill bg-label-primary me-3 p-2">
                              <i class="ti ti-chart-pie-2 ti-sm"></i>
                            </div>
                            <div class="card-info">
                              <h5 class="mb-0 formatNum">${sales.daySales }원</h5>
                              <small>오늘</small>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-3 col-6">
                          <div class="d-flex align-items-center">
                            <div class="badge rounded-pill bg-label-info me-3 p-2">
                              <i class="ti ti-chart-pie-2 ti-sm"></i>
                            </div>
                            <div class="card-info">
                              <h5 class="mb-0 formatNum">${sales.weekSales }원</h5>
                              <small>이번 주</small>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-3 col-6">
                          <div class="d-flex align-items-center">
                            <div class="badge rounded-pill bg-label-danger me-3 p-2">
                              <i class="ti ti-chart-pie-2 ti-sm"></i>
                            </div>
                            <div class="card-info">
                              <h5 class="mb-0 formatNum">${sales.monthSales }원</h5>
                              <small>이번 달</small>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-3 col-6">
                          <div class="d-flex align-items-center">
                            <div class="badge rounded-pill bg-label-success me-3 p-2">
                              <i class="ti ti-chart-pie-2 ti-sm"></i>
                            </div>
                            <div class="card-info">
                              <h5 class="mb-0 formatNum">${sales.yearSales }원</h5>
                              <small>올해</small>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                     <div class="card-body" id="netProfitInfo" style="display: none !important; padding-top: 0px;">
                      <div class="row gy-3">
                        <div class="col-md-3 col-6">
                          <div class="d-flex align-items-center">
                            <div class="badge rounded-pill bg-label-primary me-3 p-2">
                              <i class="ti ti-chart-pie-2 ti-sm"></i>
                            </div>
                            <div class="card-info">
                              <h5 class="mb-0 formatNum">${netProfits.dayNetProfit }원</h5>
                              <small>오늘</small>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-3 col-6">
                          <div class="d-flex align-items-center">
                            <div class="badge rounded-pill bg-label-info me-3 p-2">
                              <i class="ti ti-users ti-sm"></i>
                            </div>
                            <div class="card-info">
                              <h5 class="mb-0 formatNum">${netProfits.weekNetProfit }원</h5>
                              <small>이번 주</small>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-3 col-6">
                          <div class="d-flex align-items-center">
                            <div class="badge rounded-pill bg-label-danger me-3 p-2">
                              <i class="ti ti-shopping-cart ti-sm"></i>
                            </div>
                            <div class="card-info">
                              <h5 class="mb-0 formatNum">${netProfits.monthNetProfit }원</h5>
                              <small>이번 달</small>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-3 col-6">
                          <div class="d-flex align-items-center">
                            <div class="badge rounded-pill bg-label-success me-3 p-2">
                              <i class="ti ti-currency-dollar ti-sm"></i>
                            </div>
                            <div class="card-info">
                              <h5 class="mb-0 formatNum">${netProfits.yearNetProfit }원</h5>
                              <small>올해</small>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!--/ 최근 매출 -->

                <div class="col-xl-4 col-12">
                  <div class="row">
                    <!-- Expenses -->
                    <div class="col-xl-6 mb-4 col-md-3 col-6">
                      <div class="card">
                        <div class="card-header pb-0">
                          <h5 class="card-title mb-0">일간 매출</h5>
                          <div class="dayDes">* 날짜를 선택하세요.</div>
                           <small class="text-muted"><input type="date" id="daySalesDate" onchange="changeDaySales(this);"></small>
                        </div>
                        <div class="card-body">
                          <div id="profitLastMonth"></div>
                          <div class="d-flex justify-content-between align-items-center mt-3 gap-3">
                            <h4 class="mb-0" style="font-size: 16px;"><span id="daySalesOutput" class="formatNum">${sales.daySales }</span>원</h4>
                          </div>
                         </div>
                      </div>
                    </div>
                    <!--/ Expenses -->

                    <!-- Profit last month -->
                    <div class="col-xl-6 mb-4 col-md-3 col-6">
                      <div class="card">
                        <div class="card-header pb-0">
                          <h5 class="card-title mb-0">일간 순이익</h5>
                          <div class="dayDes">* 날짜를 선택하세요.</div>
                          <small class="text-muted"><input type="date" id="dayNetProfitDate" onchange="changeDayNetProfit(this);"></small>
                        </div>
                        <div class="card-body">
                          <div id="profitLastMonth"></div>
                          <div class="d-flex justify-content-between align-items-center mt-3 gap-3">
                            <h4 class="mb-0" style="font-size: 16px;"><span id="dayNetProfitOutput" class="formatNum">${netProfits.dayNetProfit }</span>원</h4>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!--/ Profit last month -->

                    <!-- Generated Leads -->
                    <div class="col-xl-12 mb-4 col-md-6">
                      <div class="card">
                        <div class="card-body">
                          <div class="d-flex justify-content-between">
                            <div class="d-flex flex-column">
                              <div class="card-title mb-auto">
                                <h5 class="mb-1 text-nowrap" id="weekTitle">주간 매출</h5>
                                <div>* 10주 전까지 확인 가능합니다.</div>
                                <small><select id="weekSelect" onclick="changeWeekSelect(this)">
                                </select><input type="hidden" value="sales" id="weekKind"></small>
                              </div>
                              <div class="chart-statistics">
                                <h3 class="card-title mb-1" id="weekValueH3"><span id="weekValue" class="formatNum">${sales.weekSales }</span>원</h3>
                                <small class="text-success text-nowrap fw-medium" id="weekChangeBtnBox">
                                	<a href="javascript:;" class="btn btn-primary" onclick="showWeekNetProfit(this);">순이익 보기</a>
                                </small>
                              </div>
                            </div>
                            <div id="generatedLeadsChart"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!--/ Generated Leads -->
                  </div>
                </div>

                <!-- 매출 그래프 -->
                <div class="col-12 col-xl-8 mb-4">
                  <div class="card">
                    <div class="card-body p-0">
                      <div class="row row-bordered g-0">
                        <div class="col-md-8 position-relative p-4">
                          <div class="card-header d-inline-block p-0 text-wrap position-absolute">
                            <h5 class="m-0 card-title">매출과 순이익 <span id="unitSpan" style="font-size: 12px;">(단위 : 만 원)</span></h5>
                          </div>
                          <div id="totalRevenueChart" class="mt-n1"></div>
                        </div>
                        <div class="col-md-4 p-4">
                          <div class="text-center mt-4">
                            <div class="dropdown">
                               <select id="graphYear">
								<option>
                                  2024
                                </option>
                                <option>
                                  2023
                                </option>
                              </select>년
                            </div>
                          </div>
                          <h3 class="text-center pt-4 mb-0"><span id="graphTotalSales"></span>원</h3>
                          <p class="mb-4 text-center"><span class="fw-medium">매출</span></p>

                          <h3 class="text-center pt-4 mb-0"><span id="graphTotalNetProfits"></span>원</h3>
                          <p class="mb-4 text-center"><span class="fw-medium">순이익</span></p>
                          <div class="px-3">
                            <div id="budgetChart"></div>
                          </div>
                          <div class="text-center mt-4">
                            <button type="button" class="btn btn-primary" onclick="changeYear();">연도 변경</button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!--/ 매출 그래프 -->

                <!-- 회원 현황 -->
		        <div class="col-xl-12">
		        	<div class="row g-4 mb-4">
                     <div class="col-sm-6 col-xl-3">
                        <div class="card">
                           <div class="card-body">
                              <div class="d-flex align-items-start justify-content-between">
                                 <div class="content-left">
                                    <span>총 회원 수</span>
                                    <div class="d-flex align-items-center my-2">
                                       <h3 class="mb-0 me-2"><span id="totalCus">${csInfo.totCustomer }</span></h3>
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
                                       <h3 class="mb-0 me-2"><span id="malePop">${csInfo.totMale }</span> / <span id="femalePop">${csInfo.totFemale }</span></h3>
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
                                       <h3 class="mb-0 me-2"><span id="monthSignUp">${csInfo.regCustomer }</span></h3>
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
                                       <h3 class="mb-0 me-2"><span id="withDrawCus">${csInfo.withdraw }</span></h3>
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
		        </div>           
                <!--/ 회원 현황 -->
				
				<!-- 주문 현황 -->
		        <div class="col-xl-12">
              <div class="card mb-4">
                <div class="card-widget-separator-wrapper">
                  <div class="card-body card-widget-separator">
                    <div class="row gy-4 gy-sm-1">
                      <div class="col-sm-6 col-lg-3">
                        <div class="d-flex justify-content-between align-items-start card-widget-1 border-end pb-3 pb-sm-0">
                          <div>
                            <h4 class="mb-2">${orderSummary.pending}</h4>
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
                            <h4 class="mb-2">${orderSummary.completed}</h4>
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
                            <h4 class="mb-2">${orderSummary.confirmed}</h4>
                            <p class="mb-0 fw-medium">구매 확정</p>
                          </div>
                          <span class="avatar p-2 me-sm-4"> <span class="avatar-initial bg-label-secondary rounded"><i class="ti-md ti ti-checks text-body"></i></span>
                          </span>
                        </div>
                      </div>
                      <div class="col-sm-6 col-lg-3">
                        <div class="d-flex justify-content-between align-items-start">
                          <div>
                            <h4 class="mb-2">${orderSummary.refund}</h4>
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
		        </div>           
				<!--/ 주문 현황 -->

                <!-- 교환/반품/취소 내역 -->
                <div class="col-xl-12">
                  <div class="card">
                    <div class="table-responsive card-datatable">
                      <div id="csList">최근 교환/반품/취소 내역
                      <button id="detailCsListBtn" onclick="showOrderCsModal();">상세히 보기</button>
                      </div>
                      <table class="table datatable-invoice border-top">
                        <thead>
                          <tr id="mainCsTableTr">
                            <th></th>
                            <th>구분</th>
                            <th>주문번호</th>
                            <th>상품명</th>
                            <th>수량</th>
                            <th>주문자</th>
                            <th>일자</th>
                          </tr>
                        </thead>
                        <tbody id="exchangeTbody">
                        	<c:forEach var="cs" items="${orderCs }" end="9">
                        	  <tr>
	                            <th class="center">${cs.csNo }</th>
	                            <th class="center">${cs.csType }</th>
	                            <th class="center"><a href="/admin/order/detail?no=${cs.orderNo}">${cs.orderNo }</a></th>
	                            <th>${cs.productName }</th>
	                            <th class="center">${cs.productQuantity }</th>
	                            <th class="center">${cs.nickname }</th>
	                            <th class="center">${cs.csDate }</th>
	                          </tr>
                        	</c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
                <!-- 교환/반품/취소 내역 -->
              </div>
            </div>
            <!-- / Content -->

            <!-- Footer -->
            <jsp:include page="../footer.jsp"></jsp:include>
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

	<!-- 교환/반품/취소 모달 -->
	<div class="modal" id="orderCsModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<span>교환/반품/취소 내역</span>
					<button type="button" class="btn-close close"
						data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
				</div>
				<div class="card">
                    <div class="table-responsive card-datatable" id="modalCsBody">
                    </div>
                  </div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger close"
						data-bs-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->

    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/node-waves/node-waves.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/hammer/hammer.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/i18n/i18n.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/typeahead-js/typeahead.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/js/menu.js"></script>

    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/apex-charts/apexcharts.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>

    <!-- Main JS -->
    
    
    <!-- Page JS -->
<%--     <script src="${pageContext.request.contextPath }/resources/assets/js/app-ecommerce-dashboard.js"></script> --%>
    
    <script src="${pageContext.request.contextPath }/resources/js/admin/sales/salesMain.js"></script>
  </body>
</html>