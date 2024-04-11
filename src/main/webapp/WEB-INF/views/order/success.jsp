<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.cafe24.goott351.domain.OrderInfoDTO" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link
      rel="icon"
      href="https://static.toss.im/icons/png/4x/icon-toss-logo.png"
    />
    <link rel="stylesheet" type="text/css" href="style.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>주문 완료</title>
  </head>

  <body>
  
	  <%
		String orderId = request.getParameter("orderId");
		OrderInfoDTO orderInfo = (OrderInfoDTO) session.getAttribute("order_"+orderId);
		System.out.println(orderInfo);
	%>

	
	<c:choose>
  <c:when test="<%= orderInfo != null %>">
  
  <c:set var="loginCustomer" value="${sessionScope.loginCustomer}" />

	<c:set var="orderId" value="<%= orderId %>"/>
	<c:set var="sessionId" value="<%= orderInfo.getSessionId() %>" />
	<c:set var="order" value="<%= orderInfo.getOrder() %>" />
	<c:set var="shipping" value="<%= orderInfo.getShipping()%>" />
	<c:set var="orderBill" value="<%= orderInfo.getBill() %>" />
	<c:set var="virtualAccount" value="<%= orderInfo.getOrder().getVirtualAccount() %>" />
	  
  
    <div class="page-wrapper">
      <jsp:include page="../header.jsp"></jsp:include>

      <main class="main">
        <div
          class="page-header text-center"
          style="background-image: url('assets/images/page-header-bg.jpg')"
        >
          <div class="container">
            <h1 class="page-title">
              주문 완료 <span>주문번호 : ${orderId}</span>
            </h1>
          </div>
          <!-- End .container -->
        </div>
        <!-- End .page-header -->
        <nav aria-label="breadcrumb" class="breadcrumb-nav">
          <div class="container">
            <ol class="breadcrumb">
              <li class="breadcrumb-item">
                <a href="cart/viewCart">장바구니</a>
              </li>
              <li class="breadcrumb-item">주문결제</li>
              <li class="breadcrumb-item active" aria-current="page">
                <b>주문완료</b>
              </li>
            </ol>
          </div>
          <!-- End .container -->
        </nav>
        <!-- End .breadcrumb-nav -->


        <div class="page-content pb-3">
          <div class="container">
            <div class="row">
              <div class="col-lg-10 offset-lg-1">
                <div class="about-text text-center mt-1">
                  <h2 class="title text-center mb-2">주문이 완료되었습니다.</h2>
                   <c:if test="${virtualAccount != null}">
                   <p>아래를 참조해서 입금해주세요.</p>
                   <br>
                   </c:if>
                  <!-- End .title text-center mb-2 -->
                </div>
                <!-- End .about-text -->
              </div>
              <!-- End .col-lg-10 offset-1 -->
            </div>
            <!-- End .row -->
            <div class="row justify-content-center">
            <div class="col-lg-5 offset-lg-1">
            	<table>
                   		<tr>
                   			<td class="title-col">주문상품</td>
                   			<td>${order.orderName}</td>
                   		</tr>
                   		<tr>
                   			<td class="title-col">배송지</td>
                   			<td>(${shipping.zipCode}) ${shipping.address}</td>
                   		</tr>
                   		<tr>
                   			<td class="title-col">결제금액</td>
                   			<td><fmt:formatNumber value="${orderBill.orderCost}"/>원</td>
                   		</tr>
                   </table>
                   
                   <c:if test="${virtualAccount != null}">
                   <br>
                   	<table>
                   		<tr>
                   			<td class="title-col">은행명</td>
                   			<td>${virtualAccount.bank}</td>
                   		</tr>
                   		<tr>
                   			<td class="title-col">계좌번호</td>
                   			<td>${virtualAccount.accountNumber}</td>
                   		</tr>
                   		<tr>
                   			<td class="title-col">입금금액</td>
                   			<td><fmt:formatNumber value="${orderBill.orderCost}"/>원</td>
                   		</tr>
                   		<tr>
                   			<td class="title-col">입금자명</td>
                   			<td>${virtualAccount.customerName}</td>
                   		</tr>
                   		<tr>
                   			<td class="title-col">입금기한</td>
                   			<td>${virtualAccount.dueDate}</td>
                   		</tr>
                   </table>
                   </c:if>
                   
              </div>
              <!-- End .col-lg-4 col-sm-6 -->
            </div>
            <!-- End .row -->
          </div>
          <div class="row justify-content-center">
          	<div class="col-lg-3 mt-3">
	          	<a href="/"><button class="btn btn-outline-primary">쇼핑 계속하기</button></a>
    	      	<a href="/mypage/openmypage"><button class="btn btn-primary">주문상세 보기</button></a>
          	</div>
          </div>
          <!-- End .container -->
        </div>
        <!-- End .page-content -->
      </main>
      <!-- End .main -->
     
      <jsp:include page="../footer.jsp"></jsp:include>
    </div>
    <!-- End .page-wrapper -->
    </c:when>
    
    
<%--     <c:otherwise> --%>
<%--     <c:redirect url="/mypage/openmypage" /> --%>
<%--     </c:otherwise>  --%>
    </c:choose>
    
    <div class="modal fade" id="order-modal" tabindex="-1" role="dialog"
		aria-hidden="true" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">장바구니</span>
			</div>
			<div class="modal-body" style="text-align: center; padding : 0px 15px 15px 15px;">
				<span style="font-size: 15px; font-weight: bold;">주문 정보를 받아볼 이메일을 입력해주세요.</span>
				<div>
        			<span>주문번호와 받는분 전화번호를 통해 주문 조회가 가능합니다.</span>
				</div>
				<div>
					<input type="email" class="form-control" id="nc_email" placeholder="이메일을 입력해주세요."/>
				</div>
			</div>
			<div style="text-align:center;">
        <button type="button" class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
        style="margin-bottom:15px; width: 200px;" onclick="sendEmail($('#nc_email').val());"
        data-dismiss="modal" aria-label="Close">이메일 전송</button>
			</div>
			</div>
		</div>
	</div>
    
  </body>

  <script>
    $(function(){
      let email = "${loginCustomer.email}";
      if(email=="" || email==null){
        $("#order-modal").modal();
      } else {
        sendEmail(email);
      }
    })


    function sendEmail(email){
      $.ajax({
            url: "sendEmail?orderId=${orderId}&email=" + email,
            type: "GET",
            dataType: "text",
            success: function (data) {
              console.log(data);
            },
            error: function (data) {
            	console.log(data);
            }
          });
    }

  </script>

  <style>
  	.title-col {
  		width : 120px;
  	}
  	td {
  		vertical-align : top;
  	}
  	.btnBox {
  		display : flex;
  		width : 200px;
  	}
  </style>
</html>
