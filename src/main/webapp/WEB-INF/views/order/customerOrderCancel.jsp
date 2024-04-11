<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">


<!-- molla/login.html  22 Nov 2019 10:04:03 GMT -->
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>상품 교환·환불</title>
<meta name="keywords" content="HTML5 Template">
<meta name="description" content="Molla - Bootstrap eCommerce Template">
<meta name="author" content="p-themes">
<!-- Favicon -->
<link rel="apple-touch-icon" sizes="180x180"
	href="../resources/assets/images/icons/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="../resources/assets/images/icons/favicon-16x16.png">
<link rel="manifest" href="../resources/assets/images/icons/site.html">
<link rel="mask-icon"
	href="../resources/assets/images/icons/safari-pinned-tab.svg"
	color="#666666">
<link rel="shortcut icon" href="../resources/images/icons/favicon.ico">
<meta name="apple-mobile-web-app-title" content="Molla">
<meta name="application-name" content="Molla">
<meta name="msapplication-TileColor" content="#cc9966">
<meta name="msapplication-config"
	content="../resources/assets/images/icons/browserconfig.xml">
<meta name="theme-color" content="#ffffff">
<!-- Plugins CSS File -->
<link rel="stylesheet" href="../resources/assets/css/bootstrap.min.css">
<!-- Main CSS File -->
<link rel="stylesheet" href="../resources/assets/css/style.css">
<link rel="stylesheet" href="/resources/css/customer/login.css">
<script src="/resources/assets/js/jquery.min.js"></script>
<script src="/resources/js/customer/login.js"></script>


<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

#birthday {
	width: 250px;
}

#addrPostcode {
	width: 250px;
}

.zipcode {
	display: flex;
}

.login-img {
	background-attachment: fixed;
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

.prdThumbImg {
	width: 100px;
	border: 1px solid lightgray;
	border-radius: 20%;
}

</style>

<body>
	<div class="page-wrapper">
		<main class="main">
			<div
				class="login-page">
				<div class="container">
					<div class="form-box">
						<div class="form-tab">
							<div class="tab-content">
								<div class="tab-pane fade show active" id="agree-2"
									role="tabpanel" aria-labelledby="agree-tab-2">
									<div class="progress" id="progressBar"></div>
									<div id="resultInputTarget"></div>


								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>


	<!-- Plugins JS File -->
	<script src="/resources/assets/js/jquery.min.js"></script>
	<script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
	<script src="/resources/assets/js/jquery.waypoints.min.js"></script>
	<script src="/resources/assets/js/superfish.min.js"></script>
	<script src="/resources/assets/js/owl.carousel.min.js"></script>
	<!-- Main JS File -->
	<script src="/resources/assets/js/main.js"></script>
	<script type="text/javascript">
		let paramData = {};
		
		$(document).ready(function(){
			$("#resultInputTarget").html(`${requestScope.mapResult.html }`)
			$("#progressBar").html(`${requestScope.mapResult.progress }`)
			
			$('#cancelReason').on('input', function() {
				var cancelReason = $(this).val().trim();
				var submitButton = $('#submitButton');

				// textarea에 입력된 값이 없으면 submit 버튼을 비활성화하고, 그렇지 않으면 활성화합니다.
				if (cancelReason === '') {
					submitButton.prop('disabled', true);
				} else {
					submitButton.prop('disabled', false);
				}
			});
		})

		function cancelFormSubmit(form, step){
			event.preventDefault();
			
			paramData.step = paramData.step == undefined ? 1 : paramData.step;
			
			if(step == 1){
				let data = {
					step : 1,
					cancelItem : []
				};

				$(".choice-cancel-item:checked").each(function(idx, item){
				    console.log(item)
					let tmpData = {};
					
				    $("input[name="+item.name+"]").each(function(i, tem) {
				    	let labelData = $(this).next().eq(0).children().children();
				        // input에 있는 data 속성들 가져오기 
					    	for(let attr in $(this).data()){
					        	tmpData[attr] = attr == 'orderNo' ? $(this).data(attr) + "" : $(this).data(attr);
					        }
					        
					        // label에 있는 data 속성들 가져오기 
					    	for(let i = 0 ; i < labelData.length; i++){
					    		let d = labelData.eq(i).children().data();
					    		tmpData[Object.keys(d).toString()] = Object.values(d).toString()
					    	}
				    })
				    data.cancelItem.push(tmpData)
				})
			    paramData = data;
			    paramData.orderNo = location.search.slice(1).split("&").map(item => item.split("=")[1])[0];
			    paramData.productNo = Number(location.search.slice(1).split("&").map(item => item.split("=")[1])[1]) || 0;
			    paramData.csType = location.pathname.slice(10);

				getData("/order/cs/next", paramData, "POST", false);
			} else if (step == 2){
				let type = "";
				let value = $("#cancelReason").val();
				if($("input[name=cancelType]:checked").attr('id') == "simpleChangeOfMind"){
					type = "단순변심";
				} else if($("input[name=cancelType]:checked").attr('id') == "productDamage"){
					type = "제품파손";
				}

				paramData.cancelType = type;
				paramData.cancelReason = value;
			
				getData("/order/cs/next", paramData, "POST", false);
			} else if(step >= 3){
				getData("/order/cs/applyCS", paramData, "POST", false);
			}
			
			
			
		}
		
		function getData(url, data, type, async){
			let result = "";
			$.ajax({
				url : url,
				type : type || "GET",
				data : JSON.stringify(data) || null,
				headers : {
					"Content-Type" : "application/json"
				},
				async : async || true,
				success : function(data){
					if(data.type == "cancel"){
					
					} else if(data.type == "checkOrder"){
					
					} else if(data.type == "orderCS"){
						if(data.result == "success"){
							$("#resultInputTarget").html(data.html);
							$("#progressBar").html(data.progress)
							paramData = JSON.parse(data.orderProduct);
						}
						
					} else if(data.type == "orderCSSubmit"){
						if(data.result == "success"){
							$("#resultInputTarget").html(successHtml)	
							$("#resultInputTarget").html(successHtml)
							$(".progress-bar").eq(0).css("width","100%")
						}
					}
					
					
				},
			    error: function (request, status, error) {
			        console.log("code: " + request.responseJSON)
			        console.log("message: " + request.responseJSON)
			        console.log("error: " + error)
			        
					$("#orderProductModal").modal("show")
					$("#modalLabel").text(request.status)
					$(".modal-body").html(request.responseText)
// 					$(".modal-footer").html(`<button type="button" class="btn btn-label-primary" data-bs-dismiss="modal">확인</button>`)
// 					$(".modal-footer").html(``);
			    },
			    complete : function() {
			    	return result;
			    }
			    
			})
		}
		
		
	</script>
</body>
</html>
