<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>로그인 및 회원가입</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="../resources/assets/images/icons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/assets/images/icons/favicon-16x16.png">
    <!-- Main CSS File -->
    <link rel="stylesheet" href="/resources/css/customer/login.css">
    <script src="/resources/assets/js/jquery.min.js"></script>
    <script src="/resources/js/customer/login.js"></script>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<script>
    let emailAuth = false;

    $(function() {

   $("#register-tab-2").click(function(){
      let inputs = $('.form-control');
      inputs.val('');
      
      $('.errMsg').hide();
   
   })
   
        // 비밀번호확인 작성을 마쳤을때
        $("#password2").keyup(function() {
            validpassword();
        });

        $("#passwordRegister").keyup(function() {
            if ($("#password2").val() != '') {
                validpassword();
            }
        });

        // 닉네임확인 작성을 마쳤을때
        $("#nickname").keyup(function() {
            validUserNickname();

        });

        // 이름확인 작성을 마쳤을때
        $("#name").keyup(function() {
            validUserName();

        });

        // 환불계좌확인 작성을 마쳤을때
        $("#refundAccount").keyup(function() {
            validUserFA();

        });
        // 핸드폰번호확인 작성을 마쳤을때
        $("#phoneNumber").keyup(function() {
            validUserPN();

        });

        // 주소 작성을 마쳤을때
        $("#addrDetail").keyup(function() {
            addr();

        });

        $("#emailAuth").click(function() {
            if (duplicateEmail() == true) {
                validEmail();
            }
        });

        $("#emailRegister").keyup(function() {
            let ema = $("#emailRegister").val();
            let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

            if (regEmail.test(ema) && ema != '') {
                printErrMsg("emailAuthWarn", "이메일을 인증해주세요.");

            } else {
                printErrMsg("emailAuthWarn", "이메일 양식에 맞게 작성해주세요.");
            }
        });

        // 코드 확인 작성을 마쳤을때
        //$("#authCode").keyup(function() {

         //   if ($("#passwordRegister").val() == '') {
          //      $("#passwordRegister").focus();
           // } else if ($("#password2").val() == '') {
             //   $("#password2").focus();
           // } else if ($("#name").val() == '') {
             //   $("#name").focus();
          //  } else {
              //  $("#nickname").focus();
          //  }
      //  });

        $("#bankName").on("change", function() {
            if ($('#bankName').val() != '') {
                $('#refundAccount').attr('disabled', false);
            } else {

                $('#refundAccount').attr('disabled', true);
                $('#refundAccount').val('');
                printErrMsg("refundAccount", "");
            }
        });

        $("#authCode").keyup(function() {
            let inputCode = $("#authCode").val(); //인증번호 입력 칸에 작성한 내용 가져오기

            console.log("입력코드 : " + inputCode);
            console.log("인증코드 : " + code);

            if (Number(inputCode) === code) {
                $("#emailAuthWarn").html('인증번호가 일치합니다!');
                emailAuth = true;
                $("#emailAuthWarn").css('color', 'green');
                $('#emailAuth').attr('disabled', true);
                $('#emailRegister').attr('readonly', true);
                $("#registerBtn").attr("disabled", false);
                printErrMsg("age", "");

            } else {
                $("#emailAuthWarn").html('인증번호가 불일치 합니다. 다시 확인해주세요!');
                $("#emailAuthWarn").css('color', 'coral');
                $("#registerBtn").attr("disabled", true);
            }
        });

        $("#name").keyup(function() {
            console.log($("#name").val())
            $('#userName').val($("#name").val())
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

        $("#refundAccount").keyup(function(e) {
            if (e.originalEvent.inputType === 'deleteContentBackward') return; // backspace 키 눌렀을 때는 처리하지 않음
            let refundAccount = $(this).val();
            // 입력된 값에서 숫자 이외의 문자를 모두 제거
            refundAccount = refundAccount.replace(/\D/g, '');
            // 전화번호 형식에 맞게 하이픈 추가
            if ($("#bankName").val() == '국민은행') {
                refundAccount = refundAccount.replace(/(\d{6})(\d{2})(\d{6})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '기업은행') {
                refundAccount = refundAccount.replace(/(\d{3})(\d{6})(\d{2})(\d{3})/, "$1-$2-$3-$4");
                $(this).val(refundAccount);
            }
            
            if($("#bankName").val() == '우리은행'){
            refundAccount = refundAccount.replace(/(\d{4})(\d{3})(\d{6})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '농협은행') {
                refundAccount = refundAccount.replace(/(\d{3})(\d{4})(\d{4})(\d{2})/, "$1-$2-$3-$4");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '하나은행') {
                refundAccount = refundAccount.replace(/(\d{3})(\d{6})(\d{5})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }
            
            if($("#bankName").val() == '제일은행'){
            refundAccount = refundAccount.replace(/(\d{3})(\d{2})(\d{6})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '케이뱅크' || $("#bankName").val() == '신한은행' || $("#bankName").val() == '신협은행' || $("#bankName").val() == '광주은행') {
                refundAccount = refundAccount.replace(/(\d{3})(\d{3})(\d{6})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '카카오뱅크') {
                refundAccount = refundAccount.replace(/(\d{4})(\d{2})(\d{6})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '대구은행') {
                refundAccount = refundAccount.replace(/(\d{3})(\d{2})(\d{6})(\d{1})/, "$1-$2-$3-$4");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '부산은행' || $("#bankName").val() == '경남은행') {
                refundAccount = refundAccount.replace(/(\d{3})(\d{4})(\d{4})(\d{2})/, "$1-$2-$3-$4");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '수협은행') {
                refundAccount = refundAccount.replace(/(\d{4})(\d{4})(\d{4})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }

               if ($("#bankName").val() == '한국씨티은행') {
                refundAccount = refundAccount.replace(/(\d{3})(\d{6})(\d{3})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '제주은행') {
                refundAccount = refundAccount.replace(/(\d{2})(\d{2})(\d{6})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }

            if ($("#bankName").val() == '전북은행') {
                refundAccount = refundAccount.replace(/(\d{3})(\d{2})(\d{7})/, "$1-$2-$3");
                $(this).val(refundAccount);
            }
        });


        $('#allCheck').change(function() {
            if ($(this).prop('checked')) {
                $('.agree').prop('checked', true);
            } else {
                $('.agree').prop('checked', false);
            }
        });

        // 세부항목 3개 모두 체크 시 전체동의 자동체크
        $('.agree').change(function() {
            if ($('#check1').prop('checked') && $('#check2').prop('checked') && $('#check3').prop('checked')) {
                $('#allCheck').prop('checked', true);
            } else {
                $('#allCheck').prop('checked', false);
            }
        });

        // 전체동의 체크해제 시 세부항목 3개 모두 자동 체크해제
        $('#allCheck').change(function() {
            if (!$(this).prop('checked')) {
                $('.agree').prop('checked', false);
            }
        });

        // 전체동의 + 세부항목 3개 모두 체크된 상태에서 세부항목 1개 체크해제 시 전체동의 자동 체크해제
        $('.agree').change(function() {
            if (!$('#check1').prop('checked') || !$('#check2').prop('checked') || !$('#check3').prop('checked')) {
                $('#allCheck').prop('checked', false);
            }
        });


        $("#birthday").keyup(function() {
            let birthday = new Date($("#birthday").val());
            let currentDate = new Date();

            let age = currentDate.getFullYear() - birthday.getFullYear();
            let birthMonth = birthday.getMonth();
            let currentMonth = currentDate.getMonth();

            if (currentMonth < birthMonth || (currentMonth == birthMonth && currentDate.getDate() < birthday.getDate())) {
                age--;
            };

            if (age >= 14) {
                printErrMsg("age", "");
                printErrMsg("mistake", "");
                $("#RegisterHide").show();
                $("#emailAuth").show();
                $("#registerBtn").attr("disabled", false);
                $("#emailRegister").attr("disabled", false);
                $("#passwordRegister").attr("disabled", false);
                $("#password2").attr("disabled", false);
                $("#name").attr("disabled", false);
                $("#registerBtn").show();
                $("#mainBtn").hide();
                $("#male").attr("disabled", false);
                $("#female").attr("disabled", false);
            } else if ($("#birthday").val() == '') {
                printErrMsg("age", "생년월일을 입력해주세요.");

            } else {
                printErrMsg("age", "생년월일 : 만 14세 미만의 어린이는 가입할 수 없습니다.");
                printErrMsg("mistake", "잘못 기재 했을 시 다시 입력해 주세요.");
                $("#RegisterHide").hide();
                $("#emailAuth").hide();
                $(".codeDiv").hide();
                $("#registerBtn").attr("disabled", true);
                $("#emailRegister").attr("disabled", true);
                $("#passwordRegister").attr("disabled", true);
                $("#password2").attr("disabled", true);
                $("#name").attr("disabled", true);
                $("#mainBtn").show();
                $("#registerBtn").hide();
                $("#male").attr("disabled", true);
                $("#female").attr("disabled", true);
            }
        });

        $("#register-tab-2").click(function() {
            $("#mainBtn").hide();

        });


        $("#togglePassword").click(function() {

            // 입력란의 type 속성을 변경하여 비밀번호를 보이게 하거나 숨깁니다.
            if ($("#passwordRegister").attr("type") === "password") {
                $("#passwordRegister").attr("type", "text");
                $(this).attr("src", "../resources/assets/images/backgrounds/open1.png"); // 이미지 변경
            } else {
                $("#passwordRegister").attr("type", "password");
                $(this).attr("src", "../resources/assets/images/backgrounds/close1.png"); // 이미지 변경
            }
        });

        $("#togglePassword2").click(function() {

            // 입력란의 type 속성을 변경하여 비밀번호를 보이게 하거나 숨깁니다.
            if ($("#password2").attr("type") === "password") {
                $("#password2").attr("type", "text");
                $(this).attr("src", "../resources/assets/images/backgrounds/open1.png"); // 이미지 변경
            } else {
                $("#password2").attr("type", "password");
                $(this).attr("src", "../resources/assets/images/backgrounds/close1.png"); // 이미지 변경
            }
        });



    }); // end of doc 

    function duplicateEmail() {
        let isValid = false;
        let ema = $("#emailRegister").val();
        let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

        if (regEmail.test(ema)) { //사용자가 입력한 이메일 값 얻어오기
            $.ajax({
                url: "duplicateEmail", // 데이터가 송수신될 서버의 주소(서블릿의 매핑주소 작성)
                type: "get", // 통신 방식 (GET, POST, PUT, DELETE)
                data: {
                    "emailRegister": $("#emailRegister").val()
                }, // 보내는 데이터
                dataType: "json", // 수신 받을 데이터 타입 (MINE TYPE)
                async: false, // 동기 통신 방식으로 하겠다. (default : true 비동기)
                success: function(data) {
                    // 통신이 성공하면 수행할 함수
                    // 이메일 중복
                    if (data == 1) {
                        //            $("#emailAuth").attr("disabled", true);
                        printErrMsg("emailAuthWarn", "이메일이 중복됩니다");
                        isValid = false;
                        // 사용가능한 이메일
                    } else if (data == 0) {
                        //               $("#emailAuth").attr("disabled", false);
                        printErrMsg("emailAuthWarn", "");
                        $('.codeDiv').show();
                        isValid = true;

                    }
                },
                error: function() {},
                complete: function() {},
            });
        } else {
            printErrMsg("emailAuthWarn", "이메일 양식에 맞게 작성해주세요.");
        }

        return isValid;
    }




    function validEmail() {
        let ema = $("#emailRegister").val();
        let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
        $.ajax({
            url: "EmailAuth",
            data: {
                email: $("#emailRegister").val()
            },
            type: 'POST',
            dataType: 'json',
            success: function(result) {
                //               $("#authCode").attr("disabled", false);

                code = result
                printErrMsg("authCode", "인증 코드가 입력하신 이메일로 전송 되었습니다.");
                isvalid = true;
                printErrMsg("emailAuth", "");
                printErrMsg("authCode", "");

                if (ema != '' && regEmail.test(ema)) {
                    $("#emailAuthWarn").html('인증 코드가 입력하신 이메일로 전송 되었습니다.');
                    $("#emailAuthWarn").css('color', 'green');
                    $("#emailRegister").attr("disabled", true);
                    printErrMsg("emailAuth", "")
                } else {
                    printErrMsg("emailAuthWarn", "이메일 양식에 맞게 작성해주세요.")
                    $("#emailRegister").focus();
                }
            },
            error: function() {},
            complete: function() {},
        });


    }


    function goToMainPage() {
        // 메인 페이지의 URL을 설정
        let mainPageUrl = "http://localhost:8081/";
        // 메인 페이지로 이동
        window.location.href = mainPageUrl;
    }


    function validUserNickname() {
        // 이메일 유효성 검사
        // 중복검사
        let isValid = false;
        let nickN = $("#nickname").val();

        if (nickN == '' || nickN.length < 2 || nickN.length > 7) {
            printErrMsg("nickname", "2자리 ~ 7자리 이내로 입력해주세요.");
        } else {

            $.ajax({
                url: "duplicateNickname", // 데이터가 송수신될 서버의 주소(서블릿의 매핑주소 작성)
                type: "get", // 통신 방식 (GET, POST, PUT, DELETE)
                data: {
                    "nickname": $("#nickname").val()
                }, // 보내는 데이터
                dataType: "json", // 수신 받을 데이터 타입 (MINE TYPE)
                async: false, // 동기 통신 방식으로 하겠다. (default : true 비동기)
                success: function(data) {
                    // 통신이 성공하면 수행할 함수
                    if (data == 1) {
                        // 아이디 중복
                        printErrMsg("nickname", "닉네임이 중복됩니다");
                        isValid = false;
                        // 사용가능한 아이디
                    } else if (data == 0) {
                        printErrMsg("nickname", "");
                        isValid = true;
                    }
                },
                error: function() {},
                complete: function() {},
            });


        }


        return isValid;

    }


    function validUserPN() {
        let isValid = false;
        let pn = $("#phoneNumber").val();


        if (pn == '' || pn.length != 13) {
            printErrMsg("phoneNumber", "핸드폰번호를 정확히 입력해주세요");
        } else {

            $.ajax({
                url: "duplicatePhoneNumber", // 데이터가 송수신될 서버의 주소(서블릿의 매핑주소 작성)
                type: "get", // 통신 방식 (GET, POST, PUT, DELETE)
                data: {
                    "phoneNumber": $("#phoneNumber").val()
                }, // 보내는 데이터
                dataType: "json", // 수신 받을 데이터 타입 (MINE TYPE)
                async: false, // 동기 통신 방식으로 하겠다. (default : true 비동기)
                success: function(data) {
                    // 통신이 성공하면 수행할 함수
                    if (data == 1) {
                        // 아이디 중복
                        printErrMsg("phoneNumber", "핸드폰번호가 중복됩니다");
                        isValid = false;
                        // 사용가능한 아이디
                    } else if (data == 0) {
                        printErrMsg("phoneNumber", "");
                        isValid = true;
                    }
                },
                error: function() {},
                complete: function() {},
            });


        }


        return isValid;

    }


function validUserFA(){
      //  계좌번호 유효성 검사
      // 중복검사
      let isValid = false;
      let FA = $("#refundAccount").val();
      
      if(FA == "" || FA.search('[0-9,\-]{2,6}\-[0-9,\-]{2,6}\-[0-9,\-]') < 0) {
         printErrMsg("refundAccount", "계좌번호를 정확히 입력해주세요");
      } else {
            $.ajax({
               url : "duplicateRefundAccount", // 데이터가 송수신될 서버의 주소(서블릿의 매핑주소 작성)
               type : "get", // 통신 방식 (GET, POST, PUT, DELETE)
               data : {"refundAccount" : $("#refundAccount").val()}, // 보내는 데이터
               dataType : "json", // 수신 받을 데이터 타입 (MINE TYPE)
               async : false, // 동기 통신 방식으로 하겠다. (default : true 비동기)
               success : function(data) {
                  // 통신이 성공하면 수행할 함수
                  if(data == 1){
                     // 계좌번호 중복
                     printErrMsg("refundAccount", "계좌번호가 중복됩니다");
                     isValid = false;
                     // 사용가능한 계좌번호
                  } else if(data == 0) {
                     printErrMsg("refundAccount", "");
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



    // 회원가입 버튼 눌렀을 때(유효성검사)   
    function validCheck() {
        let isValid = false;

        let userNameValid = validUserName();
        let pwdValid = validpassword();
        let phoneNumberValid = validUserPN();
        let nicknameValid = validUserNickname();
        let nameValid = validUserName();
        let addrValid = addr();

        //이메일 인증 통과

        let checkAgree = $("input[type=checkbox][name=msgAgree]:checked").val();
        let checkAgree1 = $("input[type=checkbox][name=msgAgree1]:checked").val();
        let checkAgree2 = $("input[type=checkbox][name=msgAgree2]:checked").val();
        if (checkAgree1 == undefined || checkAgree2 == undefined) {
            printErrMsg('check4MsgAgree', '가입조항을 체크해 주세요');
            $("#check4MsgAgree").focus();
        } else {
            printErrMsg('check4MsgAgree', '');

        }

        //alert(checkAgree);

        if ($("#birthday").val() != '' && nameValid && nicknameValid && phoneNumberValid && userNameValid && pwdValid && addrValid && emailAuth == true && checkAgree1 && checkAgree2 == 'Y') {
            isValid = true;
            printErrMsg("check4MsgAgree", "");
        } else {
            if (emailAuth != true) {
                $("#emailRegister").focus();
                printErrMsg("emailAuthWarn", "이메일을 인증해주세요.");
            } else if (validpassword() != true) {
                $("#passwordRegister").focus();
            } else if (validUserPN() != true) {
                $("#phoneNumber").focus();
            } else if (validUserNickname() != true) {
                $("#nickname").focus();
            } else if (validUserName() != true) {
                $("#name").focus();
            } else if (addr() != true) {
                $("#addrDetail").focus();
            } else if ($("#birthday").val() == '') {
                printErrMsg("age", "생년월일을 입력해주세요.");
                $("#birthday").focus();
            }
        }



        return isValid;


    }

    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        let isValid = false
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.

                } else {

                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('addrPostcode').value = data.zonecode;
                document.getElementById("addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addrDetail").focus();
                printErrMsg("addrDetail", "");

            }


        }).open();
        isValid = true;

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


    //이름 유효성 검사
    function validUserName() {
        let isValid = false;
        let n = $("#name").val();
        let regex = /^[^ㄱ-ㅎㅏ-ㅣ]{2,17}$/
        if (n.length < 2 || n.length > 17) {
            printErrMsg("name", "2자리 ~ 17자리 이내로 입력해주세요.");
            isValid = false;
        } else if (!regex.test(n)){
            printErrMsg("name", "이름을 정확히 입력해주세요.");
            isValid = false;
        } else {
            printErrMsg("name", ""); // 조건이 맞을 때 에러 메시지를 지움
            isValid = true;

        }
        return isValid;
    }


    function addr() {
        let isValid = false;
        if ($("#addr").val() != '' && $("#addrPostcode").val() != '') {
            isValid = true;

        } else {
            printErrMsg("addrDetail", "우편번호와 주소를 입력해주세요.");
        }
        return isValid;
    }



    //비밀번호 유효성 검사
    function validpassword() {
        let isValid = false;
        let pw = $("#passwordRegister").val();
        let pw2 = $("#password2").val();
        let num = pw.search(/[0-9]/g);
        let eng = pw.search(/[a-z]/ig);
        let spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

        if (pw.length < 8 || pw.length > 20) {
            printErrMsg("passwordRegisterMsg", "8자리 ~ 20자리 이내로 입력해주세요.");
            isValid = false;
        } else if (pw.search(/\s/) != -1) {
            printErrMsg("passwordRegisterMsg", "비밀번호는 공백 없이 입력해주세요.");
            isValid = false;
        } else if (num < 0 || eng < 0 || spe < 0) {

            printErrMsg("passwordRegisterMsg", "영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
            isValid = false;

        } else if (pw != pw2) {
            printErrMsg("passwordRegisterMsg", "비밀번호가 같지 않습니다.");
            isValid = false;
        } else {
            printErrMsg("passwordRegisterMsg", "");
            isValid = true;
        }
        return isValid;
    }
</script>
<style>
    .errMsg {
        color: coral;
        font-size: 12px;
        font-weight: bold;
    }

    .upLoadFiles img {
        width: 50px;
    }

    #birthday {
        width: 250px;
    }

    #addrPostcode {
        width: 250px;
    }

    .zipcode {
        display: flex;
    }

    .postCode {
        position: absolute;
    }

    .postBtn {
        position: relative;
        left: 265px;
        botton: 100px;
    }

    .essential {
        color: red;
    }

    .select {
        color: gray;
    }

    .hrefColor {
        color: black;
    }

    .genders {
        display: flex;
    }

    .genderAll {
        padding: 11px 20px 11px 0;
    }

    .male {
        padding: 0px 10px 0px;
    }

    .na {
        width: 220px;

    }

    .password-toggle {
        position: absolute;
        top: 50%;
        right: 10px;
        transform: translateY(-50%);
        cursor: pointer;
    }


    .password-container {
        position: relative;
    }

    #onlyNum {
        font-size: 12px;
        font-weight: bold;
        color: gray;
        opacity: 0.5;
    }


#check4MsgAgree{
   margin-bottom : 0px;
}

#bankName:hover, #birthday:hover, #agreeCk:hover{
    cursor : pointer;
}

select{
  background : url('../resources/assets/images/backgrounds/downArrow.png') no-repeat 90% 50%/10px auto;
}

</style>

<body>
    <div class="page-wrapper">
        <jsp:include page="../header.jsp"></jsp:include>

        <main class="main">
            <nav aria-label="breadcrumb" class="breadcrumb-nav border-0 mb-0">
                <div class="container">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/">홈</a></li>
                        <li class="breadcrumb-item active" aria-current="page">로그인</li>
                    </ol>
                </div>
                <!-- End .container -->
            </nav>
            <!-- End .breadcrumb-nav -->

            <div class="login-page bg-image pt-8 pb-8 pt-md-12 pb-md-12 pt-lg-17 pb-lg-17 login-img">

                <div class="container">
                    <div class="form-box">
                        <div class="form-tab">
                            <ul class="nav nav-pills nav-fill" role="tablist">
                                <li class="nav-item"><a class="nav-link active" id="agree-tab-2" data-toggle="tab" href="#agree-2" role="tab" aria-controls="agree-2" aria-selected="false">로그인</a></li>
                                <li class="nav-item"><a class="nav-link" id="register-tab-2" data-toggle="tab" href="#register-2" role="tab" aria-controls="register-2" aria-selected="true">회원가입</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <!-- 로그인 시작 -->
                                <div class="tab-pane fade show active" id="agree-2" role="tabpanel" aria-labelledby="agree-tab-2">
                                    <form action="login" method="post">
                                        <div class="form-group">
                                            <label for="email">이메일 *</label>
                                            <c:choose>
                                                <c:when test="${loginStatus == 'fail' }">
                                                    <input type="text" class="form-control" id="lEmail" name="email" value="${customerEmail }">
                                                </c:when>
                                                <c:when test="${param.loginCheck == 'over' }">
                                                    <input type="text" class="form-control" id="lEmail" name="email" value="${param.customerEmail }">
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${cookie.rememberId.value != null }">
                                                            <input type="text" class="form-control" id="lEmail" name="email" value="${cookie.rememberId.value }">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="text" class="form-control" id="lEmail" name="email">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <!-- End .form-group -->

                              <div class="form-group " >
                                 <label for="password">비밀번호 *</label> <input type="password"
                                    class="form-control" id="lPassword" name="password">
                                 <c:choose>
                                    <c:when test="${loginStatus == 'fail' }">
                                       <span id="loginFailMsg">이메일 혹은 비밀번호를 확인해주세요.</span>
                                    </c:when>
                                    <c:when test="${param.loginCheck == 'over' }">
                                       <span id="loginFailMsg">로그인 시도가 5번을 초과했습니다. 이메일/비밀번호 찾기를 이용해주세요.</span>

                                    </c:when>
                                    <c:otherwise>
                                       <span id="loginFailMsg"></span>
                                    </c:otherwise>
                                 </c:choose>
                              </div>
                              <!-- End .form-group -->

                              <div class="form-footer mt-3">
                                 <a href="${pageContext.request.contextPath}/customer/findinfo_id?path=${param.path}"  class="forgot-link">이메일/비밀번호 찾기</a>

                                 <div id="checkboxes" class="forgot-link">
                                    <div class="custom-control custom-checkbox">
                                       <c:choose>
                                          <c:when test="${cookie.rememberId.value != null }">
                                             <input type="checkbox" class="custom-control-input"
                                                id="rememberId" name="rememberId" checked>
                                          </c:when>
                                          <c:otherwise>
                                             <input type="checkbox" class="custom-control-input"
                                                id="rememberId" name="rememberId">
                                          </c:otherwise>
                                       </c:choose>
                                       <label class="custom-control-label loginCheck" for="rememberId">이메일 기억하기</label>
                                    </div>
                                    <div class="custom-control custom-checkbox">
                                       <c:choose>
                                          <c:when test="${cookie.autoLogin.value != null }">
                                             <input type="checkbox" class="custom-control-input"
                                                id="autoLogin" name="autoLogin" checked>
                                          </c:when>
                                          <c:otherwise>
                                             <input type="checkbox" class="custom-control-input"
                                                id="autoLogin" name="autoLogin">
                                          </c:otherwise>
                                       </c:choose>
                                       <label class="custom-control-label loginCheck" for="autoLogin">자동
                                          로그인</label>
                                    </div>
                                 </div>
                                 <!-- End .custom-checkbox -->

                                 <button id="loginBtn" type="submit"
                                    class="btn btn-outline-primary-2 forgot-link">
                                    <span>로그인</span>
                                 </button>
                              </div>
                              <!-- End .form-footer -->

										<input type="hidden" name="path" value="${param.path }">
									</form>
									${pageContext.request.contextPath }
									<div class="form-choice mt-3">
										<p class="text-center">소셜 로그인</p>
										<div class="row">
											<div class="col-sm-12">
<!-- 												<a href="https://kauth.kakao.com/oauth/authorize?client_id=fedfd31e6211b6353700f2d410a0c0d5&redirect_uri=http://localhost:8081/customer/getCodeForKakao&response_type=code" class="btn btn-login btn-g" onclick="savePathToKakao();" style="background-color: #FEE500;">  -->
												<a href="https://kauth.kakao.com/oauth/authorize?client_id=fedfd31e6211b6353700f2d410a0c0d5&redirect_uri=http://goott351.cafe24.com/customer/getCodeForKakao&response_type=code" class="btn btn-login btn-g" onclick="savePathToKakao();" style="background-color: #FEE500;"> 
													<img src="${pageContext.request.contextPath }/resources/assets/images/kakao_login.png">
												</a>
											</div>
										</div>
										<!-- End .row -->
									</div>
									<!-- End .form-choice -->
								</div>
								<!-- .End .tab-pane -->
								<!-- 로그인 끝 -->

                                <div class="tab-pane fade" id="register-2" role="tabpanel" aria-labelledby="register-tab-2">
                                    <form action="register_jhs" method="post">
                                        <input type="hidden" name="pathR" value="${param.path }"> <!-- 돌아갈 경로를 담아놓을 태그 -->
                                        <div class="form-group email-form">
                                            <label for="emailRegister" class="form-label">이메일 *</label>

                                            <div class="input-group">
                                                <input class="form-control" placeholder="이메일을 입력해주세요." name="emailRegister" id="emailRegister" type="email">
                                                <input type="button" value="인증하기" class="btn btn-outline-primary-2 btn-minwidth-sm" id="emailAuth">
                                            </div>
                                            <span id="emailWarn"></span>


                                            <div class=" mail-check-box codeDiv" style="display: none;">
                                                <input class="form-control" placeholder="인증 코드 6자리를 입력해주세요." maxlength="6" name="authCode" id="authCode" type="text">
                                            </div>
                                            <span id="emailAuthWarn"></span>
                                        </div>


                                        <div class="form-group">
                                            <label for="passwordRegister" class="form-label">비밀번호
                                                *</label>
                                            <div class="password-container">
                                                <input type="password" class="form-control error-field" id="passwordRegister" placeholder="비밀번호를 입력해주세요." name="passwordRegister" maxlength="20">
                                                <img src="../resources/assets/images/backgrounds/close1.png" class="password-toggle" id="togglePassword" style="width: 20px;" >
                                            </div>
                                            <span id="passwordRegisterMsg"></span>
                                        </div>

                                        <div class="form-group">
                                            <label for="password2" class="form-label">비밀번호 확인 *</label>
                                            <div class="password-container">
                                                <input type="password" class="form-control error-field" id="password2" placeholder="비밀번호를 한번 더 입력해주세요." name="password2" maxlength="20">
                                                <img src="../resources/assets/images/backgrounds/close1.png" class="password-toggle" id="togglePassword2" style="width: 20px;">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="name" class="form-label">이름 *</label> <input type="text" class="form-control error-field" id="name" placeholder="이름을 입력해주세요." name="name">
                                        </div>
                                        <div class="form-group  ">
                                            <label for="birthday" class="form-label">생년월일 *</label> <input type="date" name="birthday" id="birthday" min="1900-01-01" max="2024-03-29" class="form-control">
                                            <span id=age></span>
                                            <span id=mistake></span>
                                        </div>

                                        <div class="form-group genders">
                                            <span class="genderAll">성별</span>
                                            <div class="custom-control custom-radio">
                                                <input type="radio" name="gender" value="male" id="male" class="custom-control-input" checked> <label for="male" class="form-label custom-control-label male">남</label>
                                            </div>
                                            <div class="custom-control custom-radio">
                                                <input type="radio" name="gender" value="female" id="female" class="custom-control-input"> <label for="female" class="form-label custom-control-label female">여</label>
                                            </div>
                                        </div>

                                        <div id="RegisterHide">
                                            <div class="form-group error-field">
                                                <label for="nickname" class="form-label">닉네임 *</label> <input type="text" class="form-control error-field" id="nickname" maxlength="7" size="7" placeholder="닉네임을 입력해주세요." name="nickname">
                                            </div>


                                            <div class="form-group error-field">
                                                <label for="phoneNumber" class="form-label">핸드폰번호 *</label>
                                                <input type="text" class="form-control error-field" id="phoneNumber" placeholder="핸드폰번호를 입력해주세요." name="phoneNumber" maxlength="13" size="13">
                                                <span id="onlyNum">'-' 없이 숫자만 입력해주세요.</span>
                                            </div>

                                            <div class="form-group">
                                                <label for="address" class="form-label">주소 *</label>
                                                <div>
                                                    <input type="text" id="addrPostcode" class="form-control postCode" placeholder="우편번호 주소" name="addrPostcode" readonly> <input type="button" onclick="execDaumPostcode()" class="btn btn-outline-primary-2 btn-minwidth-sm postBtn" value="우편번호 찾기" id="postBtn">
                                                </div>
                                                <br> <input type="text" id="addr" name="addr" class="form-control" placeholder="주소를 입력해주세요." readonly>
                                                <input type="text" id="addrDetail" name="addrDetail" class="form-control" placeholder="상세주소를 입력해주세요.">
                                            </div>

                                            <div class="form-group">
                                                <label for="userName" class="form-label">예금주</label> <input type="text" class="form-control" id="userName" placeholder="예금주를 입력해주세요." name="userName" readonly>
                                            </div>

                                            <div class="form-group">
                                                <label for="bankName" class="form-label">은행명 </label> <select id="bankName" name="bankName" class="form-control" style="width: 150px;">
                                                    <option value='' selected="selected">은행 선택</option>
                                                    <option value="국민은행">국민은행</option>
                                                    <option value="신한은행">신한은행</option>
                                                    <option value="기업은행">기업은행</option>
                                                    <option value="하나은행">하나은행</option>
                                                    <option value="농협은행">농협은행</option>
                                                    <option value="우리은행">우리은행</option>
                                                    <option value="카카오뱅크">카카오뱅크</option>
                                                    <option value="케이뱅크">케이뱅크</option>
                                                    <option value="신협은행">신협은행</option>
                                                    <option value="제일은행">SC제일은행</option>
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
                                            </div>




                                            <div class="form-group error-field">
                                                <label for="refundAccount" class="form-label">계좌번호</label> <input type="text" class="form-control" id="refundAccount" placeholder="계좌번호를 입력해주세요." name="refundAccount" maxlength="14" size="14" disabled>
                                                <span id="onlyNum">'-' 없이 숫자만 입력해주세요.</span>
                                            </div>



                                            <div class="form-group">
                                                <label class="form-label" style="margin-bottom: 0px;"> 약관동의 * </label>
                                                <div class="custom-control custom-checkbox" style="margin-top: 5px;">
                                                    <input type="checkbox" id="allCheck" name="msgAgree" class="custom-control-input agree" value="Y" /> <label for="allCheck" class="custom-control-label hrefColor" id="agreeCk">전체동의</label>
                                                </div>

                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" id="check2" name="msgAgree1" class="custom-control-input agree" value="Y" /> <label for="check2" class="custom-control-label hrefColor" id="agreeCk">이용약관 동의<span class="essential">(필수)</span></label><a href="#agree-modal" data-toggle="modal" style="padding-left: 10px; color : gray">더보기</a>
                                                </div>
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" id="check1" name="msgAgree2" class="custom-control-input agree" value="Y" /> <label for="check1" class="custom-control-label hrefColor" id="agreeCk">개인정보 수집 및 이용 동의
                                                        <span class="essential">(필수)</span></label>
                                                    <a href="#agree2-modal" data-toggle="modal" style="padding-left: 5px; color : gray">더보기</a>
                                                </div>
                                                <div class="custom-control custom-checkbox" id="check4MsgAgree">
                                                    <input type="checkbox" id="check3" name="check3" class="custom-control-input agree" /> <label for="check3" class="custom-control-label hrefColor" id="agreeCk">메일 문자 수신
                                                        동의 <span class="select">(선택)</span></label>
                                                    <a href="#agree3-modal" data-toggle="modal" style="padding-left: 5px; color : gray">더보기</a>
                                                </div>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="form-group" style="justify-content : center; text-align: center">
                                            <button type="submit" class="btn btn-outline-primary-2 btn-minwidth-sm" onclick="return validCheck();" id="registerBtn">회원가입</button>
                                        </div>
                                    </form>
                                    <div class="form-group" style="justify-content : center; text-align: center">
                                        <button type="button" class="btn btn-outline-primary-2 btn-minwidth-sm" onclick="goToMainPage();" id="mainBtn">메인으로 가기</button>
                                    </div>

                                </div>
                                <!-- .End .tab-pane -->
                            </div>
                            <!-- End .tab-content -->
                        </div>
                        <!-- End .form-tab -->
                    </div>
                    <!-- End .form-box -->
                </div>
                <!-- End .container -->
            </div>
            <!-- End .login-page section-bg -->
        </main>
        <!-- End .main -->
    </div>

    <jsp:include page="../footer.jsp"></jsp:include>


    <div class="modal fade" id="agree-modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-body">

                    <div class="form-box">
                        <div class="form-tab">
                            <ul class="nav nav-pills nav-fill" role="tablist">
                                <li class="nav-item"><a class="nav-link active" id="agree-tab" data-toggle="tab" href="#agree" role="tab" aria-controls="agree" aria-selected="true">이용약관 동의</a>
                                </li>

                            </ul>
                            <div class="tab-content" id="tab-content-5">
                                <div class="tab-pane fade show active" id="agree" role="tabpanel" aria-labelledby="agree-tab">
                                    <div class="form-group">
                                        <div class="modal_body2" style="max-height: calc(50vh - 200px); overflow-x: hidden; overflow-y: 20px;">
                                            <div class="modal_con_overflow" tabindex="0">
                                                <!--다사자규 서비스 이용약관-->
                                                <div class="agreed_txt_wrap">
                                                    <div class="agreed_txt">

                                                        <div>
                                                            <ul>
                                                                <li class="form-footer" style="font-size: 20px; justify-content: center; padding-top: 30px;">제1장
                                                                    총칙</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제1조. (목적)</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_content">
                                                            <ul>
                                                                <li class="frt_txt form-footer">본 약관은 다사자규
                                                                    통합인증 포털(이하 "다사자규 포털")이 제공하는 모든 서비스(이하 "서비스")의 이용조건 및
                                                                    절차, 이용자와 다사자규 포털의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로
                                                                    합니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제2조. (용어의
                                                                    정의)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul class="form-footer">
                                                                <li class="frt_txt">본 약관에서 사용하는 용어의 정의는 다음과 같습니다.</li>
                                                                <li><span class="frt_num">1.</span> 이용자 : 본 약관에 따라
                                                                    다사자규포털이 제공하는 서비스를 받는 자</li>
                                                                <li><span class="frt_num">2.</span> 가입 : 다사자규 포털이
                                                                    제공하는 신청서 양식에 해당 정보를 기재하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위</li>
                                                                <li><span class="frt_num">3.</span> 회원 : 본 약관에
                                                                    동의하고, 정상적으로 ID와 인증수단을 발급받아 이용할 수 있는 권한을 부여받은 개인</li>
                                                                <li><span class="frt_num">4.</span> ID : 사용자가 회원가입
                                                                    시 등록한 ID로 다사자규 포털에서 사용하는 ID</li>
                                                                <li><span class="frt_num">5.</span> 비밀번호 : 이용자와
                                                                    아이디가 일치하는지를 확인하고 통신상의 자신의 비밀 보호를 위하여 이용자 자신이 문자, 숫자,
                                                                    특수문자 조합으로 선정한 번호</li>
                                                                <li><span class="frt_num">6.</span> 탈퇴 : 회원이 이용가입을
                                                                    종료시키는 행위</li>
                                                                <li><span class="frt_num">7.</span> 연계사이트 :“다사자규
                                                                    서비스이용기관 협약”에 따라 다사자규 포털과 연계되어 있는 사이트</li>
                                                                <li><span class="frt_num">8.</span> 연계사이트 목록 :
                                                                    다사자규 포털에 게시되어 있는 연계사이트 목록</li>
                                                                <li><span class="frt_num">9.</span> 개인정보 제3자 제공 대상
                                                                    및 항목 :“개인정보 제3자 제공 동의”에 정의된 제공 대상 및 항목</li>
                                                                <li class="p_num">이 약관에서 정의하지 않은 용어는 개별 서비스에 대한 약관
                                                                    및 이용규정에서 정하는 바에 의합니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제3조. (약관의
                                                                    효력과 변경)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul class="form-footer">
                                                                <li><span class="frt_num">1.</span> 본 약관은 다사자규 포털
                                                                    게시판에 게시되고, 귀하가 회원가입을 완료함으로써 그 효력이 발생합니다.</li>
                                                                <li><span class="frt_num">2.</span> 관리자가 본 약관을 변경하는
                                                                    경우, 적용 일자와 변경사항을 명시하여 적용 일자 7일 전에 다사자규 포털 게시판을 통해
                                                                    공지하거나 e-mail을 통해 회원에게 공지하며, 공지와 동시에 그 효력이 발생합니다.</li>
                                                                <li><span class="frt_num">3.</span> 관리자가 제2항에 따라
                                                                    변경된 약관을 공지하면서 회원에게 변경된 약관의 적용일까지 거부 의사를 표시하지 않으면 약관의
                                                                    변경에 동의한 것으로 간주한다는 내용을 명확하게 공지하였음에도 회원이 명시적으로 거부의 의사표시를
                                                                    하지 아니한 경우 회원이 개정약관에 동의한 것으로 봅니다. 이 경우 변경되어 공지된 약관의 내용을
                                                                    알지 못해 발생하는 회원의 피해는 관리자가 책임지지 않습니다.</li>
                                                                <li><span class="frt_num">4.</span> 회원이 변경된 약관의 적용에
                                                                    동의하지 않을 때에는 서비스 이용을 중단하고, 이용가입을 해지할 수 있습니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제4조. (약관 외
                                                                    준칙)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul>
                                                                <li class="frt_txt">본 약관에 명시되지 않는 사항이 관계 법령에 규정되어
                                                                    있는 경우 그 규정을 따르며, 그렇지 않으면 일반적인 관례에 따릅니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title">
                                                            <ul>
                                                                <li class="agreed_txt_tit form-footer" style="font-size: 20px; justify-content: center; padding-top: 30px;">제2장
                                                                    서비스 이용</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제5조.
                                                                    (이용가입의 성립)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content form-footer">
                                                            <ul>
                                                                <li><span class="frt_num">1.</span> 이용가입은 신청자가
                                                                    온라인으로 다사자규 포털에서 제공하는 소정의 가입신청 양식에서 요구하는 사항을 기록하여 가입을
                                                                    완료하는 것으로 성립됩니다.</li>
                                                                <li><span class="frt_num">2.</span> 다사자규 포털은 다음 각
                                                                    호에 해당하는 이용가입에 대하여는 가입을 취소할 수 있습니다.</li>
                                                            </ul>
                                                            <ul class="agree_content_num2">
                                                                <li><span class="frt_num2">1)</span> 다른 사람의 명의를
                                                                    사용하여 신청하였을 때</li>
                                                                <li><span class="frt_num2">2)</span> 이용 가입 신청서의 내용을
                                                                    허위로 기재하였거나 신청하였을 때</li>
                                                                <li><span class="frt_num2">3)</span> 사회의 안녕질서 혹은
                                                                    미풍양속을 저해할 목적으로 신청하였을 때</li>
                                                                <li><span class="frt_num2">4)</span> 다른 사람의 서비스 이용을
                                                                    방해하거나 그 정보를 도용하는 등의 행위를 하였을 때</li>
                                                                <li><span class="frt_num2">5)</span> 본 서비스를 이용하여
                                                                    법령과 본 약관이 금지하는 행위를 하는 경우</li>
                                                                <li><span class="frt_num2">6)</span> 기타 다사자규 포털에서
                                                                    정한 이용신청요건이 미비 되었을 때</li>
                                                            </ul>
                                                            <ul>
                                                                <li><span class="frt_num">3.</span> 본 약관 제10조 제1항의
                                                                    사항에 해당하면 그 사유가 해소될 때까지 이용가입 성립을 유보할 수 있습니다.</li>
                                                                <li><span class="frt_num">※</span>다사자규 포털이 제공하는
                                                                    서비스는 그 변경될 서비스의 내용을 제10조 제2항에 따라 이용자에게 공지하고 서비스를 변경하여
                                                                    제공할 수 있습니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제6조. (회원정보
                                                                    사용에 대한 동의)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content form-footer">
                                                            <ul>
                                                                <li><span class="frt_num">1.</span>회원의 정보에 대해서는
                                                                    다사자규 포털의 회원 정보보호 처리방침이 적용됩니다.</li>
                                                                <li><span class="frt_num">2.</span>다사자규 포털의 회원
                                                                    정보는 다음과 같이 수집, 사용, 관리, 보호됩니다.</li>
                                                            </ul>
                                                            <ul class="agree_content_num2">
                                                                <li><span class="frt_num2">1)</span>회원정보의 수집 :
                                                                    다사자규 포털은 귀하의 당 서비스 가입 시 귀하가 제공하는 정보를 통하여 귀하에 관한 정보를
                                                                    수집합니다.</li>
                                                                <li><span class="frt_num2">2)</span>회원정보의 사용 :
                                                                    다사자규 포털은 당 서비스 제공과 관련해서 수집된 회원의 신상정보를 본인의 승낙 없이 제3자에게
                                                                    누설, 배포하지 않습니다. 단, 전기통신 기본법 등 법률의 규정에 따라 국가기관의 요구가 있는
                                                                    경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리 위원회의 요청이 있는 경우 또는 기타 관계
                                                                    법령에서 정한 절차에 따른 요청이 있는 경우, 귀하가 다사자규 포털에 제공한 개인정보를 스스로
                                                                    공개한 경우에는 그러하지 않습니다.</li>
                                                                <li><span class="frt_num2">3)</span>회원정보의 관리 : 귀하는
                                                                    개인정보의 보호 및 관리를 위하여 서비스의 개인정보관리에서 수시로 귀하의 개인정보를 수정/삭제할 수
                                                                    있습니다. 수신되는 정보 중 불필요하다고 생각되는 부분도 변경/조정할 수 있습니다.</li>
                                                                <li><span class="frt_num2">4)</span>회원정보의 보호 : 귀하의
                                                                    개인정보는 오직 귀하만이 열람/수정/삭제할 수 있으며, 이는 전적으로 귀하의 ID와 인증수단에 의해
                                                                    관리되고 있습니다. 따라서 타인에게 본인의 ID와 인증수단을 알려주어서는 아니 되며, 작업 종료
                                                                    시에는 반드시 로그아웃해주시고, 웹 브라우저의 창을 닫아주시기 바랍니다. 이는 타인과 컴퓨터를
                                                                    공유하는 인터넷 카페나 도서관 같은 공공장소에서 컴퓨터를 사용하는 경우에 귀하의 정보 보호를 위하여
                                                                    필요한 사항입니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제7조. (회원의
                                                                    정보보안)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul class="form-footer">
                                                                <li><span class="frt_num">1.</span> 가입 신청자가 가입 절차를
                                                                    완료하는 순간부터 귀하는 입력한 정보의 비밀을 유지할 책임이 있으며, 회원의 ID와 인증수단을
                                                                    사용하여 발생하는 모든 결과에 대한 책임은 회원 본인에게 있습니다.</li>
                                                                <li><span class="frt_num">2.</span> ID와 인증수단에 관한 모든
                                                                    관리의 책임은 회원에게 있으며, 회원의 ID나 인증수단이 부정하게 사용되었다는 사실을 발견한
                                                                    경우에는 즉시 다사자규 포털에 신고하여야 합니다. 신고하지 않음으로 인한 모든 책임은 회원
                                                                    본인에게 있습니다.</li>
                                                                <li><span class="frt_num">3.</span> 이용자는 서비스의 사용 종료
                                                                    시마다 정확히 접속을 종료하도록 해야 하며, 정확히 종료하지 아니함으로써 제3자가 귀하에 관한
                                                                    정보를 이용하게 되는 등으로 인해 발생하는 손해 및 손실에 대하여 다사자규 포털은 책임을
                                                                    부담하지 아니합니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제8조.(서비스
                                                                    이용시간)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul class="form-footer">
                                                                <li><span class="frt_num">1.</span> 서비스 이용시간은
                                                                    다사자규 포털의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로
                                                                    합니다.</li>
                                                                <li><span class="frt_num">2.</span> 제1항의 이용시간은 정기점검
                                                                    등의 필요로 인하여 다사자규 포털이 정한 날 또는 시간은 예외로 합니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제9조. (서비스의
                                                                    중지)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul class="form-footer">
                                                                <li><span class="frt_num">1.</span> 귀하는 다사자규 포털에
                                                                    보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 국가의 비상사태, 정전, 당 포털의 관리
                                                                    범위 외의 서비스 설비 장애 및 기타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지
                                                                    못한 경우 및 기타 통신 데이터의 손실이 있으면 다사자규 포털은 관련 책임을 부담하지
                                                                    아니합니다.</li>
                                                                <li><span class="frt_num">2.</span> 다사자규 포털이 정상적인
                                                                    서비스 제공의 어려움으로 인하여 일시적으로 서비스를 중지하여야 하면 서비스 중지 1주일 전의 고지
                                                                    후 서비스를 중지할 수 있으며, 이 기간에 귀하가 고지내용을 인지하지 못한 데 대하여 다사자규
                                                                    포털은 책임을 부담하지 아니합니다. 부득이한 사정이 있으면 위 사전 고지 기간은 감축되거나 생략될
                                                                    수 있습니다. 또한, 위 서비스 중지 때문에 본 서비스에 보관되거나 전송된 메시지 및 기타 통신
                                                                    메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의
                                                                    손실이 있을 경우에 대하여도 다사자규 포털은 책임을 부담하지 아니합니다.</li>
                                                                <li><span class="frt_num">3.</span> 다사자규 포털의 사정으로
                                                                    서비스를 영구적으로 중단하여야 하면 제2항에 의거합니다. 다만, 이 경우 사전 고지 기간은 1개월로
                                                                    합니다.</li>
                                                                <li><span class="frt_num">4.</span> 다사자규 포털은 사전
                                                                    고지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 이에 대하여 귀하 또는 제3자에게
                                                                    어떠한 책임도 부담하지 아니합니다.</li>
                                                                <li><span class="frt_num">5.</span> 다사자규 포털은 이용자가
                                                                    본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지할 수 있습니다. 이
                                                                    경우 다사자규 포털은 위 이용자의 접속을 금지할 수 있습니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제10조.
                                                                    (연계사이트 이용)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul class="form-footer">
                                                                <li><span class="frt_num">1.</span> 다사자규 포털 회원은
                                                                    연계사이트 목록에 게시되어 있는 사이트에 대해 별도의 가입절차 없이 원활하게 이용할 수 있습니다.</li>
                                                                <li><span class="frt_num">2.</span> 연계사이트는 다사자규의 포털 운영 관련 정책의 변경, 개별 사이트의 사정에 따라 추가 또는 제외될 수 있으며,
                                                                    해당 변경 사항은 다사자규 포털 게시판을 통해 공지하거나 e-mail을 통해 회원에게
                                                                    공지합니다.</li>
                                                                <li><span class="frt_num">3.</span> 다사자규 포털과
                                                                    연계사이트 중 일부 사이트의 특정 서비스를 제공하기 위해 회원에게 별도 또는 추가적인 가입절차 및
                                                                    정보입력을 요청할 수 있으며, 회원이 이러한 특정 서비스를 이용할 경우 해당 사이트 또는 서비스의
                                                                    이용 약관, 규정 또는 세칙 등이 본 약관보다 우선 적용됩니다.</li>
                                                                <li><span class="frt_num">4.</span> 회원의 ID 및 인증수단에
                                                                    관한 관리책임은 회원 본인에게 있으며 “개인정보 제3자 제공 동의”에 정의된 제공 대상 이외의
                                                                    대상에게 ID 및 인증수단을 알려주거나 이용하게 해서는 안 됩니다.</li>
                                                                <li><span class="frt_num">5.</span> 회원이 자신의 ID 및
                                                                    인증수단을 도용당하거나 “개인정보 제3자 제공 동의”에 정의된 제공 대상 이외의 대상이 사용하고
                                                                    있음을 인지한 경우에는 즉시 관리자에게 통보하고 그 안내에 따라야 합니다.</li>
                                                                <li><span class="frt_num">6.</span> 다사자규 포털의 귀책사유
                                                                    없이 회원이 자신의 ID 및 인증수단을 도용당한 데 따른 손해에 대해서는 법적 책임을 부담하지
                                                                    않습니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title">
                                                            <ul>
                                                                <li class="agreed_txt_tit form-footer" style="font-size: 20px; justify-content: center; padding-top: 30px;">제3장
                                                                    의무 및 책임</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제11조.
                                                                    (다사자규 포털의 의무)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul class="form-footer">
                                                                <li><span class="frt_num">1.</span> 다사자규 포털은 법령과
                                                                    본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적, 안정적으로 서비스를 제공하기
                                                                    위해 노력할 의무가 있습니다.</li>
                                                                <li><span class="frt_num">2.</span> 다사자규 포털은 약관
                                                                    변경사항의 공지 또는 회원에 대한 통지가 필요한 경우 해당 절차를 성실히 준수하여 수행합니다.</li>
                                                                <li><span class="frt_num">3.</span> 다사자규 포털은 회원이
                                                                    본 약관을 위배했다고 판단되면 서비스와 관련된 모든 정보를 이용자의 동의 없이 삭제할 수 있습니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제12조. (회원의
                                                                    의무 및 서비스 이용제한)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content form-footer">
                                                            <ul>
                                                                <li><span class="frt_num">1.</span> 귀하가 제공하는 정보의
                                                                    내용이 허위인 것으로 판명되거나, 그러하다고 의심할 만한 합리적인 사유가 발생하면 다사자규
                                                                    포털은 귀하의 본 서비스 사용을 일부 또는 전부 중지할 수 있으며, 이로 인해 발생하는 불이익에
                                                                    대한 책임을 부담하지 아니합니다.</li>
                                                                <li><span class="frt_num">2.</span> 귀하가 다사자규 포털
                                                                    서비스를 통하여 게시, 전송, 입수하였거나 전자메일 기타 다른 수단에 의하여 게시, 전송 또는
                                                                    입수한 모든 형태의 정보에 대하여는 귀하가 모든 책임을 부담하며 다사자규 포털은 어떠한 책임도
                                                                    부담하지 아니합니다.</li>
                                                                <li><span class="frt_num">3.</span> 다사자규 포털은 당
                                                                    포털이 제공한 서비스가 아닌 가입자 또는 기타 관계기관이 제공하는 서비스의 내용상의 정확성, 완전성
                                                                    및 질에 대하여 보장하지 않습니다. 따라서 다사자규 포털은 귀하가 위 내용을 이용함으로 인하여
                                                                    입게 된 모든 종류의 손실이나 손해에 대하여 책임을 부담하지 아니합니다.</li>
                                                                <li><span class="frt_num">4.</span> 귀하는 본 서비스를 통하여
                                                                    다음과 같은 행동을 하지 않는 데 동의합니다.</li>
                                                            </ul>
                                                            <ul class="agree_content_num2">
                                                                <li><span class="frt_num2">1)</span> 타인의 아이디(ID)와
                                                                    인증수단을 도용하는 행위</li>
                                                                <li><span class="frt_num2">2)</span> 저속, 음란, 모욕적,
                                                                    위협적이거나 타인의 프라이버시를 침해할 수 있는 내용을 전송, 게시, 게재, 전자메일 또는 기타의
                                                                    방법으로 전송하는 행위</li>
                                                                <li><span class="frt_num2">3)</span> 서비스를 통하여 전송된
                                                                    내용의 출처를 위장하는 행위</li>
                                                                <li><span class="frt_num2">4)</span> 법률, 약관에 의하여
                                                                    이용할 수 없는 내용을 게시, 게재, 전자메일 또는 기타의 방법으로 전송하는 행위</li>
                                                                <li><span class="frt_num2">5)</span> 타인의 특허, 상표,
                                                                    영업비밀, 저작권, 기타 지적 재산권을 침해하는 내용을 게시, 게재, 전자메일 또는 기타의 방법으로
                                                                    전송하는 행위</li>
                                                                <li><span class="frt_num2">6)</span> 다사자규 포털의 승인을
                                                                    받지 아니한 광고, 판촉물, 정크메일 등 다른 형태의 권유를 개시, 게재, 전자메일 또는 기타의
                                                                    방법으로 전송하는 행위</li>
                                                                <li><span class="frt_num2">7)</span> 다른 사용자의 개인정보를
                                                                    수집 또는 저장하는 행위</li>
                                                            </ul>
                                                            <ul>
                                                                <li><span class="frt_num">5.</span> 회원 가입 시에 요구되는
                                                                    정보는 정확하게 기재하여야 합니다. 또한, 이미 제공된 귀하에 대한 정보가 정확한 정보가 되도록
                                                                    유지, 갱신하여야 하며, 회원은 자신의 ID 및 인증수단을 제3자에게 이용하게 해서는 안 됩니다.</li>
                                                                <li><span class="frt_num">6.</span> 회원은 다사자규 포털의
                                                                    사전 승낙 없이 서비스를 이용하여 어떠한 영리 행위도 할 수 없습니다.</li>
                                                                <li><span class="frt_num">7.</span> 회원은 다사자규 포털
                                                                    서비스를 이용하여 얻은 정보를 포털관리자의 사전승낙 없이 복사, 복제, 변경, 번역, 출판·방송
                                                                    기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없습니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title">
                                                            <ul>
                                                                <li class="agreed_txt_tit form-footer" style="font-size: 20px; justify-content: center; padding-top: 30px;">제4장
                                                                    기타</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제13조.
                                                                    (다사자규 포털의 소유권)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul class="form-footer">
                                                                <li><span class="frt_num">1.</span>다사자규 포털이 제공하는
                                                                    서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과
                                                                    관련된 지적 재산권 및 기타 권리는 정부에 소유권이 있습니다.</li>
                                                                <li><span class="frt_num">2.</span>귀하는 다사자규 포털이
                                                                    명시적으로 승인한 경우를 제외하고는 전항의 소정의 각 재산에 대한 전부 또는 일부의 수정, 대여,
                                                                    대출, 판매, 배포, 제작, 양도, 재 라이센스, 담보권 설정 행위, 상업적 이용 행위가 할 수
                                                                    없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제14조.
                                                                    (양도금지)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul>
                                                                <li class="frt_txt form-footer">회원은 서비스의 이용 권한, 기타
                                                                    이용가입 상의 지위를 타인에게 양도 및 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제15조.
                                                                    (손해배상)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul>
                                                                <li class="frt_txt form-footer">다사자규 포털은 무료로 제공되는
                                                                    서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 고의로 행한 범죄행위를 제외하고 이에 대하여
                                                                    책임을 부담하지 아니합니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제16조.
                                                                    (면책조항)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul class="form-footer">
                                                                <li><span class="frt_num">1.</span>다사자규 포털은 서비스에
                                                                    표출된 어떠한 의견이나 정보에 대한 확신이나 대표할 의무가 없으며 회원이나 제3자에 의해 표출된
                                                                    의견을 승인하거나 반대하거나 수정하지 않습니다. 다사자규 포털은 어떠한 경우라도 회원이 서비스에
                                                                    담긴 정보에 의존해 얻은 이득이나 입은 손해에 대한 책임이 없습니다.</li>
                                                                <li><span class="frt_num">2.</span>다사자규 포털은 회원 간
                                                                    또는 회원과 제3자 간에 서비스를 매개로 하여 물품거래 혹은 금전적인 거래 등과 관련하여 어떠한
                                                                    책임도 부담하지 아니하고, 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 부담하지
                                                                    않습니다.</li>
                                                            </ul>
                                                        </div>

                                                        <div class="agree_title_sub">
                                                            <ul>
                                                                <li class="agreed_txt_tit_s form-footer">제17조.
                                                                    (관할법원)</li>
                                                            </ul>
                                                        </div>
                                                        <div class="agree_content">
                                                            <ul>
                                                                <li class="frt_txt">다사자규 포털과 이용자 간에
                                                                    발생한 서비스 이용에 관한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는
                                                                    대한민국의 법원에 제기합니다.</li>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                </div>
                                                <!--//다사자규 서비스 이용약관-->

                                            </div>
                                        </div>
                                        <div style="text-align:center; padding-top: 30px;">
                                            <button type="reset" class="btn btn-danger" id="closeBtn" style="display :inline-block; width: 150px; font-size:1.5rem; " data-dismiss="modal" aria-label="Close">닫기</button>
                                        </div>

                                    </div>
                                </div>


                            </div>

                        </div>


                    </div>
                    <!-- .End .tab-pane -->

                </div>
                <!-- .End .tab-pane -->
            </div>
            <!-- End .tab-content -->



        </div>
        <!-- End .form-tab -->
    </div>

    <div class="modal fade" id="agree2-modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-body">

                    <div class="form-box">
                        <div class="form-tab">
                            <ul class="nav nav-pills nav-fill" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="agree-tab" data-toggle="tab" href="#agree" role="tab" aria-controls="agree" aria-selected="true">개인정보 수집 및 이용 동의</a>
                                </li>
                            </ul>

                            <div class="modal_con_overflow" tabindex="0" style="max-height: calc(50vh - 200px); overflow-x: hidden; overflow-y: 20px;">
                                <!--개인정보 취급방침-->
                                <div class="personal_txt_wrap">
                                    <div class="personal_txt">
                                        <div class="personal_content">
                                            <ul>
                                                <li class="frt_txt form-footer">&lt;다사자규&gt;은(는) ｢개인정보 보호법｣ 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.</li>
                                            </ul>
                                        </div>

                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 1조. 개인정보의 처리 목적</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content form-footer">
                                            <ul>
                                                <li><span class="frt_num">①</span>&lt;다사자규&gt;는 개인정보를 다음의 목적을 위해 처리합니다.</li>
                                                <li><span class="frt_num2">처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 사용되지 않으며, 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</span></li>
                                                <li><span class="frt_num2">가. </span>서비스 제공</li>
                                                <li><span class="frt_num2"><b style="text-decoration:underline;">회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 만14세 미만 아동 개인정보 수집 시 법정대리인 동의 여부 확인, 각종 고지·통지, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적</b>으로 개인정보를 처리합니다.</span></li>
                                                <li><span class="frt_num">②</span>다사자규가 개인정보 보호법 제32조에 따라 등록·공개하는 개인정보파일의 처리목적은 다음과 같습니다.</li>

                                                <table class="table_06_1" id="serviceListTable">
                                                    <caption>개인정보파일의 처리목적</caption>
                                                    <colgroup>
                                                        <col width="10%">
                                                        <col width="20%">
                                                        <col width="20%">
                                                        <col width="50%">
                                                    </colgroup>
                                                    <thead>
                                                        <tr style="padding:0px 0px 0px 0px;">
                                                            <th scope="col" style="padding:0px 0px 0px 0px;">순번</th>
                                                            <th scope="col" style="padding:0px 0px 0px 0px;">개인정보파일의 명칭</th>
                                                            <th scope="col" style="padding:0px 0px 0px 0px;">운영근거</th>
                                                            <th scope="col" style="padding:0px 0px 0px 0px;">처리목적</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="data_list">
                                                        <tr>
                                                            <td>1</td>
                                                            <td>다사자규 회원</td>
                                                            <td>정보주체 동의</td>
                                                            <td>본인식별·인증, 회원자격 유지·관리</td>
                                                        </tr>
                                                    </tbody>
                                                </table>

                                                <li><span class="frt_num2 ">가. </span>다사자규는 다음의 개인정보 항목을 처리하고 있습니다.</li>

                                                <table class="table_06_1" id="serviceListTable">
                                                    <caption>개인정보파일에 기록되는 개인정보의 항목</caption>
                                                    <colgroup>
                                                        <col width="10%">
                                                        <col width="20%">
                                                        <col width="70%">
                                                    </colgroup>
                                                    <thead>
                                                        <tr style="padding:0px 0px 0px 0px;">
                                                            <th scope="col" style="padding:0px 0px 0px 0px;">순번</th>
                                                            <th scope="col" style="padding:0px 0px 0px 0px;">개인정보파일의 명칭</th>
                                                            <th scope="col" style="padding:0px 0px 0px 0px;">개인정보파일에 기록되는 개인정보의 항목</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="data_list">
                                                        <tr>
                                                            <td>1</td>
                                                            <td>다사자규 회원</td>
                                                            <td>이름,생년월일,성별,내 외국인 유무,로그인ID,연락처,법정대리인 이름,법정 대리인 생년월일,법정 대리인 연계정보,이메일,연계정보</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </ul>
                                        </div>
                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 2조. 개인정보의 처리 및 보유 기간</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content form-footer">
                                            <ul>
                                                <li><span class="frt_num">&lt;다사자규&gt;는 법령에 따른 개인정보 보유․이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유․이용기간 내에서 개인정보를 처리․보유합니다.</span></li>
                                                <li><span class="frt_num2"><b>가. </b></span><b>보유근거 : </b><b style="text-decoration:underline;">정보주체의 동의</b></li>
                                                <li><span class="frt_num2"><b>나. </b></span><b>처리목적 : </b><b style="text-decoration:underline;">홈페이지 회원가입 및 관리</b></li>
                                                <li><span class="frt_num2"><b style="font-size:17px; text-decoration:underline;">다. </b></span><b style="font-size:17px; text-decoration:underline;">보유기간 : 회원탈퇴시까지 2년(2년주기 재동의)</b></li>
                                                <li><span class="frt_num2">※ </span>단 다사자규는 홈페이지회원 등의 홍보 및 대국민서비스 목적의 이용 특성상 2년 주기로 <b>홈페이지 재동의 절차</b>를 통한 동의자에 한해 계속적인 보유 가능<br>(행정안전부 표준개인정보보호지침 제60조 개인정보파일보유기간의 산정 ③항 근거)</li>
                                                <li><span class="frt_num2"><b>라. </b></span><b>동의 거부권과 불이익 : </b>정보주체는 개인정보의 수집·이용 목적에 대한 동의를 거부할 수 있으며, 동의 거부시 다사자규 홈페이지에 회원가입이 되지 않으며 다사자규에서 제공하는 서비스를 이용할 수 없습니다.</li>
                                            </ul>
                                        </div>
                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 3조. 개인정보처리의 위탁</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content form-footer">
                                            <ul>
                                                <li><span class="frt_num">① </span>&lt;다사자규&gt;는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.</li>
                                                <li><span class="frt_num2"><b>가. </b></span><b>위탁 업무 : 다사자규 운영 및 유지관리</b></li>
                                                <li><span class="frt_num2"><b>나. </b></span><b>위탁받는 자(수탁자) : 한국지역정보개발원</b></li>
                                                <li><span class="frt_num2">- </span>주소 : 서울시 마포구 성암로 301 (상암동)</li>
                                                <li><span class="frt_num2">- </span>전화 : 02-2031-9828</li>
                                                <li><span class="frt_num2"><b>다. </b></span><b>재위탁받는 자(재수탁자) : 씨앤비시스템(주)</b></li>
                                                <li><span class="frt_num2">- </span>주소 : 서울시 강서구 공항대로 103 마곡엠밸리9단지 업무시설동</li>
                                                <li><span class="frt_num2">- </span>전화 : 1533-3713</li>
                                                <li><span class="frt_num">② </span>&lt;다사자규&gt;는 위탁계약 체결 시 ｢개인정보 보호법｣ 제26조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적․관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리․감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.</li>
                                                <li><span class="frt_num">③ </span>위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.</li>
                                            </ul>
                                        </div>
                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 4조. 정보주체와 법정대리인의 권리의무 및 그 행사방법</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content form-footer">
                                            <ul>
                                                <li class="frt_txt">이용자는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다.</li>
                                                <li><span class="frt_num">① </span>정보주체는 &lt;다사자규&gt;에 대해 언제든지 다음 각호에 해당하는 개인정보에 관련한 권리를 행사할 수 있습니다.<br>
                                                    가. 개인정보 열람요구<br>
                                                    나. 개인정보의 오류에 대한 정정 및 삭제의 요구<br>
                                                    다. 처리정지 요구 </li>
                                                <li><span class="frt_num">② </span>제1항에 따른 권리 행사는 &lt;다사자규&gt;에 대해 개인정보 보호법 시행령 제41조 제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며, &lt;다사자규&gt;는 이에 대해 지체 없이 조치하겠습니다.</li>
                                                <li><span class="frt_num">③ </span>제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 “개인정보 처리 방법에 관한 고시(제2020-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.</li>
                                                <li><span class="frt_num">④ </span>개인정보 열람 및 처리정지 요구는 개인정보보호법 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한될 수 있습니다. </li>
                                                <li><span class="frt_num">⑤ </span>개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다. </li>
                                                <li><span class="frt_num">⑥ </span>&lt;다사자규&gt;는 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다. </li>
                                            </ul>
                                        </div>
                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 5조. 처리하는 개인정보의 항목</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content form-footer">
                                            <ul>
                                                <li><span class="frt_num"></span>&lt;다사자규&gt;는 다음의 개인정보 항목을 처리하고 있습니다.</li>
                                                <li><span class="frt_num"><b>가. </b></span><b>다사자규 회원정보</b></li>
                                                <li><span class="frt_num2"><b style="font-size:17px; text-decoration:underline;">- </b></span><b style="font-size:17px; text-decoration:underline;">필수 수집 항목</b><br>
                                                    <b style="font-size:17px; text-decoration:underline; margin-left:10px;">· 홈페이지 가입 : 이름, 생년월일, 성별, 내 외국인 유무, 연계정보, 로그인ID, 이메일, 연락처, 법정대리인 이름, 법정대리인 생년월일, 법정대리인 연계정보</b></li>
                                                <li><span class="frt_num2">- </span>선택 수집 항목<br>
                                                    <span style="margin-left:10px;">· 선택항목 수집하지 않음</span></li>
                                            </ul>
                                        </div>
                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 6조. 개인정보의 파기</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content ">
                                            <ul class="personal_content_num2 form-footer">
                                                <li><span class="frt_num">① </span>&lt;다사자규&gt;는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다. 다만, 본 방침 제2조 내용에 따라 동의자에 한해 연장되거나 다른 법령에 따라 보존이 필요한 경우 파기되지 않을 수 있습니다.</li>
                                                <li><span class="frt_num">② </span>개인정보 파기의 절차 및 방법은 다음과 같습니다.</li>
                                                <li><span class="frt_num">가. </span>파기절차</li>
                                                <li><span class="frt_num2"></span>&lt;다사자규&gt;는 불필요한 개인정보 및 개인정보파일은 개인정보책임자의 책임하에 내부방침 절차에 따라 다음과 같이 처리하고 있습니다.</li>
                                                <li><span class="frt_num2">- </span>개인정보의 파기<br>
                                                    <span style="margin-left:10px;">· 보유기간이 경과한 개인정보는 종료일로부터 지체 없이 파기합니다.</span></li>
                                                <li><span class="frt_num2">- </span>개인정보파일의 파기<br>
                                                    <span style="margin-left:10px;">· 개인정보파일의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보파일이 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 지체 없이 그 개인정보파일을 파기합니다.</span></li>
                                                <li><span class="frt_num">나. </span>파기방법</li>
                                                <li><span class="frt_num2">1) </span>전자적 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.</li>
                                                <li><span class="frt_num2">2) </span>종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.</li>
                                            </ul>
                                        </div>
                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 7조. 개인정보의 안전성 확보 조치</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content form-footer">
                                            <ul>
                                                <li><span class="frt_num">&lt;다사자규&gt;는 「개인정보 보호법 제29조」에 따라 다음과 같이 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.</span></li>
                                                <li><span class="frt_num">①</span>내부관리계획의 수립 및 시행</li>
                                                <li><span class="frt_num2">내부관리계획 수립 및 시행은 다사자규 내부관리계획을 준수하여 시행합니다.</span></li>
                                                <li><span class="frt_num">②</span>개인정보에 대한 접근 제한</li>
                                                <li><span class="frt_num2">개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경, 말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.</span></li>
                                                <li><span class="frt_num">③</span>개인정보의 암호화</li>
                                                <li><span class="frt_num2">이용자의 개인정보는 암호화 되어 저장 및 관리되고 있습니다. 또한 중요한 데이터는 저장 및 전송 시 암호화하여 사용하는 등의 별도 보안기능을 사용하고 있습니다.</span></li>
                                                <li><span class="frt_num">④</span>개인정보 취급 직원의 최소화 및 교육</li>
                                                <li><span class="frt_num2">개인정보처리시스템에 접속한 기록(웹 로그, 요약정보 등)을 1년 이상 보관, 관리하고 있으며, 5만명 이상의 정보 주체에 관하여 개인정보를 처리하거나, 고유식별정보 또는 민감정보를 처리하는 개인정보처리 시스템의 경우에는 2년 이상 보관, 관리하고 있습니다. 개인정보처리시스템에 접속한 기록은 위변조 및 도난, 분실되지 않도록 보안 기능을 사용하고 있습니다.</span></li>
                                                <li><span class="frt_num">⑤</span>개인정보 취급 담당자의 최소화 및 교육</li>
                                                <li><span class="frt_num2">개인정보를 취급하는 담당자를 지정하고 최소화하여 개인정보를 관리하는 대책을 시행하고 있습니다.</span></li>
                                                <li><span class="frt_num">⑥</span>해킹 등에 대비한 기술적 대책</li>
                                                <li><span class="frt_num2">해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신·점검을 하며 외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다.</span></li>
                                                <li><span class="frt_num">⑦</span>비인가자에 대한 출입통제</li>
                                                <li><span class="frt_num2">개인정보를 보관하고 있는 개인정보시스템의 물리적 보관장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.</span></li>
                                            </ul>
                                        </div>
                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 8조. 개인정보 자동 수집 장치의 설치·운영 및 거부에 관한 사항</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content form-footer">
                                            <ul>
                                                <li><span class="frt_num">①</span>&lt;다사자규&gt;는 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(Cookie)’를 사용합니다.</li>
                                                <li><span class="frt_num">②</span>쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다.<br>
                                                    <ol>
                                                        <li>가. 쿠키의 사용 목적 : 이용자 공지사항 등 팝업 허용 여부를 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.</li>
                                                        <li>나. 쿠키의 설치·운영 및 거부 : 웹브라우저 상단의 도구&gt;인터넷 옵션&gt;개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부할 수 있습니다.
                                                            <ol>
                                                                <li style="margin-left:10px;">- Internet Explorer : 웹브라우저 우측 상단의 도구 메뉴 &gt; 인터넷 옵션 &gt; 개인정보 &gt; 설정 &gt; 고급 </li>
                                                                <li style="margin-left:10px;">- Edge: 웹브라우저 우측 상단의 설정 메뉴 &gt; 쿠키 및 사이트 권한 &gt; 쿠키 및 사이트 데이터 관리 및 삭제 </li>
                                                                <li style="margin-left:10px;">- Chrome: 웹브라우저 우측 상단의 설정 메뉴 &gt; 개인정보 및 보안 &gt; 쿠키 및 기타 사이트 데이터</li>
                                                            </ol>
                                                        </li>
                                                        <li>다. 단, 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.</li>
                                                    </ol>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 9조. 개인정보 보호책임자</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content form-footer">
                                            <ul>
                                                <li><span class="frt_num">&lt;다사자규&gt;는 「개인정보 보호법 제31조(시행령 제32조, 표준지침 제22조)」에 따라 다음과 같이 책임관이 지정되어 있습니다.</span></li>
                                            </ul>
                                        </div>

                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제 10조. 권익침해 구제방법</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content form-footer">
                                            <ul>
                                                <li class="frt_txt">정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.</li>
                                            </ul>
                                            <ul class="personal_content_num2">
                                                <li><span class="frt_num2">1. </span>개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)</li>
                                                <li><span class="frt_num2">2. </span>개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr)</li>
                                                <li><span class="frt_num2">3. </span>대검찰청 : (국번없이) 1301 (www.spo.go.kr)</li>
                                                <li><span class="frt_num2">4. </span>경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)</li>
                                            </ul>
                                            <ul>
                                                <li class="frt_txt">「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.</li>
                                                <li class="frt_txt">※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(www.simpan.go.kr) 홈페이지를 참고하시기 바랍니다.</li>
                                            </ul>
                                        </div>
                                        <div class="personal_title_sub">
                                            <ul>
                                                <li class="agreed_txt_tit_s form-footer">제11조. 개인정보 관리수준 진단 결과</li>
                                            </ul>
                                        </div>
                                        <div class="personal_content ">
                                            <ul>
                                                <li><span class="frt_num">①</span>행정안전부(소속기관 포함)는 정보주체의 개인정보를 안전하게 관리하기 위해 「개인정보 보호법」 제11조에 따라 매년 개인정보보호위원회에서 실시하는 “공공기관 개인정보 관리수준진단”을 받고 있습니다.</li>
                                                <li><span class="frt_num">②</span>행정안전부(소속기관 포함)는 2022년도 개인정보 관리수준진단 평가에서 ‘S’ 등급을 획득하였습니다.</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!--//개인정보 취급방침-->
                            </div>
                            <div style="text-align:center; padding-top: 30px;">
                                <button type="reset" class="btn btn-danger " id="closeBtn" style="display :inline-block; width: 150px; font-size:1.5rem; " data-dismiss="modal" aria-label="Close">닫기</button>
                            </div>
                        </div><!-- End .form-tab -->
                    </div><!-- End .form-box -->
                </div><!-- End .modal-body -->
            </div><!-- End .modal-content -->
        </div><!-- End .modal-dialog -->
    </div><!-- End .modal -->

    <div class="modal fade" id="agree3-modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-body">

                    <div class="form-box">
                        <div class="form-tab">
                            <ul class="nav nav-pills nav-fill" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="agree-tab" data-toggle="tab" href="#agree" role="tab" aria-controls="#agree" aria-selected="true">메일 문자 수신 동의</a>
                                </li>
                            </ul>
                            <div id="container">
                                <div id="content">
                                    <h1 class="pvsHeading1"><img src="https://i.jobkorea.kr/content/images/policy/pvs_h_msgprovision.gif" alt="문자서비스 이용약관" style="padding-top: 30px;"></h1>


                                    <div class="pvsSec pvsCntTp" style="max-height: calc(50vh - 200px); overflow-x: hidden; overflow-y: 20px;">
                                        <ol>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg01" id="gg01"></a><strong>제 1 조 (목적) </strong></dt>
                                                    <dd>본 약관은 잡코리아 유한책임회사(이하 "회사")가 운영하는 웹사이트 및 모바일 어플리케이션(이하 "사이트")에서 제공하는 문자메시지 발송 서비스(이하 "서비스")를 이용함에 있어 이용자의 권리/의무 및 책임사항, 기타 필요사항을 규정함을 목적으로 한다.</dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg02" id="gg02"></a><strong>제 2 조 (정의) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 서비스 : 회사가 사이트에서 유료 또는 무료로 제공하는 SMS, LMS 등 문자메시지 발송 기능</li>
                                                            <li>2. 이용자 : 회사가 제공하는 서비스를 이용하고자 절차에 의거 신청한 사이트의 기업회원</li>
                                                            <li>3. 이용신청 : 회사가 정한 별도의 기준과 절차에 따라 서비스 이용을 신청하는 것</li>
                                                            <li>4. 이용정지 : 회사가 정한 일정한 요건에 따라 일정기간 동안 서비스 이용을 보류 조치하는 것</li>
                                                            <li>5. 해지 : 이용자가 서비스 이용신청 후 사용중 이를 해약하는 것</li>
                                                            <li>6. 스팸메시지 : 수신자의 의사에 반하여 정보통신망을 통해 일방적으로 전송 또는 게시되는 영리목적의 광고성 정보</li>
                                                            <li>7. 문자피싱메시지 : 전자금융사기를 목적으로 전송 또는 게시되는 정보</li>
                                                            <li>8. 스미싱메시지 : 메시지 내용 중 인터넷 주소를 클릭하면 악성코드가 설치되어 수신자가 모르는 사이에 금전적 피해 또는 개인ㆍ금융정보 탈취 피해를 야기하는 메시지</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg03" id="gg03"></a><strong>제 3 조 (약관의 명시와 개정) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 회사는 이 약관의 내용을 이용자가 쉽게 알 수 있도록 서비스 약관 메뉴에 게시한다.</li>
                                                            <li>2. 회사는 "약관규제에관한법률", “개인정보보호법” "정보통신망이용촉진및정보보호등에관한법률(이하 "정보통신망법")", "전자상거래 등에서의 소비자 보호에 관한 법률", "전기통신사업법" 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있다.</li>
                                                            <li>3. 회사가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 제1항의 방식에 따라 그 개정약관의 적용일자 7일 전부터 적용일자 전까지 공지한다. <br>다만, 이용자의 권리 또는 의무에 관한 중요한 규정의 변경은 최소한 30일 전에 공지하고 일정기간 서비스내 공지사항, 전자우편, 로그인시 동의창 등의 전자적 수단을 통해 따로 명확히 통지하도록 한다.</li>
                                                            <li>4. 회사가 전항에 따라 개정약관을 공지 또는 통지하면서 이용자에게 약관 변경 적용일까지 거부의사를 표시하지 않으면 동의한 것으로 본다는 뜻을 명확하게 공지 또는 통지하였음에도 이용자가 명시적으로 거부의 의사표시를 하지 아니한 경우 약관의 규제에 관한 법률 제12조 제1호 단서에 따라 이용자가 개정약관에 동의한 것으로 본다.</li>
                                                            <li>5. 이용자가 개정약관의 적용에 동의하지 않을 경우 회사는 개정약관의 내용을 해당 이용자에게 적용할 수 없으며, 이 경우 이용자는 이용신청을 해지할 수 있다. 다만, 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 회사는 이용신청을 해지할 수 있다.</li>
                                                            <li>6. 이용자는 약관의 변경에 대하여 주의의무를 다하여야 하며 약관 미준수로 인한 이용자의 피해는 회사가 책임지지 않는다.</li>
                                                            <li>7. 이 약관이 이용자에게 적용되는 기간은 이용자의 서비스 신청일부터 해지일 까지를 원칙으로 하되, 단, 채권 또는 채무관계가 있을 경우에는 채권, 채무의 완료일 까지로 한다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg04" id="gg04"></a><strong>제 4 조 (서비스 이용 신청) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 이용자는 회사가 정한 별도의 기준과 절차에 따라 약관에 동의하여 서비스 이용 신청을 완료하고 회사가 이를 승낙함으로써 서비스 이용이 가능하다.</li>
                                                            <li>
                                                                2. 회사는 제 1항과 같이 서비스 이용을 신청한 이용자 중 다음 각호에 해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용 신청을 해지할 수 있다.
                                                                <ol>
                                                                    <li>① 이용자가 이 약관에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 회사의 이용자 재가입 승낙을 얻은 경우에는 예외로 한다.</li>
                                                                    <li>② 등록 내용에 허위, 기재누락, 오기가 있는 경우</li>
                                                                    <li>③ 실명이 아니거나 타인의 명의를 이용한 경우</li>
                                                                    <li>④ 이용자가 서비스의 정상적인 제공을 저해하거나 다른 이용자의 서비스 이용에 지장을 줄 것으로 예상되는 경우</li>
                                                                    <li>⑤ 회사의 업무상 또는 기술상 문제로 인해 가입승낙을 유보하는 경우</li>
                                                                    <li>⑥ 이용자가 서비스를 이용하여 법령에 위반되는 행위를 하거나 이와 유사한 행위를 하는 경우</li>
                                                                </ol>
                                                            </li>
                                                            <li>3. 회사는 제1항에 따른 신청에 있어서 이용자의 종류에 따라 전문기관을 통한 실명확인 및 본인인증을 요청할 수 있다.</li>
                                                            <li>4. 서비스 이용 신청의 성립시기는 회사의 승낙이 이용자에게 도달한 시점으로 한다.</li>
                                                            <li>5. 회사는 이용자에 대해 회사정책에 따라 등급별로 구분하여 이용시간, 이용횟수, 서비스 메뉴 등을 세분하여 이용에 차등을 둘 수 있다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg05" id="gg05"></a><strong>제 5 조 (이용자의 아이디 및 비밀번호의 관리에 대한 의무) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 이용자의 아이디와 비밀번호에 관한 관리책임은 이용자에게 있으며 이를 제3자가 이용하도록 하여서는 안 된다.</li>
                                                            <li>2. 기타 본 약관에서 정하지 아니하는 아이디 및 비밀번호 관리에 대한 이용자의 의무는 사이트의 기업회원 약관에 따른다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg06" id="gg06"></a><strong>제 6 조 (개인정보보호 수집 및 보호 의무) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 회사는 "정보통신망법", "개인정보보호법", "전기통신사업법" 등 관계 법령이 정하는 바에 따라 이용자의 개인정보를 보호하기 위해 노력한다.</li>
                                                            <li>2. 회사는 개인정보의 보호 및 사용에 대해서는 관련 법령 및 회사의 개인정보처리방침에 그 수집범위 및 목적을 사전 고지한다. 단, 회사에서 제공하는 공식 사이트 이외의 링크된 사이트에서는 회사의 개인정보처리방침이 적용되지 않는다.</li>
                                                            <li>3. 기타 본 약관에서 정하지 아니하는 개인정보보호 관련 사항은 사이트의 개인정보 처리방침 등 정책에 따른다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg07" id="gg07"></a><strong>제 7 조 (이용자에 대한 통지) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 회사가 이용자에 대한 서비스 관련 내용의 통지를 하는 경우, 사이트의 기업회원 약관에 의거 사이트 가입 신청시 등록한 이메일, 휴대전화 문자메세지 또는 어플리케이션 푸쉬 알림 중 수신에 동의한 수단을 활용하여 각종 고지나 통지를 이행할 수 있다.</li>
                                                            <li>2. 회사는 불특정다수 회원에 대한 통지의 경우 1주일이상 서비스에 게시함으로써 개별 통지에 갈음할 수 있다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg08" id="gg08"></a><strong>제 8 조 (서비스 제공의 의무) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 회사는 "정보통신망법", "개인정보보호법", "전기통신사업법" 등 관련법과 이 약관이 금지하는 행위를 하지 않으며 이용자에게 제공하는 서비스를 안정적으로 제공하기 위하여 최선을 다해야 한다.</li>
                                                            <li>2. 회사는 안정적인 서비스를 지속적으로 제공하기 위하여 설비에 장애가 생기거나 멸실 되었을 때 지체 없이 수리 또는 복구를 한다. 다만, 천재지변이나 비상사태 등 부득이한 경우에는 서비스를 일시 중단하거나 영구 중지할 수 있다.</li>
                                                            <li>3. 회사는 이용자가 서비스 이용 신청 혹은 발신번호 등록 시 타인의 명의를 도용한 부정가입을 방지하기 위해 본인인증 서비스 사업자가 제공하는 인증방법을 통해 본인확인 인증서비스를 제공ㆍ운영한다.</li>
                                                            <li>4. 회사는 서비스 제공과 관련 취득한 이용자의 개인정보를 본인의 동의 없이 타인에게 누설하거나 배포할 수 없으며 서비스 관련 업무 이외의 목적으로 사용할 수 없습니다. 다만 관계법령에 의한 관계기관으로부터의 요청 등 법률의 규정에 따른 적법한 절차에 의한 경우는 그러하지 않는다.</li>
                                                            <li>5. 회사는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보보호를 위한 보안 시스템과 개인정보보호 책임자를 갖추어야 한다.</li>
                                                            <li>6. 회사는 이용자의 사전 동의 없이 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않는다.</li>
                                                            <li>7. 회사는 이용계약의 체결, 계약사항의 변경 및 해지 등 이용자와의 계약관련 절차 및 내용 등에 있어 이용자에 편의를 제공하도록 노력한다.</li>
                                                            <li>8. 회사의 서비스 이용시에 회사의 귀책사유 없는 이용자의 시스템 장애 발생, 각종 카페, 블로그, 클럽 등 게시판의 개인정보유출에 대한 피해 등은 회사가 책임을 지지 않는다.</li>
                                                            <li>9. 회사의 사이트는 서비스의 본질적인 부분이 아닌 경우 사전예고 없이 모양과 기능이 수정될 수 있다.</li>
                                                            <li>10. 회사는 서비스 제공목적에 맞는 서비스 이용 여부를 확인하기 위하여 상시적으로 모니터링을 실시한다.</li>
                                                            <li>11. 회사는 "정보통신망법", "개인정보보호법", "전기통신사업법"에 등 관련 법 따라 스팸메시지ㆍ문자피싱메시지ㆍ스미싱메시지, 사기, 협박, 음란성, 범죄를 목적으로 하거나 교사 또는 방조하는 내용의 정보, 발신번호조작 등으로 인지되는 문자메시지에 대해서 차단 및 제한할 수 있다.</li>
                                                            <li>
                                                                12. 회사는 서비스 제공이 불가능한 경우 다음과 같이 처리한다.
                                                                <ol>
                                                                    <li>① 서비스 제공이 불가능한 경우 : 천재지변, 시스템(통신) 장애 및 점검, 서비스 양도 및 폐지(휴지) 등</li>
                                                                    <li>② 천재지변 등을 제외한 서비스 제공이 불가능한 경우 이용자(고객)에게 사전 공지(안내)를 한다.</li>
                                                                    <li>③ 천재지변 등을 제외한 서비스 제공이 불가능한 경우 이용자(회원)에게 사전 공지(안내) 없이 서비스를 중단 하였을 시, 그로 인해 피해가 발생한 이용자(회원)에게 피해에 따른 손해를 확인 후 보상할 수 있다.</li>
                                                                    <li>④ 회사는 사업의 전부 및 일부를 휴지 또는 폐지 하고자 할 때에는 그 휴지 또는 폐지 예정일의 30일전까지 그 내용을 이용자(고객)에게 이메일, 홈페이지 등을 이용하여 공지한다.</li>
                                                                </ol>
                                                            </li>
                                                            <li>13. 회사는 이용자가 불법스팸을 전송한 사실을 확인한 경우 한국인터넷진흥원 불법스팸대응센터에 관련 자료를 첨부하여 신고할 수 있다.</li>
                                                            <li>14. 회사는 한국인터넷진흥원으로부터 스팸신고가 접수된 경우 서비스 제공목적에 맞는 서비스 이용 여부를 확인하기 위하여 다량의 문자전송여부 및 서비스 변경이력을 확인할 수 있다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg9" id="gg9"></a><strong>제 9 조 (불만사항 접수 및 처리 의무) </strong></dt>
                                                    <dd>
                                                        <p>회사는 이용자의 불만사항 접수 및 처리절차를 다음과 같이 처리한다.</p>
                                                        <ol>
                                                            <li>① 불만사항 접수는 일반전화, 게시판, 이메일에 의한 방법으로 접수 받는다.</li>
                                                            <li>② 불만사항 처리는 접수 방법에 따라 운영자가 직접 전화, 답변하여 처리하는 것을 원칙으로 하고, 불만형태별로 처리기간을 정하여 그 기간 내에 처리한다.</li>
                                                        </ol>
                                                        <table border="1" class="pvsTplTb_1" summary="불만사항 별 처리 방식입니다.">
                                                            <caption class="skip">불만사항 및 처리절차</caption>
                                                            <colgroup>
                                                                <col width="20%">
                                                                <col width="20%">
                                                                <col width="20%">
                                                                <col width="20%">
                                                                <col width="20%">
                                                            </colgroup>
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col">불만형태</th>
                                                                    <th scope="col">유형</th>
                                                                    <th scope="col">원인</th>
                                                                    <th scope="col">처리절차</th>
                                                                    <th scope="col">처리기간</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td rowspan="3">서비스 관련</td>
                                                                    <td>통신 장애</td>
                                                                    <td>회사의 귀책사유</td>
                                                                    <td>대고객 사과 및 품질개선</td>
                                                                    <td>3일 이내</td>
                                                                </tr>
                                                                <tr>
                                                                    <td rowspan="2">시스템 장애</td>
                                                                    <td>회사의 귀책사유</td>
                                                                    <td>대고객 사과 및 품질개선</td>
                                                                    <td>3일 이내</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>이용자(회원)의 귀책사유</td>
                                                                    <td>대고객 설명</td>
                                                                    <td>1일 이내</td>
                                                                </tr>
                                                                <tr>
                                                                    <td rowspan="3">요금 관련</td>
                                                                    <td rowspan="3">청구요금 이의</td>
                                                                    <td rowspan="2">회사의 귀책사유</td>
                                                                    <td>과금전 : 정정 과금 처리</td>
                                                                    <td>3일 이내</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>과금후 : 환불 처리</td>
                                                                    <td>7일 이내</td>
                                                                </tr>
                                                                <tr>
                                                                    <td rowspan="1">이용자의 귀책사유</td>
                                                                    <td>대고객 설명</td>
                                                                    <td>1일 이내</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg10" id="gg10"></a><strong>제 10 조 (발신번호 변작방지 의무) </strong></dt>
                                                    <dd>
                                                        <p>회사는 발신번호의 변작방지를 위해 다음과 같은 조치를 취한다.</p>
                                                        <ol>
                                                            <li>① 번호인증을 통한 발신번호 사전등록서비스를 제공/운영</li>
                                                            <li>② 회사에서 제공하는 통일된 발신번호로 발신</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg11" id="gg11"></a><strong>제 11 조 (이용자의 금지행위 의무)</strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>
                                                                1. 이용자는 현행 법령, 회사가 제공하는 서비스에 정한 약관, 이용안내 및 서비스와 관련하여 공지한 주의사항, 회사가 통지하는 사항, 기타 서비스 이용에 관한 규정을 준수하여야 하며, 기타 회사의 업무에 방해되는 행위를 해서는 안된다
                                                                <ol>
                                                                    <li>① 정보통신망법(제50조)에 따라 광고문자 표기 의무사항을 위반해서는 안된다.</li>
                                                                    <li>② 이용자가 본인 명의가 아닌 타인의 전화번호를 부정하게 사용하는 경우에 서비스를 중지시키고, 필요시 회원 탈퇴 및 접속IP를 차단한다.</li>
                                                                </ol>
                                                            </li>
                                                            <li>2. 이용자는 서비스를 이용하여 얻은 정보를 회사의 사전 승낙 없이 복사, 복제, 변경, 번역, 출판, 발송 및 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없다.</li>
                                                            <li>
                                                                3. 이용자는 서비스를 이용함에 있어서 공공질서 또는 미풍양속을 해치는 행위, 또는 다음 각 호에 해당하는 행위를 해서는 안되며, 위반시 회사는 이용자의 서비스이용을 정지하고 일방적으로 서비스 이용 신청을 해지할 수 있다.
                                                                <ol>
                                                                    <li>① 다른 이용자의 이용 아이디를 부정 사용하는 행위</li>
                                                                    <li>② 해킹 행위 또는 컴퓨터 바이러스의 유포 행위</li>
                                                                    <li>③ 타인의 의사에 반하여 광고성정보 등 유사한 내용을 지속적으로 전송하는 행위</li>
                                                                    <li>④ 회사와 타인의 지적 재산권 등을 침해하는 행위(불법 복제물 복제·전송 등을 포함)</li>
                                                                    <li>⑤ 범죄행위를 목적으로 하거나 범죄행위를 교사하거나, 반국가적 범죄의 수행 등을 목적으로 하는 행위</li>
                                                                    <li>⑥ 서비스의 안전적인 운영에 지장을 주거나 줄 우려가 있다고 판단되는 행위(신청 또는 변경 시 허위내용을 등록하는 행위 포함)</li>
                                                                    <li>⑦ 원하지 않는 메시지를 타인에게 보내는 행위</li>
                                                                    <li>⑧ 회사와 타인의 명예를 손상시키거나 모욕하는 행위 또는 일체의 업무를 방해하는 행위</li>
                                                                    <li>⑨ 외설 또는 폭력적인 메시지, 팩스, 음성, 메일, 기타 공서양속에 반하는 정보를 서비스에 공개 또는 게시, 전송하는 행위 등 선량한 풍속 또는 기타 사회질서를 해하거나 관계법령에 위반하는 행위</li>
                                                                    <li>⑩ 회사의 동의 없이 영리를 목적으로 서비스를 사용하는 행위 및 제3자에게 임의로 서비스를 임대하는 행위</li>
                                                                </ol>
                                                            </li>
                                                            <li>4. 이용자는 스팸메시지ㆍ문자피싱메시지 전송 등 불법행위를 하거나 전기통신사업법 등 관련 법령을 준수하지 않아 발생하는 모든 민ㆍ형사상의 책임을 부담한다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg12" id="gg12"></a><strong>제 12 조 (서비스의 변경) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 회사는 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 서비스를 변경할 수 있다.</li>
                                                            <li>2. 서비스의 내용, 이용방법, 이용시간에 대하여 변경이 있는 경우에는 변경사유, 변경될 서비스의 내용 및 제공일자 등을 그 변경 전에 해당 서비스 초기화면에 게시하여야 한다.</li>
                                                            <li>3. 회사는 무료로 제공되는 서비스의 일부 또는 전부를 회사의 정책 및 운영의 필요상 수정, 중단, 변경할 수 있으며 이에 대하여 관련법에 특별한 규정이 없는 한 이용자에게 별도의 보상을 하지 않다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg13" id="gg13"></a><strong>제 13 조 (서비스 이용의 제한 및 정지) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 회사는 원활한 서비스 제공을 위하여 이 약관을 위반하거나 서비스의 정상적인 운영을 방해하는 경우 서비스 이용을 제한하거나 정지할 수 있다.</li>
                                                            <li>2. 회사는 1항에도 불구하고 주민등록법을 위반한 명의도용 및 결제도용, 저작권법을 위반한 불법프로그램의 제공 및 운영방해, 정보통신망법을 위반한 스팸메시지 및 불법통신, 해킹, 악성프로그램의 배포, 접속권한 초과행위 등과 같이 관련법을 위반한 경우에는 즉시 영구이용정지를 할 수 있다. 본 항에 따른 서비스 이용정지 시 서비스 내의 금액, 혜택 및 권리 등도 모두 소멸되며 회사는 이에 대해 별도로 보상하지 않는다.</li>
                                                            <li>
                                                                3. 회사는 다음 각호에 해당하는 경우 해당 역무의 제공을 거부하는 조치를 할 수 있으며, 이용자에게 통지한다. 단, 회사가 긴급하게 이용을 정지할 필요가 있다고 인정하는 경우나, 이용자의 귀책사유로 인해 통지할 수 없는 경우에는 통지를 생략할 수 있다.
                                                                <ol>
                                                                    <li>① 이용자가 정보통신망법 제50조 또는 제50조의 8을 위반하여 불법스팸 발송을 하는 경우</li>
                                                                    <li>② 방송통신위원회ㆍ한국인터넷진흥원ㆍ과학기술정보통신부 등 관계기관이 불법스팸메시지ㆍ문자피싱메시지 등 불법행위의 전송사실을 확인하여 이용정지를 요청하는 경우</li>
                                                                    <li>③ 광고성 정보의 전송 또는 수신으로 역무의 제공으로 장애가 일어나거나 일어날 우려가 있는 경우</li>
                                                                    <li>④ 이용자가 발송한 문자 또는 팩스메시지 광고성 정보 메시지의 수신을 원하지 아니하는 경우</li>
                                                                    <li>⑤ 제10조(발신번호 변작방지 의무)를 위반하여 발신번호를 변작하는 등 거짓으로 표시한 경우</li>
                                                                    <li>⑥ 과학기술정보통신부ㆍ한국인터넷진흥원 등 관련 기관이 발신번호 변작 등을 확인하여 이용 정지를 요청하는 경우</li>
                                                                    <li>⑦ 유료서비스를 사용한 이용자가 요금 등을 납입할 의무를 이행하지 아니한 경우</li>
                                                                    <li>⑧ 제11조(이용자의 금지행위 의무)를 이행하지 아니한 경우</li>
                                                                    <li>⑨ 정보통신윤리위원회의 시정요구가 있거나, 불법선거 운동과 관련하여 선거관리위원회의 유권해석을 받은 경우 또는 수사기관이나 법원의 결정 또는 명령 등으로 회사의 이용자에 대한 서비스 제공이 관련 법령상 제한되는 경우</li>
                                                                    <li>⑩ 이용자는 사전에 명시적으로 광고 수신동의를 얻은 자에게만 광고 메시지를 전송할 수 있으며, 오후9시 부터 다음날 오전8시까지는 별도의 사전 동의를 받아야 함에도 이를 어긴 경우</li>
                                                                    <li>⑪ 기타 회사가 사회통념상 합리적인 관점에서 이용자로 부적당하다고 판단한 경우</li>
                                                                </ol>
                                                            </li>
                                                            <li>4. 이용자가 3항에 해당되어 타 서비스에 악용될 우려가 있다는 객관적 정황이 있는 경우에는 그 다른 서비스도 이용정지 할 수 있다. 특히 3항 5호 및 6호에 해당하는 경우 회사는 이용자의 서비스를 영구정지 조치할 수 있으며, 원인이 해소되는 경우 해제할 수 있다.</li>
                                                            <li>5. 제3항의 이용정지 경우 사회적 공익을 저해할 목적이나 범죄적 목적으로 서비스를 이용하고 있다고 판단되는 경우 이용자에게 회사는 사전통보 없이 서비스를 즉시 중단할 수 있으며 그에 따른 데이터도 복구를 전제로 하지 않고 삭제할 수 있다.</li>
                                                            <li>6. 회사는 이용정지 등의 원인이 된 사유가 완전히 해소되기 전까지는 이용정지등 조치를 해제하지 아니 할 수 있으며, 그 이용정지등의 사유가 해소된 것이 확인된 경우에는 이용정지조치를 즉시 해제한다.</li>
                                                            <li>7. 회사는 회사에서 정하는 스미싱 등 스팸방지를 위해 특정 단어가 포함된 문자 메시지에 대해 발송을 제한 할 수 있다.</li>
                                                            <li>8. 회사는 이용자에게 강제적인 서비스 신청 해지 사유가 발생할 경우 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여한다. 단 해당 기간 동안 회사는 이용자에게 서비스를 중지할 수 있다.</li>
                                                            <li>9. 회사는 스팸메시지ㆍ피싱문자 전송을 방지하기 위해서 문자 팩스의 일일발송량을 제한할 수 있으며 자체 모니터링을 강화할 수 있다.</li>
                                                            <li>10. 2회 이상 동일한 이용정지 사유가 발생하는 이용자에게는 회사는 이용자에게 사전통보 없이 서비스를 즉시 중단할 수 있으며, 제8항의 소명기회 부여를 생략하고 이용자에게 이용정지사유 2회 이상 발생으로 인한 사유임을 알려 서비스 해지 조치를 할 수 있다. 이 경우 해당 거래 관련 자료는 관련 법령에 따라 필요한 기간 동안 보관한다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg14" id="gg14"></a><strong>제 14 조 (문자 발송량의 제한) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 회사는 스팸메시지ㆍ피싱문자 전송을 방지하기 위해서 문자 팩스의 일일발송량을 제한할 수 있으며 자체 모니터링을 강화할 수 있다.</li>
                                                            <li>2. 회사는 이용자가 제출하는 증빙서류 등을 통해 불법스팸 전송이 아님을 확인할 수 있는 경우 초과전송이 가능하다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg15" id="gg15"></a><strong>제 15 조 (서비스 이용 신청 해지) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 이용자가 서비스 이용 신청 해지를 하고자 할 때에는 본인이 직접 서비스 이용 해지를 신청하거나 전자우편, 전화 등의 방법을 통하여 회사에 신청하여야 한다.</li>
                                                            <li>2. 회사는 1항의 규정에 의하여 해지 신청이 접수되면 즉시 이용 신청을 해지한다. 단, 별도의 채무나 채권 관계가 있을 경우에는 그러하지 아니한다.</li>
                                                            <li>3. 서비스 해지 후로부터 5년간 고객의 자료를 보호할 의무를 가진다. 단, 서비스해지 후 보관된 개인정보 및 기타 서비스자료는 관련법규에 의하여 보존 의무가 없는 것으로 판명이 되면 즉시 삭제처리 된다.</li>
                                                            <li>
                                                                4. 회사는 이용자가 다음 중 하나에 해당하는 것이 객관적으로 명백하거나 관련 증거가 확보된 경우 별도의 소명기회 부여 없이 당해 서비스 신청을 해지할 수 있다.
                                                                <ol>
                                                                    <li>① 타인의 명의로 신청하였거나 신청시 제출한 자료 및 정보가 허위 또는 누락되었음이 확인된 경우</li>
                                                                    <li>② 회사의 서비스 제공목적 외의 용도로 서비스를 이용하거나, 전기통신사업법 제30조에 위반하여 제3자에게 서비스를 이용하도록 제공한 경우</li>
                                                                    <li>③ 방송통신위원회 또는 한국인터넷진흥원 또는 기타 유관기관이 불법스팸 전송과 관련하여 서비스 이용 해지를 요청하는 경우</li>
                                                                    <li>④ 회사가 제공하는 서비스를 이용하여 불법스팸을 전송한 사실이 확인된 경우</li>
                                                                    <li>⑤ 불특정 다수를 대상으로 메시지(SMS, LMS, MMS 포함), 음성(영상)통화 등의 방법을 통해 무차별적인 스팸을 전송한 사실이 확인된 경우</li>
                                                                    <li>⑥ 서비스를 이용하여 수신자를 기망하여 회신을 유도하는 행위를 하는 경우</li>
                                                                    <li>⑦ 제14조의 규정에 의하여 이용정지를 당한 이후 1년 이내에 이용정지 사유가 재발한 경우</li>
                                                                    <li>⑧ 발신자 정보를 변작하여 영리목적의 광고성 정보를 전송하였거나, 또는 발신자 정보를 변작하여 위해를 입힐 목적으로 문자메시지를 전송한 사실이 확인된 경우</li>
                                                                    <li>⑨ 이용자가 전송한 광고성 정보에 대해 회사가 한국인터넷진흥원 등에 불법스팸 유무확인을 요청하여 불법스팸임이 확인된 경우</li>
                                                                </ol>
                                                            </li>
                                                            <li>5. 회사는 불법스팸을 전송하였다고 확인된 이용자가 이용중인 다른 서비스가 불법스팸에 악용되고 있거나 악용될 우려가 있다는 객관적 정황이 있는 경우에는 그 다른 서비스도 해지 할 수 있다.</li>
                                                            <li>6. 회사는 제4항의 규정에 의하여 서비스 신청을 해지하는 경우, 그 사실을 당해 이용자에게 통지한다. 단, 회사가 긴급하게 서비스 이용을 해지 할 필요가 있다고 인정하는 경우나, 이용자의 귀책사유로 인해 통지할 수 없는 경우에는 통지를 생략할 수 있다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt><a name="gg16" id="gg16"></a><strong>제 16 조 (서비스 요금 및 환불) </strong></dt>
                                                    <dd>
                                                        <ol>
                                                            <li>1. 유료서비스 이용과 관련하여 이용자가 납부하여야 할 요금은 이용료 사이트에 게재한 바에 따른다.</li>
                                                            <li>2. 환불에 관한 규정은 기업서비스 이용약관 제11조(서비스 요금의 환불)에 따른다.</li>
                                                        </ol>
                                                    </dd>
                                                </dl>
                                            </li>
                                        </ol>
                                    </div>
                                    <div style="text-align:center; padding-top: 30px;">
                                        <button type="reset" class="btn btn-danger " id="closeBtn" style="display :inline-block; width: 150px; font-size:1.5rem; " data-dismiss="modal" aria-label="Close">닫기</button>
                                    </div>
                                </div>
                            </div>

                        </div><!-- .End .tab-pane -->
                    </div><!-- End .tab-content -->
                </div><!-- End .form-tab -->
            </div><!-- End .form-box -->
        </div><!-- End .modal-body -->
    </div><!-- End .modal-content -->

    <!-- Plugins JS File -->
    <script src="/resources/assets/js/jquery.min.js"></script>
    <script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
    <script src="/resources/assets/js/jquery.waypoints.min.js"></script>
    <script src="/resources/assets/js/superfish.min.js"></script>
    <script src="/resources/assets/js/owl.carousel.min.js"></script>
    <!-- Main JS File -->
    <script src="/resources/assets/js/main.js"></script>
</body>

<!-- molla/login.html  22 Nov 2019 10:04:03 GMT -->

</html>
