<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
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
<!-- <link rel="mask-icon" -->
<!-- 	href="/resources/assets/images/icons/safari-pinned-tab.svg" -->
<!-- 	color="#666666"> -->
<link rel="shortcut icon"
	href="/resources/assets/images/icons/favicon.ico">
<meta name="apple-mobile-web-app-title" content="Molla">

<meta name="application-name" content="Molla">
<meta name="msapplication-TileColor" content="#cc9966">
<meta name="msapplication-config"
	content="/resources/assets/images/icons/browserconfig.xml">
<meta name="theme-color" content="#ffffff">
<!-- Plugins CSS File -->
<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
<!-- Main CSS File -->
<link rel="stylesheet" href="/resources/assets/css/style.css">
<link rel="stylesheet"
	href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css">
<link rel="stylesheet"
	href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css">
<link rel="stylesheet"
	href="/resources/assets/css/plugins/nouislider/nouislider.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<c:set var="URL" value="${pageContext.request.requestURL}" />
<c:set var="customer" value="${sessionScope.loginCustomer}"/>
<style>

.product-media{
	height: 50px;
	width: 50px;
}
table th {
 	position: sticky;
 	top : 0;
}


/* 스크롤바의 폭 너비 */
.scrollbar::-webkit-scrollbar {
    width: 10px;  
}

.scrollbar::-webkit-scrollbar-thumb {
    background: #000000; /* 스크롤바 색상 */
    border-radius: 10px; /* 스크롤바 둥근 테두리 */
}

.scrollbar::-webkit-scrollbar-track {
    background: #B7B8B7;  /*스크롤바 뒷 배경 색상*/
}

.orderNameSpan{
	padding: 8px;
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
  	width: 400px;
  	height: 43px;
}
#refundAccount * {
	text-align: center;
    display: block;
    padding: 5px 0;
    margin: 10px auto;
}

</style>

<script>
$(function(){
	// active 클래스 초기화
	$.each($("aside .nav-link"), function(i, nav){
		$(nav).attr("class", "nav-link");
	});
	
	$("#tab-dashboard-link").addClass("active");
});
</script>
</head>
<body>
<div class="page-wrapper">
	<jsp:include page="../header.jsp"></jsp:include>
	<!-- header 파일 인클루드 -->
 		<main class="main">
            <div class="page-content">
            	<div class="dashboard">
	              <div class="container">
	                <div class="row">
						 	<jsp:include page="mypageAside.jsp"></jsp:include>
	                		<div class="col-md-8 col-lg-10">
								    <div class="tab-pane" id="tab-dashboard" aria-labelledby="tab-dashboard-link">
										<!-- 메인 페이지 시작 -->
										<!-- 마이페이지 정보 -->
								    		<div class="row align-items-center">
								    		<div class="heading">
								    				<h2 class="title" style="font-weight: bolder;">내 정보</h2>
								    		</div>
								    		<div class="row align-items-center">
								    			<table class="table table-wishlist table-mobile" style="border-top: 2px solid;">
								    				<tr>
														<td></td>								    				
								    					<td style="padding: 30px 50px; width: 100px;">
								    						<figure style="width: 80px;">
							                                	<c:if test="${userInfo.userImg == null }">
							                                       <img src="/resources/assets/images/products/details/basic.png" class="rounded-circle" id="nowUserImg">
							                                	</c:if>
							                                	<c:if test="${userInfo.userImg != null }">
							                                		<img src="${userInfo.userImg }" class="rounded-circle" id="nowUserImg">
							                                	</c:if>
					                                		</figure><!-- End .entry-media -->
								    					
								    					</td>
								    					<td> 
								    						<div class="entry-body">
						                                    <h2 class="entry-title">
						                                        	<span>${userInfo.nickname }</span>님 환영합니다.
						                                    </h2><!-- End .entry-title -->
						                                    <div class="entry-content">
						                                    <c:choose>
						                                    	<c:when test="${userInfo.isAdmin == 'A'}">
						                                    		<p>회원 등급 : 관리자 </p>
						                                    	</c:when>
						                                    	<c:when test="${userInfo.isAdmin == 'M'}">
						                                    		<p>회원 등급 : 개시판 매니저 </p>
						                                    	</c:when>
						                                    	<c:when test="${userInfo.isAdmin == 'U'}">
						                                    		<p>회원 등급 : 일반회원 </p>
						                                    	</c:when>
						                                    </c:choose>
						                                        <a href="javascript:;" class="read-more" onclick="viewPointLog('${userInfo.uuid}')">보유 포인트 : ${userInfo.userPoint }점</a>
						                                    </div><!-- End .entry-content -->
								    						 </div>
								    					</td>
								    					<td><input type="button" class="btn btn-link" value="프로필 이미지 변경" onclick="changeUserImg();"/></td>
								    				</tr>
								    			</table>
								    		</div>
								    		
								    			
								    		<!-- 상단 유저 정보 끝 -->
								    		<div class="heading">
								    			<h2 class="title" style="font-weight: bolder;">주문 내역</h2>
								    		</div>
								    		
								    		<c:choose>
								    			<c:when test="${empty orderList }">
								    			<div class="row align-items-center" style="padding-left: 20px; height:150px; border-top: 2px solid; margin-left: 8px;">
								    					<div>
									    					<h3>❌⛔주문 상품이 없습니다❌⛔ </h3>
								    					</div>
								    			</div>
								    			</c:when>
								    			<c:otherwise>
								    			<div class="row align-items-center scrollbar" style="padding-left: 20px; max-height:750px; overflow:auto; border-top: 2px solid; margin-left: 8px;">
								    			<%-- <div>${orderList }</div> --%>
								    			<table class="table table-wishlist table-mobile" style=" padding: 0px 10px;">
													<thead>
														<tr>
															<th>주문번호</th>
															<th class="pl-5">주문명</th>
															<th>결제금액</th>
															<th>결제수단</th>
															<th>주문일</th>
															<th>주문상태</th>
															<th></th>
															<th></th>
														</tr>
													</thead>
													<tbody>
													<c:forEach var="list" items="${orderList }">
														<tr>
															<td onclick="detailOrder('${list.orderVo.orderNo }','${list.orderVo.orderStatus }');">
																${list.orderVo.orderNo }
															</td>
															<td class="pl-5" onclick="detailOrder('${list.orderVo.orderNo }','${list.orderVo.orderStatus }');">
																<span class="orderNameSpan">${list.orderVo.orderName }</span>
															</td>
															<td onclick="detailOrder('${list.orderVo.orderNo }','${list.orderVo.orderStatus }');">
																<fmt:formatNumber value="${list.orderBillingVo.orderCost }" />원
															</td>
															<td class="pt-1 pb-1" onclick="detailOrder('${list.orderVo.orderNo }','${list.orderVo.orderStatus }');">
																${list.orderVo.payMethod }<br/>
																<c:if test="${list.orderVo.payMethod eq  '포인트'}">
																<span style="color : gray;">-<fmt:formatNumber value="${list.orderBillingVo.pointDiscount }" />점</span>
																</c:if>
															</td>
															<td onclick="detailOrder('${list.orderVo.orderNo }','${list.orderVo.orderStatus }');">
																<fmt:formatDate value="${list.orderVo.orderTime }" pattern="yyyy-MM-dd HH:mm"/>	
															</td>
															<td id="oStatus_${list.orderVo.orderNo }" onclick="detailOrder('${list.orderVo.orderNo }','${list.orderVo.orderStatus }');">
																${list.orderVo.orderStatus }
															</td>
															<td class="oBtn_${list.orderVo.orderNo }">
															<c:if test="${list.orderVo.orderStatus == '배송완료' and list.orderVo.orderStatus!='구매확정'}">
																<input type="button" class="btn btn-link" style="margin:auto;"value="구매확정" onclick="orderStatusUpdate('${list.orderVo.orderNo }');"/>
															</c:if>
															<c:if test="${list.orderVo.orderStatus == '결제완료' or list.orderVo.orderStatus=='입금대기'}">
																	<input type="button" class="btn btn-link" value="주문취소" onclick="openCancelModal('${list.orderVo.orderNo }', '${list.orderVo.payMethod}', '${list.orderVo.orderStatus }');"/>
																</c:if>
															</td>
															<td class="pt-1 pb-1 oBtn_${list.orderVo.orderNo }">
																<c:choose>
																	<c:when test="${list.csType == null and list.orderVo.orderStatus == '배송완료' and list.orderVo.orderStatus !='구매확정'}">
																		<div>
																			<button class='btn btn-link d-flex'  onclick='orderCsChange("${list.orderVo.orderNo }")'>교환</button>
																			<button class='btn btn-link d-flex' onclick='orderCsCost("${list.orderVo.orderNo }")'>반품</button>
																		</div>
																	</c:when>
																	<c:when test="${list.csType == '반품'}">
																		<span><a href="/mypage/csList">반품 신청중</a></span>
																	</c:when>
																	<c:when test="${list.csType == '교환'}">
																		<span><a href="/mypage/csList">교환 신청중</a></span>
																	</c:when>
																</c:choose>
															</td>
														</tr>
													</c:forEach>	
													</tbody>
								    			</table>
								    			</div>
								    			</c:otherwise>
								    		</c:choose>
								    		<div>
				                		</div>
								    	<!-- 메인 페이지 끝 -->
								    </div><!-- .End .tab-pane -->

								   
	                		</div><!-- End .col-lg-9 -->
	                	</div><!-- End .row -->
	                </div><!-- End .container -->
                </div><!-- End .dashboard -->
            </div><!-- End .page-content -->
         </div>
        </main><!-- End .main -->
       
        
		
		<!-- mypage Modal -->
		<div class="modal fade" id="info-modal" tabindex="-1" role="dialog" aria-hidden="true" >
			<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
				<div class="modal-content">
				 
				<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
					<span style="font-size: 20px; font-weight: bold;">마이페이지</span>
				</div>
				<div class="modal-body" style="text-align: center; padding : 0px 15px 15px 15px;">
				<span id="modalText" style="font-size: 15px; font-weight: bold;"></span>
				</div>
				<div style="text-align:center;">
				<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
				style="margin-bottom:15px; width: 200px;"
				data-dismiss="modal" aria-label="Close">확인</button>
				</div>
				</div>
			</div>
			</div> <!-- mypage Modal -->
	
		<!-- mypage Modal -->
		<div class="modal fade" id="detailOrderModal" tabindex="-1" role="dialog" >
		<div class="modal-dialog modal-lg modal-dialog-centered " style="max-width: 1000px;">
			<div class="modal-content">
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">상품 상세보기</span>
			</div>
			<div style="display: flex; justify-content: center;">
			<div class="modal-body" style="padding: 0px 40px; width: 900px;">
			<div class="scrollbar" style="width:100%; max-height:450px; overflow:auto; padding: 0px 10px;">
				<table class="table table-pointLog table-mobile" style="border-bottom :1px solid gray; margin-bottom: 10px; padding: 20px 20px;">
					<thead>
						<tr>
							<th></th>
							<th>상품</th>
							<th>수량</th>
							<th>금액</th>
							<th></th>
						</tr>
					</thead> 
					<tbody id="tbodyDetail">
							
					</tbody>
				</table>
				</div>
			
				<div class='row' style="padding-bottom: 10px; padding-top: 15px;">
					<div class='col-12 col-md-3'>
						<span>주문번호 :&nbsp;&nbsp;</span><span id="modalOrderNo"></span>
					</div>
					
					<div class='col-12 col-md-2'>
						<span>배송비 :&nbsp;&nbsp;</span><span id="modalOrderDeliveryCost"></span>
					</div>
					<div class='col-12 col-md-3'>
						<span>총 결제 금액 :&nbsp;&nbsp;</span><span id="modalOrderCost"></span><span>원</span>
					</div>
					<div class='col-12 col-md-2'>
						<span>포인트 사용 :&nbsp;&nbsp;</span><span id="modalOrderPointCost"></span><span>점</span>
					</div>
					<div class='col-12 col-md-2'>
						<span>적립금 :&nbsp;&nbsp;</span><span id="modalOrderPoint"></span><span>점</span>
					</div>
				</div>
				<div class='row'>
					<div class='col-12 col-md-3'>
						<span>받으시는 분 :&nbsp;&nbsp;</span><span id="modalShippingReciever"></span>
					</div>
					<div class='col-12 col-md-3'>
						<span>연락처 :&nbsp;&nbsp;</span><span id="modalShippingPhone"></span>
					</div>
					<div class='col-12 col-md-6'>
						<span>주소 :&nbsp;&nbsp;</span><span id="modalShippingAddr"></span>
					</div>
				</div>
				<div class='row'>
					<div class='col-12 col-md-6'>
						<span>요청사항 :&nbsp;&nbsp;</span><span id="modalShippingRequest"></span>
					</div>
				</div>
			</div>
			</div>
			<div style="text-align:center;">
			<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" onclick="closeBtn();"
			style="margin-bottom:15px; width: 200px;"
			data-dismiss="modal" aria-label="Close">확인</button>
			</div>
			</div>
		</div>
	</div> <!-- mypage Modal -->
	
	
	<div class="modal fade" id="detailPointModal" tabindex="-1" role="dialog" >
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" style="max-width: 700px;">
			<div class="modal-content">
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">포인트 정보</span>
			</div>
			<div class="modal-body" style="margin: 15px 40px;">
				<table class="table table-wishlist table-mobile" style="margin-bottom: 10px; padding: 20px 10px;">
					<thead>
						<tr>
							<th></th>
							<th>사유</th>
							<th>날짜</th>
							<th>포인트</th>
							<th></th>
							
						</tr>
					</thead> 
					<tbody id="tbodyPoint">
							
					</tbody>
				</table>
			
			</div>
			<div style="text-align:center;">
			<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" onclick="closeBtn();"
			style="margin-bottom:15px; width: 200px;"
			data-dismiss="modal" aria-label="Close">확인</button>
			</div>
			</div>
		</div>
	</div> <!-- mypage Modal -->
	
	<div class="modal fade" id="userImgModal" tabindex="-1" role="dialog" >
		<div class="modal-dialog modal-dialog-centered" style="max-width: 700px;">
			<div class="modal-content">
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">유저 이미지 변경</span>
			</div>
			<div class="modal-body" style="margin: 15px 40px;">
				<input type="file" class="form-control" id="userImgFile" accept="image/*"/>
				<div id="uploadImg"></div>
			</div>
			<div style="text-align:center;">
			<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" onclick="updateUserImg();"
			style="margin : 10px 20px 20px 0px; width: 150px;"
			data-dismiss="modal" aria-label="Close" id="upBtnImg" disabled="disabled">변경</button>
			<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" onclick="closeBtn();"
			style="margin : 10px 0px 20px 20px; width: 150px;"
			data-dismiss="modal" aria-label="Close">닫기</button>
			</div>
			</div>
		</div>
	</div> <!-- mypage Modal -->
	
	
	<div class="modal fade" id="orderStatusAskmodal" tabindex="-1" role="dialog" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">주문내역</span>
			</div>
			<div class="modal-body" style="text-align: center; padding : 0px 15px 15px 15px;">
				<span style="font-size: 15px; font-weight: bold;">구매확정을 하시겠습니까?</span> </br>
				<span>* 구매확정 후 취소/환불/교환은 할 수 없습니다!</span>
			</div>
			<input type="hidden" id="upOrderNo"/>
			<div style="text-align:center;">
			<button class="btn btn-outline-primary-2 btn-order btn-block" onclick="updateStatus()" 
			style="margin:0px 5px 15px 0px; width: 150px;"
			data-dismiss="modal" aria-label="Close" >네</button>
			<button class="btn btn-outline-primary-2 btn-order btn-block" onclick="closeBtn()" 
			style="margin:0px 0px 15px 5px; width: 150px;"
			data-dismiss="modal" aria-label="Close">아니요</button>
			</div>
			</div>
		</div>
	</div>

	<!-- 주문 취소 확인 모달 -->
	<div class="modal fade" id="orderCancelmodal" tabindex="-1" role="dialog" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">주문취소</span>
			</div>
			<div class="modal-body" style="text-align: center; padding : 0px 15px 15px 15px;">
				<span style="font-size: 15px; font-weight: bold;">주문을 취소하시겠습니까?</span> </br>
				<span>* 주문 취소는 배송 시작 전까지만 가능합니다!</span>
			</div>
			
			<div id="refundAccount" class="input-hide sm password" 
			style="display: none;">
				<h6>환불 계좌 입력</h6>
				<select id="bank" class="d-height input-w100 btn-outline-secondary" style="width: 150px;">
					<option value='' <c:if test="${customer.bankName != ''}">selected</c:if> >은행선택</option>
					<option value="국민은행" <c:if test="${customer.bankName == '국민은행'}">selected</c:if> >국민은행</option>
					<option value="신한은행" <c:if test="${customer.bankName == '신한은행'}">selected</c:if> >신한은행</option>
					<option value="기업은행" <c:if test="${customer.bankName == '기업은행'}">selected</c:if> >기업은행</option>
					<option value="하나은행" <c:if test="${customer.bankName == '하나은행'}">selected</c:if> >하나은행</option>
					<option value="농협은행" <c:if test="${customer.bankName == '농협은행'}">selected</c:if> >농협은행</option>
					<option value="우리은행" <c:if test="${customer.bankName == '우리은행'}">selected</c:if> >우리은행</option>
					<option value="카카오뱅크" <c:if test="${customer.bankName == '카카오뱅크'}">selected</c:if> >카카오뱅크</option>
					<option value="케이뱅크" <c:if test="${customer.bankName == '케이뱅크'}">selected</c:if> >케이뱅크</option>
					<option value="신협은행" <c:if test="${customer.bankName == '신협은행'}">selected</c:if> >신협은행</option>
					<option value="제일은행" <c:if test="${customer.bankName == '제일은행'}">selected</c:if> >SC제일은행</option>
					<option value="제주은행" <c:if test="${customer.bankName == '제주은행'}">selected</c:if> >제주은행</option>
					<option value="대구은행" <c:if test="${customer.bankName == '대구은행'}">selected</c:if> >대구은행</option>
					<option value="한국씨티은행" <c:if test="${customer.bankName == '한국씨티은행'}">selected</c:if> >한국씨티은행</option>
					<option value="부산은행" <c:if test="${customer.bankName == '부산은행'}">selected</c:if> >부산은행</option>
					<option value="수협은행" <c:if test="${customer.bankName == '수협은행'}">selected</c:if> >수협은행</option> 
					<option value="경남은행" <c:if test="${customer.bankName == '경남은행'}">selected</c:if> >경남은행</option>
					<option value="전북은행" <c:if test="${customer.bankName == '전북은행'}">selected</c:if> >전북은행</option>
					<option value="광주은행" <c:if test="${customer.bankName == '광주은행'}">selected</c:if> >광주은행</option>
				</select>
					
					<input class="d-height input-w80" type="text" size="40" id="accountNumber" placeholder="계좌번호를 숫자만 입력해 주세요." maxlength="16" value="${customer.refundAccount}">
					<input class="d-height input-w80" type="text" size="40" id="holderName" placeholder="예금주" maxlength="10" value="${customer.name}">
			</div>
			<input type="hidden" id="cancelOrderNo"/>
			<input type="hidden" id="cancelPayment"/>
			<input type="hidden" id="cancelStatus"/>

			
			<div style="text-align:center;">
			<button class="btn btn-outline-primary-2 btn-order btn-block" onclick="orderCancel()" 
			style="margin:0px 5px 15px 0px; width: 150px;"
			data-dismiss="modal" aria-label="Close" >네</button>
			<button class="btn btn-outline-primary-2 btn-order btn-block" onclick="closeBtn()" 
			style="margin:0px 0px 15px 5px; width: 150px;"
			data-dismiss="modal" aria-label="Close">아니요</button>
			</div>
			</div>
		</div>
	</div>
	

	<jsp:include page="../footer.jsp"></jsp:include>
	<!-- footer 파일 인클루드 -->
 </div>

<script type="text/javascript">
$(function(){
	
	$("#userImgFile").change(function(){
		var nameList = ($(this).val()).split(".");
		var fileExt = nameList[nameList.length - 1];
		if(fileExt == "png" || fileExt == "jpg" || fileExt == "jpeg"){
			var upImg = $("#userImgFile")[0].files;
			console.log(upImg);
			if(upImg[0].size < 150000){
				$("#uploadImg").text(upImg[0].name + "로 변경 가능 합니다!").css("color", "green");
				$("#upBtnImg").attr("disabled", false);
			} else {
				$("#userImgFile").val('');
				$("#upBtnImg").attr("disabled", true);
				$("#uploadImg").text("150KB 미만 사진만 가능합니다.").css("color", "red");
			}
			 
			
		} else {
			$("#userImgFile").val('');
			$("#upBtnImg").attr("disabled", true);
			$("#uploadImg").text("png, jpg, jpeg 형식만 가능합니다.").css("color", "red");
		};
		

	});
	
	
	
});


function updateUserImg(){

	var upImg = $("#userImgFile")[0].files;
	 const selectedfile = upImg;
	  if (selectedfile.length > 0) {
	    const [imageFile] = selectedfile;
	    const fileReader = new FileReader();
	    fileReader.onload = () => {
	    	const srcData = fileReader.result;
	      //console.log('base64:', srcData)
	     $.ajax({
			url : "updateUserImg", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			data : {
				"userImg" : srcData
			}, // 데이터 보내기
			/* dataType : "json", // 수신받을 데이터 타입 (MINE TYPE) */
			success : function() {},
			error : function() {},
			complete : function() {
				$("#nowUserImg").attr("src",srcData);
			},
		});
	    };
	    fileReader.readAsDataURL(imageFile);
	}
	
	  
	  $("#userImgModal").hide();
};



function closeBtn(){
	$("#detailOrderModal").hide();
	$("#detailPointModal").hide();
	$("#userImgModal").hide();
	$("#orderStatusAskmodal").hide();
}

function orderCsChange(orderNo){
	// 교환
	location.href = "/order/cs/exchange?orderNo="+orderNo;
	
};

function orderCsCost(orderNo){
	// 반품
	location.href = "/order/cs/return?orderNo="+orderNo;
};

function orderCancel(){
	//취소
	let obj = {};
	let orderNo = $("#cancelOrderNo").val();
	let payment = $("#cancelPayment").val();
	let status = $("#cancelStatus").val();
	obj.orderNo = orderNo
	if(payment=="가상계좌"&&status=="결제완료"){
		let bank = $("#bank").val().replace("은행", "");
		bank = bank.replace("뱅크","");
		obj.bank = bank;
		obj.accountNumber = $("#accountNumber").val().replaceAll("-", "");
		obj.holderName = $("#holderName").val();
	}

	$.ajax({
			url : "/order/cs/cancel", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			dataType : "text", // 수신받을 데이터 타입 (MINE TYPE),
			data : JSON.stringify(obj),
			contentType: 'application/json',
			success : function(data) {
				console.log(data);
				$("#oStatus_"+orderNo).text("주문취소");
				$(".oBtn_"+orderNo).html('')
				$("#orderStatusAskmodal").hide();
			},
			error : function() {}
		});
}

function openCancelModal(orderNo, payment, status){
	$("#cancelOrderNo").val(orderNo);
	$("#cancelPayment").val(payment);
	$("#cancelStatus").val(status);

	if(payment=="가상계좌"&&status=="결제완료"){
		$("#refundAccount").show();
	}else{
		$("#refundAccount").hide();
	}

	$("#orderCancelmodal").modal();
}

function detailOrder(orderNo, orderStatus){
	
	$.ajax({
		url : "detailOrder", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		data : {
			"orderNo" : orderNo
		}, // 데이터 보내기
		dataType : "json", // 수신받을 데이터 타입 (MINE TYPE)
		//processData : false, // text데이터에 대해서 쿼리스트링 처리를 하지 않겠다.
		//contentType : false, // application/x-www-form-urlencoded 처리하지 않음.
		success : function(data) {
			// 통신이 성공하면 수행할   함수
				console.log(data);
				let output = "";
				console.log(data.opList);
				$("#modalOrderNo").text(data.oBill.orderNo);
				$("#modalOrderCost").text(data.oBill.orderCost.toLocaleString('ko-KR'));
				$("#modalOrderPoint").text(data.oBill.orderPoint.toLocaleString('ko-KR'));
				$("#modalShippingReciever").text(data.osDto.reciever);
				$("#modalShippingPhone").text(data.osDto.phone);
				$("#modalShippingAddr").text(data.osDto.address);
				$("#modalOrderPointCost").text(data.oBill.pointDiscount.toLocaleString('ko-KR'));
				$("#modalShippingRequest").text(data.osDto.request);
				if(data.oBill.orderCost > 50000){
					$("#modalOrderDeliveryCost").text("무료배송");
				} else {
					$("#modalOrderDeliveryCost").text("3,000원");
				}
				for(var i = 0; i < data.opList.length; i++){
					output += "<tr>";
					if(data.opList[i].orderCancel == 'Y') {
						output += "<s>";
					}
					output += "<td style='padding : 0px;'><div class='product'><figure class='product-media'><a href='../product/productDetail?productNo=" +  data.opList[i].productNo +"'>";
					output += "<img src='" + data.opList[i].thumbnailImg + "'></a></figure></div></td>";
					output += "<td><h3 class='product-title'>" + data.opList[i].productName + "</h3></td>";
					output += "<td>" + data.opList[i].quantity + "</td>";
					output += "<td>" + data.opList[i].orderPrice.toLocaleString('ko-KR') + "원</td>";
					if(orderStatus == "배송완료"){
						$("#orderCancel").hide();
					} else if(orderStatus == "구매확정") {
						$("#orderCancel").hide();
						if(data.opList[i].orderCancel == 'Y'){
							output += "<td>취소된 상품</td>";
						} else if(data.opList[i].orderCancel == 'N' && data.opList[i].review == 'N'){
							output += "<td><a href='/mypage/writeReview?productNo="+data.opList[i].productNo+"&orderNo="+data.oBill.orderNo+"' class='btn btn-link'>리뷰작성</a></td>";
						} else if(data.opList[i].review == 'Y' && data.opList[i].orderCancel == 'N'){
							output += "<td>구매확정</td>";
						}
					} else {
						$("#orderCancel").show();
						output += "<td>" + orderStatus + "</td>";
					}
					if(data.opList[i].orderCancel == 'Y') {
						output += "</s>";
					}
					output += "</tr>";
				};
				$("#tbodyDetail").html(output);
				
			
		},
		error : function() {},
		complete : function() {
			$("#detailOrderModal").modal();
		},
	});
	
};
	
	function viewPointLog(uuid){

		$.ajax({
			url : "viewPointLog", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			data : {
				"uuid" : uuid
			}, // 데이터 보내기
			dataType : "json", // 수신받을 데이터 타입 (MINE TYPE)
			success : function(data) {
				// 통신이 성공하면 수행할   함수
					console.log(data);
					console.log(data.pointList[1]);
					console.log(new Date(data.pointList[1].when));
					var output = "";
					for(var i = 0; i < data.pointList.length; i++){
						output += "<tr>";
						output += "<td></td>";
						output += "<td>"+ data.pointList[i].why +"</td>";
						
						var eDate = new Date(data.pointList[i].when);
						var year = eDate.getFullYear();
						var month = ('0' + (eDate.getMonth() + 1)).slice(-2);
						var day = ('0' + eDate.getDate()).slice(-2);
						var dateString = year + '-' + month + '-' + day;
						
						output += "<td>"+ dateString +"</td>";
						output += "<td>"+ data.pointList[i].howmuch +"점</td>";
						output += "<td></td>";
						output += "</tr>";
						$("#tbodyPoint").html(output);
					};
					
			},
			error : function() {},
			complete : function() {
				$("#detailPointModal").modal();
			},
		});
		
	};

	function changeUserImg(){
		$("#userImgModal").modal();
		
	};
	
	
	function orderStatusUpdate(orderNo){
		$("#upOrderNo").val(orderNo);
		$("#orderStatusAskmodal").modal();
	};
	
	function updateStatus(){
		var orderNo = $("#upOrderNo").val();
		console.log(orderNo);
		
		$.ajax({
			url : "updateOrderStatus", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			data : {
				"orderNo" : orderNo
			}, // 데이터 보내기
			success : function(data) {
				
			},
			error : function() {},
			complete : function() {
				$("#oStatus_"+orderNo).text("구매확정");
				$(".oBtn_"+orderNo).html('')
				$("#orderStatusAskmodal").hide();
			},
			});
		
	};

	$("#accountNumber").on("input", function(e) {
		if (e.originalEvent.inputType === 'deleteContentBackward') return; // backspace 키 눌렀을 때는 처리하지 않음
		let newRefundAccount = $(this).val();
		// 입력된 값에서 숫자 이외의 문자를 모두 제거
		newRefundAccount = newRefundAccount.replace(/\D/g, '');
		// 전화번호 형식에 맞게 하이픈 추가
		$(this).val(newRefundAccount);
	});

</script>

<style>
	.dashboard .btn {
		min-width : 40px;
	}
	
	.table th, .table td {
    padding-left: 0;
    padding-right: 0;
    padding-top: 1.4rem;
    padding-bottom: 1.4rem;
}
</style>
</body>
</html>