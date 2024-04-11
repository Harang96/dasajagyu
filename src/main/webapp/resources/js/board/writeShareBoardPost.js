$('.summernote').summernote({
 	height: 600,
  	lang: "ko-KR",
  	toolbar: [
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['height', ['height']],
			    ['insert',['picture','link','video']],
			    ['view', ['help']]
			  ],
	fontNames: ['sans-serif', 'Poppins', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'],
	fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
});

if (readCookie("writeFail")) {
	alert("글 작성에 실패했습니다.");
	removeCookie("writeFail");
}

$("#contentInput").on("input", function() {
	let len = $("#contentInput").val().length;
	let maxLen = 600;
	
	if (len > maxLen) {
		$("#contentInput").val($("#contentInput").val().slice(0, maxLen));
		alert("게시글은 600자까지 작성 가능합니다.");
	}
});

function checkBlank(e) {
	let title = $("#postTitleInput").val().length;
	let content = $("#contentInput").val().length;
	
	if (title == 0) {
		alert("제목을 입력해주세요.");
		e.preventDefault();
	} else if (content == 0) {
		alert("내용을 입력해주세요.");
		e.preventDefault();
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