<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>비회원 주문 조회</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
      $(function () {
        $(function () {
          // active 클래스 초기화
          $.each($("aside .nav-link"), function (i, nav) {
            $(nav).attr("class", "nav-link");
          });

          $("#tab-findOrder-link").addClass("active");
        });
        $("#phone").on("input", function (e) {
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
    </script>
<style>
.product-media {
	height: 50px;
	width: 50px;
}

table th {
	position: sticky;
	top: 0;
}
</style>
</head>
<body>
	<div class="page-wrapper">
		<jsp:include page="../header.jsp"></jsp:include>

		<main class="main mainFontStyle">
			<div class="page-header text-center">
				<div class="container">
					<h1 class="page-title">비회원 주문 조회</h1>
				</div>
			</div>
			<nav aria-label="breadcrumb" class="breadcrumb-nav">
				<div class="container">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="/">홈</a></li>
						<li class="breadcrumb-item"><a href="/">고객 서비스</a></li>
						<li class="breadcrumb-item active" aria-current="page">비회원 주문 조회</li>
					</ol>
				</div>
				<!-- End .container -->
			</nav>
			<!-- End .breadcrumb-nav -->
			<div class="page-content">
				<div class="container">
					<div class="row">
						<div class="form-tab">
							<div class="tab-content" id="tab-content-5">
								<div class="tab-pane fade show active" id="agree" role="tabpanel" aria-labelledby="agree-tab">
									<div class="form-group">
										<div class="col privacy">
											<div id="termsStyle" class="col-lg-4 offset-lg-1" style="margin: auto">
												<div class="mt-3">
													<span style="font-size: 17px; font-weight: bold">주문번호와 배송 받는 분의 전화번호를 입력해주세요.</span>
												</div>
												<div class="mb-3 mt-3">
													<label><b>주문 번호</b></label> <input type="text" class="form-control" id="orderId" />
												</div>
												<div class="mb-3 mt-3">
													<label for="phone" class="form-label"><b>전화번호</b></label> <input type="text" class="form-control" id="phone" maxlength="13" size="15" />
												</div>
												<button class="btn btn-block btn-primary" onclick="detailOrder();">조회하기</button>
											</div>

										</div>
									</div>
								</div>
							</div>
							<!-- End .container -->
						</div>
						<!-- End .page-content -->
					</div>
				</div>
			</div>
		</main>
		<!-- End .main -->

		<!-- mypage Modal -->
		<div class="modal" id="detailOrderModal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" style="max-width: 1000px">
				<div class="modal-content">
					<div class="modal-name" style="text-align: center; border-bottom: 2px solid gray; margin: 15px 40px;">
						<span style="font-size: 20px; font-weight: bold">상품 상세보기</span>
					</div>
					<div style="display: flex; justify-content: center">
						<div class="modal-body" style="padding: 0px 40px; width: 900px">
							<div class="scrollbar" style="width: 100%; height: 450px; overflow: auto">
								<table class="table table-pointLog table-mobile" style="border-bottom: 1px solid gray; margin-bottom: 10px; padding: 20px 20px;">
									<thead>
										<tr>
											<th></th>
											<th>상품</th>
											<th>수량</th>
											<th>금액</th>
										</tr>
									</thead>
									<tbody id="tbodyDetail"></tbody>
								</table>
							</div>

							<div class="row" style="padding-bottom: 10px; padding-top: 15px">
								<div class="col-12 col-md-3">
									<span>주문번호 :&nbsp;&nbsp;</span><span id="modalOrderNo"></span>
								</div>
								<div class="col-12 col-md-2">
									<button class="btn btn-link" id="orderCancel" onclick="orderCancel()">주문 취소</button>
								</div>
								<div class="col-12 col-md-2">
									<span>배송비 :&nbsp;&nbsp;</span><span id="modalOrderDeliveryCost"></span>
								</div>
								<div class="col-12 col-md-3">
									<span>총 결제 금액 :&nbsp;&nbsp;</span><span id="modalOrderCost"></span><span>원</span>
								</div>
								<div class="col-12 col-md-2">
									<span>적립금 :&nbsp;&nbsp;</span><span id="modalOrderPoint"></span><span>점</span>
								</div>
							</div>
							<div class="row">
								<div class="col-12 col-md-3">
									<span>받으시는 분 :&nbsp;&nbsp;</span><span id="modalShippingReciever"></span>
								</div>
								<div class="col-12 col-md-3">
									<span>연락처 :&nbsp;&nbsp;</span><span id="modalShippingPhone"></span>
								</div>
								<div class="col-12 col-md-6">
									<span>주소 :&nbsp;&nbsp;</span><span id="modalShippingAddr"></span>
								</div>
							</div>
							<div class="row">
								<div class="col-12 col-md-6">
									<span>요청사항 :&nbsp;&nbsp;</span><span id="modalShippingRequest"></span>
								</div>
							</div>
						</div>
					</div>
					<div style="text-align: center">
						<button type="reset" class="btn btn-outline-primary-2 btn-order btn-block" onclick="modalClose()" style="margin-bottom: 15px; width: 200px" data-dismiss="modal" aria-label="Close">확인</button>
					</div>
				</div>
			</div>
		</div>
		<!-- mypage Modal -->

		<jsp:include page="../footer.jsp"></jsp:include>
	</div>
</body>
<script>
    function modalClose() {
      $("#detailOrderModal").hide();
    }

    function orderCancel() {
      //취소
      window.location.href =
        "/order/cs/cancel?orderNo=" + $("#modalOrderNo").text();
    }

    function detailOrder() {
      let orderNo = $("#orderId").val();
      let phone = $("#phone").val();
      $.ajax({
        url: "/mypage/detailOrder", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
        type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
        data: {
          orderNo: orderNo,
          phone: phone,
        }, // 데이터 보내기
        dataType: "json", // 수신받을 데이터 타입 (MINE TYPE)
        success: function (data) {
          // 통신이 성공하면 수행할   함수
          console.log(data);
          let output = "";
          console.log(data.opList);
          $("#modalOrderNo").text(data.oBill.orderNo);
          $("#modalOrderCost").text(
            data.oBill.orderCost.toLocaleString("ko-KR")
          );
          $("#modalOrderPoint").text(
            data.oBill.orderPoint.toLocaleString("ko-KR")
          );
          $("#modalShippingReciever").text(data.osDto.reciever);
          $("#modalShippingPhone").text(data.osDto.phone);
          $("#modalShippingAddr").text(data.osDto.address);
          $("#modalShippingRequest").text(data.osDto.request);
          if (data.oBill.orderCost > 50000) {
            $("#modalOrderDeliveryCost").text("무료배송");
          } else {
            $("#modalOrderDeliveryCost").text("3,000원");
          }
          for (var i = 0; i < data.opList.length; i++) {
            output += "<tr>";
            output +=
              "<td style='padding : 0px;'><div class='product'><figure class='product-media'><a href='../product/productDetail?productNo=" +
              data.opList[i].productNo +
              "'>";
            output +=
              "<img src='" +
              data.opList[i].thumbnailImg +
              "'></a></figure></div></td>";
            output +=
              "<td><h3 class='product-title'>" +
              data.opList[i].productName +
              "</h3></td>";
            output += "<td>" + data.opList[i].quantity + "</td>";
            output += "<td>" + data.opList[i].orderPrice + "</td>";
            output += "</tr>";
          }
          $("#tbodyDetail").html(output);
          $("#detailOrderModal").show();
        },
        error: function () {},
        complete: function () {},
      });
    }
  </script>
</html>
