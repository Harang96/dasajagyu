/**
 * app-ecommerce-product-list
 */

'use strict';

	$(function(){
        $("#searchType").change(function(){
			location.href="/admin/product/pdQna?searchType=" + $(this).val() + "&pageProductCnt=" + pageProductCntJSP;
		});

		$(".productsPerPage").change(function(){
			location.href="/admin/product/pdQna?searchType=" + $(this).val() + "&pageProductCnt=" + pageProductCntJSP;
		});
		

	}) // onload 끝
	
	

	// 상품 정보를 업데이트하는 함수
	function updatePdQna(boardNo) {
	    let svBoardAnswer = $("#svBoardAnswer" + boardNo).val();
	
	    		
	    // 상품 정보 객체 생성
	    let updateProduct = {
	        "svBoardNo": boardNo,
	        "svBoardAnswer": svBoardAnswer
	    };
	    
	    $.ajax({
	        url: "/admin/product/updatePdQna", 
	        data : JSON.stringify(updateProduct),
	        type: "POST",
	        contentType : "application/json",
	        success: function(data) {		           
	        console.log(data) 
		        if (data = "success") {
		            location.href="'/admin/product/pdQna?pageProductCnt=" + pageProductCntJSP + "&searchType=" + $(this).val() + "'";
		        }
	        },
	        error: function() {
	        },
	    });                              
	}


	// 상품 정보를 임시 삭제하는 함수
	function deleteProductTmp(productNo) {
	    $.ajax({
	        url: "/admin/product/deleteProductTemp",
	        data: {"productNo" : productNo},
	        type: "GET",
	        dataType: "text",
	        success: function(data) {		            
	            location.href="/admin/product/pdQna?pageProductCnt=" + pageProductCntJSP + "&searchType=" + $(this).val();
	        },
	        error: function() {}
	    });
	}

	// 삭제된 상품 정보를 복원하는 함수
	function restoreProduct(productNo) {
	    $.ajax({
	        url: "/admin/product/restoreProduct",
	        data: {"productNo" : productNo},
	        type: "GET",
	        dataType: "text",
	        success: function(data) {		            
	            location.href="/admin/product/pdQna?pageProductCnt=" + pageProductCntJSP + "&searchType=" + $(this).val();
	        },
	        error: function() {}
	    });
	}
	
	// 상품 정보를 완전히 삭제하는 함수
	function deleteProduct(productNo) {
	    $.ajax({
	        url: "/admin/product/deleteProduct",
	        data: {"productNo" : productNo},
	        type: "GET",
	        dataType: "text",
	        success: function(data) {		            
	            location.href="/admin/product/pdQna?pageProductCnt=" + pageProductCntJSP + "&searchType=" + $(this).val();
	        },
	        error: function() {}
	    });
	}
