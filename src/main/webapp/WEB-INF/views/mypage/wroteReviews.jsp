<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
$(function(){
	// active 클래스 초기화
	$.each($("aside .nav-link"), function(i, nav){
		$(nav).attr("class", "nav-link");
	});
	
	$("#tab-review-link").addClass("active");
});
</script>

</head>
<body>
<div class="page-wrapper">
	<jsp:include page="../header.jsp"></jsp:include>
		<main class="main">
 			 <div class="page-content">
            	<div class="dashboard">
	              <div class="container">
	                <div class="row">
						<jsp:include page="mypageAside.jsp"></jsp:include>
						<div class="col-md-8 col-lg-10">
						 	 <div class="tab-pane" id="tab-reviewable" >
						 	 <div class="heading">
									<h2 class="title" style="font-weight: bolder;"> 리뷰 관리</h2>
								</div>
								<ul class="nav nav-pills justify-content-center bt2 mb-3 pt-2 pb-2" id="tabs-6" role="tablist">
								    <li class="nav-item">
								        <a class="nav-link" id="tab-21-tab" href="reviewable" aria-selected="true" >리뷰 작성한</a>
								    </li>
								    <li class="nav-item">
								        <a class="nav-link active" id="tab-22-tab" href="wroteReviews"><b>작성한 리뷰</b></a>
								    </li>
								</ul>
							<div><b>내가 작성한 리뷰 ${list.size()}</b></div>
								    	<c:choose>
								    	<c:when test="${list != null && list.size() > 0 }">
								    		<table class="table table-wishlist table-mobile">
											<tbody>
											<c:forEach var="product" items="${list}" >
												<tr id="prd_${product.reviewNo}">
													<td class="product-col pt-0 pb-0">
														<div class="product">
															<figure class="product-media">
																<a href="../product/productDetail?productNo=${product.productNo}">
																	<img src="${product.thumbnailImg }" alt="Product image">
																</a>
															</figure>
														</div><!-- End .product -->
													</td>
													<td class="pt-0 pb-0">
													<div><b>${product.originalName}</b></div>
													<div class="ratings-container">
														<h3 class="product-title mr-4">
															<a href="../product/productDetail?productNo=${product.productNo }">${product.productName}</a>
														</h3>
		                                               <div class="ratings">
		                                                   <div class="ratings-val" style="width: ${product.reviewStar / 5 * 100}%;"></div><!-- End .ratings-val -->
		                                               </div><!-- End .ratings -->
													   <div class="ml-3"><fmt:formatDate value="${product.reviewDate}"/></div>
		                                           </div>
													<div>리뷰 : ${product.reviewContent}</div>
													
													<div>첨부 이미지 ${product.reviewImages.size()}개</div>
													<div style="display: flex;">
														<c:if test="${product.reviewImages.size()>0}">
															<c:forEach var="image" items="${product.reviewImages}" >
																<img class="mt-1 mb-1 mr-1" src="${image.base64}" alt="reviewImage" style="width: 50px;">
															</c:forEach>
														</c:if>
													</div>
													</td>
													<td class="action-col">
 														<button class="btn btn-block btn-outline-primary-2" onclick="modifyReview('${product.reviewNo}')">리뷰 수정하기</button> 
													</td>
													<td class="remove-col"><button class="btn-remove" onclick="deleteReview('${product.reviewNo}');" ><i class="icon-close"></i></button></td>
												</tr>
											</c:forEach>
											</tbody>
										</table><!-- End .table table-wishlist -->
								    	</c:when>
								    	<c:otherwise>
								    		<div>작성된 리뷰가 없습니다.</div>
								    	</c:otherwise>
								    	</c:choose>
								    	
									</div><!-- .End .tab-pane -->
									
							</div>
						 </div>
					</div>
				</div>
			</div>
		</div>
</main>
<jsp:include page="../footer.jsp"></jsp:include>
</div>
</body>
<style>
	.bt2 {
		border-top: 2px solid;
		border-bottom: 2px solid;
	}

	.product-col .product-media {
    display: inline-block;
    margin: auto;
    flex-shrink: 0;
    max-width: 120px !important;
	}

	.product-col .product {
    display: flex;
    align-items: center;
    margin: auto;
    padding-right: 0 !important;
    box-shadow: none;
}
.ratings-container {
    display: flex;
    align-items: center;
    font-size: 1.3rem;
    margin-bottom: 5px;
    line-height: 1;
    white-space: nowrap;
}
	
</style>
<script>
	function modifyReview(reviewNo){
		location.href = "modifyReview?no="+reviewNo;
	}
	
	function deleteReview(reviewNo){
		$.ajax({
            url: "deleteReview?no="+reviewNo,
            type: "GET",
            dataType: "text",
            success: function (data) {
            	console.log(data)
              if(data == "success"){
				$("#prd_"+reviewNo).remove();
			  }
            },
            error: function (data) {
            	console.log(data);
            }
          });
	}
</script>
</html>