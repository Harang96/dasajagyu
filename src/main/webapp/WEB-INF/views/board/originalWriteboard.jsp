<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>작품별 게시판 작성</title>
<!-- Favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
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

    <!-- Bootstrap v4.3.1 -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    />
    <!-- Bootstrap v5.3.2 -->
    <link rel="stylesheet" href="/resources/assets/css/skins/skin-demo-2.css" />
    <link rel="stylesheet" href="/resources/assets/css/demos/demo-2.css" />
    <link rel="stylesheet" href="/resources/css/product.css" />
<!-- Plugins CSS File -->
<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
<!-- Main CSS File -->
<link rel="stylesheet" href="/resources/assets/css/style.css">
    <!-- Plugins Js File -->
    <script src="/resources/assets/js/jquery.min.js"></script>
    <script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
    <script src="/resources/assets/js/jquery.waypoints.min.js"></script>
    <script src="/resources/assets/js/superfish.min.js"></script>
    <script src="/resources/assets/js/owl.carousel.min.js"></script>
    <script src="/resources/assets/js/jquery.plugin.min.js"></script>
    <script src="/resources/assets/js/bootstrap-input-spinner.js"></script>
    <script src="/resources/assets/js/jquery.elevateZoom.min.js"></script>
    <script src="/resources/assets/js/jquery.magnific-popup.min.js"></script>
    <script src="/resources/assets/js/jquery.countdown.min.js"></script>

    <!-- Main JS File -->
    <script src="/resources/assets/js/main.js"></script>
    <script src="/resources/assets/js/demos/demo-2.js"></script>
    <script src="/resources/js/header.js"></script>
    <!-- 로그인 -->
    
    
</head>
<style>

select {
    width: 250px; /* 너비 설정 */
    height: 36px; /* 높이 설정 */
    border: 1px solid #ccc; /* 테두리 설정 */
    border-radius: 5px; /* 테두리 둥글기 설정 */
    padding: 5px; /* 안쪽 여백 설정 */
    background-color: #f8f9fa; /* 배경색 설정 */
    color: #333; /* 텍스트 색상 설정 */
    font-size: 16px; /* 폰트 크기 설정 */
    float: right;
}


.originUploadFiles {

width:340px;
height: 150px;
background-color:#e9ecef;
font-size :14px;

}

#writeBoard {

height : 500px;
margin-bottom : 80px;

}

#imageBtn {

margin-bottom: 40px;

}

#cancelbtn {

text-alien: center;
border:2px solid aqua;


}

#btn {
display:inline-block; 
border:2px solid aqua;

}

#container {
width:1920px;
border: 2px solid blue;
margin: 0 auto; /* container 영역을 브라우저에서 가운데 정렬하기 위해 auto설정 */
text-align: center; /* inline-block화 된 div들을 텍스트 마냥 center로 정렬*/

}
</style>

<script type="text/javascript">



document.addEventListener("DOMContentLoaded", function(event) {
    // 버튼 클릭 이벤트 리스너 추가
    document.getElementById("btn").addEventListener("click", function() {
        alert("글쓰기 완료했습니다!");
    });

    // 취소 버튼 클릭 이벤트 리스너 추가
    document.getElementById("cancelbtn").addEventListener("click", function() {
    });
});

// $(document).ready(function() {
//     $(".boardwrite").submit(function(event) {
//         event.preventDefault(); // 폼의 제출을 중지합니다.

//         alert("글쓰기 작성이 완료되었습니다.");
//         this.submit();
//     });
// });
 
// $.ajax({
//     type: 'POST',
//     url: 'boardwrite',
//     data: $(this).serialize(), // 폼 데이터 직렬화하여 전송
//     success: function(response) {
//         // 서버에서 반환된 응답을 처리
//         if (response.redirectPage) {
//             // 서버에서 리디렉션할 페이지가 반환되었을 경우 해당 페이지로 이동
//             window.location.href = 'board/originalBoard';
//         } else {
//             // 서버에서 리디렉션할 페이지가 없는 경우에 대한 처리
//             console.log('서버에서 리디렉션할 페이지가 없습니다.');
//         }
//     },
//     error: function() {
//         // 서버 요청이 실패한 경우에 대한 처리
//         console.log('서버 요청 실패');
//     }
// 		});
//   });

$(function(){
	
	$(".originUploadFiles").on("dragenter dragover", function(evt) {
		evt.preventDefault(); // 진행중인 이벤트 버블링 캔슬	
		});
	
		$(".originUploadFiles").on("drop", function(evt) {
			evt.preventDefault(); // 진행중인 이벤트 버블링 캔슬
			
			console.log(evt.originalEvent.dataTransfer.files);
			
			let files = evt.originalEvent.dataTransfer.files;
			
			for (let file of files){
				console.log(file);
				
				let form = new FormData(); // 파일을 보낼거니까 formData를 써야함
				form.append("originaluploadFile", file); // 전송할 데이터 추가
				// 위문장에서 "uploadFile" 파일의 이름은 컨트롤러단의 MultipartFile 매개변수명과 일치시킨다.
				
				$.ajax({
					url : "originUploadFile", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
					type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
					data : form , // 데이터 보내기
					dataType : "json", // 수신받을 데이터 타입 (MINE TYPE)
					processData : false, // text데이터에 대해서 쿼리스트링 처리를 하지 않겠다.
					contentType : false, // application/x-www-form-urlencoded 처리하지 않음.
					//async : false, // 동기 통신 방식으로 하곘다. (default : true 비동기)
					success : function(data) {
						// 통신이 성공하면 수행할   함수
						
							if (data != null) {
// 								displayUploadedFile(data);
								alert("성공하였습니다.")
							}
						
					},
					error : function() {},
					complete : function() {},
				});
				
			}
					
		});
		
	});


// 	function displayUploadedFile(json) {
// 		let output = "";
		
// 		$.each(json, function(i, elt) {
// 			let name = elt.newFileName.replaceAll("\\", "/");
			
// 			if (elt.thumbFileName != null) { // 이미지
// 				let thumb = elt.thumbFileName.replaceAll("\\", "/");
// 				output += `<img src='../resources/uploads\${thumb}' id='\${elt.originalFileName}'/>`;
// 				output += `<img src='../resources/images/remove.png' class='remIcon' onclick='remFile(this)'/>`;
// 			} else { // 이미지가 아닌 경우
// 				output += `<a href='../resources/uploads\${name}'>\${elt.originalFileName}</a>`;
// 				output += `<img src='../resources/images/remove.png' class='remIcon'/>`;
// 			}
			
// 		});
		
// 		$(".upLoadFiles").html(output);
		
// 	}



</script>

<body>
<!-- 로그인 하지 않은 유저는 login.jsp페이지로 이동시키기. -->
<%-- 		<c:set var="workwriteboardLogin" value="${pageContext.request.requestURL}"/> --%>
<%-- 	<c:if test="${sessionScope.loginMember == null }"> --%>
<%-- 		<c:redirect url="../customer/loginOpen?path=${workwriteboardLogin}"></c:redirect> --%>
<%-- 	</c:if> --%>

<jsp:include page="../header.jsp"></jsp:include>

	<div class="header-search-wrapper search-wrapper-wide">
		<nav aria-label="breadcrumb" class="breadcrumb-nav mb-2">
			<div class="container">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">다사자규</a></li>
					<li class="breadcrumb-item"><a href="#">커뮤니티</a></li>
					<li class="breadcrumb-item" active aria-current="page">작품별 게시판</li>
					<li class="breadcrumb-item"><a href="#">글쓰기</a></li>
				</ol>
			</div>
			<!-- End .container -->
		</nav>
		<!-- End .breadcrumb-nav -->
	</div>
	<div class="container">
		<form action="originalBoardwrite" class="boardwrite" method="POST" id="boardwrite" enctype="multipart/form-data">
			<div style="display: inline-block; vertical-align: top;" >
				<h4 style="margin-top: 40px; display: inline;">카테고리 선택</h4>
				<select id="originalCategory" name="originalCategory"
					style="display: inline; margin-left: 15px;">
					<c:forEach var="originalCategory" items="${categoryList }">
						<option value="${originalCategory.boardCategoryNo }" 
							<c:if test="${category eq originalCategory.boardCategoryNo}">selected</c:if>>${originalCategory.boardCategoryName }</option>
					</c:forEach>
				</select>
			</div>
			<!-- End .sidebar -->
			<div>
				<h4 style="margin-top: 40px;">제목</h4>
			</div>
			<div class="input-group">
				<input class="form-control" placeholder="제목을 입력해주세요." name="boardTitle"
					id="boardTitle" type="text">
			</div>
			<div>
				<h4 style="margin-top: 40px;">내용</h4>
			</div>
			<div class="input-group">
				<textarea class="form-control" placeholder="내용을 입력해주세요."
					name="boardContent" id="boardContent" rows="10" style="width: 100%;"></textarea>
			</div>

			<div>
				<h4 style="margin-top: 40px;">이미지 파일</h4>
			</div>
			<div class="mb-3 mt-3">
				<label for="upFile" class="form-label" style="font-size: 16px;">첨부이미지:</label>
				<div class="originUploadFiles" style="left: 20px;">업로드할 파일을 드래그 앤 드롭하시오.</div>
				<div class="upFiles"></div>
			</div>
			<!-- 글쓰기 버튼을 누를때 같이 전송됨. -->
			<input type="hidden" name="csrfToken"
				value="${sessionScope.csrfToken }">
			<input type="hidden" name="uuid"
			value="${loginCustomer.uuid } ">
			<div class="input-group-addon">
<button type="submit" class="btn btn-primary" id="btn" style="border: 0px; display: inline-block;">글쓰기</button>
<button type="reset" value="취소" class="btn btn-primary" id="cancelbtn" style="border: 0px; margin:20px;" onclick="window.location.href='/board/originalBoard'">취소</button>
			</div>


		</form>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>

	<!-- Plugins JS File -->
	<script src="/resources/assets/js/jquery.min.js"></script>
	<script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
	<script src="/resources/assets/js/jquery.waypoints.min.js"></script>
	<script src="/resources/assets/js/superfish.min.js"></script>
	<script src="/resources/assets/js/owl.carousel.min.js"></script>
	<!-- Main JS File -->
	<script src="/resources/assets/js/main.js"></script>
</body>
</html>