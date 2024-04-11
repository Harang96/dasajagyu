<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 소개</title>
<link rel="icon" href="/resources/assets/images/icons/favicon.ico" />
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<main class="main mainFontStyle">
        <div class="page-header text-center">
            <!-- <div class="page-header text-center" style="background-image: url('assets/images/page-header-bg.jpg')"> -->
            <div class="container">
                <h1 class="page-title">회사 소개
                    <!-- <span> 이용약관</span> -->
                </h1>
            </div><!-- End .container -->
        </div><!-- End .page-header -->
        <nav aria-label="breadcrumb" class="breadcrumb-nav">
            <div class="container">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="/">홈</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">팀 소개</li>
                </ol>
            </div><!-- End .container -->
        </nav><!-- End .breadcrumb-nav -->
        <div class="page-content">
            <div class="container">
                <div class="row">
                    <div class="form-tab">
                        <div class="tab-content" id="tab-content-5">
                            <div class="tab-pane fade show active" id="agree" role="tabpanel" aria-labelledby="agree-tab">
                                <div class="form-group">
                                    <div id="homeInfoStyle" class="col privacy">

                                        <!-- 본문내용 -->
                                        <div class="page-body">
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- End .container -->
            </div><!-- End .page-content -->
        </div>
    </main><!-- End .main -->

    <jsp:include page="../footer.jsp"></jsp:include> <!-- footer 파일 인클루드 -->
</body>
</html>