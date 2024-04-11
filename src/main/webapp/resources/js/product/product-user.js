/**
 * 
 */
 
$(function (){
	// 좋아요
	$(".btn-wishlist").click(function() {
		if ($(this).hasClass("like")) {
			$(this).removeClass("like");
			sendBehavior("dislike", $(this).attr("id"));
		} else {
			$(this).addClass("like");
			sendBehavior("like", $(this).attr("id"));
		}
		        
	});
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
			error : function (){},
			complete : function (){},
		});
	}
}
     
function toPurchase(productNo){
	let order = [{
		"productNo" : productNo,
		"qty" : "1"
	}]
	location.href="/order?products=" + encodeURIComponent(JSON.stringify(order));
} /* toPurchase */

function toCart(productNo, currentQty){
	if (currentQty != 0) {
		$.ajax({
			url: "/cart/addProduct", 
			data : {
				"productNo" : productNo,
				"qty" : "1"
			},
			type: "POST", 
			dataType : "text",
			success: function(data) {
				$("#cart-modal").modal();	
			},
			error: function() {},
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
			error: function() {},
		});                              
	}
} /* toCart */


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