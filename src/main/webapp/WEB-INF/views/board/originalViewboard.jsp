<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/3dfa264fc9.js" crossorigin="anonymous"></script>
<title>게시글</title>
<!-- Favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
<script type="text/javascript">



$(document).ready(function(){
	
	

	$("button").click(function(event) { // .fa-heart 클래스를 가진 요소 대신에 모든 버튼 요소에 대한 클릭 이벤트를 지정
		 event.preventDefault(); // 이벤트의 기본 동작을 중지시킵니다.
		 
	    let message = ""; // 알림 메시지 초기화
	    if (this.id == 'like'){ // 좋아요 -> 안좋아요
	        $(this).removeClass("fa-solid").addClass("fa-regular");
	        $(this).attr("id","dislike"); // id를 'dislike'로 변경
	        sendBehavior("dislike"); // 좋아요를 취소했으므로 dislike로 동작을 보냄
	    } else if (this.id == 'dislike'){ // 안좋아요 -> 좋아요
	        $(this).removeClass("fa-regular").addClass("fa-solid");
	        $(this).attr("id","like"); // id를 'like'로 변경
	        sendBehavior("like"); // 좋아요를 추가했으므로 like로 동작을 보냄
	    }
	    if (message !== "") {
	        alert(message); // 알림 메시지가 비어있지 않으면 알림을 표시
	    }
	});
	
// 	$(".fa-heart").click(function() {
// 		alert(this.id);
// 		if (this.id == 'dislike'){ // 안좋아요 -> 좋아요
// 			$(this).removeClass("fa-regular").addClass("fa-solid");
// 			$(this).attr("id","like"); // uuid만 쓰면 가져오는거고 두번째를 쓰면 바꿔준다.
// 		} else if (this.id == 'like'){ // 좋아요 -> 안좋아요
// 			$(this).removeClass("fa-solid").addClass("fa-regular");
// 			$(this).attr("id","dislike");
// 		}
		
// 		sendBehavior(this.id);
// // 		getAllReplies();
// 	});	
		
		
	
	var formobj = $("form[name='readform']");
	// 수정
	$(".btn_edit").on("click", function(){
		formobj.attr("action", "/board/originEditboard");
		formobj.attr("method", "POST");
		formobj.submit();		
	})
	
})

	$(function() {
		$(".closeModal").click(function() {
			$("#delModal").hide();
		});
	});
	
	




//ReplyDelete 함수 정의
function ReplyDelete(boardNo, replyNo) {
    let replyId = '${sessionScope.loginCustomer.uuid}'; 
//     let boardNo = $('#boardNo').data('boardNo'); // 보드번호 가져오기
    
    $.ajax({
        url : 'deleteReply', 
        type : "POST", 
        data: { "replier" : replyId,
        		"boardNo" : boardNo,
        		"replyNo" : replyNo
        		}, 
        dataType : "text", 
        success : function(data) {
            console.log(data);
            if(data == "success") {
            	alert("댓글 삭제가 완료되었습니다.");
            }
           },
        error : function() {
//         	console.error(xhr.responseText); // 에러 상세 정보 확인
            alert("댓글 삭제 중 오류가 발생했습니다.");
        }
    });
}

// 	$(function() {
		
		
// 		let status = '${param.status}';
// 		if (status == 'noPermission') {
// 			alert("수정 권한이 없습니다");
// 		}

// <i class="fa-regular fa-heart" id="dislike"></i>
// <i class="fa-solid fa-heart" id="like"></i>	
		
		
// 	$(".fa-heart").click(function() {
// 		alert($(this).attr("id"));
// 		if ($(this).attr("id") == 'dislike'){ // 안좋아요 -> 좋아요
// 			$(this).removeClass("fa-regular").addClass("fa-solid");
// 			$(this).attr("id","like"); // id만 쓰면 가져오는거고 두번째를 쓰면 바꿔준다.
// 		} else if ($(this).attr("id") == 'like'){ // 좋아요 -> 안좋아요
// 			$(this).removeClass("fa-solid").addClass("fa-regular");
// 			$(this).attr("id","dislike");
// 		}
		
// 		sendBehavior($(this).attr("id"));
// 		getAllReplies();
// 	});	
		
		
		
// 	});

function sendBehavior (behavior) {
	let who = '${sessionScope.loginCustomer.uuid}';
	let boardNo = '${board.boardNo}';
// 	alert(who);
	if (who == '' || who == null){
		location.href="/customer/loginOpen?redirectUrl=originWriteboard?boardNo=${originWriteboard.boardNo}";
	} else {
		
		$.ajax({
			url : "/board/likedislike", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "post", // 통신 방식 (GET(읽음), POST(저장), PUT(수정), DELETE(삭제))
			data: {
				"who" : who,
				"boardNo" : boardNo,
				"behavior" : behavior
			},
			dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
			success : function(data) {
				console.log(data);
			if (data == 'success'){
				location.reload();
			}
		
			},
			error : function() {
// 				alert("error 발생");
			},
			complete : function() {
			},
		});
		
	}
	
	
	
}
	
	
	


// 	function procPostDate(date) {
// 		let postDate = new Date(date); // 댓글 작성일
// 		let now = new Date(); // 현재 날짜시간
		
// 		let diff = (now - postDate) / 1000; // 시간 차 (초 단위)
// // 		let diff = 3000;
// 		console.log(diff);
		
// 		let times = [
// 			{name: "일", time: 24 * 60 * 60},
// 			{name : "시간", time : 60 * 60},
// 			{name : "분", time : 60}
// 		]
		
// 		for (let val of times){
// 			let betweenTime = Math.floor(diff / val.time)
			
// 			console.log(val.time, diff, betweenTime);
			
// 			if (betweenTime > 0){
// 				if (diff > 24 * 60 * 60){ // 1일 이상이 지났다.
// 					return postDate.toLocaleString();
// 				}
				
// 				return betweenTime + val.name + "전";
// 			}
			
// 		}
		
// 		return "방금전";
// 	}
	
	
	
	
	function saveReplyBtn() {
		let parentNo = '${board.boardNo}';
		let replyText = $("#replyContent").val();
		let replier = '${sessionScope.loginCustomer.uuid}';

		let newReply = {
				"parentNo" : parentNo,
				"replyContent" : replyText,
				"replier" : replier
		}
		
		if (replier == ''){ // 로그인하지 않은 유저
			location.href='/customer/loginOpen?redirectUrl=originalViewBoard&boardNo=' + parentNo;
		} else {
			
		$.ajax({
			url : "originalReply", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "POST", // 통신 방식 (GET(읽음), POST(저장), PUT(수정), DELETE(삭제))
			data :  newReply, // 보낼 데이터
			dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
			success : function(data) {
				console.log(data);
				alert("댓글작성이 완료되었습니다");
				if(data == "success"){
					getAllReplies();
					$("#replyContent").val("");
					
				}
			},
			error : function() {
				alert("error 발생");
			},
			complete : function() {
			},
		});
		
	   }
		
	}
	
	
	//댓글관련
// 	function displayAllReplies(replies){
// 		output = '<ul class="list-group">';
// 		if (replies.length > 0) {
// 			$.each(replies, function(i, elt){
// 				output += `<li class="list-group-item">`;
// 				output += `<div class = 'replyText'>\${elt.replyText}</div>`;
// 				output += `<div class = 'replyInfo'><span class ='replier'>\${elt.replier}</span>`;
// 				let elapsedTime = procPostDate(elt.postDate)
// 				output += `<span class='postDate'>\${elapsedTime}</span></div>`;
				
// //	 			output += `<span class='postDate'>\${elt.postDate}</span></div>`;

// 				output += `<div class='btnIcons'><img src='../resources/images/modify.png'/>`;
// 				output += `<img src='../resources/images/delete.png'/></div>`;
// 				output += `</li>`;
// 			});
// 		}
// 		output += '</ul>';
// 		$(".allReplies").html(output);
		
// 	}
	

	
	function deleteCategory(boardNo) {
		$.ajax({
			url : "deleteCategory", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			type : "post", // 통신 방식 (GET(읽음), POST(저장), PUT(수정), DELETE(삭제))
			dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
			data : {
				"boardNo" : boardNo,
				},
			success : function(data) {
				console.log(data);
				alert("게시물이 삭제되었습니다.");
				window.location.href = "/board/originalBoard"; 
			},
			error : function() {
				alert("error 발생");
			},
			complete : function() {
			},
		});
	}
	

	
</script>
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
}
	.readLikeCnt{
		display: flex;
/* 		justify-content: space-between; */
	}
	.uploadedImage{
		display: flex;
		justify-content: flex-start;
		align-items: center;
		padding: 10px;
	}
	
	.btns{
		display: flex;
		justify-content: flex-end;
		align-items: center;
	}
	 
/* 	.btn{ */
/* 		margin: 10px; */
/* 	} */
	
	.btnIcons img{
		width : 25px;
	}
	
	.btnIcons {
		float: right;
		margin-right: 5px;
	}
	
	#replyText{
		margin: 20px;
		padding: 10px;
		background-color: #eee;
	}
	
	.replyInfo{
		display: flex;
		justify-content: space-between;
	}
	
	.fa-heart {
		color: red;
	}
	
</style>
</head>
<body>
	
	<c:if test="${param.status == 'noPermission' }">
		<script type="text/javascript">
			window.alert("No Permission");
		</script>
	</c:if>	
	
	<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
	<jsp:include page="../header.jsp"></jsp:include>

<%-- 	${requestScope.board } ${requestScope.upLoadFile } --%>

	<div class="container">
		<h3>게시판 글 조회</h3>
		<div class="readLikeCnt" >
			<div class="readCount">
				조회수<span class="badge bg-primary" style="font-size: 14px; width: 40px; height:20px;">${board.boardRead }</span>
			</div>
		
			<div class="likeCount" style="margin-left: 10px;">
				좋아요<span class="badge bg-info" style="font-size: 14px; width: 40px; height:20px;">${board.boardLike }</span>	
		</div>
				<select id="boardCategoryNo" name="originalCategory"
				disabled style="margin-left: 20px;">
					<c:forEach var="originalCategory" items="${categoryList }">
						<option value="${originalCategory.boardCategoryNo }"
							<c:if test="${board.originalCategory == originalCategory.boardCategoryNo}">selected</c:if>>${originalCategory.boardCategoryName }</option>
							
					</c:forEach>
				</select>
				
				
				
				<div>
<!-- 				<i class="fa-regular fa-heart" id="dislike"></i> -->
<!-- 				<i class="fa-solid fa-heart" id="like"></i> -->

			</div>
<%-- 		<div>${likePeople }</div> --%>



			</div>

		


		
		
		
		<div class="mb-3 mt-3">
			<label for="boardNo" class="form-label">글번호:</label> <input type="text"
				class="form-control" id="boardNo" value="${board.boardNo}"
				readonly>
		</div>

		<div class="mb-3 mt-3">
			<label for="writer" class="form-label">작성자:</label> <input
				type="text" class="form-control" id="uuid"
				value="${board.nickname }" readonly>
		</div>

		<div class="mb-3 mt-3">
			<label for="title" class="form-label">제목:</label> <input type="text"
				class="form-control" id="title" value="${board.boardTitle }" readonly>

		</div>


		<div class="mb-3 mt-3">
			<label for="content" class="form-label">내용:</label>
			<div style="width: 100%; font-size:20px;" id="content">${board.boardContent }</div>
<%-- 			<textarea rows="20" style="width: 100%" id="content" readonly>${board.boardContent }</textarea> --%>
		<%--<div id ="content">${requestScope.board.content }</div> --%>
			
		</div>
		
		<div>
			<label for="uploadFile" class="form-label">첨부 이미지:</label>
		<c:forEach var = "uf" items = "${upFileList}">
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${uf.thumbFileName != null }"> --%>
					<div class="uploadedImage">
							<img src="data:image/jpeg;base64,${uf.base64}" width="50%" id="uploadFile"/>	
					</div>				
<%-- 			</c:when> --%>
<%-- 			<c:otherwise> --%>
					
<%-- 					<a href="../resources/uploads/${uf.newFileName }" >${uf.newFileName }</a> --%>
					
<%-- 			</c:otherwise> --%>
<%-- 		</c:choose> --%>
		</c:forEach>
		
		
		</div>
		
		<c:if test="${requestScope.upLoadFile != null}">
			<div class="mb-3 mt-3">
				<label for="upFile" class="form-label">첨부이미지:</label> <img
					src="${contextPath}${requestScope.upLoadFile.newFileName }"/>
			</div>
			<div>
				<span>${requestScope.upLoadFile.originalFileName }</span>
			</div>
		</c:if>
		
		<!-- 		로그인한 유저가 작성자와 같으면 수정, 삭제버튼을 보여주고 -->
		<!-- 		로그인한 유저가 작성자와 같지않으면 수정, 삭제 disabled 시킨다. -->

	</div>
	<!-- 글 삭제를 위한 모달 -->
   <div class="modal" id="delModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Modal Heading</h4>
					<button type="button" class="btn-close closeModal" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
				 ${requestScope.OriginalBoardVO.boardNo }번글을 삭제할까요?
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" data-bs-dismiss="modal" onclick="deleteReply();">삭제</button>
					<button type="button" class="btn btn-danger closeModal" data-bs-dismiss="modal" style="background-color : red;
            border : 0px solid #ffffff;">취소</button>
				</div>

			</div>
		</div>
	</div>
	
	<!------------- 댓글 --------------->
		<div class="container">
		 <div class="row">
      		 <div class="col">
				<label for="replyText" class="form-label">댓글:</label>
				<input type="text" class="form-control mb-3" 
					id="replyContent"  placeholder="내용을 입력하세요." style="heigth: 300px;"></input>
			</div>
		  </div>
		</div>
		
		<div class="container">
		<div class="replyBtns mb-3 mt-3">
		<input type="hidden" name="boardNo" value= "${board.boardNo}">
		<button type="button" class="btn btn-info" onclick="saveReplyBtn();" style= "width: 150px;
    height: 40px;
    border: 0px;
    background-color: #198754;
    color : #ffffff">댓글달기</button>
    
    		
<!--  	boardNo번 글을 좋아요 한 사람의 경우, solid 하트로 보여주기 -->
			<c:set var="hasHeart" value="false"></c:set>
<c:forEach var="who" items="${likePeople}">
    <c:choose>
        <c:when test="${loginCustomer.uuid == who}">
            <button id="like" style="margin-left:10px; color: #ffffff; width: 100px; height: 40px; border:0px;  background-color: #ef837b;">좋아요 취소</button>
            <c:set var="hasHeart" value="true"></c:set>
        </c:when>
    </c:choose>
</c:forEach>    
<c:if test="${hasHeart == false}">
    <button id="dislike" style="margin-left:10px; color: #ffffff; width: 100px; height: 40px; border:0px;  background-color: #ef837b;">좋아요</button>
</c:if>
<%-- 	  		<c:set var="hasHeart" value="false"></c:set> --%>
<%-- 	  		<c:forEach var="who" items="${likePeople }"> --%>
<%-- 	  			<c:choose> --%>
<%-- 	  				<c:when test="${loginCustomer.uuid == who}"> --%>
<!-- 	  					<button class="fa-solid fa-heart" id="like" style="margin-left:10px; color: #424242;">좋아요</button> -->
<%-- 	  					<c:set var="hasHeart" value="true"></c:set> --%>
<%-- 	  				</c:when> --%>
<%-- 	  			</c:choose> --%>
	  			
<%-- 	  		</c:forEach>	 --%>
<%-- 	  		<c:if test="${hasHeart == false }"> --%>
<!-- 	  			<button class="fa-regular fa-heart" id="dislike" style="margin-left:10px; color: #424242;">좋아요 취소</button> -->
<%-- 	  		</c:if> --%>
            <button type="button" class="btn_edit" onclick="location.href='/board/originalEditboard?boardNo=${board.boardNo}'" style=
    "width: 150px;
    height: 40px;
    border: 0px;
    background-color: #198754;
    color : #ffffff;
    margin-left: 800px;"
            >수정</button>
            <button type="button" class="btn btn-success" data-bs-dismiss="modal" onclick="return deleteCategory('${board.boardNo}');" style="background-color : red;
            border : 0px solid #ffffff; margin-left:10px; margin-bottom:5px;">삭제</button>
			<button type="submit" class="btn_info" onclick="location.href='/board/originalBoard'" style="width:80px;
			height: 40px;
			border: 0px;
			margin-left:10px;">목록으로</button>
			
			<ul class="list-group" style="margin-top: 40px;">
				<c:forEach var ="reply" items="${replylist}">
					<li class="list-group-item" >
						<div class='replyText'>
						${reply.replyContent }
						</div>
						<div class='replyInfo'>
							<span class='replier' id="replier">${reply.nickname}</span>
						</div>
			<!-- 댓글삭제 버튼 -->
						<div class="modal-header">
							<button type="button" class="btn btn-primary"
								onclick="ReplyDelete(${reply.boardNo},${reply.replyNo });" style="background-color : red;
            border : 0px solid #ffffff;">댓글 삭제</button>
						</div>
					</li>
				</c:forEach>
		</ul>
	</div>
		</div>


	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>