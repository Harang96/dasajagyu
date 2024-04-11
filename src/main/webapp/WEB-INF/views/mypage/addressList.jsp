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
<title>배송지 관리</title>
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
<!-- <link rel="manifest" href="/resources/assets/images/icons/site.html"> -->
<link rel="mask-icon"
	href="/resources/assets/images/icons/safari-pinned-tab.svg"
	color="#666666">
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
<script>
	function goEdit(no){
		window.open("/mypage/modifyAddr?deliveryNo="+no, "주소지수정", 'width=500, height=800');
	};

	function saveAddr(){
		window.open("/mypage/mypageAddr","주소지추가", 'width=500, height=800');
	};

</script>


<style type="text/css">

.addrBtn {
   text-align: center;
   justify-content: center;
   margin: auto;
   
}
.addrsN {
   border: 1px solid #222;
   margin-top: 10px;
    margin-bottom: 10px;
    padding-left: 10px;
    
}

.deliveryAddr{
	border-top: 2px solid #222;


}

.addrsY {
   border: 2px solid #222;
   margin-top: 10px;
    margin-bottom: 10px;
    padding-left: 10px;
    
}
#basicAaddrColor {
	color : green;
}
</style>
<script>
$(function(){
	// active 클래스 초기화
	$.each($("aside .nav-link"), function(i, nav){
		$(nav).attr("class", "nav-link");
	});
	
	$("#tab-delivery-link").addClass("active");
})
</script>

</head>
<body>
	<div class="page-wrapper">
<jsp:include page="../header.jsp"></jsp:include>
<!-- header 파일 인클루드 -->
 		<main class="main">
            <div class="page-content">
            	<div class="dashboard">
	              <div class="container"">
	                <div class="row">
						 	<jsp:include page="mypageAside.jsp"></jsp:include>
	                		<div class="col-md-8 col-lg-10">
	                			
								<div>
	                               <h4 style="font-weight: bolder;">배송지 관리</h4>
	                               <div class="table_type_A table_form no-td-bb deliveryAddr">
	                               
		                               <c:forEach var="addr" items="${addrList }">
		                                <c:if test="${addr.basicAddr == 'Y' }">
	                                  <div class = "addrsY" style="margin-top: 15px; margin-bottom: 15px;">
				                                     <input type="hidden" class="form-control" id="deliveryNo${addr.deliveryNo }" name="deliveryNo" value="${addr.deliveryNo }">
				                                     <div>${addr.deliveryName }&emsp;<span id = "basicAaddrColor">[기본 배송지]</span> </div>
				                                     <div>[${addr.deliveryPostcode}] ${addr.deliveryAddr } ${addr.deliveryDetail }</div>
				                                     <div>${addr.phoneNumber }</div>
				                                      <h3 class="card-title"><button type= "submit" class= "btn btn-outline-primary-2 btn-minwidth-sm" style="padding : 3px; margin-bottom: 10px; margin-top: 5px;" onclick="goEdit(${addr.deliveryNo })">수정</button></h3>
	                                 </div>
	                                 </c:if>
			                          </c:forEach>
		                               <c:forEach var="addr" items="${addrList }">

		                                <c:if test="${addr.basicAddr == 'N' }">
	                                  <div class = "addrsN" style="margin-top: 15px; margin-bottom: 15px;">
				                                     <input type="hidden" class="form-control" id="deliveryNo${addr.deliveryNo }" name="deliveryNo" value="${addr.deliveryNo }">
				                                     <div>${addr.deliveryName }</div>
				                                     <div>[${addr.deliveryPostcode}] ${addr.deliveryAddr } ${addr.deliveryDetail }</div>
				                                     <div>${addr.phoneNumber }</div>
				                                      <h3 class="card-title"><button class= "btn btn-outline-primary-2 btn-minwidth-sm" style="padding : 3px; margin-bottom: 10px; margin-top: 5px;" onclick="goEdit(${addr.deliveryNo })">수정</button></h3>
	                               				</form>
	                                 </div>
	                                 </c:if>
		                               </c:forEach>     
                                  			<div class="col-lg-6 addrBtn">
                                         		 <h3 class="card-title"><button class="btn btn-block btn-outline-primary-2 btnAddr" onclick="saveAddr()"><i class="icon-plus"></i>배송지 추가하기</button></h3>
		                                  	</div>
                              		 </div><!-- End .row -->

									
								</div>
							</div>
							</div>
							
						</div>
					</div>
				</div>
				
			</main>	
			
			<jsp:include page="../footer.jsp"></jsp:include>
	</div>
<!-- footer 파일 인클루드 -->

</body>
</html>