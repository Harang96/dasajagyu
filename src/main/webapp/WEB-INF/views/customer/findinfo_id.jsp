<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
  <!-- molla/login.html  22 Nov 2019 10:04:03 GMT -->

  <head>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>이메일 찾기 / 비밀번호 찾기</title>
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
    <!-- Plugins CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css" />
    <!-- Main CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/style.css" />
  </head>

  <style>
    .errMsg {
      color: #ef837b;
      font-size: 15px;
      font-weight: bold;
    }

    .upLoadFiles img {
      width: 50px;
    }

    #FindNameErrMsg {
      color: #ef837b;
      font-size: 15px;
      font-weight: bold;
    }

    #birthday {
      width: 250px;
    }

    #addrPostcode {
      width: 250px;
    }

    #Code,
    #findpassword {
      display: none;
    }

    .hidden {
      display: none;
    }

    .final_pw_ck {
      display: none;
      color: #ef837b;
    }

    .pwck_input_re_1 {
      display: none;
      color: green;
    }

    .pwck_input_re_2 {
      display: none;
      color: #ef837b;
    }

    .pwck_input_re_3 {
      display: none;
      color: green;
    }

    .final_pwck_ck {
      display: none;
      colore: #ef837b;
    }

    .modal {
      position: absolute;
      z-index: 10;
      background-color: white;
      width: 50%;
      left: 25%;
      top: 25%;
      padding: 20px;
      border-radius: 15px;
    }

    .errMsg {
      color: #ef837b;
      font-size: 15px;
      font-weight: bold;
    }

    #newPasswordErrMsg {
      color: #ef837b;
      font-size: 15px;
      font-weight: bold;
    }

    #FindNumberErrMsg {
      color: #ef837b;
      font-size: 15px;
      font-weight: bold;
    }
  </style>

  <script>
    var code = "";

    $(document).ready(function () {
      // 비밀번호 input 박스에서 포커스가 벗어날때
      $("#input-findpassword").on("blur", function () {
        checkNewPassword();
      });

      $("#check-findpassword").on("blur", function () {
        checkNewPassword();
      });

      /* $('#FindemailAuth').click(function() {
            // 모달 2페이지로 이동
            $('#Code').show();
            $('#findpassword, #emailfind').hide();
        }); */

      $("#FindemailAuthBtn").click(function () {
        // 모달 3페이지로 이동
        $("#findpassword").show();
        $("#Code, #emailfind").hide();
      });

      $("#Findname").on("focusout", function () {
        let Nametest = validfindid();
        let emailFindbtn = $("#searchIdClick").val();
        let nameinput = $("#Findname").val();
        let nameinput2 = $("#phoneNumber").val();
        let btncount2 = 500;
      });
      //사용자가 입력한 이름값 얻어오기

      $("#searchIdClick").click(function () {
        let name = $("#Findname").val();
        let phone = $("#phoneNumber").val();
        let email = $("#id_value").val();

        console.log(name);
        console.log(콜);

        let json = {
          name: name,
          phoneNumber: phone,
        };

        $.ajax({
          type: "get",
          url: "idSearch_click",
          data: json,
          dataType: "text",
          headers: {
            "Content-Type": "application/json",
          },
          success: function (data) {
            console.log(data);
          },
          error: function (data) {},
        });
      });

      $("#input-findpassword").on("focusout", function () {
        let userPw = validpassword();
        let btncount = 500;

        console.log(userPw);

        if (userPw == true) {
          // 정규식이 트루일때 버튼 활성화 이벤트
          $("#check-findpassword").blur(function () {
            if (validpassword() == true) {
              $("#confrimMsg").attr("disabled", false);
            }
          });

          $("#confrimMsg").click(function () {
            let password = $("#input-findpassword").val();
            let confirmPassword = $("#check-findpassword").val();

            let json = {
              newPwd: password,
              newPwd2: confirmPassword,
            };

            console.log(password);
            console.log(confirmPassword);

            $.ajax({
              type: "POST",
              url: "./confrimMsg",
              data: JSON.stringify(json),
              dataType: "json",
              headers: {
                "Content-Type": "application/json",
              },
              success: function (data) {
                if (data.status == "success") {
                  console.log(data.status);
                  alert("비밀번호 변경이 완료되었습니다.");
                  window.location.href = "/customer/loginOpen?path=" + "${param.path }";
                } else {
                  alert("비밀번호 변경을 실패했습니다.");
                }
              },
              error: function (error) {
                alert("ajax 실패");
                console.log(error);
              },
            });
          });
        } else {
          setTimeout(function () {
            $("#confrimMsg").prop("disabled", true);
          }, btncount);
        }
      });

      // 인증코드 입력 칸 focusout 이벤트
      $("#FindauthCode").on("focusout", function () {
        let inputCode = $("#FindauthCode").val(); //인증번호 입력 칸에 작성한 내용 가져오기

        console.log("입력코드 : " + inputCode);
        console.log("인증코드 : " + code);

        if (Number(inputCode) === code) {
          $("#FindemailAuthWarn").html("인증번호가 일치합니다.");
          $("#FindemailAuthWarn").css("color", "green");
          $("#FindemailAuth").attr("disabled", true);
          $("#Findemail").attr("readonly", true);
          $("#FindemailAuthBtn").attr("disabled", false);
        } else {
          $("#FindemailAuthWarn").html("인증번호가 불일치 합니다. 다시 확인해주세요!");
          $("#FindemailAuthWarn").css("color", "#ef837b");
          $("#FindemailAuthBtn").attr("disabled", true);
        }
      });

      $("#register-tab-2").click(function () {
        let inputs = $(".form-control");
        inputs.val("");

        $(".errMsg").hide();
      });
    });

    //         $("#emailRegister").on("focusout", function() {
    //             let ema = $("#emailRegister").val();

    //             // 이메일 인증하기 버튼 클릭 이벤트
    //             if (regEmail.test(ema)) { //사용자가 입력한 이메일 값 얻어오기

    //                 let btncount = 500;

    //                 setTimeout(function() {
    //                     $("#FindemailAuth").prop("disabled", false);
    //                 }, btncount);

    //             } else {
    //                 printErrMsg("emailWarn", "이메일 양식에 맞게 작성해주세요.");
    //                 $("#FindemailAuth").prop("disabled", true);
    //             }

    //         });

    function checkEmailVal() {
      var email = $("#emailRegister").val();
      var regEmail = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

      if (regEmail.test(email) && email != "") {
        $.ajax({
          url: "./FindEmailAuth",
          data: {
            email: email,
          },
          type: "POST",
          dataType: "json",
          async: false,
          success: function (result) {
            console.log("result : " + result);
            code = result;
            alert("인증 코드가 입력하신 이메일로 전송 되었습니다.");
          },
          error: function () {},
          complete: function () {
            $("#Code").show();
            $("#findpassword, #emailfind").hide();
          },
        });
      } else {
        $("#emailWarn").text("이메일이 양식이 틀렸습니다!");
      }
    }

    function printErrMsg(id, msg) {
      //                      let $errMsg = $(`#\${id}`).next('.errMsg');
      // 새로운 에러 메시지 생성 또는 업데이트
      if (msg) {
        // 기존에 에러 메시지가 있으면 업데이트하고, 없으면 새로 생성
        if ($errMsg.length) {
          //                            $errMsg.text(msg).show(); //메세지가 업데이트하고 보이도록 설정
          $("#newPasswordErrMsg").html("비밀번호가 일치하지 않습니다.");
        } else {
          //                            $errMsg = $('<div class="errMsg"></div>')
          //                                  .insertAfter(`#\${id}`).text(msg)
          //                                  .show();
          $("#newPasswordErrMsg").html("비밀번호를 8자 이상 영문, 특수");
        }
      } else {
        // 메세지가 없으면 에러 메세지 삭제
        //                         $errMsg.hide().remove(); //숨기고 삭제
        $("#newPasswordErrMsg").html("");
      }
    }

    function goMobileCode() {
      window.open("/customer/phoneNumberCodeTest", "핸드폰 인증 확인", "width=500, height=462");
    }

    // 비밀번호 유효성검사 : '영문 + 숫자 + 특수문자 조합으로 6~20자리를 사용해야 합니다
    function validpassword() {
      let isvalid = false;
      let userPw = $("#input-findpassword").val();
      let userPw2 = $("#check-findpassword").val();
      let num = userPw.search(/[0-9]/g);
      let eng = userPw.search(/[a-z]/gi);
      let spe = userPw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

      if (userPw.length < 8 || userPw.length > 20) {
        //               printErrMsg("input-findpassword", "8자리 ~ 20자리 이내로 입력해주세요.");
        $("#newPasswordErrMsg").html("8자리 ~ 20자리 이내로 입력해주세요.");
      } else if (userPw.search(/\s/) != -1) {
        //                   printErrMsg("input-findpassword", "비밀번호는 공백 없이 입력해주세요.");
        $("#newPasswordErrMsg").html("비밀번호는 공백 없이 입력해주세요.");
      } else if (num < 0 || eng < 0 || spe < 0) {
        //                   printErrMsg("input-findpassword", "영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
        $("#newPasswordErrMsg").html("영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
      } else if (userPw != userPw2) {
        //                     printErrMsg("input-findpassword", "비밀번호가 같지 않습니다.");
        $("#newPasswordErrMsg").html("비밀번호가 같지 않습니다.");
      } else {
        //                     printErrMsg("input-findpassword", "");
        $("#newPasswordErrMsg").html("");
        isvalid = true;
      }
      return isvalid;
    }

    function checkNewPassword() {
      let newPassword = $("#input-findpassword").val();
      let newPasswordCheck = $("#check-findpassword").val();

      if (newPassword == "") {
        // 양식 메세지 띄우기
      } else {
        validpassword(); // 양식 검사
      }
    }

    function selectEamil() {}
  </script>
  <style>
    #registerBtn {
      padding: 25px 135px 25px 135px;
      border-radius: 5px;
      margin-top: 30px;
    }

    #shopping {
      padding: 15px 0px 0px 0px;
      text-align: center;
      justify-content: center;
    }

    #shopping2 {
      padding: 10px 0px 20px 0px;
      text-align: center;
      justify-content: center;
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
              <li class="breadcrumb-item active" aria-current="page">이메일/비밀번호 찾기</li>
            </ol>
          </div>
          <!-- End .container -->
        </nav>
        <!-- End .breadcrumb-nav -->
        <div
          class="login-page bg-image pt-8 pb-8 pt-md-12 pb-md-12 pt-lg-17 pb-lg-17"
          style="
            background-image: url('/resources/assets/images/backgrounds/login-background.png') !important;
          "
        >
          <div class="container">
            <div class="form-box">
              <div class="form-tab">
                <ul class="nav nav-pills nav-fill" role="tablist">
                  <li class="nav-item">
                    <a
                      class="nav-link active"
                      id="signin-tab-2"
                      data-toggle="tab"
                      href="#signin-2"
                      role="tab"
                      aria-controls="signin-2"
                      aria-selected="false"
                      >이메일 찾기</a
                    >
                  </li>
                  <li class="nav-item">
                    <a
                      class="nav-link"
                      id="register-tab-2"
                      data-toggle="tab"
                      href="#register-2"
                      role="tab"
                      aria-controls="register-2"
                      aria-selected="true"
                      >비밀번호 찾기</a
                    >
                  </li>
                </ul>
                <div class="tab-content">
                  <div
                    class="tab-pane fade show active"
                    id="signin-2"
                    role="tabpanel"
                    aria-labelledby="signin-tab-2"
                  >
                    <div>
                      <div class="modal" id="modal">
                        <h4><b>고객님의 아이디는</b><span class="close">&times;</span></h4>
                        <br />
                        <h2 id="id_value">${email}</h2>
                        <br />
                        <input type="button" value="확인" id="idSearch_btn" />
                      </div>

                      <!-- End .form-group -->

                      <div class="form-group" style="justify-content: center; text-align: center">
                        <button
                          type="submit"
                          class="btn btn-primary"
                          id="registerBtn"
                          onclick="goMobileCode()"
                        >
                          <span style="font-size: 19px">본인명의 핸드폰 인증</span>
                        </button>
                      </div>

                      <div class="form-group">
                        <div id="shopping">회원님의 명의로 등록된</div>
                        <div id="shopping2">휴대폰으로 본인확인을 진행합니다.</div>
                      </div>
                      <!-- End .form-footer -->
                    </div>
                    <!-- End .form-group -->
                  </div>
                  <!-- .End .tab-pane -->
                  <div
                    class="tab-pane"
                    id="register-2"
                    role="tabpanel"
                    aria-labelledby="register-tab-2"
                  >
                    <div class="emailsearch" id="emailfind">
                      <!--                                         <form action="#" onsubmit="return false"> -->
                      <div class="form-group email-form">
                        <label for="emailRegister" class="form-label">이메일 *</label>
                        <div class="input-group">
                          <input
                            class="form-control"
                            placeholder="이메일을 입력해주세요."
                            name="emailRegister"
                            id="emailRegister"
                            type="email"
                          />
                        </div>
                        <span id="emailWarn"></span>
                      </div>
                      <!-- End .form-group -->

                      <div class="input-group-addon">
                        <input
                          type="button"
                          value="인증하기"
                          class="btn btn-primary"
                          id="emailCheckBtn"
                          onclick="checkEmailVal();"
                        />
                      </div>
                      <!-- End .form-footer -->
                      <!--                                         </form> -->
                    </div>
                    <div class="form-dept2" id="form-dept2">
                      <div class="form-group email-form" id="findCode">
                        <form action="#" id="Code" class="hidden" onsubmit="return false">
                          <label for="FindCode" class="form-label">인증코드 *</label>
                          <div class="mail-check-box codeDiv">
                            <input
                              class="form-control"
                              placeholder="인증코드를 입력해주세요."
                              name="FindauthCode"
                              id="FindauthCode"
                              type="email"
                              maxlength="6"
                            />
                          </div>
                          <div class="input-group-addon">
                            <input
                              type="button"
                              value="인증하기"
                              class="btn btn-primary"
                              id="FindemailAuthBtn"
                            />
                          </div>
                          <span id="FindemailAuthWarn"></span>
                        </form>
                      </div>
                      <div class="findpassword" id="find-password">
                        <form action="#" id="findpassword" class="hidden" onsubmit="return false">
                          <div class="form-group password-form">
                            <label for="input-findpassword" class="form-label"
                              >새비밀번호 입력</label
                            >
                            <div class="input-group">
                              <input
                                class="form-control"
                                placeholder="비밀번호를 입력해주세요."
                                name="input-findpassword"
                                id="input-findpassword"
                                type="password"
                              />
                            </div>
                            <span id="newPasswordErrMsg"></span>
                            <span class="final_pw_ck">비밀번호를 입력하세요.</span>
                            <span class="pwck_input_re_1" id="pwck_input_re_1"
                              >비밀번호가 일치합니다.</span
                            >
                            <div>
                              <label for="check-findpassword" class="form-label"
                                >비밀번호 확인</label
                              >
                            </div>
                            <div class="input-group">
                              <input
                                class="form-control"
                                placeholder="비밀번호를 입력해주세요."
                                name="check-findpassword"
                                id="check-findpassword"
                                type="password"
                              />
                              <!-- 비밀번호가 일치하지 않을때 -->
                            </div>
                            <div>
                              <span class="pwck_input_re_3" id="pwck_input_re_3"
                                >동일한 비밀번호 입니다.</span
                              >
                              <span class="pwck_input_re_2" id="pwck_input_re_2"
                                >비밀번호가 일치하지 않습니다.</span
                              >
                              <span id="pwWarn"></span>
                            </div>
                            <div>
                              <p>
                                <span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
                              </p>
                              <span id="pwWarn"></span>
                            </div>
                          </div>
                          <!-- End .form-group -->
                          <div class="input-group-addon" id="confrim" style="display: block">
                            <input
                              type="button"
                              value="변경하기"
                              class="btn btn-primary"
                              id="confrimMsg"
                            />
                          </div>
                          <!-- End .form-footer -->

                          <div class="input-group-addon" id="success" style="display: none">
                            <input type="submit" value="로그인 하러가기" class="btn btn-primary"
                            id="successBtn" onclick=>
                          </div>
                          <!-- End .form-footer -->
                          <span id="password"></span>
                        </form>
                      </div>
                    </div>
                    <!-- dept2 -->
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
    <!-- End .login-page section-bg -->

    <jsp:include page="../footer.jsp"></jsp:include>

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
