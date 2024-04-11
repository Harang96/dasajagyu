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
<title>작품별 게시판 수정</title>
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



#writeBoard {

height : 500px;
margin-bottom : 80px;

}

#imageBtn {

margin-bottom: 40px;

}

#cancelbtn{

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
$(function(){
	// 드래그
	$(".upFileArea").on("dragenter dragover", function (e){
		e.preventDefault(); // 진행중인 이벤트 버블링을 캔슬함.
	});
	
	// 드롭
	$(".upFileArea").on("drop", function (e){
		e.preventDefault(); // 진행중인 이벤트 버블링을 캔슬함.
		
		let files = e.originalEvent.dataTransfer.files;
		
		for(let file of files){
			let form = new FormData(); // form태그에서 데이터를 전송해주는 역할을 함.
			form.append("uploadFile", file); // 전송할 upload데이터를 하나씩 추가함. "uploadfile" 파일이름은 컨트롤러단의 MultipartFile매개변수명과 일치시켜야 한다. 
			
			console.log(form);
			
			
			sendData("uploadFile", "POST", form, "json", false);
		}
		
	});
	
});


// 업로드한 파일을 출력


function displayUploaedfile(data) {
	let output = "";
	
	$.each(data, function(i, elt){
		let name = elt.newFileName.replaceAll("\\", "/");
		
		if(elt.thumbFileName != null){ // 업로드한 파일이 이미지인 경우
			let thumb = elt.thumbFileName.replaceAll("\\", "/");
			output += `<div id="thumbnailObj\${i}" class="thumbnailObj">`; 
			output += `<img id="\${elt.originalFileName}" alt="" src="../resources/uploads/\${thumb}">`; // \${thumb} \는 el이 아니다라는 표시
			output += `<img class="rmBtn" alt="" src="../resources/img/remove.png" onclick="rmFile(this)">`;
			output += `</div>`;
			
		} else { // 업로드한 파일이 이미지가 아닌 경우
			output += `<a href="../resources/uploads/\${name}">\${elt.originalFileName}</a>`; // \${thumb} \는 el이 아니다라는 표시
		}
		
	})
	
	$(".uploadedFileArea").html(output);
}

</script>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="header-search-wrapper search-wrapper-wide">
		<nav aria-label="breadcrumb" class="breadcrumb-nav mb-2">
			<div class="container">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">다사자규</a></li>
					<li class="breadcrumb-item"><a href="#">커뮤니티</a></li>
					<li class="breadcrumb-item active" aria-current="page">작품별 게시판</li>
					<li class="breadcrumb-item"><a href="#">글쓰기</a></li>
				</ol>
			</div>
			<!-- End .container -->
		</nav>
		<!-- End .breadcrumb-nav -->
	</div>
	<div class="container">
		<form action="updateOriginalBoard" method="POST">
			<h4>카테고리 선택</h4>
						<!-- End .widget-title -->
						<!-- 폼태그가 시작하는 이곳 -->
			<select id="boardCategoryNo" name="originalCategory" style="display: inline; margin-left: 15px;"> 
				<c:forEach var="originalCategory" items="${categoryList }">
					<option value="${originalCategory.boardCategoryNo }"
						<c:if test="${board.originalCategory == originalCategory.boardCategoryNo}">selected</c:if>>${originalCategory.boardCategoryName }</option>
				</c:forEach>
			</select>
			<input type="hidden" name="boardNo" value="${board.boardNo }">
			<div>
				<h4 style="margin-top: 40px;">제목</h4>
			</div>
			<div class="input-group">
				<input class="form-control" placeholder="제목을 입력해주세요." name="boardTitle"
					id="boardTitle" type="text" value="${board.boardTitle }">
			</div>
			<div class="mb-3 mt-3">
				<h4>작성자</h4>
				<input type="text" class="form-control" id="uuid" value="${board.nickname }"  readonly>
			</div>
			<div>
				<h4>내용</h4>
			</div>
			<div class="input-group">
				<textarea class="form-control" placeholder="내용을 입력해주세요."
					name="boardContent" id="content" rows="10" style="width:100%;">${board.boardContent}</textarea>
			</div>

<!-- 			<div> -->
<!-- 				<h4>이미지 파일</h4> -->
<!-- 			</div> -->
<!-- 			<div class="mb-3 mt-3"> -->
<!-- 				<input type="file" class="form-control" placeholder="이미지 업로드" -->
<!-- 					id="originaluploadFile" name="originaluploadFile" multiple> -->
<!-- 				<div class="upFileArea">업로드할 파일을 드래그 앤 드롭하시오.</div> -->
<!-- 				<div class="uploadedFileArea"></div> -->
<!-- 			</div> -->

			<div class="container" style="margin-top:80px;">
				<div class="input-group-addon">
					<button type="submit" value="수정" class="btn btn-primary" id="btn" style="border: 0px; display: inline-block;  background-color: #198754;
    color : #ffffff; margin-right: 10px;">수정</button>
<button type="reset" value="취소" class="btn btn-primary" id="cancelbtn" style="border: 0px; margin:20px;" onclick="window.location.href='/board/originalBoard'">취소</button>
				</div>
			</div>
						<!-- 글쓰기 버튼을 누를때 같이 전송됨. -->
			<input type="hidden" name="csrfToken" value="${sessionScope.csrfToken }">
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