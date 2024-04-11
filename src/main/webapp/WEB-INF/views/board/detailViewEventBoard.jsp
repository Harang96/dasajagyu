<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Insert title here</title>
<!-- Favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
<style>
.tabContainer {
	border-bottom: 2px solid;
}

.banner {
	position: relative;
}

img {
	
}

h5 {
	font-weight: bold !important;
	font-size: 30px !important;
}

.under {
	margin-top: 20px !important;
	display: flex !important;
	align-items: center !important;
	justify-content: center; /* 가운데 정렬 */
}
</style>
<script type="text/javascript">
function deleteEvent(no) {
	// 취소버튼 클릭시 드래그드랍한 모든 파일 삭제
	
	$.ajax({
		url : "deleteEvent", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		type : "post", // 통신 방식 (GET, POST, PUT, DELETE)
		dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
		data : {
			"eventNo" : no,
			},
		success : function(data) {
			// 통신이 성공하면 수행할   함수
			if (data = "success"){
				location.href="/board/eventBoard";				
			}
			
		},
		error : function() {},
		complete : function() {
// 			location.href="/board/eventBoard"
		},
	});
}

function askDel(){
	$("#delete-modal").modal();
};


</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	
	<div class="container pt-1">
    <div class="row">
        <c:forEach items="${imgList}" var="img" varStatus="status">
           
                <c:if test="${img.eventNo == param.no && img.eventimgIdentify == 2}">
                    <div class="banner banner-cat">
                        <h5>${eventDetail.title}</h5>
                        <img src="data:image;base64,${img.imgUrl}" alt="Banner" class="img-fluid">
                    </div>
                </c:if>
            	
        </c:forEach>
    </div>
</div>

	
	<div class="under">
		<c:if test="${loginCustomer.isAdmin == 'A'}">	
		<button type="button" class="btn btn-info" onclick="location.href='modifyViewEvent?no=${eventDetail.eventNo}'">수정</button>
<%-- 		<button type="submit" class="btn btn-danger" onclick ="deleteEvent('${eventDetail.eventNo }');">삭제</button> --%>
			<button type="submit" class="btn btn-danger" onclick ="askDel()">삭제</button>
		</c:if>	
		<button type="button" class="btn btn-primary" onclick="location.href='eventBoard'">목록으로</button>
	</div>
	
	<div class="custom-control" style="right: 0; position: absolute;">
	</div>
	
	
	
	
	<jsp:include page="../footer.jsp"></jsp:include>
	<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog"
		aria-hidden="true" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-body modalStyle" style="text-align: center; padding : 0px 15px 15px 15px;">
				<span style="font-size: 15px; font-weight: bold;">이벤트 글을 삭제 하시겠습니까?</span>
			</div>
			<div style="text-align:center;">
			<button class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
			style="margin:0px 5px 15px 0px; width: 150px;"
			data-dismiss="modal" aria-label="Close" onclick="deleteEvent('${eventDetail.eventNo }');">네</button>
			<button class="btn btn-outline-primary-2 btn-order btn-block" id="closeBtn" 
			style="margin:0px 0px 15px 5px; width: 150px;"
			data-dismiss="modal" aria-label="Close">아니요</button>
			</div>
			</div>
		</div>
	</div>
</body>
</html>