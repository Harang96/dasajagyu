$(function () {
  if (readCookie("adminStatus") != "") {
  	removeCookie("adminStatus");
  	
  	alert("관리자 페이지는 관리자만 접근할 수 있습니다.");
  }

  let thisPath = location.href;
  if (thisPath.includes("loginOpen")) {
    $("#loginHrefBox").hide();
  }

  if (thisPath.includes("/order?")) {
    $("#loginHrefBox").hide();
    $(".top-menu li").hide();
  }

  if (readCookie("autoLogin") != "") {
    let sessionKey = readCookie("autoLogin");
    $.ajax({
      url: "/customer/sessionCheck",
      type: "get",
      dataType: "text",
      async: false,
      success: function (data) {
        if (data == "") {
          let path = location.href;
          let returnPath = path.match(/\/\/[^\/]*(\/.*)/)[1];
  		  let encodedReturnPath = encodeURIComponent(returnPath);
  		  
          location.href = "/customer/autoLogin?path=" + encodedReturnPath + "&sessionKey=" + sessionKey;
        }
      },
      error: function () {},
      complete: function () {},
    });
  }
});

function saveReturnPath(obj) {
  let path = location.href;
  let returnPath = path.match(/\/\/[^\/]*(\/.*)/)[1];
  let encodedReturnPath = encodeURIComponent(returnPath);
  let href = $(obj).attr("href");
  
  location.href = href + "?path=" + encodedReturnPath;
}

function readCookie(searchName) {
  let cook = document.cookie;

  let cookArr = cook.split("; ");

  let value = "";
  for (let i = 0; i < cookArr.length; i++) {
    let cookName = cookArr[i].split("=")[0];
    if (cookName.trim() == searchName) {
      value = cookArr[i].split("=")[1];
    }
  }

  return value;
}

function getReturnPath() {
  let tmpPath = location.href;
  let returnPath = tmpPath.match(/\/\/[^\/]*(\/.*)/)[1];
  let encodedReturnPath = encodeURIComponent(returnPath);
  
  return encodedReturnPath;
}

function savePathToKakaoLogout() {
	let tmpPath = location.href;
	let returnPath = tmpPath.match(/\/\/[^\/]*(\/.*)/)[1]; 
	
	addCookieLogout(returnPath);
	
	location.href="https://kauth.kakao.com/oauth/logout?client_id=fedfd31e6211b6353700f2d410a0c0d5&logout_redirect_uri=http://localhost:8081/customer/kakaoLogout";
}

function addCookieLogout(returnPath) {
	let returnCook = "";
	let now = new Date();
	now.setDate(now.getYear() + 1);
	returnCook = "kakaoLogoutPath=" + returnPath + ";expires=" + now.toUTCString() + ";path=/";

	document.cookie = returnCook;
}

function removeCookie(cookieName) {
	let returnCook = "";
	let now = new Date();
	cook = cookieName + "=;expires=" + now.toUTCString() + ";path=/";

	document.cookie = cook;
}
