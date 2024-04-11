<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html>

<head>
    <!--     <meta charset="UTF-8"> -->
    <!--     <title>마이페이지</title> -->
    <!--     <meta name="keywords" content="HTML5 Template" /> -->
    <!--     <meta name="description" content="FigureShop" /> -->
    <!--     <meta name="author" content="p-themes" /> -->
    <!--     <link rel="stylesheet" href="/resources/assets/css/plugins/nouislider/nouislider.css"> -->
    <%--
    <c:set var="URL" value="${pageContext.request.requestURL}" />
    --%>
<style>
	.nav-item {
		padding-left : 30px;
	}    
</style>
</head>

<body>
    <aside class="col-md-4 col-lg-2">
        <ul class="nav nav-dashboard flex-column mb-3 mb-md-0" role="tablist">
            <li class="nav-item">
                <a class="nav-link" id="tab-dashboard-link" href="../mypage/openmypage" aria-control="tab-dashboard">프로필 / 주문내역</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-wishList-link" href="../mypage/wishList">찜목록</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-delivery-link" href="../mypage/addressList" aria-controls="tab-delivery">배송지 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-review-link" href="../mypage/reviewable" aria-controls="tab-review">리뷰 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-active-link" href="../mypage/myActivity" aria-controls="tab-active">나의 활동내역</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-cs-link" href="../mypage/csList" aria-controls="tab-cs">나의 고객센터</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-privacy-link" href="../mypage/changeMemberInfoJoin" aria-controls="tab-privacy">개인정보 관리</a>
            </li>
        </ul>
    </aside>
</body>

</html>