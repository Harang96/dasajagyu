<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions"%> <%@ taglib prefix="sql"
uri="http://java.sun.com/jsp/jstl/sql"%> <%@ taglib prefix="x"
uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>찜목록</title>
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
    <link
      rel="shortcut icon"
      href="/resources/assets/images/icons/favicon.ico"
    />
    <meta name="apple-mobile-web-app-title" content="Molla" />

    <meta name="application-name" content="Molla" />
    <meta name="msapplication-TileColor" content="#cc9966" />
    <meta
      name="msapplication-config"
      content="/resources/assets/images/icons/browserconfig.xml"
    />
    <meta name="theme-color" content="#ffffff" />
    <!-- Plugins CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css" />
    <!-- Main CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/style.css" />
    <link
      rel="stylesheet"
      href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css"
    />
    <link
      rel="stylesheet"
      href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css"
    />
    <link
      rel="stylesheet"
      href="/resources/assets/css/plugins/nouislider/nouislider.css"
    />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <c:set var="URL" value="${pageContext.request.requestURL}" />
    <head>
      <meta charset="UTF-8" />
      <title>글쓰기</title>
      <link
        href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
        rel="stylesheet"
      />
      <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css"
      />
      <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/board/writeShareBoardPost.css"
      />
    </head>
    <style>
      .table-wishlist {
        background-color: red;
      }
      input[type="number"]::-webkit-inner-spin-button,
      input[type="number"]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
      }
      input[type="number"] {
        -moz-appearance: textfield;
      }
    </style>
  </head>
  <body>
    <div class="page-wrapper">
      <jsp:include page="../header.jsp"></jsp:include>
      
      
<main class="main mainFontStyle">
    	<div class="page-header text-center">
        <!-- <div class="page-header text-center" style="background-image: url('assets/images/page-header-bg.jpg')"> -->
            <div class="container">
                <h1 class="page-title">새 ${svType.toUpperCase() } 작성</h1>
            </div><!-- End .container -->
        </div><!-- End .page-header -->
        <nav aria-label="breadcrumb" class="breadcrumb-nav">
            <div class="container">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="/">홈</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="/">고객 서비스</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">새 ${svType.toUpperCase() } 작성</li>
                </ol>
            </div><!-- End .container -->
        </nav><!-- End .breadcrumb-nav -->
        <div class="page-content">
            <div class="container">
                <div class="row">
                    <div class="form-tab">
                        <div class="tab-content" id="tab-content-5">
                            <div class="tab-pane fade show active" id="agree" role="tabpanel" aria-labelledby="agree-tab">
                                <div class="form-group">
                                    <div id="termsStyle" class="col privacy">
                                        <div>
                                            <!--다사자규 서비스 이용약관-->
                                            <div class="agreed_txt_wrap">
																								<form action="write" method="post" id="submitForm">
													                        <input type="hidden" name="svType" value="${svType }" />
													                        <input
													                          type="hidden"
													                          name="uuid"
													                          value="${sessionScope.loginCustomer.uuid }"
													                        />
													                        <input
													                          type="hidden"
													                          name="commentBoardNo"
													                          value="${commentBoardNo }"
													                        />
													                        <input
													                          type="hidden"
													                          name="nickname"
													                          value="${sessionScope.loginCustomer.nickname }"
													                        />
													                        <table id="infoTable">
													                          <colgroup>
													                            <col style="width: 9%" />
													                            <col style="width: 25%" />
													                            <col style="width: 8%" />
													                            <col style="width: 25%" />
													                            <col style="width: 8%" />
													                            <col style="width: 25%" />
													                          </colgroup>
													                          <tr>
													                            <td id="postTitle" class="postTag">글 제목</td>
													                            <td id="postTitleInputTd" colspan="6">
													                              <input
													                                id="postTitleInput"
													                                type="text"
													                                name="svBoardTitle"
													                                style="width: 100%"
													                              />
													                            </td>
													                          </tr>
													                          <tr>
													                            <td class="postTag">작성자</td>
													                            <td id="postWriterInputTd">
													                              ${sessionScope.loginCustomer.nickname }
													                            </td>
													                            <td class="postTag">주문번호</td>
													                            <td id="postOrderNoInputTd">
													                              <input
													                                id="postOrderNoInput"
													                                type="text"
													                                name="orderNo"
													                                value=""
													                                style="width: 100%"
													                              />
													                            </td>
													                            <td class="postTag">상품번호</td>
													                            <td id="postProductNoInputTd">
													                              <input
													                                id="postProductNoInput"
													                                type="number"
													                                name="productNo"
													                                value=""
													                                style="width: 100%"
													                              />
													                            </td>
													                          </tr>
													
													                          <tr>
													                            <td class="postTag">비공개</td>
													                            <td id="postHiddenYnInputTd">
													                              <input
													                                id="postHiddenYnInput"
													                                type="checkbox"
													                                name="svIsHidden"
													                              />
													                            </td>
													                            <c:if test="${commentBoardNo ne null }">
													                              <td class="postTag">대상 게시글 번호</td>
													                              <td id="postCommentBoardNoInputTd">
													                                ${commentBoardNo }
													                              </td>
													                            </c:if>
													                          </tr>
													                        </table>
													                        <textarea
													                          class="summernote"
													                          name="svBoardContent"
													                          id="contentInput"
													                        ></textarea>
													                        <table id="infoTable2"></table>
													
													                        <div id="savePostBtnBox">
													                          <button id="savePostBtn" onclick="submitWrite()">
													                            작성
													                          </button>
<!-- 													                          <button id="resetPostBtn" onclick="cancelWrite()"> -->
<!-- 													                            취소 -->
<!-- 													                          </button> -->
													                        </div>
													                      </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- End .container -->
            </div><!-- End .page-content -->
        </div>
    </main><!-- End .main -->

      <jsp:include page="../footer.jsp"></jsp:include>
    </div>

    <!-- summernote 관련 스크립트 -->
    <!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
    <script
      src="https://kit.fontawesome.com/256bd7c463.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
    <script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/board/writeShareBoardPost.js"></script>

    <script type="text/javascript">
      $(function () {
        // active 클래스 초기화
        $.each($("aside .nav-link"), function (i, nav) {
          $(nav).attr("class", "nav-link");
        });

        $("#tab-review-link").addClass("active");
      });

      function submitWrite() {
        if (confirm($("[name=svType]").val()+"를 등록하시겠습니까?")) {
          $("#submitForm").submit();
        }
      }
      function cancelWrite() {
        if (confirm($("[name=svType]").val()+"를 등록 취소하시겠습니까?")) {
          location.href = "/contact/" + $("[name=svType]").val();
        }
      }
    </script>
  </body>
</html>
