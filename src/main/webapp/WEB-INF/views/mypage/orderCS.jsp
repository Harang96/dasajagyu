<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <style>
      .product-media {
        width: 400px;
      }
    </style>
    <script>
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
                      <div class="heading">
                        <h2 class="title" style="font-weight: bolder;"> ${csType} 신청</h2>
                      </div>
                      <form action="/order/cs/applyCS" method="post" enctype="multipart/form-data" >
                        <input type="hidden" name="orderNo" value="${orderNo}">
                        <input type="hidden" name="csType" value="${csType}">

                        <h5 class="pt-3" style="border-top: 2px solid;">상품 선택</h5>
                        <table class="table table-wishlist table-mobile">
                          <tbody>
                          <c:forEach var="product" items="${list}" varStatus="status">
                            <tr id="prd_${product.productNo}">
                              <td>
                                <input type="hidden" name="selectedProduct${status.index}" value='{"no":${product.productNo}, "name":"${product.productName}", "price":${product.orderPrice}, "quantity":${product.quantity}, "totalPrice":${product.orderPrice * product.quantity}}'>
            <input type="checkbox" name="selectedProducts" class="form-control-input" value="${status.index}" checked>
                              </td>
                              <td class="product-col">
                                <div class="product">
                                  <figure class="product-media">
                                    <a href="../product/productDetail?productNo=${product.productNo }">
                                      <img src="${product.thumbnailImg }" alt="Product image">
                                    </a>
                                  </figure>
                                </div><!-- End .product -->
                              </td>
                              <td class="">
                              <h3 class="product-title">
                                <a href="../product/productDetail?productNo=${product.productNo }">${product.productName }</a>
                              </h3>
                              <div><b><fmt:formatNumber value="${product.orderPrice}"/>원</b></div>
                              <div>주문 수량 : ${product.quantity}개</div>
                              </td>
                              <!-- <td class="action-col">
                                <button class="btn btn-block btn-outline-primary-2" onclick="toWriteReview('${product.productNo}','${product.orderNo}')">리뷰 작성하기</button>
                              </td> -->
                            </tr>
                          </c:forEach>
                          </tbody>
                        </table><!-- End .table table-wishlist -->


                        <div>
                        <h5>신청 사유</h5>
                         <c:if test="${csType=='반품'}">
                          <input type="radio" name="reasonType" value="simple" id="simple"
													class="form-control-input"> <label
													for="simple" class="form-label">단순변심/주문실수</label>
                         </c:if>

                          <input type="radio" name="reasonType" value="damage" id="damage"
													class="form-control-input" checked> <label
													for="damage" class="form-label">상품파손/오배송</label>
                        </div>
                        

                        <div>
                          <label><b>상세 사유</b></label>
                          <textarea
                            id="reviewContent"
                            name="reason"
                            class="form-control"
                            cols="30"
                            rows="4"
                            placeholder="신청 상세 사유를 입력해주세요."
                          ></textarea>
                        </div>

                        <div>
                          <label><b>사진첨부</b></label>
                          <input
                            type="file"
                            id="uploadFile"
                            name="uploadFile"
                            class="form-control"
                            multiple
                          />
                        </div>

                        <div>
                          <input
                            type="submit"
                            class="btn btn-block btn-primary"
                          />
                        </div>
                      </form>
                         
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
  <script>
    
  </script>
</html>
