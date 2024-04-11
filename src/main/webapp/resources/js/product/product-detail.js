/**
 * App eCommerce Add Product Script
 */
'use strict';

		$(function (){
			$("#qnA_btn").on("click", function() {
				$("#qna-title").val("");
				$("#qna-textarea").val("");
			});
			
			// 좋아요
			$(".btn-wishlist").click(function() {
			    if ($(this).hasClass("like")) {
			        $(this).removeClass("like");
			        sendBehavior("dislike", $(this).attr("id"));
			    } else {
			        $(this).addClass("like");
			        sendBehavior("like", $(this).attr("id"));
			    }
	    	}); /* End 좋아요 */
	    	
	    	$("#qnA_btn").click(function() {
		    	if (uuid == ""){
	        		let returnLikePath = getReturnPath();
	        		location.href="/customer/loginOpen?path=" + returnLikePath;
		    	}
			})
	    }); 
	    
	    function sendBehavior(behavior, productNo){
	    	
	    	if (uuid == ""){
        		let returnLikePath = getReturnPath();
        		location.href="/customer/loginOpen?path=" + returnLikePath;
	    	} else {
	    		$.ajax({
	    			url : "/product/likedislike",
	    			type : "POST", // 통신방식 (GET, POST, PUT, DELETE)
	    			data : {
	    				"productNo" : productNo,
	    				"uuid" : uuid,
	    				"behavior" : behavior
	    			},
	    			dataType : "text", // MIME Type
	    			success : function (data){
	    				if (data == "success") {
	    				}
	    			},
	    			error : function (){
	    			},
	    			complete : function (){},
	    		});
	    	}
	    } /* sendBehavior */
	    
	    function toPurchase(productNo){
	          let order = [{
	                "productNo" : productNo,
	                "qty" : $("#qty").val()
	          }]
	          location.href="/order?products=" + encodeURIComponent(JSON.stringify(order));
	       }
	
      function toCart(productNo, currentQty){
          if (currentQty != 0) {
             $.ajax({
               url: "/cart/addProduct", 
               data : {
                  "productNo" : productNo,
	              "qty" : $("#qty").val()
               },
               type: "POST", 
               dataType : "text",
               success: function(data) {
				$("#cart-modal").modal();	
               },
               error: function() {
               },
            });              
          } else {
             $.ajax({
               url: "/cart/addProduct", 
               data : {
                  "productNo" : productNo,
                  "qty" : "0"
               },
               type: "POST", 
               dataType : "text",
               success: function(data) {
				$("#cart-modal").modal();	
               },
               error: function() {
               },
            });                              
          }
      } /* toCart */
		
		// 총 합계를 계산하고 표시하는 함수
function updateTotalPrice() {
    // 상품금액 요소와 수량 요소를 가져옴
    let salesCostElement = document.getElementById("salesCost");
    let quantityElement = document.getElementById("qty");
    let salesCostText;

    // 수량이 변경될 때마다 호출되는 함수 내부에서도 수량과 상품금액을 가져오도록 수정
    if (salesCostElement) {
        // 할인된 가격 요소와 원래 가격 요소를 찾음
        let discountedPriceElement = salesCostElement.querySelector(".discounted-price");
        let originalPriceElement = salesCostElement.querySelector(".original-price");

        // 할인된 가격이 있는 경우
        if (discountedPriceElement) {
            salesCostText = discountedPriceElement.textContent.trim(); // 텍스트 앞뒤 공백 제거
        } else {
            // 할인된 가격이 없는 경우 원래 가격 요소에서 가격을 가져옴
            salesCostText = originalPriceElement.textContent.trim(); // 텍스트 앞뒤 공백 제거
        }

        // 상품금액 요소의 텍스트 컨텐츠를 가져와서 숫자로 변환
        let salesCost = parseFloat(salesCostText.replace(/[^\d.-]+/g, '')); // 숫자와 소수점만 남기고 제거

        // 수량을 가져옴
        if (quantityElement) {
            let quantity = parseInt(quantityElement.value);

            // 총 금액 계산
            let totalPrice = salesCost * quantity;

            // 총 합계를 표시할 요소에 총 합계를 표시 (천 단위마다 쉼표(,) 추가)
            document.getElementById("totalPrice").textContent = totalPrice.toLocaleString();
        } else {
            console.error("품절된 상품입니다.");
        }

    } else {
        // 상품금액 요소가 존재하지 않는 경우, 처리할 내용 추가
        console.error("상품금액 요소를 찾을 수 없습니다.");
    }
}

		
		function hideQnaModal() {
			$("#qnA-modal").css("display", "none");
			$("#qnA-modal").css("padding-right", "");
			$(".modal-open").css("padding-right", "");
			
	    	$("#qnA-modal").removeAttr("aria-hidden");
	    	$("#qnA-modal").removeAttr("aria-modal");
	    	$("#qnA-modal").attr("aria-hidden", "true");
	    
	    	$("#qnA-modal").removeClass("show");
	    	$(".modal-open").removeClass("modal-open");
	    	$(".modal-backdrop").removeClass("modal-backdrop fade show");
	    	
            location.href = "/product/productDetail?productNo=" + productNo;
		}
      
		// 페이지 로드 시에 총 합계를 업데이트
		window.onload = function() {
			updateTotalPrice();
		};
		
		/* ========================= 문의하기 ========================= */
		function qna_input() {
			let writter = $("#qna-uuid").val();
			let title = $("#qna-title").val();
			let textArea = $("#qna-textarea").val();
// 			let productNo = '${param.productNo}';
			
			
			 // 문의 제목이 비어 있는 경우
	        if (title == '') {
	            // 필수 입력 사항을 알리는 모달 표시
	            alert("문의 제목은 필수 사항입니다.");
	        }
	        
	        // 문의 내용이 비어 있는 경우
	        else if (textArea == '') {
	            // 필수 입력 사항을 알리는 모달 표시
	            alert("문의 내용은 필수 사항입니다.");
	        } else {
	 		 	$.ajax({
	    			url : "/product/productQna",
	    			type : "GET", // 통신방식 (GET, POST, PUT, DELETE)
	    			data : {
	    				"uuid" : writter,
	    				"svBoardTitle" : title,
	    				"svBoardContent" : textArea,
	    				"productNo" : productNo
	    			},
	    			dataType : "text", // MIME Type
	    			success : function (data){
	    				
	    				if (data == "success") {
	    		            alert("문의가 성공적으로 등록되었습니다.");
	    					hideQnaModal();
 
	    					// 상품 문의 테이블에서 이 보드의 번호로 가져오기
	    					location.href = "/product/productDetail?productNo=" + productNo;
	    				}
	    			},
	    			error : function (){
	    			},
	    			complete : function (){},
	    		}); 
	        }
		}		
		
		// 서버에서 데이터를 가져와서 문의하기 리스트를 표시하는 함수
		function getProductDetailAndDisplayQna(productNo) {
		    $.ajax({
		        url: "/product/qna",
		        type: "GET",
		        data: {
		            "productNo": productNo
		        },
		        dataType: "json",
		        success: function(data) {
		            // 서버에서 반환된 데이터에서 문의하기 리스트를 가져옴
		            let productQnaList = data.qna;

		            // 가져온 문의하기 리스트를 화면에 표시
		            displayQnaList(productQnaList);
		        },
		        error : function (){
    				alert("Error")
    			},
    			complete : function (){},
    		});
		}

		// 이 상품의 문의 내역 가져오기
 		function getListOfQna() {
// 			let productNo = '${param.productNo}';
				
			$.ajax({
    			url : "/product/productQna",
    			type : "GET", // 통신방식 (GET, POST, PUT, DELETE)
    			data : {
    				"productNo" : productNo	
    			},
    			dataType : "json", // MIME Type
    			success : function (data){
    				displayQnaList(data);
    			},
    			error : function (){
    			},
    			complete : function (){},
    		});		
		}
		
		// 문의 내역을 받아와서 테이블로 화면에 표시하는 함수
		function displayQnaList(data) {
		    let result = "<tr><th>Title</th><th>Content</th></tr>";
		    
		    // 받은 데이터를 테이블 형태로 변환하여 추가
		    data.forEach(function(qna) {
		        result += "<tr><td>" + qna.sv_board_title + "</td><td>" + qna.sv_board_content + "</td></tr>";
		    });
		    
		    // 문의 내역을 표시할 요소에 추가
		    $("#qnaTbody").html(result);
		}
		
		/* ========================= 문의하기 제목 글자수 제한 ========================= */
		// 입력 필드
		let titleInputField = document.getElementById('qna-title');
	    let contentInputField = document.getElementById('qna-textarea');
		
	    // 입력 필드의 텍스트 길이 확인 및 팝업 표시 함수
	    function checkLength() {
	        let maxLengthTitle = parseInt(titleInputField.getAttribute('maxlength'));
	        let maxLengthContent = parseInt(contentInputField.getAttribute('maxlength'));
	        
	        let titleCurrentLength = titleInputField.value.length;
	        let contentCurrentLength = contentInputField.value.length;
	        
	        // 문의하기 제목 - 현재 길이가 최대 길이(30)를 초과하는 경우
	        if (titleCurrentLength >= maxLengthTitle) {
	            // 팝업 표시
	            $("#qna-popup-title").fadeIn(); // Fade in 효과

	            // 1초 후에 팝업 숨기기
	            setTimeout(function() {
	                $("#qna-popup-title").fadeOut();
	            }, 1000); // 1초 후에 실행
	        }
	        
	        // 문의하기 내용 - 현재 길이가 최대 길이(300)를 초과하는 경우
	        if (contentCurrentLength >= maxLengthContent) {
	            // 팝업 표시
	            $("#qna-popup-content").fadeIn(); // Fade in 효과

	            // 1초 후에 팝업 숨기기
	            setTimeout(function() {
	                $("#qna-popup-content").fadeOut();
	            }, 1000); // 1초 후에 실행
	        }
	        
	    }
	    
	    // 입력 필드의 내용이 변경될 때마다 호출되는 함수
	    if(titleInputField) {
	    	titleInputField.addEventListener('input', checkLength);
	    }
	    
	    if(contentInputField) {
	    	contentInputField.addEventListener('input', checkLength);
	    }
		/* ========================= 문의하기 End ========================= */
		
		// 모달 오픈 코드

		  function askLogin(no){
		  	if(uuid == ""){
		  		$("#order-modal").modal();
		  		$(".memberBtn").attr("id", no);
		  		$(".nonMemberBtn").attr("id", no);
		  		
		  	} else {
		  		toPurchase(no);
		  	}
		  }

		  function toLogin(no){
		  	location.href="/customer/loginOpen?path=/product/productDetail?productNo=" + no

		  }
		  
		  
		  function delPdQnA(svBNo){
			   $.ajax({
		      url : "/mypage/delPdQnA", // 데이터가 송수신될 서버의 주소 (서블릿의 매핑주소 작성)
			      type : "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			      data : {
			         "svBNo" : svBNo
			      }, // 데이터 보내기
			      dataType : "text", // 수신받을 데이터 타입 (MINE TYPE)
			      success : function(data) {
			         if(data == "success"){
			            window.location.reload();
			         } else {
			            alert("삭제 에러");
			         }
			         
			      },
			      error : function() {},
			      complete : function() {
			      },
			   });
			   
			};