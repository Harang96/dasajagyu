<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Molla - Bootstrap eCommerce Template</title>
    <meta name="keywords" content="HTML5 Template">
    <meta name="description" content="Molla - Bootstrap eCommerce Template">
    <meta name="author" content="p-themes">
    <!-- Favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="/resources/assets/images/icons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/resources/assets/images/icons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/resources/assets/images/icons/favicon-16x16.png">
    <link rel="manifest" href="/resources/assets/images/icons/site.html">
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
</head>
<script type="text/javascript">
	let code;
	let email;
    $(function() {
    	
    	$("#phoneNumber").blur(function(){
    		validUserPN();
         });
      
    	$("#Findname").blur(function(){
    		validfindid();
         });
      
    	
    	
        //휴대폰 번호 인증
      $("#phoneChk").click(function(){
    	  
    		if(customerValid() == true){
    	        printErrMsg("phone2", "인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");
    	        let phone = $("#phoneNumber").val();
    	        $.ajax({
    	            type: "GET",
    	            url: "phoneCheck?phone=" + phone,
    	            cache: false,
    	            success: function(data) {
    	                if (data == "error") {
    	                    printErrMsg("phone2", "유효한 번호를 입력해주세요.");
    	                    $("#phoneNumber").attr("autofocus", true);
    	                } else {
    	                	code = data;
    	                    $("#phone2").attr("disabled", false);
    	                    $("#phoneChk2").css("display", "inline-block");
    	                    printErrMsg("phone2", "인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
    	                    $("#phone2").css('display', 'block');
    	                    $("#phoneNumber").attr("readonly", true); 
    	               }
    	        
    	            }
    	        });
    	            } else {
    	            	printErrMsg("Findname", "일치하는 정보가 없습니다.");
		            	printErrMsg("phone2", "일치하는 정보가 없습니다.");	
    	            }
      });
        

        $("#phoneNumber").on("input", function(e) {
            if (e.originalEvent.inputType === 'deleteContentBackward') return; // backspace 키 눌렀을 때는 처리하지 않음
            let phoneNumber = $(this).val();
            // 입력된 값에서 숫자 이외의 문자를 모두 제거
            phoneNumber = phoneNumber.replace(/\D/g, '');
            // 전화번호 형식에 맞게 하이픈 추가
            phoneNumber = phoneNumber.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
            // 입력 필드에 반영
            $(this).val(phoneNumber);
        });


      

    
    $("#phone2").keyup(function(){
    	let isValid = false;
   	  
   	  let phoneCode = $("#phone2").val()
   	
   		console.log("입력코드 : " + phoneCode);
   		console.log("인증코드 : " + code);  
   	  
       if(phoneCode === code){
           $("#phone2Msg").text("인증번호가 일치합니다.");
           $("#phone2Msg").css("color", "green");
           printErrMsg("phone2", "");
           $("#email").text(email);
           $("#email").css("color", "green");
           $("#myFindId").css("display", "block");
           $("#phoneDoubleChk").val("true");
           $("#phone2").attr("disabled", true);
           $("#phoneNumber").attr("disabled", false);
           

       } else {
    	   $("#phone2Msg").text("인증번호가 일치하지 않습니다.");
           $("#phone2Msg").css("color", "coral");
           printErrMsg("phone2", "");
           $("#phoneDoubleChk").val("false");
           $(this).attr("autofocus", true);
           $("#phoneNumber").attr("disabled", false);
       }
    });
    
    
    
    
    });

    function validUserPN(){
  	  let isValid = false;
  	   let pn = $("#phoneNumber").val();
  	   
  	   
  	   if(pn == '' || pn.length != 13){
  		   printErrMsg("phone2", "핸드폰번호를 정확히 입력해주세요");
  	   } else {
  	
  	         $.ajax({
  	            url : "duplicatePhoneNumber", // 데이터가 송수신될 서버의 주소(서블릿의 매핑주소 작성)
  	            type : "get", // 통신 방식 (GET, POST, PUT, DELETE)
  	            data : {"phoneNumber" : $("#phoneNumber").val()}, // 보내는 데이터
  	            dataType : "json", // 수신 받을 데이터 타입 (MINE TYPE)
  	            async : false, // 동기 통신 방식으로 하겠다. (default : true 비동기)
  	            success : function(data) {
  	               // 통신이 성공하면 수행할 함수
  	               console.log(data);
  	               if(data == 1){
  		                  // 아이디 중복
  		                  printErrMsg("phone2", "");
  		               	  isValid = true;
  		                  // 사용가능한 아이디
  		               } else if(data == 0) {
  		            	   printErrMsg("phone2", "핸드폰 번호가 일치하지 않습니다.");
  		            		
  		            	   isValid = false;
  		              }
  		            },
  	            error : function() { 
  	            },
  	            complete : function() {
  	            },
  	         });     
  } 
  	   
  	 return isValid;

    }
    
  
	function customerValid(){
		let isValid = false;
		let phoneNumber = $("#phoneNumber").val();
		let name = $("#Findname").val();
		
		
		  $.ajax({
	            url : "idSearch_click", // 데이터가 송수신될 서버의 주소(서블릿의 매핑주소 작성)
	            type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
	            data : {"phoneNumber" : phoneNumber,
	            		 "name" : name
	            }, // 보내는 데이터
	            dataType : "json", // 수신 받을 데이터 타입 (MINE TYPE)
	            async : false, // 동기 통신 방식으로 하겠다. (default : true 비동기)
	            success : function(data) {
	               // 통신이 성공하면 수행할 함수
	               console.log(data);
	               		if(data != null){
		                  // 아이디 중복
		                  email = data.email;
		                  printErrMsg("phone2", "");
		                
		               	  isValid = true;
		                  // 사용가능한 아이디
		               } else if(data == "fail") {
		            	   printErrMsg("Findname", "일치하는 정보가 없습니다.");
		            	   printErrMsg("phone2", "일치하는 정보가 없습니다.");
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

    function validfindid() {
        let isvalid = false;
        let userName = $("#Findname").val();
        let regex = /^[^ㄱ-ㅎㅏ-ㅣ]{2,17}$/
        
       if (!regex.test(userName)) {
            printErrMsg("Findname", "이름 형식에 맞지 않습니다.");	
        } else if (userName.length == 0) {
            printErrMsg("Findname", "이름을 입력해주세요.");	
        } else {
        	printErrMsg("Findname", "");	
            isvalid = true;
        }
        return isvalid;
    }

    function validCheck(){
    	let isValid = false;
        
    	   let customerValid = customerValid()
    	   
    	   if(customerValid == true){
    	      isValid = true;
    	   } 
    	   
    	   return isValid;
    }
    
    function celBtn(){
    	window.close();
    }
    
    
    function ajax() {
        $.ajax({
            url: "loginOpen", // 목적지
            type: "get", // HTTP Method
            data: $("#email").html(), // 전송 데이터
            success: function() { // 성공 시 실행
                window.close();
                window.opener.location.href="/customer/loginOpen";
            	
            },
            error: function() { //실패 시 실행
            }
        });
    }
</script>

<style>
    .errMsg, #phone2Msg{
        color: coral;
        font-size: 12px;
        font-weight: bold;
    }

    #phoneNumber {
        margin-bottom: 0px;
    }

    #deliveryName {
        margin-bottom: 0px;
    }

    #deliveryDetail {
        margin-bottom: 0px;
    }

    #deliveryAddr {
        margin-bottom: 0px;
    }
    #Findname {
    	margin-bottom: 0px;
    }

    #deliveryPostcode {
        width: 250px;
    }

    .postCode {
        position: absolute;
    }

    .postBtn {
        position: relative;
        left: 265px;
        botton: 100px;
    }

    #phoneChk2 {
        position: absolute;
    }

    #btnAddr {
        position: relative;
        left: 128px;
    }
    #phone2{
    	margin-bottom: 0px;
    }
    #email {
    	color : green;
    	font-size : 1.4rem;
        font-weight: bold;
    
    }
    #myFindId {
    	font-size : 1.4rem;
    	font-weight: bold;
    }
</style>

<body>

    <main class="main">
        <div class="page-content mb-0 pb-0">
            <div class="dashboard">
                <div class="container">
                    <div class="row">
                        <div class="col-md-8 col-lg-9">
                            <div class="tab-content">
                                <div class="tab-pane fade show active pb-0" id="tab-delivery" role="tabpanel" aria-labelledby="tab-delivery-link">
                                    <div class="row">
                                        <div class="col-lg-6">
                                    
                                            <div class="card card-dashboard mb-0">
                                            	
                                                <div class="card-body" style="padding-bottom: 60px;">
                                                    <!-- <form action="modifyUpdateAddr" method="post"> -->
                                                    <div class="form-group error-field">
                                                        <div class="form-group">
                                                            <label for="Findname" class="form-label">이름 *</label>
                                                            <input type="text" class="form-control error-field" id="Findname" name="Findname" placeholder="이름을 입력해주세요."/>
                                                        </div>
                                                        <div class="form-group">
                                                          <label for="phoneNumber" class="form-label">핸드폰번호 *</label> 
                                                         <div class="input-group">
                                                        <input id="phoneNumber" type="text" name="phoneNumber" placeholder="핸드폰번호를 입력해주세요." class="form-control" maxlength="13" size="15" required/> 
                                                        <button id="phoneChk" class="doubleChk btn btn-outline-primary-2 btn-minwidth-sm">인증번호 보내기</button>
                                                        </div>
                                                        <input id="phone2" type="text" name="phone2" class="form-control" placeholder="인증 코드 6자리를 입력해주세요." style="display: none;" required /> 
                                                       <span id ="phone2Msg"></span>
                                                        <input type="hidden" id="phoneDoubleChk" /></div>
                                                        <div id="myFindId" style="display : none;">개인계정 : <span id="email" class="form-group"></span></div>
                                                          
                                                        <button class="doubleChk btn btn-outline-primary-2 btn-minwidth-sm" id="phoneChk2" onclick="ajax()" style="margin-top: 15px;">로그인</button>
                                                       <button class="btn btn-outline-primary-2 btn-minwidth-sm" id="btnAddr" onclick ="celBtn()" style="margin-top: 15px;">취소</button>
 													</div>                                                      


                                                    </div>
                                                    
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </main>

    <script src="/resources/assets/js/jquery.min.js"></script>
    <script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
    <script src="/resources/assets/js/jquery.waypoints.min.js"></script>
    <script src="/resources/assets/js/superfish.min.js"></script>
    <script src="/resources/assets/js/owl.carousel.min.js"></script>
    <!-- Main JS File -->
    <script src="/resources/assets/js/main.js"></script>

</body>

</html>