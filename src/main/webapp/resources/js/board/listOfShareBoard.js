$(function() {
	if (readCookie("pointSuccess")) {
		alert("글 작성으로 인한 50포인트가 지급되었습니다.");
		removeCookie("pointSuccess");
	}
	
	if (readCookie("writeSuccess")) {
		alert("글 작성이 완료되었습니다.");
		removeCookie("writeSuccess");
	}
	
	if (readCookie("getPostFail")) {
		alert("글을 불러오지 못했습니다.");
		removeCookie("getPostFail");
	}
	
	if (readCookie("deleteSuccess")) {
		alert("글이 삭제되었습니다.");
		removeCookie("deleteSuccess");
	}

	$(".writeTime").each(
		function(i, item) {
			if (i > 0) {
				let tmpWriteTime = $(item).html();
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
				$(item).html(writeTime);
			}
		}
	);
	
	$(".spanWriteTime").each(
		function(i, item) {
			let tmpWriteTime = $(item).html();
			let date = tmpWriteTime.split(" ")[0];
			
			$(item).html(date);
	});
});

function changeSearchType(obj) {
	let val = obj.value;
	
	$("#formSearchType").val(val);
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