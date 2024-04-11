/**
 * app-ecommerce-product-list
 */

'use strict';

	$(function(){
        $("#searchType").change(function(){
        if ($(".classNo").val() != 0) {
				location.href="/admin/product/productList?searchType=" + $(this).val() + "&pageProductCnt=" + $(".productsPerPage").val() + "&classNo=" + $(".classNo").val() + "&searchWord=" + $(".searchWord").val();
			} else if ($(".originalClass").val() != "") {
				location.href="/admin/product/productList?searchType=" + $(this).val() + "&pageProductCnt=" + $(".productsPerPage").val() + "&originalClass=" + $(".originalClass").val() + "&searchWord=" + $(".searchWord").val();
			} else if ($(".manufacturerNo").val() != 0) {
				location.href="/admin/product/productList?searchType=" + $(this).val() + "&pageProductCnt=" + $(".productsPerPage").val() + "&manufacturerNo=" + $(".manufacturerNo").val() + "&searchWord=" + $(".searchWord").val();
		 	} else {
				location.href="/admin/product/productList?searchType=" + $(this).val() + "&pageProductCnt=" + $(".productsPerPage").val() + "&searchWord=" + $(".searchWord").val();
		 	}
        })
		
		$(".btn-close").click (function(){
			$("#updateModal").hide();
		})
		
		$(".modalClose").click (function(){
			$("#updateModal").hide();
		})

		$(".productsPerPage").change(function(){
			if ($(".classNo").val() != 0) {
				location.href="/admin/product/productList?pageProductCnt=" + $(this).val() + "&classNo=" + $(".classNo").val() + "&searchWord=" + $(".searchWord").val();
			} else if ($(".originalClass").val() != "") {
				location.href="/admin/product/productList?pageProductCnt=" + $(this).val() + "&originalClass=" + $(".originalClass").val() + "&searchWord=" + $(".searchWord").val();
			} else if ($(".manufacturerNo").val() != 0) {
				location.href="/admin/product/productList?pageProductCnt=" + $(this).val() + "&manufacturerNo=" + $(".manufacturerNo").val() + "&searchWord=" + $(".searchWord").val();
		 	} else {
				location.href="/admin/product/productList?pageProductCnt=" + $(this).val() + "&searchWord=" + $(".searchWord").val();
		 	}

		});
		
		$(".classNo").change(function(){
			location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&classNo=" + $(this).val();

		});
		
		$(".originalClass").change(function(){
			location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&originalClass=" + $(this).val();

		});
		
		$(".manufacturerNo").change(function(){
			location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&manufacturerNo=" + $(this).val();

		});
		
		$('.searchWord').on('keypress', function(e){
	        if(e.keyCode == '13') {
				if ($(".classNo").val() != 0) {
					location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&classNo=" + $(".classNo").val() + "&searchWord=" + $(".searchWord").val();
				} else if ($(".originalClass").val() != "") {
					location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&originalClass=" + $(".originalClass").val() + "&searchWord=" + $(".searchWord").val();
				} else if ($(".manufacturerNo").val() != 0) {
					location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&manufacturerNo=" + $(".manufacturerNo").val() + "&searchWord=" + $(".searchWord").val();
			 	} else {
					location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&searchWord=" + $(".searchWord").val();
			 	}
			}

		});

	}) // onload 끝
	
	
	function updateProductModal(productNo) {
	    let productName = $('#productName' + productNo).val();
	    let classNo = $('#classNo' + productNo + ' option:selected').val();
	    let className = $('#classNo' + productNo + ' option:selected').html();
	    let manufactureNo = $('#manufacturerNo' + productNo + ' option:selected').val();
	    let manufactureName = $('#manufacturerNo' + productNo + ' option:selected').html();
	    let originalName = $('#originalName' + productNo).val();
	    let originalClass = $('#originalClass' + productNo + ' option:selected').val();
	    let classType = $('#originalClass' + productNo + ' option:selected').html().replace("&gt;", ">");
	    let salesCost = $('#salesCost' + productNo).val();
	    let discountRateVal = $('#discountRate' + productNo).val();
	    let currentQty = $('#currentQty' + productNo).val();
	    let isRecommend; // isRecommend 변수를 선언
	    let judge = $('input[id="isRecommend' + productNo + '"]').is(":checked");
	    if (judge){
	        isRecommend = 'Y';
	    } else {
	        isRecommend = 'N';
	    }
	    	    
	    let salesCostFormatted = salesCost.toLocaleString('en-US', { style: 'currency', currency: 'KRW' });
	    
	    $("#productNo").html(productNo);
	    $("#productName").html(productName);
	    $("#classNo").html("(" + classNo + ") " + className);
	    $("#manufacturerNo").html("(" + manufactureNo + ") " + manufactureName);
	    $("#originalName").html(originalName);
	    $("#originalClass").html("(" + originalClass + ") " + classType);
	    $("#salesCost").html(salesCostFormatted);
	    $("#discountRate").html(discountRateVal);
	    $("#currentQty").html(currentQty);
	    $("#isRecommend").html(isRecommend);
	    $(".updateProduct").attr("id", productNo);
	    
	    
	    $("#updateModal").show()
	}

	// 상품 정보를 업데이트하는 함수
	function updateProduct() {
	    let productNo = $("#productNo").html();
	    let productName = $('#productName' + productNo).val();
	    let classNo = $('#classNo' + productNo + ' option:selected').val();
	    let manufactureNo = $('#manufacturerNo' + productNo + ' option:selected').val();
	    let originalName = $('#originalName' + productNo).val();
	    let originalClass = $('#originalClass' + productNo + ' option:selected').val();
	    let salesCost = $('#salesCost' + productNo).val().replace('￦', "").replaceAll(",", "");
	    let discountRateVal = $('#discountRate' + productNo).val();
	    let discountRate = $('#discountRate' + productNo).val().replace("%", "");
	    let currentQty = $('#currentQty' + productNo).val();
	    let isRecommend; // 변수 정의
	    let judge = $('input[id="isRecommend' + productNo + '"]').is(":checked");
	    if (judge){
	        isRecommend = 'Y';
	    } else {
	        isRecommend = 'N';
	    }
	    		
	    // 상품 정보 객체 생성
	    let updateProduct = {
	        "productNo": parseInt(productNo),
	        "productName": productName,
	        "classNo": parseInt(classNo),
	        "manufacturerNo": parseInt(manufactureNo),
	        "originalName": originalName,
	        "originalClass": originalClass,
	        "salesCost": parseInt(salesCost),
	        "discountRate": parseInt(discountRate),
	        "currentQty": parseInt(currentQty),
	        "isRecommend": isRecommend
	    };
	    
	    $.ajax({
	        url: "/admin/product/updateProduct", 
	        data : JSON.stringify(updateProduct),
	        type: "POST", 
	        contentType : "application/json",
	        success: function(data) {		            
	            $("#updateModal").hide();
	            if ($(".classNo").val() != 0) {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&classNo=" + $(".classNo").val() + "&searchWord=" + $(".searchWord").val();
	            } else if ($(".originalClass").val() != "") {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&originalClass=" + $(".originalClass").val() + "&searchWord=" + $(".searchWord").val();
	            } else if ($(".manufacturerNo").val() != 0) {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&manufacturerNo=" + $(".manufacturerNo").val() + "&searchWord=" + $(".searchWord").val();
	            } else {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&searchWord=" + $(".searchWord").val();
	            }
	
	            $("#updateModal").hide();
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
	            // 페이지 리로드 또는 다른 처리
	            if ($(".classNo").val() != 0) {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&classNo=" + $(".classNo").val() + "&searchWord=" + $(".searchWord").val();
	            } else if ($(".originalClass").val() != "") {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&originalClass=" + $(".originalClass").val() + "&searchWord=" + $(".searchWord").val();
	            } else if ($(".manufacturerNo").val() != 0) {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&manufacturerNo=" + $(".manufacturerNo").val() + "&searchWord=" + $(".searchWord").val();
	            } else {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&searchWord=" + $(".searchWord").val();
	            }
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
	            // 페이지 리로드 또는 다른 처리
	            if ($(".classNo").val() != 0) {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&classNo=" + $(".classNo").val() + "&searchWord=" + $(".searchWord").val();
	            } else if ($(".originalClass").val() != "") {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&originalClass=" + $(".originalClass").val() + "&searchWord=" + $(".searchWord").val();
	            } else if ($(".manufacturerNo").val() != 0) {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&manufacturerNo=" + $(".manufacturerNo").val() + "&searchWord=" + $(".searchWord").val();
	            } else {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&searchWord=" + $(".searchWord").val();
	            }
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
	            // 페이지 리로드 또는 다른 처리
	            if (data == 'success') {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&classNo=" + $(".classNo").val() + "&searchWord=" + $(".searchWord").val();
	            } else if ($(".originalClass").val() != "") {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&originalClass=" + $(".originalClass").val() + "&searchWord=" + $(".searchWord").val();
	            } else if ($(".manufacturerNo").val() != 0) {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&manufacturerNo=" + $(".manufacturerNo").val() + "&searchWord=" + $(".searchWord").val();
	            } else {
	                location.href="/admin/product/productList?pageProductCnt=" + pageProductCntJSP + "&searchWord=" + $(".searchWord").val();
	            }
	        },
	        error: function() {}
	    });
	}
