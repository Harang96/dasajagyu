<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>개인정보 관리</title>
    <meta name="keywords" content="HTML5 Template">
    <meta name="description" content="Molla - Bootstrap eCommerce Template">
    <meta name="author" content="p-themes">
    <!-- Favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="/resources/assets/images/icons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/resources/assets/images/icons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/resources/assets/images/icons/favicon-16x16.png">
    <!-- <link rel="manifest" href="/resources/assets/images/icons/site.html"> -->
    <link rel="mask-icon" href="/resources/assets/images/icons/safari-pinned-tab.svg" color="#666666">
    <link rel="shortcut icon" href="/resources/assets/images/icons/favicon.ico">
    <meta name="apple-mobile-web-app-title" content="Molla">

    <meta name="application-name" content="Molla">
    <meta name="msapplication-TileColor" content="#cc9966">
    <meta name="msapplication-config" content="/resources/assets/images/icons/browserconfig.xml">
    <meta name="theme-color" content="#ffffff">
    <!-- Plugins CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
    <!-- Main CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/style.css">
    <link rel="stylesheet" href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css">
    <link rel="stylesheet" href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css">
    <link rel="stylesheet" href="/resources/assets/css/plugins/nouislider/nouislider.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <c:set var="URL" value="${pageContext.request.requestURL}" />
    <script type="text/javascript">
        $(function() {



            $("#password").blur(function() {
            		if(validpassword() == true){
            			passwordCkJoin()
            		}			
              })
              
          	// active 클래스 초기화
          	$.each($("aside .nav-link"), function(i, nav){
          		$(nav).attr("class", "nav-link");
          	});
          	
          	$("#tab-privacy-link").addClass("active");
 
            });
        	





        function validCheck() {
            let isValid = false;


            let pwdValid = validpassword(); 
            let duplicatePwd = passwordCkJoin();


            if (pwdValid && duplicatePwd == true) {
                isValid = true;
                passwordCkJoin()
                
                printErrMsg("password", "");
            }

            return isValid;
        }


        function printErrMsg(id, msg) {
            let $errMsg = $(`#\${id}`).next('.errMsg');

            // 새로운 에러 메시지 생성 또는 업데이트
            if (msg) {
                // 기존에 에러 메시지가 있으면 업데이트하고, 없으면 새로 생성
                if ($errMsg.length) {
                    $errMsg.text(msg).show(); // 메시지 업데이트하고 보이도록 설정
                } else {
                    $errMsg = $('<div class="errMsg"></div>').insertAfter(`#\${id}`).text(msg).show(); // 새로운 메시지 생성하고 보이도록 설정
                }

            } else { // 메시지가 없으면 에러 메시지 삭제
                $errMsg.hide().remove(); // 숨기고 삭제
            }
        }

      //비밀번호 유효성 검사
        function validpassword(){
        	   let isValid = false;
        	   let pw = $("#password").val();

        	   if(pw == '' || pw.length < 0){
        		   printErrMsg("password", "비밀번호는 공백 없이 입력해주세요.");
        		   isValid = false;
        	  
        	   }else {   
			      printErrMsg("password", "");
			      isValid = true;
	 		  }
        	   return isValid;
           }

        
        function passwordCkJoin(){
        	let password = $("#password").val();
     	   // 이메일 유효성 검사
     	   // 중복검사
     	   let isValid = false;
     	         $.ajax({
     	            url : "duplicatePwd", // 데이터가 송수신될 서버의 주소(서블릿의 매핑주소 작성)
     	            type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
     	            data : {"password" : password }, // 보내는 데이터
     	            dataType : "text", // 수신 받을 데이터 타입 (MINE TYPE)
     	            async : false, // 동기 통신 방식으로 하겠다. (default : true 비동기)
     	            success : function(data) {
     	               // 통신이 성공하면 수행할 함수
     	               console.log(data);
     	              if(data == 1){
		                  // 아이디 중복
		                  printErrMsg("password", "");
		                  isValid = true;
		                  // 사용가능한 아이디
		               } else if(data == 0) {
		            	   printErrMsg("password", "비밀번호가 일치하지 않습니다.");
	              		 isValid = false;
		           	   }
     	               
     	            },
     	            error : function() { 
     	            },
     	            complete : function() {
     	            },
     	         });

	 	   return isValid;
        }
    </script>
    <style type="text/css">
    @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
        h4 {
            font-weight: bold !important;
            margin-bottom: 50px;
        }
        .memberInfoJoin .title-style h4 {
        	font-family: 'GmarketSansMedium';
        	font-size: 2em;
    		padding-top: 1em;
        }
       .memberInfoJoin .form-style {
     	  border-top: 2px solid #222;
       }
       .memberInfoJoin .btn-center {
           width: fit-content;
		    display: block;
		    margin: 20px auto;
       }
       .memberInfoJoin .dashboard .btn {
	       	width: 180px;
		    height: 2.9em;
		    font-size: 1.6rem;
       }

        .table_type_A {
        	display: block;
            border-collapse: collapse;
/*             width: 100%; */
            border: 0;
            margin-bottom: 80px;
            
            /* padding-left: 130px; */
            box-sizing: border-box;
            
            margin: 0 auto;
    		width: fit-content;
        }
        .table_type_A * {
      	  box-sizing: border-box;
        }
        
        .table_type_A.table_form td {
        	font-family: 'GmarketSansMedium';
        	padding: 8px 0;
        	font-size: 1em;
        }

        .table_type_A.table_form .input-box .input-box-inner {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table_type_A.table_form .input-box .pwd span {
            display: inline-block;
            width: 8px;
            height: 8px;
            margin: 10px 7px 0 0;
            background: #111;
            border-radius: 50%;
        }

        .btn btn-box color-gray btn-email {
            border: 2px soild black !important;
        }

        .table_type_A.table_form .input-hide.password input:nth-last-of-type(1) {
            margin-top: 8px;
        }

        input[type="password"].input-w100 {
            width: 100%
        }

        input[type="password"] {
            border: 1px solid #e5e5e5;
        }

        input[type="text"].input-w100 {
            width: 100%
        }

        input[type="text"] {
            border: 1px solid #e5e5e5;
        }

        .table_type_A .flex-between2 {
            display: flex;
            justify-content: space-between;
        }

        .table_type_A .flex-between {
            display: flex;
            justify-content: space-between;
        }

        td {
            padding: 8px;
            font-weight: bolder;
        }

        .font-bold {
            font-weight: bolder;
        }

        .btn-outline-secondary {
            margin-top: 2px !important;
            padding: 5px !important;
            margin-bottom: 0px !important;
        }

        .btn-dark {
            margin-top: 2px !important;
            padding: 5px !important;
            margin-bottom: 0px !important;
        }

        .util_radio {
            margin-left: 10px;
        }

        .font-bold {
            width: 155px;
        }

        .flex-between {
            padding-left: 0px;
        }

    </style>
</head>

<body>
  <div class="page-wrapper">
    <jsp:include page="../header.jsp"></jsp:include>
    <!-- header 파일 인클루드 -->
    <main class="main memberInfoJoin">
        <div class="page-content">
            <div class="dashboard">
                <div class="container">
                    <div class="row">
                        <jsp:include page="mypageAside.jsp"></jsp:include>
                        <div class="col-md-9 col-lg-10 title-style">
                            <h4>개인정보 변경</h4>
                            <form action="changeMemberInfo" method="post" class="form-style">
                             <table class="table_type_A table_form no-td-bb pt-5">
                                 <colgroup>
                                     <col style="width: 140px;">
                                     <col style="width: *;">
                                 </colgroup>
                                 <tbody>
                                     <tr>
                                         <td class="font-bold text-left">아이디</td>
                                         <td class="font-roboto">${loginCustomer.email}</td>
                                     </tr>
                                     <tr>
                                         <td class="text-left"><label for="secession_pw" class="font-bold">비밀번호</label></td>
                                         <td>
						
                                             <input class="d-height input-w100" type="password" size="40" name="password" id="password" placeholder="비밀번호 입력해주세요." maxlength="20">
											 <input type="hidden" class="form-control" name="uuid" id="uuid" value="${loginCustomer.uuid }" readonly />
                                         </td>
                                     </tr>
                                 </tbody>
                                 <tfoot class="btn-center">
                                     <tr>
	                                     <td>
	                                     	<button type="submit" id="joinBtn" class="btn btn-outline-secondary" id="joinBtn" onclick="return validCheck()">다음</button>
	                                     </td>
                                     </tr>
                                 </tfoot>
                             </table>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../footer.jsp"></jsp:include>
    <!-- footer 파일 인클루드 -->
  </div>
</body>

</html>