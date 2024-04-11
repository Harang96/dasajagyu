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
<link rel="apple-touch-icon" sizes="180x180"
	href="/resources/assets/images/icons/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="/resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="/resources/assets/images/icons/favicon-16x16.png">
<!-- <link rel="manifest" href="/resources/assets/images/icons/site.html"> -->
<link rel="mask-icon"
	href="/resources/assets/images/icons/safari-pinned-tab.svg"
	color="#666666">
<link rel="shortcut icon"
	href="/resources/assets/images/icons/favicon.ico">
<meta name="apple-mobile-web-app-title" content="Molla">

<meta name="application-name" content="Molla">
<meta name="msapplication-TileColor" content="#cc9966">
<meta name="msapplication-config"
	content="/resources/assets/images/icons/browserconfig.xml">
<meta name="theme-color" content="#ffffff">
<!-- Plugins CSS File -->
<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
<!-- Main CSS File -->
<link rel="stylesheet" href="/resources/assets/css/style.css">
<link rel="stylesheet"
	href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css">
<link rel="stylesheet"
	href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css">
<link rel="stylesheet"
	href="/resources/assets/css/plugins/nouislider/nouislider.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<c:set var="URL" value="${pageContext.request.requestURL}" />
<script type="text/javascript">

$(function(){

		// active 클래스 초기화
	$.each($("aside .nav-link"), function(i, nav){
		$(nav).attr("class", "nav-link");
	});
	
	$("#tab-privacy-link").addClass("active");

	  $("#password2").blur(function(){
			  validpassword();
		 	 
		  }) 
		  
		  $("#password").change(function(){ 
			 if($("#password2").val() != ''){
					 validpassword();

			 }
		  })
		  
		  // 핸드폰번호확인 작성을 마쳤을때
		$("#phoneNumber").blur(function(){
				validUserPN();
      
  		 });
	  
	  // 닉네임확인 작성을 마쳤을때
	   $("#nickname").blur(function(){
	      validUserNickname();
	      
	   });   
	  
	// 환불계좌확인 작성을 마쳤을때
		$("#newRefundAccount").blur(function(){
			validUserFA();
	      
	    });  
	
	    $("#changePasswordBtn").click(function(){
			$('#imagePwd').css('display', 'none')
		});	  
	    
	    $("#pwdCancleBtn").click(function(){
	    	$('#imagePwd').css('display', 'block');
	    	$('#password').val('');
	    	$('#password2').val('');
	    	 printErrMsg("passwordRegisterMsg", "");
	    });
	    
	    $("#changephoneBtn").click(function(){
	    	$('#phone').css('display', 'none')
		});	 
	    
		
	    $("#phoneCancleBtn").click(function(){
	    	$('#phone').css('display', 'block')
	    	$('#phoneNumber').val('');
	    	printErrMsg("phoneNumber", "");
	    
	    });
		  
	    $("#changeNicknameBtn").click(function(){
	    	$('#nick').css('display', 'none')
		});	 
	    
		
	    $("#nicknameCancleBtn").click(function(){
	    	$('#nick').css('display', 'block')
	    	$('#nickname').val('');
	    	printErrMsg("nickname", "");
	    });
	    
	    $("#changeBankBtn").click(function(){
	    	$('#bankName').css('display', 'none')
	    	$('#refundAccount').css('display', 'none')
		});	 
	    
		
	    $("#bankCancelBkBtn").click(function(){
	    	$('#bankName').css('display', 'block')
	    	$('#refundAccount').css('display', 'block')
	    	$('#newRefundAccount').val('');
	    	$('#newBankName').val('');
	    	printErrMsg("newRefundAccount", "");
	    
	    });
	    
		$("#newBankName").on("change",function(){
			if($('#newBankName').val() != ''){
				$('#newRefundAccount').attr('disabled', false);
			} else {
				
				$('#newRefundAccount').attr('disabled', true);
				$('#newRefundAccount').val('');
				printErrMsg("newRefundAccount", "");
			}
			
			});
	    
	    
		  $("#phoneNumber").on("input", function(e) {
	          if(e.originalEvent.inputType === 'deleteContentBackward') return; // backspace 키 눌렀을 때는 처리하지 않음
	          let phoneNumber = $(this).val();
	          // 입력된 값에서 숫자 이외의 문자를 모두 제거
	          phoneNumber = phoneNumber.replace(/\D/g, '');
	          // 전화번호 형식에 맞게 하이픈 추가
	          phoneNumber = phoneNumber.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	          // 입력 필드에 반영
	          $(this).val(phoneNumber);
	        });

	  
		  $("#newRefundAccount").on("input", function(e) {
	            if (e.originalEvent.inputType === 'deleteContentBackward') return; // backspace 키 눌렀을 때는 처리하지 않음
	            let newRefundAccount = $(this).val();
	            // 입력된 값에서 숫자 이외의 문자를 모두 제거
	            newRefundAccount = newRefundAccount.replace(/\D/g, '');
	            // 전화번호 형식에 맞게 하이픈 추가
	            if($("#newBankName").val() == '국민은행'){
	            	newRefundAccount = newRefundAccount.replace(/(\d{6})(\d{2})(\d{6})/, "$1-$2-$3");
	           		 $(this).val(newRefundAccount);
	            }
	         
	            if($("#newBankName").val() == '기업은행'){
	            newRefundAccount = newRefundAccount.replace(/(\d{3})(\d{6})(\d{2})(\d{3})/, "$1-$2-$3-$4");
	            	$(this).val(newRefundAccount);
	            }
	            
	            if($("#newBankName").val() == '우리은행'){
	            newRefundAccount = newRefundAccount.replace(/(\d{4})(\d{3})(\d{6})/, "$1-$2-$3");
	                $(this).val(newRefundAccount);
	            }
	            
	            if($("#newBankName").val() == '농협은행'){
	            newRefundAccount = newRefundAccount.replace(/(\d{3})(\d{4})(\d{4})(\d{2})/, "$1-$2-$3-$4");
	                $(this).val(newRefundAccount);
	            }
	            
	            if($("#newBankName").val() == '하나은행'){
	            newRefundAccount = newRefundAccount.replace(/(\d{3})(\d{6})(\d{5})/, "$1-$2-$3");
	                $(this).val(newRefundAccount); 
	            }
	            
	            if($("#newBankName").val() == 'SC제일은행'){
	            newRefundAccount = newRefundAccount.replace(/(\d{3})(\d{2})(\d{6})/, "$1-$2-$3");
	                $(this).val(newRefundAccount);
	            }
	            
	            if($("#newBankName").val() == '케이뱅크' || $("#newBankName").val() == '신한은행' || $("#newBankName").val() == '신협은행' || $("#newBankName").val() == '광주은행'){
	            newRefundAccount = newRefundAccount.replace(/(\d{3})(\d{3})(\d{6})/, "$1-$2-$3");
	                $(this).val(newRefundAccount);    
	            }
	           
	            if($("#newBankName").val() == '카카오뱅크'){
	            newRefundAccount = newRefundAccount.replace(/(\d{4})(\d{2})(\d{6})/, "$1-$2-$3");
	                $(this).val(newRefundAccount);
	                 
	            }
	            
	            if($("#newBankName").val() == '수협은행'){
	                refundAccount = refundAccount.replace(/(\d{4})(\d{4})(\d{4})/, "$1-$2-$3");
	                    $(this).val(refundAccount);
	                     
	                }
	            
	            if($("#newBankName").val() == '대구은행'){
	                newRefundAccount = newRefundAccount.replace(/(\d{3})(\d{2})(\d{6})(\d{1})/, "$1-$2-$3-$4");
	                    $(this).val(newRefundAccount);
	                     
	                }
	                
	            if($("#newBankName").val() == '부산은행' || $("#newBankName").val() == '경남은행'){
	                newRefundAccount = newRefundAccount.replace(/(\d{3})(\d{4})(\d{4})(\d{2})/, "$1-$2-$3-$4");
	                    $(this).val(newRefundAccount);
	                     
	                }
	            
	            if($("#newBankName").val() == '한국시티은행'){
	                newRefundAccount = newRefundAccount.replace(/(\d{3})(\d{6})(\d{3})/, "$1-$2-$3");
	                    $(this).val(newRefundAccount);
	                     
	                }
	          
	            if($("#newBankName").val() == '제주은행'){
	                newRefundAccount = newRefundAccount.replace(/(\d{2})(\d{2})(\d{6})/, "$1-$2-$3");
	                    $(this).val(newRefundAccount);
	                     
	                }
	            
	            if($("#newBankName").val() == '전북은행'){
	                newRefundAccount = newRefundAccount.replace(/(\d{3})(\d{2})(\d{7})/, "$1-$2-$3");
	                    $(this).val(newRefundAccount);
	                     
	                }
	            
	            
	        });
			// 수신동의 모달 텍스트 클릭시 라디오 버튼 클릭 반응
		  $('#agreeYlabel').click(function(){
	            // 클릭된 레이블의 이전 형제 요소인 라디오 버튼을 체크합니다.
	            $('#main_agreeY').prop('checked', true);
	        });
			// 수신동의 모달 텍스트 클릭시 라디오 버튼 클릭 반응
		   $('#agreeNlabel').click(function(){
	            // 클릭된 레이블의 이전 형제 요소인 라디오 버튼을 체크합니다.
	            $('#main_agreeN').prop('checked', true);
	        });
		   
			// 회원탈퇴 모달 텍스트 클릭시 라디오 버튼 클릭 반응
		   $('#radio1Label').click(function(){
	            // 클릭된 레이블의 이전 형제 요소인 라디오 버튼을 체크합니다.
	            $('#radio1').prop('checked', true);
	        });
			// 회원탈퇴 모달 텍스트 클릭시 라디오 버튼 클릭 반응
		   $('#radio2Label').click(function(){
	            // 클릭된 레이블의 이전 형제 요소인 라디오 버튼을 체크합니다.
	            $('#radio2').prop('checked', true);
	        });
			// 회원탈퇴 모달 텍스트 클릭시 라디오 버튼 클릭 반응
		   $('#radio3Label').click(function(){
	            // 클릭된 레이블의 이전 형제 요소인 라디오 버튼을 체크합니다.
	            $('#radio3').prop('checked', true);
	        });
			// 회원탈퇴 모달 텍스트 클릭시 라디오 버튼 클릭 반응
		   $('#radio4Label').click(function(){
	            // 클릭된 레이블의 이전 형제 요소인 라디오 버튼을 체크합니다.
	            $('#radio4').prop('checked', true);
	        });
			// 회원탈퇴 모달 텍스트 클릭시 라디오 버튼 클릭 반응
		   $('#radio5Label').click(function(){
	            // 클릭된 레이블의 이전 형제 요소인 라디오 버튼을 체크합니다.
	            $('#radio5').prop('checked', true);
	        });
			// 회원탈퇴 모달 텍스트 클릭시 라디오 버튼 클릭 반응
		   $('#radio6Label').click(function(){
	            // 클릭된 레이블의 이전 형제 요소인 라디오 버튼을 체크합니다.
	            $('#radio6').prop('checked', true);
	        });
		   
		   
		   
});

function validUserFA(){
	   //  계좌번호 유효성 검사
	   // 중복검사
	   let isValid = false;
	   let FA = $("#newRefundAccount").val();
		
	   if(FA == "" || FA.search('[0-9,\-]{3,6}\-[0-9,\-]{2,6}\-[0-9,\-]') < 0) {
		   printErrMsg("newRefundAccount", "계좌번호를 정확히 입력해주세요");
	   } else {
	         $.ajax({
	            url : "duplicateRefundAccount", // 데이터가 송수신될 서버의 주소(서블릿의 매핑주소 작성)
	            type : "get", // 통신 방식 (GET, POST, PUT, DELETE)
	            data : {"newRefundAccount" : $("#newRefundAccount").val()}, // 보내는 데이터
	            dataType : "json", // 수신 받을 데이터 타입 (MINE TYPE)
	            async : false, // 동기 통신 방식으로 하겠다. (default : true 비동기)
	            success : function(data) {
	               // 통신이 성공하면 수행할 함수
	               console.log(data);
	               if(data == 1){
	                  // 계좌번호 중복
	                  printErrMsg("newRefundAccount", "계좌번호가 중복됩니다");
	                  isValid = false;
	                  // 사용가능한 계좌번호
	               } else if(data == 0) {
	            	   printErrMsg("newRefundAccount", "");
	               isValid = true;
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



function validUserPN(){
	  let isValid = false;
	   let pn = $("#phoneNumber").val();
	   
	   
	   if(pn == '' || pn.length != 13){
		   printErrMsg("phoneNumber", "핸드폰번호를 정확히 입력해주세요");
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
		                  printErrMsg("phoneNumber", "핸드폰번호가 중복됩니다");
		                  isValid = false;
		                  // 사용가능한 아이디
		               } else if(data == 0) {
		            	   printErrMsg("phoneNumber", "");
	               isValid = true;
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


function validpassword(){	   
	   let isValid = false;
	   let pw =$("#password").val();
	   let pw2 = $("#password2").val();
	   let num = pw.search(/[0-9]/g);
	   let eng = pw.search(/[a-z]/ig);
	   let spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	      
	   if(pw.length < 8 || pw.length > 20){
		   printErrMsg("passwordRegisterMsg", "8자리 ~ 20자리 이내로 입력해주세요.");
		   isValid = false;
			 } else if(pw.search(/\s/) != -1){
				 printErrMsg("passwordRegisterMsg", "비밀번호는 공백 없이 입력해주세요.");
				 isValid = false;
			 } else if(num < 0 || eng < 0 || spe < 0 ){

				 printErrMsg("passwordRegisterMsg", "영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
				 isValid = false;

			 } else if (pw != pw2) {
				   printErrMsg("passwordRegisterMsg", "비밀번호가 같지 않습니다.");
				   isValid = false;
			   }else {   
			      printErrMsg("passwordRegisterMsg", "");
			      isValid = true;
	   }
	   return isValid;
   }
	 
function validUserNickname(){
	   // 이메일 유효성 검사
	   // 중복검사
	   let isValid = false;
	   let nickN = $("#nickname").val();
	  
	   if(nickN == '' || nickN.length < 2 || nickN.length > 15){
		   printErrMsg ("nickname", "2자리 ~ 15자리 이내로 입력해주세요.");
	   } else {
	
	         $.ajax({
	            url : "duplicateNickname", // 데이터가 송수신될 서버의 주소(서블릿의 매핑주소 작성)
	            type : "get", // 통신 방식 (GET, POST, PUT, DELETE)
	            data : {"nickname" : $("#nickname").val()}, // 보내는 데이터
	            dataType : "json", // 수신 받을 데이터 타입 (MINE TYPE)
	            async : false, // 동기 통신 방식으로 하겠다. (default : true 비동기)
	            success : function(data) {
	               // 통신이 성공하면 수행할 함수
	               console.log(data);
	               if(data == 1){
	                  // 아이디 중복
	                  printErrMsg("nickname", "닉네임이 중복됩니다");
	                  isValid = false;
	                  // 사용가능한 아이디
	               } else if(data == 0) {
	            	   printErrMsg("nickname", "");
	               isValid = true;
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
	 

function validCheck(){
	let isValid = false;	
	let pwdValid = validpassword();
	if (pwdValid == true){
		 isValid = true;
		 passwordUpdate()
	      printErrMsg("passwordRegisterMsg", "");
	}
	   return isValid;
}
	  
function validCheck2(){
	let isValid = false;
	let PNValid = validUserPN();
	if (PNValid == true){
		 isValid = true;
		 mobileUpdate()
	      printErrMsg("phoneNumber", "");
	}	
	   return isValid;
}

function validCheck3(){
	let isValid = false;	
	let nicknameValid = validUserNickname();	
	if (nicknameValid == true){
		 isValid = true;
   		 nicknameUpdate()
	     printErrMsg("nickname", "");
	}	
	   return isValid;
}

function validCheck5(){
	let isValid = false;
	let bankValid = validUserFA();
	if (bankValid == true){
		 isValid = true;
		 bankUpdate()
	      printErrMsg("refundAccount", "");
	      printErrMsg("bankName", "");
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
	   
function showPasswordForm() {
    let bodyPw = document.getElementById("bodyPw");
    let changePasswordBtn = document.getElementById("changePasswordBtn");
    
    bodyPw.style.display = "block";
    changePasswordBtn.style.display = "none";
}

function cancelBtn() {
    let bodyPw = document.getElementById("bodyPw");
    let changePasswordBtn = document.getElementById("changePasswordBtn");
       
    bodyPw.style.display = "none";
    changePasswordBtn.style.display = "block";
}

function shownickname() {
    let bodyNn = document.getElementById("bodyNn");
    let changeNicknameBtn = document.getElementById("changeNicknameBtn");
   
    bodyNn.style.display = "block";
    changeNicknameBtn.style.display = "none";
}

function cancelNBtn() {
    let bodyNn = document.getElementById("bodyNn");
    let changeNicknameBtn = document.getElementById("changeNicknameBtn");
       
    bodyNn.style.display = "none";
    changeNicknameBtn.style.display = "block";
}


function showphone() {
  	    let bodyPh = document.getElementById("bodyPh");
	    let changephoneBtn = document.getElementById("changephoneBtn");
	   
	    bodyPh.style.display = "block";
	    changephoneBtn.style.display = "none";
	   
	}
	
	
function cancelPBtn() {
    let bodyPh = document.getElementById("bodyPh");
    let changephoneBtn = document.getElementById("changephoneBtn");
       
    bodyPh.style.display = "none";
    changephoneBtn.style.display = "block";
}		
		
function showAccount() {
	   let bodyAc = document.getElementById("bodyAc");
	    let changeRefundAccountBtn = document.getElementById("changeRefundAccountBtn");
	   
	    bodyAc.style.display = "block";
	    changeRefundAccountBtn.style.display = "none";
	   
	}

function cancelABtn() {
    let bodyAc = document.getElementById("bodyAc");
    let changeRefundAccountBtn = document.getElementById("changeRefundAccountBtn");
       
    bodyAc.style.display = "none";
    changeRefundAccountBtn.style.display = "block";
}

function showBankName() {
	    let bodyBk = document.getElementById("bodyBk");
	    let changeBankBtn = document.getElementById("changeBankBtn");
	   
	    bodyBk.style.display = "block";
	    changeBankBtn.style.display = "none";
	   
	}

function cancelBkBtn() {
 	let bodyBk = document.getElementById("bodyBk");
 	let changeBankBtn = document.getElementById("changeBankBtn");
    
 	bodyBk.style.display = "none";
 	changeBankBtn.style.display = "block";
	}

function passwordUpdate(){
		let password = $("#password").val();
		let uuid = '${loginCustomer.uuid}';
		
	$.ajax({
		url : "pwdUpdate", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
		data : {"password" : password, 
				"uuid" : uuid	
		},
		success : function(data) {
			// 통신이 성공하면 수행할   함수
			if(data == "success"){
				$("#bodyPw").hide();	 
				$('#changePasswordBtn').css('display', 'block');
				$("#password").val('');
				$("#password2").val('');
				$("#imagePwd").show();
			}
		},
		error : function() {},
		complete : function() {},
	});
	
}

function mobileUpdate(){
	let phoneNumber = $("#phoneNumber").val();
	let uuid = '${loginCustomer.uuid}';
	
	$.ajax({
		url : "mobileUpdate", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
		data : {"phoneNumber" : phoneNumber, 
				"uuid" : uuid	
		},
		success : function(data) {
			// 통신이 성공하면 수행할 함수
			if(data == "success"){
				$("#bodyPh").hide();
				$("#phone").html(phoneNumber);
				$('#changephoneBtn').css('display', 'block');
				$("#phoneNumber").val('');
				$("#phone").show();
			}
		},
		error : function() {},
		complete : function() {},
	});
	
}

function nicknameUpdate(){
	let nickname = $("#nickname").val();
	let uuid = '${loginCustomer.uuid}';
	
	$.ajax({
		url : "nicknameUpdate", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
		data : {"nickname" : nickname, 
				"uuid" : uuid	
		},
		success : function(data) {
			// 통신이 성공하면 수행할 함수
			if(data == "success"){
				$("#bodyNn").hide();
				$("#nick").html(nickname);
				$('#changeNicknameBtn').css('display', 'block');
				$("#nickname").val('');
				$("#nick").show();
			}
		},
		error : function() {},
		complete : function() {},
	});

	
}

function bankUpdate(){
	let newBankName = $("#newBankName").val();
	let newRefundAccount = $("#newRefundAccount").val();
	let uuid = '${loginCustomer.uuid}';
	
	$.ajax({
		url : "bankUpdate", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
		data : {"newBankName" : newBankName, 
				"uuid" : uuid,
				"newRefundAccount" : newRefundAccount
		},
		success : function(data) {
			// 통신이 성공하면 수행할 함수
			if(data == "success"){
				$("#bodyBk").hide();
				$("#bankName").html(newBankName);
				$("#refundAccount").html(newRefundAccount);
				$('#changeBankBtn').css('display', 'block');
				$('#newBankName').val('');
				$('#newRefundAccount').val('');
				$("#bankName").show();
				$("#refundAccount").show();
			}
		},
		error : function() {},
		complete : function() {},
	});

	
}

function agreeModal(){
	$("#agreeModal").modal();
}

function agreeUpdate(){
	let isValid = false;
	let checkedValue = $('input[name="agree_mobile"]:checked').val();
	let uuid = '${loginCustomer.uuid}';
	
	$.ajax({
		url : "agreeUpdate", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
		data : {"checkedValue" : checkedValue, 
				"uuid" : uuid
		},
		success : function(data) {
			// 통신이 성공하면 수행할   함수
			console.log(data)
			if(data == "success"){
			$('input[name="agree_mobile"]:checked').html(checkedValue);
			$("#agreeModal").hide();
			isValid = true;
			}
		},
		error : function() {},
		complete : function() {},
	});

	return isValid
	
}

function withdraw(){
		$("#withdrawModal").modal();
}

function withdrawNow(){
	var reason = $("input[name='reason']:checked").val();
	var email = '${loginCustomer.email}';
	
	if(reason == "직접입력"){
		reason = $("#reasonText").val() + "";
	}
	
	$.ajax({
		url : "/admin/customer/delCsInfo", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
		data : {
			"email" : email,
			"reason" : reason
		},
		type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
		success : function() {
			// 통신이 성공하면 수행할   함수
		},
		error : function() {},
		complete : function() {
			location.href="/customer/logout?path=/";
		}
	});
}

function closeBtn(){
	$("#withdrawModal").hide();
	$("#agreeModal").hide();
	
}
</script>
<style type="text/css">
h4 {
	font-weight: bold !important;
	margin-bottom: 50px;
}

.table_type_A {
	border-collapse: collapse;
	width: 100%;
	border: 0;
	margin-bottom: 80px;
	border-top: 2px solid #222;
	padding-left: 130px;
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

#ReceiveSettings {
	position: absolute;
}

#changeNicknameBtn3 {
	position: relative;
	left: 1130.50px;
	bottom : 10px;
}

.form-check-label:hover, #newBankName:hover{
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="page-wrapper">
	<jsp:include page="../header.jsp"></jsp:include>
	<!-- header 파일 인클루드 -->
	<main class="main">
		<div class="page-content">
			<div class="dashboard">
				<div class="container">
					<div class="row">
						<jsp:include page="mypageAside.jsp"></jsp:include>
						<div class="col-md-8 col-lg-10">
							<div>
								<div>

									<h4>로그인정보</h4>
									<table class="table_type_A table_form no-td-bb">
										<colgroup>
											<col style="width: 140px;">
											<col style="width: *;">
										</colgroup>
										<tbody>
											<tr class="__pt-32">
												<td class="font-bold text-left">아이디</td>
												<td class="font-roboto">${userInfo.email}</td>
											</tr>

											<tr>
												<td class="text-left"><label for="secession_pw"
													class="font-bold">비밀번호</label></td>
												<td>

													<div class="input-box">
														<div class="input-box-inner">
															<p class="flex pwd" id ="imagePwd">
																<span></span><span></span><span></span><span></span><span></span>
															</p>
															<label id="changePasswordBtn"
																class="btn btn-outline-secondary" for="isChgPw"
																onclick="showPasswordForm()">변경하기</label>
														</div>
														
														<div id="bodyPw" class="input-hide sm password"
															style="display: none;">
															<input class="d-height input-w100" type="password"
																size="40" name="password" id="password"
																placeholder="새 비밀번호 입력" maxlength="16">
															<p class="font font-12 color-red warning"
																id="note_invalid_pw" style="display: none">새 비밀번호는
																필수입력입니다.</p>
															<span id="passwordRegisterMsg"></span> <input
																class="d-height input-w100" type="password" size="40"
																name="password2" id="password2" placeholder="새 비밀번호 확인"
																maxlength="16">
															<p class="font font-12 color-red warning"
																id="note_invalid_rePw" style="display: none">새 비밀번호는
																필수입력입니다.</p>
															<div class="btn-area">
																<a href="javascript:;" class="btn btn-outline-secondary"
																	onclick="cancelBtn()" id="pwdCancleBtn">변경 취소</a> <a href="javascript:;"
																	class="btn btn-dark" id="pwdCk" onclick="validCheck();">확인</a>
															</div>
														</div>					
												
												</div>
											</td>
										</tr>

										</tbody>
									</table>
									<h4>회원정보</h4>
									<table class="table_type_A table_form no-td-bb">
										<colgroup>
											<col style="width: 140px;">
											<col style="width: *;">
										</colgroup>
										<tbody>
											<tr class="__pt-32">
												<td class="font-bold text-left">이름</td>
												<td class="flex-between2">
													<p>${userInfo.name}</p> <span
													class="caption font-13 font color-888">개명 후 실명확인기관에
														등록된 경우, 이름 변경이 가능합니다.</span>
												</td>
											</tr>
											<tr>
												<td class="font-bold text-left">휴대폰 번호</td>
												<td>
													<div class="input-box">
														<div class="input-box-inner">
															<p class="font-roboto" id ="phone">${userInfo.phoneNumber}</p>
															<label id="changephoneBtn"
																class="btn btn-outline-secondary" for="isChgPh"
																onclick="showphone()">변경하기</label>
														</div>
														<div id="bodyPh" class="input-hide sm password"
															style="display: none;">
															<input class="d-height input-w100" type="text" size="40"
																name="rePh" id="phoneNumber"
																placeholder="변경할 핸드폰번호를 숫자만 입력해 주세요." maxlength="13">
															<p class="font font-12 color-red warning"
																id="note_invalid_rePw" style="display: none">닉네임.</p>
															<div class="btn-area">
																<a href="javascript:;" class="btn btn-outline-secondary"
																	onclick="cancelPBtn()" id="phoneCancleBtn">변경 취소</a> <a href="javascript:;"
																	class="btn btn-dark" onclick="validCheck2()">확인</a>
															</div>
														</div>
													</div>
												</td>
											</tr>
											
													<tr>
												<td class="font-bold text-left">닉네임</td>
												<td>
													<div class="input-box">
														<div class="input-box-inner">
															<p id="nick">${userInfo.nickname}</p>

															<label id="changeNicknameBtn"
																class="btn btn-outline-secondary" for="isChgNn"
																onclick="shownickname()">변경하기</label>
														</div>
														<div id="bodyNn" class="input-hide sm password"
															style="display: none;">
															<input class="d-height input-w100" type="text" size="40"
																name="reNn" id="nickname" placeholder="변경할 닉네임을 입력해 주세요."
																maxlength="16">
															<p class="font font-12 color-red warning"
																id="note_invalid_rePw" style="display: none">닉네임.</p>
															<div class="btn-area">
																<a href="javascript:;" class="btn btn-outline-secondary" id ="nicknameCancleBtn" onclick="cancelNBtn()">변경 취소</a> 
																<a href="javascript:;" class="btn btn-dark" onclick="validCheck3()">확인</a>
															</div>
														</div>
													</div>


												</td>
											</tr>
											
											 <tr>
												<td class="font-bold text-left">환불 계좌</td>
												<td>
													<div class="input-box">
														<div class="input-box-inner" id="bankNameHeader">
															<p class="font-roboto" id="bankName" >${userInfo.bankName}</p>
															<label id="changeBankBtn"
																class="btn btn-outline-secondary" for="isChgBk"
																onclick="showBankName()">변경하기</label>
														</div>
														<div class="input-box">
															<div class="input-box-inner">
															<p class="font-roboto" id="refundAccount">${userInfo.refundAccount}</p>
															</div>
														<div id="bodyBk" class="input-hide sm password"
															style="display: none;">
															
															 <select id="newBankName" name="newBankName" class="d-height input-w100 btn-outline-secondary" style="width: 150px;">
																		<option value='' selected>은행선택</option>
																		 <option value="국민은행">국민은행</option>
                                                  						 <option value="신한은행">신한은행</option>
                                                   						 <option value="기업은행">기업은행</option>
						                                                 <option value="하나은행">하나은행</option>
						                                                 <option value="농협은행">농협은행</option>
						                                                 <option value="우리은행">우리은행</option>
						                                                 <option value="카카오뱅크">카카오뱅크</option>
						                                                 <option value="케이뱅크">케이뱅크</option>
						                                                 <option value="신협은행">신협은행</option>
						                                                 <option value="SC제일은행">SC제일은행</option>
						                                                 <option value="제주은행">제주은행</option>
						                                                 <option value="대구은행">대구은행</option>
						                                                 <option value="한국씨티은행">한국씨티은행</option>
						                                                 <option value="부산은행">부산은행</option>
						                                                 <option value="수협은행">수협은행</option> 
						                                                 <option value="경남은행">경남은행</option>
						                                                 <option value="전북은행">전북은행</option>
						                                                 <option value="광주은행">광주은행</option>
						                                                 <option value="기타">기타</option>
																		</select>
																	
																	<div id="bodyAc" class="input-hide sm password">
																	<input class="d-height input-w100" type="text" size="40"
																		name="rePh" id="newRefundAccount" placeholder="변경할 계좌번호를 숫자만 입력해 주세요." maxlength="16" disabled>
		
																	<p class="font font-12 color-red warning" id="note_invalid_rePw" style="display: none">닉네임.</p>
																	<div class="btn-area">
																		<a href="javascript:;" class="btn btn-outline-secondary"
																			onclick="cancelBkBtn()" id ="bankCancelBkBtn">변경 취소</a> <a href="javascript:;"
																			class="btn btn-dark" onclick="validCheck5()">확인</a>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</td>
											</tr>
											
											 <tr>
												<td>



												</td>
											</tr>
											
									
											<tr>
												<td class="font-bold text-left">가입일</td>
												<td>
													<div class="input-box">
														<div class="input-box-inner">
															<p class="font-roboto">${userInfo.registerDate}</p>
														</div>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
									 <h4 id="ReceiveSettings">수신 설정</h4>
									 <label id="changeNicknameBtn3" class="btn btn-outline-secondary" for="isChgPw" onclick="agreeModal()">변경하기</label>
                      		  <table class="table_type_A table_form no-td-bb last" id="agreeRadioBox">
                            <colgroup>
                                <col style="width: 140px;">
                                <col style="width: *;">
                            </colgroup>
                            <tbody>
                            <tr class="__pt-32">
                                <td class="font-bold text-left">메일, 문자 수신 동의</td>
                                
                                <td class="flex-between">
                                
                                	<c:choose>
                                		<c:when test="${userInfo.msgAgree == 'Y' }">
                                			<div>
		                                        <input type="radio" name="agree_mobile" id="main_agreeY" value="Y" class="util_radio" checked >
		                                        <label class="form-check-label" for="agree_mobile_y" id="agreeYlabel"><span></span>수신 동의</label>
		                                        <input type="radio" name="agree_mobile" id="main_agreeN" value="N" class="util_radio" >
		                                        <label class="form-check-label" for="agree_mobile_n" id="agreeNlabel"><span></span>수신 거부</label>
                                    		</div>
                                		</c:when>
                                		<c:when test="${userInfo.msgAgree == 'N' }">
                                			<div>
		                                        <input type="radio" name="agree_mobile" id="main_agreeY" value="Y" class="util_radio" >
		                                        <label class="form-check-label" for="agree_mobile_y" id="agreeYlabel"><span></span>수신 동의</label>
		                                        <input type="radio" name="agree_mobile" id="main_agreeN" value="N" class="util_radio" checked >
		                                        <label class="form-check-label" for="agree_mobile_n" id="agreeNlabel "><span></span>수신 거부</label>
                                    		</div>
                                		</c:when>
                                	
                                	</c:choose>
                                    
                                    
                                    
                                    
                                </td>
                                
                            </tr>
                            </tbody>
                        </table>
                        
                           <label id="changeNicknameBtn" class="btn btn-outline-secondary" for="withdrawBtn" onclick="withdraw()">회원탈퇴</label>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>   
   </main>
   <!-- 회원 탈퇴 모달 -->
	<div class="modal fade" id="withdrawModal" tabindex="-1" role="dialog" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">회원 탈퇴</span>
			</div>
			<div class="modal-body" style=" padding : 0px 15px 15px 15px; margin-left: 30px;">
				<span style="font-size: 15px; font-weight: bold;">회원탈퇴 하시겠습니까?</span> </br>
				<span>* 탈퇴 시 보유 포인트, 기록이 모두 삭제됩니다!</span>
				<div>
					<span>삭제 사유를 선택해주세요.</span>
					<div class="form-check">
					  <input type="radio" class="form-check-input" id="radio1" name="reason" value="배송 불만" checked>
					  <label class="form-check-label" for="radio1" id ="radio1Label">배송 불만</label>
					</div>
					<div class="form-check">
					  <input type="radio" class="form-check-input" id="radio2" name="reason" value="상품 다양성 불만">
					  <label class="form-check-label" for="radio2" id ="radio2Label">상품 다양성 불만</label>
					</div>
					<div class="form-check">
					  <input type="radio" class="form-check-input" id="radio3" name="reason" value="가격품질 불만">
					  <label class="form-check-label" for="radio3" id ="radio3Label">가격품질 불만</label>
					</div>
					<div class="form-check">
					  <input type="radio" class="form-check-input" id="radio4" name="reason" value="사이트 이용 불편">
					  <label class="form-check-label" for="radio4" id ="radio4Label">사이트 이용 불편</label>
					</div>
					<div class="form-check">
					  <input type="radio" class="form-check-input" id="radio5" name="reason" value="이용빈도 낮음">
					  <label class="form-check-label" for="radio5" id ="radio5Label">이용빈도 낮음</label>
					</div>
					<div class="form-check">
					  <input type="radio" class="form-check-input" id="radio6" name="reason" value="직접입력">
					  <label class="form-check-label" for="radio6" id ="radio6Label">직접입력</label>
					  	<input type="text" class="form-control" id="reasonText" style="width:70%;" maxlength='30'/>
					  
					</div>
					
					
				</div>
			</div>
			
			<div style="text-align:center; padding-bottom:20px;">
			<button class="btn btn-outline-secondary" onclick="withdrawNow()" 
			style="margin:0px 5px 15px 0px; width: 150px;"
			data-dismiss="modal" aria-label="Close" >네</button>
			<button class="btn btn-outline-secondary" onclick="closeBtn()" 
			style="margin:0px 0px 15px 5px; width: 150px;"
			data-dismiss="modal" aria-label="Close">아니요</button>
			</div>
			</div>
		</div>
	</div>
	
	
	  <!-- 수신 동의 모달 -->
	<div class="modal fade" id="agreeModal" tabindex="-1" role="dialog" >
		<div class="modal-dialog modal-dialog-centered" style="width: 450px;">
			<div class="modal-content">
			 
			<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
				<span style="font-size: 20px; font-weight: bold;">수신 설정</span>
			</div>
			<div class="modal-body" style=" padding : 0px 15px 15px 15px; margin-left: 30px;">
				<span style="font-size: 15px; font-weight: bold;">메일, 문자 수신 동의를 변경하시겠습니까?</span>
			</div>
			
			<div style="text-align:center; padding-bottom:20px;">
			<button class="btn btn-outline-secondary" onclick="agreeUpdate()" 
			style="margin:0px 5px 15px 0px; width: 150px;"
			data-dismiss="modal" aria-label="Close" >네</button>
			<button class="btn btn-outline-secondary" onclick="closeBtn()" 
			style="margin:0px 0px 15px 5px; width: 150px;"
			data-dismiss="modal" aria-label="Close">아니요</button>
			</div>
			</div>
		</div>
	</div>
	
	
   <jsp:include page="../footer.jsp"></jsp:include>
   <!-- footer 파일 인클루드 -->
	</div>
</body>
</html>