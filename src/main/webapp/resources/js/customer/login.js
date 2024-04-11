$(function() {
	$("#lEmail").on("blur", function() {
		loginEmailCheck();
	});
	
	$("#lPassword").on("blur", function() {
		loginPasswordCheck();
	});
	
	$("#loginBtn").on("click", function() {
		if (loginPasswordCheck()) {
			event.preventDefault();
			$("#lPassword").focus();
		}
		
		if (loginEmailCheck()) {
			event.preventDefault();			
			$("#lEmail").focus();
		}
		
	});
	
	
});

function loginEmailCheck() {
	let result = false;
	
	let email = $("#lEmail");
	
	if (email.val() == "") {
		email.attr("placeholder", "이메일을 입력해주세요.");
		result = true;
	}
	
	$("#loginFailMsg").html("");
	
	return result;
}

function loginPasswordCheck() {
	let result = false;
	
	let password = $("#lPassword");
	
	if (password.val() == "") {
		password.attr("placeholder", "비밀번호를 입력해주세요.");
		result = true;
	}
	
	return result;
}

function savePathToKakao() {
	let path = location.href;
	let returnPath = path.split("path=")[1].split(";")[0]; 
	let encodedPath = decodeURIComponent(returnPath);
	
	addCookie(encodedPath);
}

function addCookie(returnPath) {
	let returnCook = "";
	let now = new Date();
	now.setDate(now.getYear() + 1);
	returnCook = "kakaoPath=" + returnPath + ";expires=" + now.toUTCString() + ";path=/";

	document.cookie = returnCook;
}