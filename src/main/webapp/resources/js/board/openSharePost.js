let uuid = $("#loginCustomerUuid").val();
let boardNo = $("#postBoardNo").val();

$(function() {

	$(".replyInput").on("input", function() {
		let len = $(".replyInput").val().length;
		let maxLen = 300;
		
		if (len > maxLen) {
			$(".replyInput").val($(".replyInput").val().slice(0, maxLen));
			alert("댓글은 300자까지 작성 가능합니다.");
		}
	});
		
	if (readCookie("modifySuccess")) {
		alert("글 수정에 성공 하였습니다.");
		removeCookie("modifySuccess");
	}
	
	if (readCookie("deleteFail")) {
		alert("글 삭제에 실패했습니다.");
		removeCookie("deleteFail");
	}
	
	if (readCookie("openModifyFail")) {
		alert("글 수정을 불러오는 것에 실패했습니다.");
		removeCookie("openModifyFail");
	}

	if ($("#modifyDifference").val() == "diff") {
		alert("글의 작성자만 게시글을 수정할 수 있습니다.");
	}
	
	setTimeLocale();
	
	// 삭제 모달
	$(".close").click(function() {
		$("#deleteCheck").hide();
		$("#deleteReply").hide();
		$("#modifyReply").hide();
	});
	
	$("#deletePostBtn").click(function() {
		$("#deleteCheck").show();
	});
	
	// 좋아요 체크
	if (uuid != "") {
		checkLike(uuid, boardNo);
	}
	
	// 좋아요 기능
	$("#likeBtn").on("click", function() {
		setLike(uuid, boardNo);
	});
});

function setTimeLocale() {
	let tmpWriteTime = $("#writtenTime").val();
	let date = tmpWriteTime.split(" ")[0] + " ";
	let time = tmpWriteTime.split(" ")[1];
	
	let hour = time.split(":")[0];
	if (hour <= 12) {
		hour = "오전 " + hour + "시";
	} else {
		hour = "오후 " + (hour - 12) + "시";
	}
	
	let minute = time.split(":")[1] + "분";
	
	let writeTime = date + hour + minute;
	$("#writtenTime").val(writeTime);
}

function checkLike(uuid, boardNo) {
	$.ajax({
        url: "checkShareLike",
        type: "get",
        data: {"boardNo" : boardNo,
    		"uuid" : uuid
        },
        dataType: "text",
        async: false,
        success: function(data) {
        	if (data == "find") {
				$("#likeBtn").addClass("onLike");
        	}
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
}

function setLike(uuid, boardNo) {
	if ($("#likeBtn").hasClass("onLike")) { // 좋아요가 눌린 상태
		dislikePost(uuid, boardNo);
	} else { // 좋아요가 눌리지 않은 상태
		likePost(uuid, boardNo);
	}
}

function likePost(uuid, boardNo) {
	$.ajax({
        url: "likeSharePost",
        type: "get",
        data: {"boardNo" : boardNo,
    		"uuid" : uuid
        },
        dataType: "text",
        async: false,
        success: function(data) {
        	$("#likeCount").html(data);
        	$("#likeBtn").addClass("onLike");
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
}

function dislikePost(uuid, boardNo) {
	$.ajax({
        url: "dislikeSharePost",
        type: "get",
        data: {"boardNo" : boardNo,
    		"uuid" : uuid
        },
        dataType: "text",
        async: false,
        success: function(data) {
        	$("#likeCount").html(data);
        	$("#likeBtn").removeClass("onLike");
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
}

function writeReply(e, uuid) {
	let content = $("#replyInput").val();
	
	if (content.length == 0) {
		alert("내용을 입력해주세요.");
		e.preventDefault();
	} else {
		$.ajax({
	        url: "writeShareReply",
	        type: "post",
	        data: {"content" : content,
	        	"boardNo" : boardNo,
	    		"uuid" : uuid
	        },
	        dataType: "text",
	        async: false,
	        success: function(data) {
				if (data == "success") {
					$("#replyInput").val("");
					alert("댓글 작성이 완료되었습니다.");
					getReplyWithPage(1);
				}
	        },
	        error: function() {
	
	        },
	        complete: function() {
			
	        }
	   	});
   	}
}

function getReplyWithPage(pageNo) {
	$.ajax({
        url: "getShareReply",
        type: "post",
        data: {
        	"boardNo" : boardNo,
    		"pageNo" : pageNo
        },
        dataType: "json",
        async: false,
        success: function(data) {
			printPagingBtn(data);
			printReplyBody(data);
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
   	
   	return false;
}

function printPagingBtn(data) {
	let replyPaging = data.replyPaging;
	let begin = replyPaging.startNumOfCurrentPagingBlock;
	let end = replyPaging.startNumOfCurrentPagingBlock + 10;
	let result = "";
	
	result += `<li class="page-item">`;
    
	if (replyPaging.pageNo == 1 || replyPaging.pageNo == null || replyPaging.pageNo == '') {
  		result += `<a class="page-link page-link-prev ml-0 mr-0 disabled" href="#" aria-label="Previous" tabindex="-1" aria-disabled="true" onclick="return false;">처음으로</a>`;
	} else {
        result += `<a class="page-link page-link-prev ml-0 mr-0" href="#" onclick="return getReplyWithPage(1);" aria-label="Previous" tabindex="-1" aria-disabled="true">처음으로</a>`;
    }
	    
	if (replyPaging.pageNo == 1 || replyPaging.pageNo == null || replyPaging.pageNo == '') {
        result += `<a class="page-link page-link-prev ml-0 mr-0 disabled" href="#" aria-label="Previous" tabindex="-1" aria-disabled="true" onclick="return false;">이전</a>`;
	} else {
        result += `<a class="page-link page-link-prev ml-0 mr-0" href="#" onclick="return getReplyWithPage(${replyPaging.pageNo - 1 });" aria-label="Previous" tabindex="-1" aria-disabled="true">이전</a>`;
	}
	
    result += `</li>`;
    
	for (let page = begin; page < end; page++) {
        if (page <= replyPaging.totalPageCnt) {
    		if (replyPaging.pageNo == page || (replyPaging.pageNo == null && page == 1) || (replyPaging.pageNo == '' && page == 1)) {
    			result += `<li class="page-item ml-0 mr-0" aria-current="page"><a class="page-link" id="nowPage" href="#" style="color:coral;" onclick="return false;">${page }</a></li>`;
			} else {
    			result += `<li class="page-item ml-0 mr-0" aria-current="page"><a class="page-link" href="#" onclick="return getReplyWithPage(${page });">${page }</a></li>`;
			}
		}
	}
	
    result += `<li class="page-item">`;
    
	if (replyPaging.pageNo == replyPaging.totalPageCnt || replyPaging.totalPageCnt == 1) {
		result += `<a class="page-link page-link-next ml-0 mr-0 disabled" href="#" aria-label="Next" onclick="return false;">다음</a>`;
	} else {
		result += `<a class="page-link page-link-next ml-0 mr-0" href="#" onclick="return getReplyWithPage(${replyPaging.pageNo + 1 });" aria-label="Next">다음</a>`;
	}        
	
    if (replyPaging.pageNo == replyPaging.totalPageCnt || replyPaging.totalPageCnt == 1) {
		result += `<a class="page-link page-link-next ml-0 mr-0 disabled" href="#" aria-label="Next" onclick="return false;">끝으로</a>`;
    } else {
		result += `<a class="page-link page-link-next ml-0 mr-0" href="#" onclick="return getReplyWithPage(${replyPaging.totalPageCnt });" aria-label="Next">끝으로</a>`;
    }
    
    result += `</li>`;
    
    $(".pagination").html(result);
}

function printReplyBody(data) {
	let replies = data.postReply;
	let paging = data.replyPaging;
	let result = "";
	
	$.each(replies, function(i, item) {
		if (i >= paging.startRowIndex && i < paging.startRowIndex + 10) {
			let formattedDate = formatDate(item.replyDate);
			
			result += "<tbody class='replyBody'>";
			result += "<tr class='replyWriterTr'>";
			result += "<td class='replyWriterImgTd' rowspan='3'>";
			
			if (item.userImg != "" && item.userImg != null) {
				result += "<img class='replyWriterImg' src='" + item.userImg+ "'/>";
			} else {
				result += "<img class='replyWriterImg' src='/resources/assets/images/products/details/basic.png'></td>";
			}
			
			result += "<td class='replyWriterTd' colspan='2'>" + item.writer + "<input type='hidden' value='" + item.uuid + "'></td>";
			result += "</tr>";
			result += "<tr class='replyContentTr'>";
			result += "<td class='replyContentTd' colspan='2'>" + item.replyContent + "</td>";
			result += "</tr>";
			result += "<tr class='writeTimeTr'>";
			result += "<td class='writeTime'>" + formattedDate + "</td><td>";
			if (uuid == item.uuid) {
				result += `<button class="modifyReplyBtn" onclick="openModifyReply(${item.replyNo}, '${item.replyContent}');">수정</button>/<button class="removeReplyBtn" onclick="openRemoveModal(${item.replyNo});">삭제</button>`;
			}
			result += "</td></tr>";
			result += "</tbody>";
		}
	});

	$("#replyTable").html(result);
	$("#replyCount").html("(" + paging.totalPostCnt + "개)");
}

function formatDate(writeTimeStamp) {
	let writeTime = new Date(writeTimeStamp);
	let formattedDate = writeTime.getFullYear() + '-' + 
    ('0' + (writeTime.getMonth() + 1)).slice(-2) + '-' + 
    ('0' + writeTime.getDate()).slice(-2);
        
    return formattedDate;
}

function openRemoveModal(replyNo) {
	$("#removeModalReplyNo").val(replyNo);
	$("#deleteReply").show();
}

function removeReply() {
	let replyNo = $("#removeModalReplyNo").val();
	
	$.ajax({
        url: "removeShareReply",
        type: "post",
        data: {
        	"replyNo" : replyNo
        },
        dataType: "text",
        async: false,
        success: function(data) {
			if (data == "success") {
				alert("댓글이 삭제되었습니다.");
				$("#deleteReply").hide();
				getReplyWithPage(1);
			}
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
}

function openModifyReply(replyNo, content) {
	let pageNo = parseInt($("#nowPage").html());
	$("#modifyModalReplyNo").val(replyNo);	
	$("#modifyInput").val(content);
	$("#modifyReply").show();
}

function modifyReply(e) {
	let pageNo = parseInt($("#nowPage").html());
	let replyNo = parseInt($("#modifyModalReplyNo").val());
	let content = $("#modifyInput").val();
	
	if (content.length == 0) {
		alert("수정할 내용을 입력해주세요.");
	} else {
		$.ajax({
	        url: "modifyShareReply",
	        type: "post",
	        data: {
	        	"replyNo" : replyNo,
	        	"content" : content
	        },
	        dataType: "text",
	        async: false,
	        success: function(data) {
				if (data == "success") {
					alert("댓글이 수정되었습니다.");
					$("#modifyModalReplyNo").val("");
					$("#modifyInput").val("");
					$("#modifyReply").hide();
					getReplyWithPage(pageNo);
				}
	        },
	        error: function() {
	
	        },
	        complete: function() {
			
	        }
	   	});
	}
}

function readCookie(searchName) {
  let cook = document.cookie;
  let result = false;

  let cookArr = cook.split("; ");

  for (let i = 0; i < cookArr.length; i++) {
    let cookName = cookArr[i].split("=")[0];
    if (cookName.trim() == searchName) {
      result = true;
    }
  }

  return result;
}

function removeCookie(cookieName) {
	let returnCook = "";
	let now = new Date();
	cook = cookieName + "=;expires=" + now.toUTCString() + ";path=/";

	document.cookie = cook;
}

