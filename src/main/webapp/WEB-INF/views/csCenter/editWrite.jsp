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
    <title>게시글 수정</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script
      src="https://kit.fontawesome.com/256bd7c463.js"
      crossorigin="anonymous"
    ></script>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/board/modifySharePost.css"
    />
  </head>
  <body>
    <jsp:include page="../header.jsp"></jsp:include>
    
    
<main class="main mainFontStyle">
    	<div class="page-header text-center">
        <!-- <div class="page-header text-center" style="background-image: url('assets/images/page-header-bg.jpg')"> -->
            <div class="container">
                <h1 class="page-title">${svType.toUpperCase() }
                    <!-- <span>다사자규 이용약관</span> -->
                </h1>
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
                    <li class="breadcrumb-item active" aria-current="page">${svType.toUpperCase() } </li>
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
																							<form action="modify" method="post" id="modifyPostForm">
																								<input type="hidden" name="svBoardNo" value="${requestParam.svBoardNo }" /> <input type="hidden" name="svType" value="${svType }" /> <input type="hidden" value="${sessionScope.loginCustomer.uuid }" name="uuid" />
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
																										<td id="postTitleInputTd" colspan="6"><input id="postTitleInput" type="text" name="svBoardTitle" style="width: 100%" /></td>
																									</tr>
																									<tr>
																										<td class="postTag">작성자</td>
																										<td id="postWriterInputTd"><input id="postWriterInput" type="text" name="nickname" value="" readonly style="width: 100%" /></td>
																										<td class="postTag">주문번호</td>
																										<td id="postOrderNoInputTd"><input id="postOrderNoInput" type="text" name="orderNo" value="" style="width: 100%" /></td>
																										<td class="postTag">상품번호</td>
																										<td id="postProductNoInputTd"><input id="postProductNoInput" type="number" name="productNo" value="" style="width: 100%" /></td>
																									</tr>
											
																									<tr>
																										<td class="postTag">비공개</td>
																										<td id="postHiddenYnInputTd"><input id="postHiddenYnInput" type="checkbox" name="svIsHidden" /></td>
																									</tr>
																								</table>
																								<textarea class="summernote" name="svBoardContent" id="contentInput"></textarea>
																								<table id="infoTable2"></table>
											
																								<div id="savePostBtnBox">
																									<button id="savePostBtn" onclick="submitWrite()">작성</button>
<!-- 																									<button id="resetPostBtn" onclick="cancelWrite()">취소</button> -->
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
       				</div>
     				</div>
</main><!-- End .main -->
    
    <jsp:include page="../footer.jsp"></jsp:include>

    <script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
    <script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/board/modifyShareBoard.js"></script>
    <script type="text/javascript">
             $(function(){
      // active 클래스 초기화
      $.each($("aside .nav-link"), function(i, nav){
        $(nav).attr("class", "nav-link");
           });

           $("#tab-review-link").addClass("active");

                	let obj = ${post}
                	for(let i of Object.entries(obj)){
                	    console.log(i)

                	    if($("[name="+i[0]+"]").attr('id') == 'contentInput'){
                	        $(".note-editable").html(i[1])
                	    } else if($("[name="+i[0]+"]").attr('type') == 'checkbox'){
                	        if(i[1]) console.log($("[name="+i[0]+"]").attr('checked', true))
                	    } else {
                	    	$("[name="+i[0]+"]").val(i[1])
                	    }
                	}
              })

                function submitWrite() {
                	if(confirm($("[name=svType]").val()+"를 수정하시겠습니까?")){
                		$("#modifyPostForm").submit();
                	}
                }
                function cancelWrite() {
                	if(confirm($("[name=svType]").val()+"를 수정하시겠습니까?")){
                		location.href='/contact/'+$("[name=svType]").val();
                	}
                }
    </script>
  </body>
</html>
