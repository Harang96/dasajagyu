<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <style>
        @import url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);
        .rate {
            display: inline-block;
            border: 0;
            margin-right: 15px;
        }
        .rate>input {
            display: none;
        }
        .rate>label {
            float: right;
            color: #ddd;
        }
        .rate>label:before {
            display: inline-block;
            font-size: 1rem;
            padding: 0.3rem 0.2rem;
            margin: 0;
            cursor: pointer;
            font-family: FontAwesome;
            content: "\f005 ";
        }
        .rate .half:before {
            content: "\f089 ";
            position: absolute;
            padding-right: 0;
        }
        .rate input:checked~label,
        .rate label:hover,
        .rate label:hover~label {
            color: #f73c32 !important;
        }
        .rate input:checked+.rate label:hover,
        .rate input input:checked~label:hover,
        .rate input:checked~.rate label:hover~label,
        .rate label:hover~input:checked~label {
            color: #f73c32 !important;
        }
        .rate>label:before {
            font-size: 2.4rem !important;
        }
        .product-media {
            width: 400px;
        }
        .img-rm{
            background: url( "/resources/images/cross.png" ) no-repeat;
            border: none;
            width: 24px;
            height: 24px;
            cursor: pointer;
        }
    </style>
    <script>
        $(function(){
        	// active 클래스 초기화
        	$.each($("aside .nav-link"), function(i, nav){
        		$(nav).attr("class", "nav-link");
        	});
        	
        	$("#tab-review-link").addClass("active");

            let rating = (Number('${review.reviewStar}')*2).toFixed();
            console.log(rating);
            let rateRadio = $(`input[type="radio"][value="\${rating}"]`);
            console.log(rateRadio.val())
            $(rateRadio).prop("checked", true);
        });

        function deleteImage(no){
            console.log(no+"번 이미지 삭제하러 ㄱ");
            $.ajax({
            url: "deleteImg?no="+no,
            type: "GET",
            dataType: "text",
            success: function (data) {
            	console.log(data)
              if(data == "success"){
				$("#img_"+no).remove();
			  }
            },
            error: function (data) {
            	console.log(data);
            }
          });
        }
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
                            	<div class="tab-content">
	                                <div class="tab-pane show active" id="tab-reviewable">
	                                    <h5 class="pl-6 ml-6">리뷰 수정</h5>
	                                    
	                                    <div class="product-details-top">
	                                        <div class="row">
	                                            <div class="col-md-6">
	                                                <div class="product-gallery mt-4">
	                                                    <figure class="product-main-image">
	                                                        <img src="${review.thumbnailImg}" alt="Product image" />
	                                                    </figure>
	                                                    <!-- End .product-main-image -->
	                                                </div>
	                                                <!-- End .product-gallery -->
	                                            </div>
	                                            <!-- End .col-md-6 -->
	
	                                            <div class="col-md-6">
	                                                <div class="product-details product-details-sidebar">
	                                                    <h1 class="product-title">
	                                                        ${review.productName }
	                                                    </h1>
	                                                    <!-- End .product-title -->
	
	                                                    <form action="modifyReview" method="post" enctype="multipart/form-data">
	                                                        <label class="d-flex"><b>별점</b></label>
	                                                        <fieldset class="rate">
	                                                            <input type="radio" id="rating10" name="reviewStar" value="10" />
	                                                            <label for="rating10" title="5점"> </label>
	                                                            <input type="radio" id="rating9" name="reviewStar" value="9" /><label class="half" for="rating9" title="4.5점"></label>
	                                                            <input type="radio" id="rating8" name="reviewStar" value="8" /><label for="rating8" title="4점"></label>
	                                                            <input type="radio" id="rating7" name="reviewStar" value="7" /><label class="half" for="rating7" title="3.5점"></label>
	                                                            <input type="radio" id="rating6" name="reviewStar" value="6" /><label for="rating6" title="3점"></label>
	                                                            <input type="radio" id="rating5" name="reviewStar" value="5" /><label class="half" for="rating5" title="2.5점"></label>
	                                                            <input type="radio" id="rating4" name="reviewStar" value="4" /><label for="rating4" title="2점"></label>
	                                                            <input type="radio" id="rating3" name="reviewStar" value="3" /><label class="half" for="rating3" title="1.5점"></label>
	                                                            <input type="radio" id="rating2" name="reviewStar" value="2" /><label for="rating2" title="1점"></label>
	                                                            <input type="radio" id="rating1" name="reviewStar" value="1" /><label class="half" for="rating1" title="0.5점"></label>
	                                                        </fieldset>
	
	                                                        <div>
	                                                            <label><b>리뷰</b></label>
	                                                            <textarea id="reviewContent" name="reviewContent" class="form-control" cols="30" rows="4" placeholder="상품에 대한 솔직한 평가를 남겨주세요.">${review.reviewContent}</textarea>
	                                                        </div>
	
	                                                        <div>
	                                                            <label><b>사진첨부</b></label>
	                                                            <input type="file" id="uploadFile" name="uploadFile" class="form-control" multiple />
																
																	<c:if test="${review.reviewImages.size()>0}">
																		<div>첨부 이미지 ${review.reviewImages.size()}개</div>
																		<div style="display: flex;">
																		<c:forEach var="image" items="${review.reviewImages}" >
                                                                            <div class="mt-1 mb-1 mr-2" id="img_${image.imgNo}">
                                                                                <img src="${image.base64}" alt="reviewImage" style="width: 100px;">
                                                                                <button type="button" class="img-rm" onclick="deleteImage(${image.imgNo})"></button>
                                                                            </div>
																		</c:forEach>
																		</div>
																	</c:if>
	                                                        </div>
	
	                                                        <div>
	                                                            <input type="hidden" name="reviewNo" value="${review.reviewNo }" />
	                                                            <input type="hidden" name="productNo" value="${review.productNo }" />
	                                                            <input type="hidden" name="orderNo" value="${review.orderNo }" />
	                                                            <input type="hidden" name="uuid" value="${review.uuid }" />
	                                                            <input type="hidden" name="originalName" value="${review.originalName }" />
	                                                            <input type="submit" class="btn btn-block btn-primary" />
	                                                        </div>
	                                                    </form>
	                                                    <!-- End .product-details-action -->
	                                                </div>
	                                                <!-- End .product-details -->
	                                            </div>
	                                        </div>
	                                        <!-- End .row -->
	                                    </div>
	                                </div>
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
</html>