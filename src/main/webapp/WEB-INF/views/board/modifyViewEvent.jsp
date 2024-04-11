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
<!-- Favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
<title>수정</title>
<script type="text/javascript">
	
	$(function(){
			
		$(".upFileArea").on("dragenter dragover", function(evt) {
		    evt.preventDefault(); // 기본 동작 방지
		});

		$(".upFileArea").on("drop", function(evt) {
		    evt.preventDefault(); // 기본 동작 방지

		    console.log(evt.originalEvent.dataTransfer.files);
		    let files = evt.originalEvent.dataTransfer.files;

		    let form = new FormData(); // 파일을 보낼 FormData 객체 생성
		    for (let i = 0; i < files.length; i++) {
		        form.append("uploadFile", files[i]); // 전송할 데이터 추가
		    }
				
				$.ajax({
					url : "uploadFile", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
					type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
					data : form , // 데이터 보내기
					dataType : "json", // 수신받을 데이터 타입 (MINE TYPE)
					processData : false, // text데이터에 대해서 쿼리스트링 처리를 하지 않겠다.
					contentType : false, // application/x-www-form-urlencoded 처리하지 않음.
					//async : false, // 동기 통신 방식으로 하곘다. (default : true 비동기)
					success : function(data) {
						// 통신이 성공하면 수행할   함수
							console.log(data);
							if (data != null) {
								displayUploadedFile(data);
								$(".upFileArea").css("display","none");
							}
						
					},
					error : function() {},
					complete : function() {},
				});
						
		});
		

// 		$(".upFileArea").on("dragenter dragover", function(evt) {
// 		    evt.preventDefault(); // 기본 동작 방지
// 		});

// 		$(".upFileArea").on("drop", function(evt) {
// 		    evt.preventDefault(); // 기본 동작 방지

// 		    console.log(evt.originalEvent.dataTransfer.files);
// 		    let files = evt.originalEvent.dataTransfer.files;

// 		    let form = new FormData(); // 파일을 보낼 FormData 객체 생성
// 		    for (let i = 0; i < files.length; i++) {
// 		        form.append("uploadFile", files[i]); // 전송할 데이터 추가
// 		    }
				
// 				$.ajax({
// 					url : "modifyuploadFile", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
// 					type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
// 					data : form , // 데이터 보내기
// 					dataType : "json", // 수신받을 데이터 타입 (MINE TYPE)
// 					processData : false, // text데이터에 대해서 쿼리스트링 처리를 하지 않겠다.
// 					contentType : false, // application/x-www-form-urlencoded 처리하지 않음.
// 					//async : false, // 동기 통신 방식으로 하곘다. (default : true 비동기)
// 					success : function(data) {
// 						// 통신이 성공하면 수행할   함수
// 							console.log(data);
// 							if (data != null) {
// 								displayUploadedFile(data);
// 								$(".upFileArea").css("display","none");
// 							}
						
// 					},
// 					error : function() {},
// 					complete : function() {},
// 				});
						
// 		});
		
		
		// 디테일이미지
		$(".detailUpFileArea").on("dragenter dragover", function(evtt) {
		    evtt.preventDefault(); // 기본 동작 방지
		});

		$(".detailUpFileArea").on("drop", function(evtt) {
		    evtt.preventDefault(); // 기본 동작 방지

		    console.log(evtt.originalEvent.dataTransfer.files);
		    let files = evtt.originalEvent.dataTransfer.files;

		    let form = new FormData(); // 파일을 보낼 FormData 객체 생성
		    for (let i = 0; i < files.length; i++) {
		        form.append("uploadFile", files[i]); // 전송할 데이터 추가
		    }
				
				$.ajax({
					url : "detailUploadFile", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
					type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
					data : form , // 데이터 보내기
					dataType : "json", // 수신받을 데이터 타입 (MINE TYPE)
					processData : false, // text데이터에 대해서 쿼리스트링 처리를 하지 않겠다.
					contentType : false, // application/x-www-form-urlencoded 처리하지 않음.
					//async : false, // 동기 통신 방식으로 하곘다. (default : true 비동기)
					success : function(data) {
						// 통신이 성공하면 수행할   함수
							console.log(data);
							if (data != null) {
								displayDetailUploadedFile(data);
								
							}
						
					},
					error : function() {},
					complete : function() {},
				});
						
		});
		
		
	});
	
	function displayUploadedFile(json) {
		let output = "";
		
		$.each(json, function(i, elt) {
			let name = elt.newImgname.replaceAll("\\", "/");
// 			console.log("newImgname: " + name);
			
			if (elt.newImgname != null) { // 이미지
				let thumb = elt.newImgname
				output += `<img src='data:image;base64,\${elt.imgUrl}' id='\${elt.originalImgname}' style='
				    width: 50px';/>`;
				output += `<img src='../resources/event/images/remove.png' class='remIcon' onclick='remFile(this)'/>`;
			} else { // 이미지가 아닌 경우
				output += `<a href='../resources/event/images/${name}'>\${elt.originalImgname}</a>`;
				output += `<img src='../resources/event/images/remove.png' class='remIcon'/>`;
			}
			
		});
		
		$(".upLoadFiles").html(output);
		
	}
	
	

function displayDetailUploadedFile(json) {
	let output = "";
	
	$.each(json, function(i, elt) {
		let name = elt.newImgname.replaceAll("\\", "/");
// 			console.log("newImgname: " + name);
		
		if (elt.newImgname != null) { // 이미지
			let thumb = elt.thumbFileName
			
			output += `<img src='data:image;base64,\${elt.imgUrl}' id='\${elt.originalImgname}' style='
			    width: 50px';/>`;
			output += `<img src='../resources/event/images/remove.png' class='remIcon' onclick='remDetailFile(this)'/>`;
		} else { // 이미지가 아닌 경우
			output += `<a href='../resources/event/images/${name}'>\${elt.originalImgname}</a>`;
			output += `<img src='../resources/event/images/remove.png' class='remIcon'/>`;
		}
		
	});
	
	$(".detailUpLoadFiles").html(output);
	
}

	
	function remFile(fileId) {
		console.log(fileId);
		let removeFile = $(fileId).prev().attr('id'); // 삭제할 파일의 originalName
		console.log(removeFile)
		
		$.ajax({
			url : "remFile", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "GET", // 통신 방식 (GET, POST, PUT, DELETE)
			data : {
				"removeFile" : removeFile
			} , // 데이터 보내기
			dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
			success : function(data) {
				// 통신이 성공하면 수행할   함수
					console.log(data);
				 if (data == 'success'){
					 $(fileId).prev().remove();
					 $(fileId).remove();
					 $(".upFileArea").css("display","block");
				 }	
				
			},
			error : function() {},
			complete : function() {},
		});
		
		
	}
	
	

	
	
	function remDetailFile(fileId) {
		console.log(fileId);
		let removeFile = $(fileId).prev().attr('id'); // 삭제할 파일의 originalName
		console.log(removeFile)
		
		$.ajax({
			url : "remDetailFile", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "GET", // 통신 방식 (GET, POST, PUT, DELETE)
			data : {
				"removeFile" : removeFile
			} , // 데이터 보내기
			dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
			success : function(data) {
				// 통신이 성공하면 수행할   함수
					console.log(data);
				 if (data == 'success'){
					 $(fileId).prev().remove();
					 $(fileId).remove();
				 }	
				
			},
			error : function() {},
			complete : function() {},
		});
		
		
	}
	
	
	function btnCancel(fileId) {
		// 취소버튼 클릭시 드래그드랍한 모든 파일 삭제
		
		$.ajax({
			url : "remAllFile", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "GET", // 통신 방식 (GET, POST, PUT, DELETE)
			dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
			success : function(data) {
				// 통신이 성공하면 수행할   함수
				console.log(data);
				location.href = "eventBoard";
				
			},
			error : function() {},
			complete : function() {},
		});
	}
		
function checkOnlyOne(element) {
	const checkboxes = document.getElementsByName("eventperiod");
	
	checkboxes.forEach((cb) => {
		    cb.checked = false;
		  })
		  
		  element.checked = true;
}

function toggleEventPeriod() {
    let startDateInput = document.getElementById('startDate');
    let endDateInput = document.getElementById('endDate');
    let alwaysCheckbox = document.getElementById('always');
    let eventPeriodLabel = document.getElementById('eventPeriodLabel');
    let alwaysCheckedInput = document.getElementById('alwaysChecked');

    if (alwaysCheckbox.checked) {
        startDateInput.disabled = true;
        endDateInput.disabled = true;
        eventPeriodContainer.style.display = 'none'; 
        startDateInput.value = "상시";
        endDateInput.value = "상시";
        eventPeriodLabel.style.color = 'gray'; 
        alwaysCheckedInput.value = "true"; 
    } else {
        startDateInput.disabled = false;
        endDateInput.disabled = false;
        eventPeriodContainer.style.display = 'block'; 
        startDateInput.value = ""; 
        endDateInput.value = ""; 
        eventPeriodLabel.style.color = ''; 
        alwaysCheckedInput.value = "false"; 
    }
    
}

window.onload = function() {
    setAlwaysCheckboxState();
};

// '상시' 체크박스 상태 설정 함수
function setAlwaysCheckboxState() {
    let startDateInput = document.getElementById('startDate');
    let endDateInput = document.getElementById('endDate');
    let alwaysCheckbox = document.getElementById('always');

    if (startDateInput.value === "3010-03-26T00:00" && endDateInput.value === "3010-03-26T00:00") {
        alwaysCheckbox.checked = true;
        eventPeriodContainer.style.display = 'none'; 
    } else {
        alwaysCheckbox.checked = false;
    }
}


</script>
<style type="text/css">
.upFileArea {
	width: 100%;
	height: 100px;
	border: 1px dotted #333;
	font-weight: bold;
	color: green;
	background-color: #eff9f7;
	text-align: center;
	line-height: 100px;
}

.detailUpFileArea {
	width: 100%;
	height: 100px;
	border: 1px dotted #333;
	font-weight: bold;
	color: green;
	background-color: #eff9f7;
	text-align: center;
	line-height: 100px;
}

.remIcon {
	width: 30px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<div class="container">
		<h1>게시글 수정</h1>
				<form action="modifyEvent" method="post" enctype="multipart/form-data">

		
		
		<div class="mb-3 mt-3">
			<label for="title" class="form-label">제목:</label> <input type="text"
				class="form-control" id="title" name="title"
				value="${eventDetail.title}">
		</div>
		<input type="hidden" class="form-control" id="eventNo" name="eventNo"
				value="${eventDetail.eventNo }">
				
		<div class="mb-3 mt-3" id="eventPeriodContainer">
			<label for="datetime">이벤트기간: <br> <input
				type="datetime-local" id="startDate" name="startDate"
				max="3010-06-20T21:00" min="2007-06-05T12:30"
				value="${eventDetail.startDate}">&emsp; ~
			</label> &emsp; <label for="datetime"> <br> <input
				type="datetime-local" id="endDate" name="endDate"
				max="3010-06-20T21:00" min="2007-06-05T12:30"
				value="${eventDetail.endDate}">
			</label> <br />
		</div>
		<input type="checkbox" id="always" name="eventperiod" 
					onclick='toggleEventPeriod()'/> 상시

		
		<div class="mb-3 mt-3">
			<label for="upFile" class="form-label">메인이미지:</label>
			<div class="upFileArea">업로드할 파일을 드래그앤드랍해 보세요</div>
			<div class="upLoadFiles" style="">
			<c:forEach var="img" items="${imgList}">
			<c:if test="${img.eventimgIdentify == 1}">
					<div class="upLoadFiles">
						<img src="data:image;base64,${img.imgUrl}" 
							id="${img.originalImgname}" style="width: 50px;"> <img
							src="../resources/event/images/remove.png" class="remIcon imgDeleteBtn"
							onclick="remFile(this)">
							<input type="hidden" class="form-control" id="eventimgNo" name="eventimgNo"
									value="${img.eventimgNo}" >	
					</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		
		<div class="mb-3 mt-3">
			<label for="upFile" class="form-label">상세이미지:</label>
			<div class="detailUpFileArea">업로드할 파일을 드래그앤드랍해 보세요</div>
			<div class="detailUpLoadFiles">
				<c:forEach var="img" items="${imgList}">
				<c:if test="${img.eventimgIdentify == 2}">
					<div class="detailUpLoadFiles">
						<img src="data:image;base64,${img.imgUrl}" 
							id="${img.originalImgname}" style="width: 50px;"> <img
							src="../resources/event/images/remove.png" class="remIcon"
							onclick="remDetailFile(this)">
					</div>
				  </c:if>
				</c:forEach>
			</div>

		</div>



		<div class="mb-3 mt-3">
			<label for="content" class="form-label">내용:</label>
			<textarea rows="20" style="width: 100%" id="content" name="content">${eventDetail.content}</textarea>
		</div>

		
		<button type="submit" class="btn btn-success">수정</button>
		<button type="button" class="btn btn-danger" onclick="btnCancel()">취소</button>

				</form>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>