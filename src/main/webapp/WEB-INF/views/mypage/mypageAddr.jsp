<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions"%> <%@ taglib prefix="sql"
uri="http://java.sun.com/jsp/jstl/sql"%> <%@ taglib prefix="x"
uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>배송지 추가</title>
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
    <link rel="stylesheet" href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/nouislider/nouislider.css" />

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
      $(function () {
        // active 클래스 초기화
        $.each($("aside .nav-link"), function (i, nav) {
          $(nav).attr("class", "nav-link");
        });

        $("#tab-delivery-link").addClass("active");

        //             $("#basicAddr").val("N");

        $("#btnAddr").click(function () {
          window.close();
        });

        // 이름확인 작성을 마쳤을때
        $("#deliveryName").blur(function () {
          validUserName();
        });

        // 핸드폰번호확인 작성을 마쳤을때
        $("#phoneNumber").blur(function () {
          validUserPN();
        });

        $("#deliveryDetail").blur(function () {
          addr();
        });

        $("#basicAddr").change(function () {
          if ($(this).is(":checked")) {
            $(this).val("Y");
          } else {
            $(this).val("N");
          }
        });

        $("#phoneNumber").on("input", function (e) {
          if (e.originalEvent.inputType === "deleteContentBackward") return; // backspace 키 눌렀을 때는 처리하지 않음
          let phoneNumber = $(this).val();
          // 입력된 값에서 숫자 이외의 문자를 모두 제거
          phoneNumber = phoneNumber.replace(/\D/g, "");
          // 전화번호 형식에 맞게 하이픈 추가
          phoneNumber = phoneNumber.replace(
            /(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,
            "$1-$2-$3"
          );
          // 입력 필드에 반영
          $(this).val(phoneNumber);
        });
      });

      function validUserPN() {
        let isValid = false;
        let pn = $("#phoneNumber").val();

        if (pn == "" || pn.length != 13) {
          printErrMsg("phoneNumber", "핸드폰번호를 정확히 입력해주세요");
        } else {
          printErrMsg("phoneNumber", "");
          isValid = true;
        }

        return isValid;
      }

      //이름 유효성 검사
      function validUserName() {
        let isValid = false;
        let n = $("#deliveryName").val();
        let regex = /^[^ㄱ-ㅎㅏ-ㅣ]{2,17}$/;

        if (!regex.test(n)) {
          printErrMsg("deliveryName", "이름을 정확히 입력해주세요."); // 조건이 맞을 때 에러 메시지를 지움
          isValid = false;
        } else {
          printErrMsg("deliveryName", "");
          isValid = true;
        }
        return isValid;
      }

      function printErrMsg(id, msg) {
        let $errMsg = $(`#\${id}`).next(".errMsg");

        // 새로운 에러 메시지 생성 또는 업데이트
        if (msg) {
          // 기존에 에러 메시지가 있으면 업데이트하고, 없으면 새로 생성
          if ($errMsg.length) {
            $errMsg.text(msg).show(); // 메시지 업데이트하고 보이도록 설정
          } else {
            $errMsg = $('<div class="errMsg"></div>').insertAfter(`#\${id}`).text(msg).show(); // 새로운 메시지 생성하고 보이도록 설정
          }
        } else {
          // 메시지가 없으면 에러 메시지 삭제
          $errMsg.hide().remove(); // 숨기고 삭제
        }
      }

      // }

      //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
      function execDaumPostcode() {
        let isValid = false;
        new daum.Postcode({
          oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            let addr = ""; // 주소 변수
            let extraAddr = ""; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === "R") {
              // 사용자가 도로명 주소를 선택했을 경우
              addr = data.roadAddress;
            } else {
              // 사용자가 지번 주소를 선택했을 경우(J)
              addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === "R") {
              // 법정동명이 있을 경우 추가한다. (법정리는 제외)
              // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
              if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
                extraAddr += data.bname;
              }
              // 건물명이 있고, 공동주택일 경우 추가한다.
              if (data.buildingName !== "" && data.apartment === "Y") {
                extraAddr += extraAddr !== "" ? ", " + data.buildingName : data.buildingName;
              }
              // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
              if (extraAddr !== "") {
                extraAddr = " (" + extraAddr + ")";
              }
              // 조합된 참고항목을 해당 필드에 넣는다.
            } else {
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("deliveryPostcode").value = data.zonecode;
            document.getElementById("deliveryAddr").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("deliveryDetail").focus();
            printErrMsg("deliveryDetail", "");
          },
        }).open();
        isValid = true;

        return isValid;
      }

      function validCheck() {
        let isValid = false;

        let phoneNumberValid = validUserPN();
        let nameValid = validUserName();
        let addrValid = addr();

        //이메일 인증 통과

        //alert(checkAgree);

        if (nameValid && phoneNumberValid && addrValid == true) {
          isValid = true;
        } else {
          if (validUserName() != true) {
            $("#deliveryName").focus();
          } else if (validUserPN() != true) {
            $("#phoneNumber").focus();
          } else if (addr() != true) {
            $("#addrDetail").focus();
          } else if (addr() != true) {
            $("#addrDetail").focus();
          }
        }

        if (isValid) {
          $.ajax({
            url: "/mypage/saveAddr", // 목적지
            type: "post", // HTTP Method
            data: $("#saveAddr").serialize(), // 전송 데이터
            success: function () {
              // 성공 시 실행
              window.close();
              window.opener.location.reload();
            },
            error: function () {
              //실패 시 실행
            },
          });
        }

        return isValid;
      }

      function addr() {
        let isValid = false;
        if ($("#deliveryDetail").val() != "" && $("#deliveryPostcode").val() != "") {
          isValid = true;
          printErrMsg("deliveryDetail", "");
        } else {
          printErrMsg("deliveryDetail", "우편번호와 주소를 입력해주세요.");
        }
        return isValid;
      }
    </script>
    <style>
      .errMsg {
        color: #ef837b;
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
    </style>
  </head>

  <body>
    <div class="page-wrapper">
      <form id="saveAddr">
        <main class="main">
          <div class="page-content">
            <div class="dashboard">
              <div class="container">
                <%-- <input type="hidden" name="pathR" value="${param.path }" /> --%>
                <!-- 돌아갈 경로를 담아놓을 태그 -->
                <div class="row">
                  <div class="col-md-8 col-lg-9">
                    <div class="tab-content">
                      <div
                        class="tab-pane fade show active"
                        id="tab-delivery"
                        role="tabpanel"
                        aria-labelledby="tab-delivery-link"
                      >
                        <div class="row">
                          <div class="col-lg-6">
                            <div class="card card-dashboard">
                              <div class="card-body">
                                <div class="form-group error-field">
                                  <div class="form-group">
                                    <label for="deliveryName" class="form-label">이름 *</label>
                                    <input
                                      type="text"
                                      class="form-control error-field"
                                      id="deliveryName"
                                      placeholder="이름을 입력해주세요."
                                      name="deliveryName"
                                    />
                                  </div>
                                  <div class="form-group">
                                    <label for="phoneNumber" class="form-label">핸드폰번호 *</label>
                                    <input
                                      type="text"
                                      class="form-control error-field"
                                      id="phoneNumber"
                                      placeholder="핸드폰번호를 입력해주세요."
                                      name="phoneNumber"
                                      maxlength="13"
                                      size="15"
                                    />
                                  </div>

                                  <div class="form-group">
                                    <label
                                      for="address"
                                      class="form-label"
                                      style="margin-bottom: 10px"
                                      >주소 *</label
                                    >
                                    <div>
                                      <input
                                        type="text"
                                        id="deliveryPostcode"
                                        class="form-control postCode"
                                        placeholder="우편번호"
                                        name="deliveryPostcode"
                                        readonly
                                      />
                                      <input
                                        type="button"
                                        onclick="execDaumPostcode()"
                                        class="btn btn-outline-primary-2 btn-minwidth-sm postBtn"
                                        value="우편번호 찾기"
                                        id="postBtn"
                                      />
                                    </div>

                                    <br />
                                    <input
                                      type="text"
                                      id="deliveryAddr"
                                      name="deliveryAddr"
                                      class="form-control"
                                      placeholder="주소를 입력해주세요."
                                      readonly
                                    />
                                    <input
                                      type="text"
                                      id="deliveryDetail"
                                      name="deliveryDetail"
                                      class="form-control"
                                      placeholder="상세주소를 입력해주세요."
                                    />
                                    <input
                                      type="hidden"
                                      class="form-control"
                                      name="uuid"
                                      id="uuid"
                                      value="${loginCustomer.uuid }"
                                      readonly
                                    />

                                    <div class="form-group">
                                      <div
                                        class="custom-control custom-checkbox"
                                        style="margin-top: 10px"
                                      >
                                        <input
                                          type="checkbox"
                                          id="basicAddr"
                                          name="basicAddr"
                                          class="custom-control-input agree"
                                        />
                                        <label
                                          for="basicAddr"
                                          class="custom-control-label hrefColor"
                                          >기본 배송지로 설정</label
                                        >
                                      </div>
                                    </div>

                                    <button
                                      type="button"
                                      class="btn btn-outline-primary-2 btn-minwidth-sm"
                                      id="addrBtn"
                                      onclick="validCheck();"
                                    >
                                      완료
                                    </button>
                                    <button
                                      type="reset"
                                      class="btn btn-outline-primary-2 btn-minwidth-sm"
                                      id="btnAddr"
                                    >
                                      취소
                                    </button>
                                  </div>
                                </div>
                                <!-- End .card-dashboard -->
                              </div>
                              <!-- End .col-lg-6 -->
                            </div>
                            <!-- End .row -->
                          </div>
                          <!-- .End .tab-pane -->
                        </div>
                      </div>
                      <!-- End .col-lg-9 -->
                    </div>
                    <!-- End .row -->
                  </div>
                  <!-- End .card-body -->
                </div>
                <!-- End .container -->
              </div>
              <!-- End .dashboard -->
            </div>
            <!-- End .page-content -->
          </div>
        </main>
        <!-- End .main -->
      </form>

      <script src="/resources/assets/js/jquery.min.js"></script>
      <script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
      <script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
      <script src="/resources/assets/js/jquery.waypoints.min.js"></script>
      <script src="/resources/assets/js/superfish.min.js"></script>
      <script src="/resources/assets/js/owl.carousel.min.js"></script>
      <!-- Main JS File -->
      <script src="/resources/assets/js/main.js"></script>
    </div>
  </body>
</html>
