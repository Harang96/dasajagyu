<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <link
      rel="icon"
      href="https://static.toss.im/icons/png/4x/icon-toss-logo.png"
    />
    <link rel="stylesheet" type="text/css" href="style.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>토스페이먼츠 샘플 프로젝트</title>
  </head>

  <body>
    <div class="result wrapper">
      <div class="box_section">
        <h2 style="padding: 20px 0px 10px 0px">
          <img
            width="25px"
            src="https://static.toss.im/3d-emojis/u1F6A8-apng.png"
          />
          결제 실패
        </h2>
        <p id="code"></p>
        <p id="message"></p>
      </div>
    </div>
  </body>
</html>

<script>
  const urlParams = new URLSearchParams(window.location.search);
  
  const error = urlParams.get("error");
  let errorMessage = "";
  
  if(error == "DBError"){
	  errorMessage = "DB에 저장하는데 실패했습니다.";
	  
  } else if(error == "ConfirmError"){
	  errorMessage = "결제 승인에 실패했습니다.";
	  
  } else if(error == "AmountError"){
	  errorMessage = "주문 금액과 결제 요청 금액이 다릅니다.";
	  
  } else if(error == "QtyError"){
	  errorMessage = "상품 재고가 부족합니다.";
  }
  
  
  
  const messageElement = document.getElementById("message");

  messageElement.textContent = "실패 사유: " + errorMessage;
</script>
