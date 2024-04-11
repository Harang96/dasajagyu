<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions"%> <%@ taglib prefix="sql"
uri="http://java.sun.com/jsp/jstl/sql"%> <%@ taglib prefix="x"
uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html lang="KO">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Exception</title>
    <meta name="keywords" content="HTML5 Template" />
    <meta name="description" content="Molla - Bootstrap eCommerce Template" />
    <meta name="author" content="p-themes" />
    <meta name="keywords" content="HTML5 Template" />
    <meta name="description" content="Molla - Bootstrap eCommerce Template" />
    <meta name="author" content="p-themes" />
    <!-- Favicon -->
    <link
      rel="apple-touch-icon"
      sizes="180x180"
      href="/resources/assets/images/icons/apple-touch-icon.png"
    />
    <link
      rel="icon"
      type="image/png"
      sizes="32x32"
      href="/resources/assets/images/icons/favicon-32x32.png"
    />
    <link
      rel="icon"
      type="image/png"
      sizes="16x16"
      href="/resources/assets/images/icons/favicon-16x16.png"
    />
    <link rel="manifest" href="/resources/assets/images/icons/site.html" />
    <link
      rel="mask-icon"
      href="/resources/assets/images/icons/safari-pinned-tab.svg"
      color="#666666"
    />
    <link rel="shortcut icon" href="/resources/assets/images/icons/favicon.ico" />
    <meta name="apple-mobile-web-app-title" content="Molla" />
    <meta name="application-name" content="Molla" />
    <meta name="msapplication-TileColor" content="#cc9966" />
    <meta name="msapplication-config" content="/resources/assets/images/icons/browserconfig.xml" />
    <meta name="theme-color" content="#ffffff" />
    <link
      rel="stylesheet"
      href="/resources/assets/vendor/line-awesome/line-awesome/line-awesome/css/line-awesome.min.css"
    />
    <!-- Plugins CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/jquery.countdown.css" />
    <link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/jquery.countdown.css" />
    <!-- Main CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/style.css" />
    <link rel="stylesheet" href="/resources/assets/css/skins/skin-demo-2.css" />
    <link rel="stylesheet" href="assets/css/demos/demo-2.css" />
    <link rel="stylesheet" href="/resources/assets/css/style.css" />
    <link rel="stylesheet" href="/resources/assets/css/skins/skin-demo-2.css" />
    <link rel="stylesheet" href="assets/css/demos/demo-2.css" />
    <style type="text/css">
      .exception * {
        font-family: "NanumSquareNeo-Variable" !important;
      }
      .exception {
        text-align: center;
      }
      .exception img {
        width: 4em;
      }
      .exception h1 {
        font-size: 3em;
        margin-bottom: 0;
        line-height: normal;
      }
      .exception h2 {
        font-size: 2em;
      }
      .exception h3 {
        font-size: 2em;
      }
      .exception .text-center img {
        display: block;
        margin: 0 auto;
      }
      .exception * {
        font-family: "NanumSquareNeo-Variable" !important;
      }
      .exception {
        text-align: center;
      }
      .exception img {
        width: 4em;
      }
      .exception h1 {
        font-size: 3em;
        margin-bottom: 0;
        line-height: normal;
      }
      .exception h2 {
        font-size: 2em;
      }
      .exception h3 {
        font-size: 2em;
      }
      .exception .text-center img {
        display: block;
        margin: 0 auto;
      }
    </style>
  </head>
  <body>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="exception">
      <div style="display: flex; justify-content: center; align-items: center; padding: 10px 50px">
        <img src="/resources/assets/images/icons/apple-touch-icon.png" />
        <h1>"피규어의 성지" 다사자규입니다.</h1>
      </div>
      <p class="text-center">
        <img
          width="96"
          height="96"
          src="https://img.icons8.com/emoji/96/sad-but-relieved-face.png"
          alt="sad-but-relieved-face"
        />
      </p>
      <div style="align-items: center; padding: 20px 0">
        <h2>죄송합니다. 예기치 않은 오류가 발생했습니다.</h2>
        <h3>잠시 후 다시 시도해 주십시오.</h3>
        <div>${errorMsg }</div>
        <h4>이용에 불편을 드려 대단히 죄송합니다.</h4>
        <p>추가적인 문제 발생 시 관리자에게 문의 바랍니다.</p>
      </div>
      <div class="errorStack">
        <a href="javascript:void(0)" id="showDetails">자세히...</a>
      </div>
      <c:forEach var="errorStack" items="${errorStack}">
        <div class="error" style="display: none; color: red">${errorStack}</div>
      </c:forEach>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
  </body>
  <!-- <script>
  </head>
  <body>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="exception">
      <div style="display: flex; justify-content: center; align-items: center; padding: 10px 50px">
        <img src="/resources/assets/images/icons/apple-touch-icon.png" />
        <h1>"피규어의 성지" 다사자규입니다.</h1>
      </div>
      <p class="text-center">
        <img
          width="96"
          height="96"
          src="https://img.icons8.com/emoji/96/sad-but-relieved-face.png"
          alt="sad-but-relieved-face"
        />
      </p>
      <div style="align-items: center; padding: 20px 0">
        <h2>죄송합니다. 예기치 않은 오류가 발생했습니다.</h2>
        <h3>잠시 후 다시 시도해 주십시오.</h3>
        <div>${errorMsg }</div>
        <h4>이용에 불편을 드려 대단히 죄송합니다.</h4>
        <p>추가적인 문제 발생 시 관리자에게 문의 바랍니다.</p>
      </div>
      <div class="errorStack">
        <a href="javascript:void(0)" id="showDetails">자세히...</a>
      </div>
      <c:forEach var="errorStack" items="${errorStack}">
        <div class="error" style="display: none; color: red">${errorStack}</div>
      </c:forEach>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
  </body>
  <!-- <script>
   document.addEventListener("DOMContentLoaded", function() {
       let showDetailsLink = document.getElementById('showDetails');
       showDetailsLink.addEventListener('click', function(event) {
           event.preventDefault(); // 링크의 기본 동작인 페이지 이동을 방지합니다.
           
           let errorDivs = document.querySelectorAll('.error');
           errorDivs.forEach(function(errorDiv) {
               errorDiv.style.display = 'block'; // 해당 에러 메시지를 보여줍니다.
           });
       });
   });
</script> -->
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      var showDetailsLink = document.getElementById("showDetails");
      var errorsVisible = false;
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      var showDetailsLink = document.getElementById("showDetails");
      var errorsVisible = false;

      showDetailsLink.addEventListener("click", function (event) {
        event.preventDefault(); // 링크의 기본 동작인 페이지 이동을 방지합니다.

        var errorDivs = document.querySelectorAll(".error");
        errorDivs.forEach(function (errorDiv) {
          if (errorsVisible) {
            errorDiv.style.display = "none"; // 에러 숨기기
          } else {
            errorDiv.style.display = "block"; // 에러 보이기
          }
        });
      showDetailsLink.addEventListener("click", function (event) {
        event.preventDefault(); // 링크의 기본 동작인 페이지 이동을 방지합니다.

        var errorDivs = document.querySelectorAll(".error");
        errorDivs.forEach(function (errorDiv) {
          if (errorsVisible) {
            errorDiv.style.display = "none"; // 에러 숨기기
          } else {
            errorDiv.style.display = "block"; // 에러 보이기
          }
        });

        // 에러 상태 반전
        errorsVisible = !errorsVisible;

        // 링크 텍스트 변경
        if (errorsVisible) {
          showDetailsLink.textContent = "간단히...";
        } else {
          showDetailsLink.textContent = "자세히...";
        }
      });
        // 에러 상태 반전
        errorsVisible = !errorsVisible;

        // 링크 텍스트 변경
        if (errorsVisible) {
          showDetailsLink.textContent = "간단히...";
        } else {
          showDetailsLink.textContent = "자세히...";
        }
      });
    });
  </script>
  </script>
</html>

