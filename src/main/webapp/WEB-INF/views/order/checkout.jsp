<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.cafe24.goott351.domain.OrderInfoDTO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>구매하기</title>
<meta charset="UTF-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<link rel="stylesheet" href="./bulma.min.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://js.tosspayments.com/v1"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<c:set var="loginCustomer" value="${sessionScope.loginCustomer}" />
<%
	String orderId = (String) request.getAttribute("orderId");
	OrderInfoDTO orderInfo = (OrderInfoDTO) session.getAttribute("order_"+orderId);
%>
<c:set var="orderId" value="<%= orderId %>"/>
<c:set var="productList" value="<%= orderInfo.getProducts() %>" />
<c:set var="orderBill" value="<%= orderInfo.getBill() %>" />
<script>
        let tossPayments = TossPayments("test_ck_7DLJOpm5QrlOgwZnL95VPNdxbWnY");
        $(function(){
        	$("#phone").on("input", function(e) {
  	          if(e.originalEvent.inputType === 'deleteContentBackward') return; // backspace 키 눌렀을 때는 처리하지 않음
  	          let phoneNumber = $(this).val();
  	          // 입력된 값에서 숫자 이외의 문자를 모두 제거
  	          phoneNumber = phoneNumber.replace(/\D/g, '');
  	          // 전화번호 형식에 맞게 하이픈 추가
  	          phoneNumber = phoneNumber.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
  	          // 입력 필드에 반영
  	          $(this).val(phoneNumber);
  	     	});	
        	
        	$("#pointDiscount").keyup(function(e){
        		 if(e.keyCode == 13){
        			 usePoint();
        			 
	       			 $(".point-query").css({
	       		            "color": "#fff",
	       		            "background-color": "#ef837b"
	       		        });
        		 }
        	});
        });
        
        function placeOrder(){
     
        	let method = $('#accordion-payment a[aria-expanded="true"]').data('value');
			let shipping = getShippingJson();
			console.log(method);
			console.log(shipping);
			
			
			$.ajax({
                url : "order/request", 
                type : "POST",
                data : JSON.stringify(shipping),
				headers : {"Content-Type" : "application/json"},
                dataType : "text",
                async : false,
                success : function(amount) {
                	console.log("amount : "+amount);
					if(amount == 0){
						let data = {
							"orderId" : "${orderId}",
							"amount" : amount,
    						"orderName" : getOrderName(),
    						"method" : "포인트",
    						"approvedAt" : new Date(),
    						"status" : "결제완료",
							"orderStatus" : "결제완료"
						}
						confirmPay(data)
					} else {
                	let requestPayJson = getPayInfo(method, amount);
                	console.log(requestPayJson);
                	tossPayments.requestPayment(method, requestPayJson)
        			.then(function(data){
						console.log(data);
        				confirmPay(data)
        			})
        			.catch(function (error) {
        	            if (error.code === "USER_CANCEL") {
        	              alert("유저가 취소했습니다.");
        	            } else {
        	              alert(error.message);
        	            }
        	        });
				}
                },
                error : function(data) {
					if(data.responseText=="shippingNull"){
						alert("배송 정보를 모두 입력해주세요.")
					}
                	console.log(error)
                },
                complete : function() {
                }
             });
			
        }
        
		function confirmPay(json) {
			$.ajax({
                url : "order/confirm", 
                type : "POST",
                data : JSON.stringify(json),
				headers : {"Content-Type" : "application/json"},
                dataType : "text",
                async : true,
                success : function(orderId) {
                	console.log(orderId);
					location.href="order/success?orderId="+orderId;
                },
                error : function(data) {
                	let error = data.responseText;
                	console.log(data);
					if(error == "DBError"){
					errorMessage = "DB에 저장하는데 실패했습니다.";
					
					} else if(error == "ConfirmError"){
						errorMessage = "결제 승인에 실패했습니다.";
						
					} else if(error == "AmountError"){
						errorMessage = "주문 금액과 결제 요청 금액이 다릅니다.";
					} else if(error == "QtyError"){
						errorMessage = "상품 재고가 부족합니다.";
						location.href="cart/viewCart";
					}

      			alert("주문 실패 \n"+errorMessage);

                    }
                 });
            }

      function getOrderName(){
      	let orderName = "";
                if (Number("${productList.size()}") > 1) {
                  orderName =
                    "${productList.get(0).productName} 외 ${productList.size()-1}개";
                } else {
                  orderName = "${productList.get(0).productName}";
                }
      	return orderName;
      }

            function getPayInfo(method, amount){

                let payJson = {
                		amount: amount,
                        orderId: "${orderId}",
                        orderName: getOrderName(),
                        customerName: "${loginCustomer.name}" || null,
                        customerEmail: "${loginCustomer.email}" || null,
                }
      	if(method!="가상계좌" && method !="계좌이체"){
      		console.log(payJson);
      		return payJson;
      	}

                let cash = payJson;
                cash.dueDate = getDueDate();
                cash.cashReceipt = {type: '미발행'} //소득공제 로 바꾸기
                cash.customerMobilePhone = "${loginCustomer.phoneNumber}".replaceAll("-", "") || null;
                cash.useEscrow = false;

                if(method=="가상계좌" || method =="계좌이체"){
      		console.log(cash);
                	return cash;
                }
            }

            // 무통장 입금 마감기한 (내일 23:59:59 구하기)
            function getDueDate(){
            	let day = new Date();
            	day.setDate(new Date().getDate()+1);
            	day.setHours(23, 59, 59, 0);
            	day.setTime(day.getTime()-day.getTimezoneOffset()*60000);
            	day = day.toISOString();
            	return day.substring(0, day.length - 5);
            }

            // 주문 관련 DB에 넣을 데이터
            function getShippingJson(){
              	let shipping = {
              			reciever : $("#reciever").val(),
              			phone : $("#phone").val(),
              			address : $("#addr").val() +" "+ $("#addrDetail").val(),
              			zipCode : $("#zipCode").val(),
              			request : $("#request").val(),
              			orderId : "${orderId}"
              	};

              	return shipping;
            }


            // 포인트 사용
            function usePoint() {
              let usePoint = $("#pointDiscount").val();
              let userPoint = Number("${loginCustomer.userPoint}");
              $.ajax({
                url: "order/usePoint?orderId=${orderId}&point=" + usePoint,
                type: "GET",
                dataType: "json",
                success: function (data) {
                  console.log(data);
                  $("#orderCost").html((data.orderCost).toLocaleString());
                  $("#orderPoint").html((data.orderPoint).toLocaleString());
                  $("#leftPoint").html((userPoint-usePoint).toLocaleString());
                },
                error: function (data) {
                 	alert(data.responseText+"보다 더 많은 포인트를 사용할 수 없습니다.");
                	console.log(data);
                }
              });
            }
            // 포인트 전액 사용
            function useAllPoint(){
            	if(${orderBill.orderCost>loginCustomer.userPoint}){
             	$("#pointDiscount").val("${loginCustomer.userPoint}");
            	} else{
            		$("#pointDiscount").val("${orderBill.productAmount-orderBill.productDiscount+orderBill.shippingCost}");
            	}
            	usePoint();
            }

            // 우편번호 찾기 API
            function execDaumPostcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        let addr = ''; // 주소 변수
                        let extraAddr = ''; // 참고항목 변수

                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }

                        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                        if(data.userSelectedType === 'R'){
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if(extraAddr !== ''){
                                extraAddr = ' (' + extraAddr + ')';
                            }
                            // 조합된 참고항목을 해당 필드에 넣는다.

                        } else {

                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        $("#zipCode").val(data.zonecode);
                        $("#addr").val(addr);
                        // 커서를 상세주소 필드로 이동한다.
                        $("#addrDetail").focus();
                    }
                }).open();
            }


            function openAddrList(){

            	 $.ajax({
                     url: "/mypage/getAddrToOrder",
                     type: "post",
                     dataType: "json",
                     success: function (data) {
                    	 	console.log(data.addrList);
                    	 	let output = "";
                    	 	for(var i = 0; i < data.addrList.length; i++){
                    	 		output += "<tr id='addr_"+ i +"'>";
                    	 		output += "<td>"+ data.addrList[i].deliveryName +"</td>";
                    	 		output += "<td>"+ data.addrList[i].phoneNumber +"</td>";
                    	 		output += "<td>"+ data.addrList[i].deliveryPostcode +"</td>";
                    	 		output += "<td>"+ data.addrList[i].deliveryAddr +"</td>";
                    	 		output += "<td>"+ data.addrList[i].deliveryDetail +"</td>";
                    	 		output += "<td><button class='btn btn-link' onclick='editAddr("+data.addrList[i].deliveryNo+")'>수정</button></td>";
                    	 		output += "<td><button class='btn btn-link' onclick='selectAddr("+i+")' data-dismiss='modal' aria-label='Close'>선택</button></td>";
                    	 		output += "</tr>";
                    	 	}

                    	 	$("#tbodyAddr").html(output);

                    	 },
                     error: function () {}
               		});


            	$("#addrModal").modal();
            }

            function selectAddr(i){
            	var name = $("#addr_"+i).children()[0];
            	var phone = $("#addr_"+i).children()[1];
            	var postcode = $("#addr_"+i).children()[2];
            	var addr = $("#addr_"+i).children()[3];
            	var deAddr = $("#addr_"+i).children()[4];
            	
            	closeBtn();

            	$("#reciever").val($(name).text());
            	$("#phone").val($(phone).text());
            	$("#zipCode").val($(postcode).text());
            	$("#addr").val($(addr).text());
            	$("#addrDetail").val($(deAddr).text());
				
            	
            	
            }

            function editAddr(no){
            	 window.open("/mypage/modifyAddr?deliveryNo="+no,"팝업",'width=500,height=700');
            }

            function closeBtn(){
            	$("#addrModal").hide();
            }
    </script>
  </head>

<body class="checkoutJsp">

	<div class="page-wrapper">
		<jsp:include page="../header.jsp"></jsp:include>
		

      <main class="main">
        <div
          class="page-header text-center"
          style="background-image: url('assets/images/page-header-bg.jpg')"
        >
          <div class="container">
            <h1 class="page-title">주문/결제</h1>
          </div>
          <!-- End .container -->
        </div>
        <!-- End .page-header -->
        <nav aria-label="breadcrumb" class="breadcrumb-nav">
          <div class="container">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="cart/viewCart">장바구니</a></li>
              <li class="breadcrumb-item active" aria-current="page"><b>주문결제</b></li>
              <li class="breadcrumb-item">주문완료</li>
            </ol>
          </div>
          <!-- End .container -->
        </nav>
        <!-- End .breadcrumb-nav -->

        <div class="page-content">
          <div class="checkout">
            <div class="container">
              <form action="#">
                <div class="row">
                  <div class="col-lg-9">
                    <h2 class="checkout-title">
                      <b>주문상품</b>
                    </h2>
                    <table class="table table-cart table-mobile">
                      <thead>
                        <tr>
                          <th>상품</th>
                          <th>가격</th>
                          <th>수량</th>
                          <th>상품 총 금액</th>
                          <th></th>
                        </tr>
                      </thead>

                      <c:forEach var="product" items="${productList}">
                        <tr>
                          <td class="product-col" style="padding: 10px 5px 10px 5px">
                            <div class="product">
                              <figure class="product-media">
                                <img src="${product.thumbImg}" alt="Product image" />
                              </figure>
                              <h3 class="product-title">${product.productName}</h3>
                              <!-- End .product-title -->
                            </div>
                          </td>
                          <td class="price-col" style="padding: 10px 5px 10px 5px">
                            <c:if test="${product.discountCost != 0 }">
                              <s><fmt:formatNumber value="${product.salesCost}" />원</s> →
                            </c:if>
                            <span class="sale-price"
                              ><fmt:formatNumber value="${product.orderPrice}" />원</span
                            >
                          </td>
                          <td class="quantity-col" style="width: 100px; padding: 10px 5px 10px 5px">
                            <span id="pdQty_41876" style="padding: 0px 10px 0px 10px"
                              >${product.qty}</span
                            >
                          </td>
                          <td
                            class="total-col"
                            id="total-col_41876"
                            style="padding: 10px 5px 10px 5px"
                          >
                            <fmt:formatNumber value="${product.orderPrice * product.qty}" />원
                          </td>
                        </tr>
                      </c:forEach>
                    </table>

                    <!-- End .checkout-title -->
                    <div class="titleBtn">
                      <h2 class="checkout-title mr-5">배송지</h2>
                      <c:if test="${loginCustomer.name != null }">
                        <button
                          type="button"
                          id="adressbook"
                          class="btn btn-outline-primary btn-round"
                          onclick="openAddrList()"
                        >
                          주소록
                        </button>
                      </c:if>
                    </div>

                    <div class="mb-3 mt-3">
                      <label>이름 *</label>
                      <input
                        type="text"
                        class="form-control"
                        id="reciever"
                        value="${delivery.deliveryName}"
                      />
                    </div>

                    <div class="mb-3 mt-3">
                      <label for="phone" class="form-label">핸드폰번호 *</label>
                      <input
                        type="text"
                        class="form-control"
                        id="phone"
                        maxlength="13"
                        size="15"
                        value="${delivery.phoneNumber}"
                      />
                    </div>

									<div class="mb-3 mt-3">
										<div class="titleBtn">
											<label for="address" class="form-label mr-5">주소 *</label> <input
												type="button" onclick="execDaumPostcode()"
												class="btn btn-outline-primary btn-round" value="우편번호 찾기">
										</div>
										<input type="text" id="zipCode" class="form-control postCode" 
											placeholder="우편번호" readonly value="${delivery.deliveryPostcode}">
										<br>
										<input type="text" id="addr" class="form-control border-top-0" placeholder="주소" readonly value="${delivery.deliveryAddr}"> 
										<input type="text" id="addrDetail" class="form-control"
											placeholder="상세주소를 입력해주세요." value="${delivery.deliveryDetail}">
									</div>

                    <label>배송 요청사항</label>
                    <textarea
                      id="request"
                      class="form-control"
                      cols="30"
                      rows="4"
                      placeholder="배송 요청사항을 적어주세요."
                    ></textarea>
                  </div>
                  <!-- End .col-lg-9 -->
                  <aside class="col-lg-3">
                    <div class="summary">
                      <h3 class="summary-title">결제 정보</h3>
                      <!-- End .summary-title -->

                      <table class="table table-summary">
                        <tr class="summary-subtotal">
                          <td>총 상품 금액</td>
                          <td><fmt:formatNumber value="${orderBill.productAmount}" />원</td>
                        </tr>
                        <tr>
                          <td>총 할인 금액</td>
                          <td>-<fmt:formatNumber value="${orderBill.productDiscount}" />원</td>
                        </tr>
                        <c:if test="${loginCustomer!=null}">
                          <tr>
                            <td>
                              <div class="checkout-point-style">포인트 사용</div>
                              <div class="titleBtn">
                                <div>사용:</div>
                                <div class="checkout-discount">
                                  <input
                                    type="text"
                                    class="form-control"
                                    style="margin-bottom: 1px; text-align: right"
                                    id="pointDiscount"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                                    value="0"
                                  />
                                </div>
                                <div>원</div>
                              </div>
                              <div class="userPoint p-3">
                                <div>
                                  보유 :
                                  <span id="userPoint"
                                    ><fmt:formatNumber value="${loginCustomer.userPoint}" /></span
                                  >원
                                </div>
                                <div>
                                  잔여 :
                                  <span id="leftPoint"
                                    ><fmt:formatNumber value="${loginCustomer.userPoint}" /></span
                                  >원
                                </div>
                              </div>
                            </td>
                            <td>
                              <div>
                                <button
                                  type="button"
                                  class="btn btn-outline-primary btn-round point-query"
                                  style="margin-bottom: 1px"
                                  onclick="usePoint();"
                                >
                                  적용
                                </button>
                              </div>
                              <div>
                                <button
                                  type="button"
                                  class="btn btn-outline-primary btn-round"
                                  onclick="useAllPoint();"
                                >
                                  전액 사용
                                </button>
                              </div>
                            </td>
                          </tr>
                        </c:if>
                        <tr>
                          <td>배송비</td>
                          <td>
                            <c:choose>
                              <c:when test="${orderBill.shippingCost!=0}">
                                <span id="shippingCost"
                                  ><fmt:formatNumber value="${orderBill.shippingCost}" /></span
                                >원
                              </c:when>
                              <c:otherwise> 무료배송 </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                        <tr class="summary-total">
                          <td>총 결제 금액</td>
                          <td>
                            <span id="orderCost"
                              ><fmt:formatNumber value="${orderBill.orderCost}" /></span
                            >원
                          </td>
                        </tr>
                        <c:if test="${loginCustomer!=null}">
                        <tr>
                          <td>적립 예정 포인트</td>
                          <td>
                            <span id="orderPoint"
                              ><fmt:formatNumber value="${orderBill.orderPoint}" /></span
                            >원
                          </td>
                        </tr>
                        </c:if>
                        <!-- End .summary-total -->
                      </table>
                      <!-- End .table table-summary -->

										<h3 class="summary-title mt-3">결제 수단</h3>
										<div class="accordion-summary mt-2" id="accordion-payment">
											<div class="card">
												<div class="card-header" id="heading-1">
													<h2 class="card-title">
														<a role="button" data-toggle="collapse" href="#collapse-1"
															aria-expanded="true" aria-controls="collapse-1" data-value="카드">
															카드 및 간편 결제 </a>
													</h2>
												</div>
												<!-- End .card-header -->
												<div id="collapse-1" class="collapse show"
													aria-labelledby="heading-1"
													data-parent="#accordion-payment">
												</div>
												<!-- End .collapse -->
											</div>
											<!-- End .card -->

                        <div class="card">
                          <div class="card-header" id="heading-2">
                            <h2 class="card-title">
                              <a
                                class="collapsed"
                                role="button"
                                data-toggle="collapse"
                                href="#collapse-2"
                                aria-expanded="false"
                                aria-controls="collapse-2"
                                data-value="가상계좌"
                              >
                                무통장 입금 (가상계좌)
                              </a>
                            </h2>
                          </div>
                          <!-- End .card-header -->
                          <div
                            id="collapse-2"
                            class="collapse"
                            aria-labelledby="heading-2"
                            data-parent="#accordion-payment"
                          ></div>
                          <!-- End .collapse -->
                        </div>
                        <!-- End .card -->

                        <div class="card">
                          <div class="card-header" id="heading-3">
                            <h2 class="card-title">
                              <a
                                class="collapsed"
                                role="button"
                                data-toggle="collapse"
                                href="#collapse-3"
                                aria-expanded="false"
                                aria-controls="collapse-3"
                                data-value="계좌이체"
                              >
                                계좌이체
                              </a>
                            </h2>
                          </div>
                          <!-- End .card-header -->
                          <div
                            id="collapse-3"
                            class="collapse"
                            aria-labelledby="heading-3"
                            data-parent="#accordion-payment"
                          ></div>
                          <!-- End .collapse -->
                        </div>
                        <!-- End .card -->

                        <div class="card">
                          <div class="card-header" id="heading-4">
                            <h2 class="card-title">
                              <a
                                class="collapsed"
                                role="button"
                                data-toggle="collapse"
                                href="#collapse-4"
                                aria-expanded="false"
                                aria-controls="collapse-4"
                                data-value="휴대폰"
                              >
                                휴대폰
                              </a>
                            </h2>
                          </div>
                          <!-- End .card-header -->
                          <div
                            id="collapse-4"
                            class="collapse"
                            aria-labelledby="heading-4"
                            data-parent="#accordion-payment"
                          ></div>
                          <!-- End .collapse -->
                        </div>
                        <!-- End .card -->

                        <div class="card">
                          <div class="card-header" id="heading-4">
                            <h2 class="card-title">
                              <a
                                class="collapsed"
                                role="button"
                                data-toggle="collapse"
                                href="#collapse-5"
                                aria-expanded="false"
                                aria-controls="collapse-5"
                                data-value="도서문화상품권"
                              >
                                상품권
                              </a>
                            </h2>
                          </div>
                          <!-- End .card-header -->
                          <div
                            id="collapse-5"
                            class="collapse"
                            aria-labelledby="heading-4"
                            data-parent="#accordion-payment"
                          ></div>
                          <!-- End .collapse -->
                        </div>
                        <!-- End .card -->
                      </div>
                      <!-- End .accordion -->

										<button type="button" onclick="placeOrder()" class="btn btn-outline-primary-2 btn-order btn-block placeorder-style">
											<span class="btn-text">결제하기</span> <span
												class="btn-hover-text">결제하기</span>
										</button>
									</div>
									<!-- End .summary -->
								</aside>
								<!-- End .col-lg-3 -->
							</div>
							<!-- End .row -->
						</form>
					</div>
					<!-- End .container -->
				</div>
				<!-- End .checkout -->
			</div>
			<!-- End .page-content -->
		</main>
		<!-- Addr modal -->
		<div class="modal checkout-modal" id="addrModal" tabindex="-1" role="dialog" >
			<div class="modal-dialog modal-dialog-centered" style="max-width: 900px;">
				<div class="modal-content">
				<div class="modal-name modal-title-style">
					<span style="font-size: 20px; font-weight: bold;">주소지 정보</span>
				</div>
				<div class="modal-body" style="margin: 15px 40px;">
					<table class="table table-wishlist table-mobile addr-style" style="margin-bottom: 10px; padding: 20px 10px;">
						<thead>
							<tr>
								<th>이름</th>
								<th>핸드폰번호</th>
								<th>유편번호</th>
								<th>주소</th>
								<th>상세주소</th>
								<th></th>
								<th></th>
							</tr>
						</thead> 
						<tbody id="tbodyAddr">
								
						</tbody>
					</table>
				</div>
				<div style="text-align:center;">
				<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" onclick="closeBtn();"
				style="margin-bottom:15px; width: 200px;"
				data-dismiss="modal" aria-label="Close">닫기</button>
				</div>
				</div>
			</div>
		</div> <!-- mypage Modal -->
		<jsp:include page="../footer.jsp"></jsp:include>
	</div>
	<!-- End .page-wrapper -->
</body>

  <style>
    .postCode {
      display: inline !important;
    }

    .titleBtn {
      display: flex;
      align-items: center;
    }

    .userPoint {
      display: flex;
      align-items: center;
    }

    .userPoint div {
      margin-right: 20px;
    }

    .btn {
      min-width: 85px !important;
      font-size: 12px;
      /* 	max-width : 70px !important; */
    }

    .table.table-cart .total-col {
      width: 100px;
    }
  </style>
</html>
