<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<!DOCTYPE html>
<html lang="KO">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Header</title>
    <meta name="description" content="FigureShop" />
    <meta name="author" content="다팔자규" />

    <!-- Favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="/resources/assets/images/icons/apple-touch-icon.png" />
    <link rel="icon" href="/resources/assets/images/icons/favicon.ico" />
    <meta name="apple-mobile-web-app-title" content="FigureShop" />
    <meta name="application-name" content="FigureShop" />

    <!-- Internet Explorer 및 Microsoft Edge -->
    <meta name="msapplication-TileColor" content="#ef837b" />
    <meta name="msapplication-config" content="/resources/assets/images/icons/browserconfig.xml" />
    <meta name="theme-color" content="#fff" />

    <!-- Plugins CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/owl-carousel/owl.carousel.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/magnific-popup/magnific-popup.css" />
    <link rel="stylesheet" href="/resources/assets/css/plugins/jquery.countdown.css" />
    <link rel="stylesheet" href="/resources/assets/vendor/line-awesome/line-awesome/line-awesome/css/line-awesome.min.css" />

    <!-- Main CSS File -->
    <link rel="stylesheet" href="/resources/assets/css/style.css" />

    <!-- Bootstrap v5.3.2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/css/skins/skin-demo-2.css" />
    <link rel="stylesheet" href="/resources/assets/css/demos/demo-2.css" />

    <!-- 상품쪽 stylesheet -->
    <link rel="stylesheet" href="/resources/css/product.css" />

    <!-- Plugins Js File -->
    <script src="/resources/assets/js/jquery.min.js"></script>
    <script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
    <script src="/resources/assets/js/jquery.waypoints.min.js"></script>
    <script src="/resources/assets/js/superfish.min.js"></script>
    <script src="/resources/assets/js/owl.carousel.min.js"></script>
    <script src="/resources/assets/js/jquery.plugin.min.js"></script>
    <script src="/resources/assets/js/bootstrap-input-spinner.js"></script>
    <script src="/resources/assets/js/jquery.elevateZoom.min.js"></script>
    <script src="/resources/assets/js/jquery.magnific-popup.min.js"></script>
    <script src="/resources/assets/js/jquery.countdown.min.js"></script>

    <!-- Main JS File -->
    <script src="/resources/assets/js/main.js"></script>
    <script src="/resources/assets/js/demos/demo-2.js"></script>
    <script src="/resources/js/header.js"></script>
</head>

<body>
    <header class="header header-2 header-intro-clearance">
        <div class="header-top">
            <div class="container">
                <div class="header-right">
                    <ul class="top-menu">
                        <li>
                            <a href="#">로그인</a>
                            <ul>
                                <c:choose>
                                    <c:when test="${sessionScope.loginCustomer == null }">
                                        <li id="loginHrefBox">
                                            <a href="/customer/loginOpen" data-toggle="modal" onclick="saveReturnPath(this);" id="loginOpenBtn">로그인 &middot; 회원가입</a>
                                        </li>
                                   		<c:set var="url" value="${pageContext.request.requestURL}"></c:set>
				                        <%-- 현재 URL이 "/contact/findOrder"가 아닌 경우에만 비회원 주문 조회 링크 표시 --%>
								     	<c:if test="${!url.toString().contains('/CsCenter/CustomerCenterSrchOrder')}">
								     		<li id="loginHrefBox">
								                <a href="/contact/findOrder">비회원 주문 조회</a>
								            </li>
								     	</c:if>
								     	<c:if test="${!url.toString().contains('/CsCenter/CustomerCenterSrchOrder')}">
								     		<li id="loginHrefBox">
								            </li>
								     	</c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <li><span>${sessionScope.loginCustomer.nickname }</span>님 환영합니다.</li>
                                        <li>
                                            <c:choose>
                                                <c:when test="${sessionScope.loginCustomer.socialLogin == 'U'}">
                                                    <a href="/customer/logout" data-toggle="modal" onclick="saveReturnPath(this);">로그아웃</a>
                                                </c:when>
                                                <c:when test="${sessionScope.loginCustomer.socialLogin == 'K'}">
                                                    <a href="https://kauth.kakao.com/oauth/logout?client_id=fedfd31e6211b6353700f2d410a0c0d5&logout_redirect_uri=http://goott351.cafe24.com/customer/kakaoLogout" data-toggle="modal" onclick="savePathToKakaoLogout();">로그아웃</a>
                                                </c:when>
                                            </c:choose>
                                        </li>
                                        <c:if test="${sessionScope.loginCustomer.isAdmin == 'M' or sessionScope.loginCustomer.isAdmin == 'A'}">
                                            <li>

                                                <a href="/admin">관리</a>
                                            </li>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </li>
                    </ul>
                    <!-- End .top-menu -->
                </div>
                <!-- End .header-right -->
            </div>
            <!-- End .container -->
        </div>
        <!-- End .header-top -->

        <div class="header-middle">
            <div class="container">
                <div class="header-left">
                    <button class="mobile-menu-toggler">
                        <span class="sr-only">모바일 메뉴</span>
                        <i class="icon-bars"></i>
                    </button>
                    <a href="/" class="logo">
                        <img src="/resources/assets/images/demos/demo-2/logo.png" alt="FigureShop Logo" />
                    </a>
                </div><!-- End .header-left -->

                <div class="header-center">
                    <!-- 검색 -->
                    <div class="header-search header-search-extended header-search-visible header-search-no-radius d-none d-lg-block">
                        <a href="#" class="search-toggle" role="button">
                            <i class="icon-search"></i>
                        </a>
                        <form action="/product/searchList" method="get">
                            <div class="header-search-wrapper search-wrapper-wide">
                                <label for="searchWord" class="sr-only">검색</label>

                                <input type="search" class="form-control" name="searchWord" id="searchWord" placeholder="검색어를 입력해주세요." required />
                                <button class="btn btn-primary" type="submit">
                                    <i class="icon-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div><!-- End .header-center -->

                <div class="header-right">
                    <div class="account">
                        <a href="/mypage/openmypage" title="My account">
                            <span class="icon">
                                <i class="icon-user"></i>
                            </span>
                            <span class="mypage"> 마이페이지 </span>
                        </a>
                    </div>
                    <!-- End .account -->

                    <div class="wishlist">
                        <a href="/mypage/wishList" title="Wishlist">
                            <span class="icon">
                                <i class="icon-heart-o"></i>
                            </span>
                            <span class="wish">찜</span>
                        </a>
                    </div>
                    <!-- End .wishlist -->
                    <div class="dropdown cart-dropdown">
                        <a href="/cart/viewCart" class="dropdown-toggle">
                            <span class="icon">
                                <i class="icon-shopping-cart"></i>
                                <c:if test="${cookie.cartCnt == null }">
                                    <span class="cart-count">0</span>
                                </c:if>
                                <c:if test="${cookie.cartCnt.value >= 0 }">
                                    <span class="cart-count">${cookie.cartCnt.value }</span>
                                </c:if>
                            </span>
                            <span class="cart">장바구니</span>
                        </a>
                        <!-- End .dropdown-cart-products -->
                    </div>
                    <!-- End .dropdown-menu -->
                </div>
                <!-- End .header-right -->
            </div>
            <!-- End .container -->
        </div>
        <!-- End .header-middle -->

        <div class="header-bottom sticky-header mainFontStyle">
            <div id="nav-style" class="container">
                <div class="header-left">
                    <div class="dropdown category-dropdown">
                        <a href="/cart/viewCart" class="dropdown-toggle" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-display="static" title="Browse Categories">
                            전체 카테고리
                        </a>
                        <div class="dropdown-menu">
                            <nav class="side-nav">
                                <ul class="menu-vertical sf-arrows">
                                    <li class="item-lead sf-with-ul">
                                        <a href="/product/listAll">상품</a>
                                        <ul>
                                            <li><a href="/product/viewList?classNo=10">예약 상품</a></li>
                                            <li><a href="/product/viewList?classNo=20">신상품</a></li>
                                            <li><a href="/product/viewDCList">할인 상품</a></li>
                                            <li><a href="/product/viewBESTList">베스트 상품</a></li>
                                            <li><a href="/product/viewMDList">MD 추천 상품</a></li>
                                        </ul>
                                    </li>
                                    <li class="item-lead">
                                        <a href="/board/eventBoard">이벤트</a>
                                    </li>
                                    <li class="item-lead sf-with-ul">
                                        <a href="javascript:void(0);" class="sf-with-ul">커뮤니티</a>
                                        <ul>
                                            <li><a href="/board/shareBoardOpen">정보 공유 게시판</a></li>
                                            <li><a href="/board/originalBoard">작품별 게시판</a></li>
                                        </ul>
                                    </li>
                                    <li class="item-lead sf-with-ul">
                                        <a href="/contact/qna" class="sf-with-ul">고객지원</a>
                                        <ul>
                                            <li><a href="/contact/qna">문의하기</a></li>
                                            <li><a href="/contact/faq">자주묻는 질문</a></li>
                                        </ul>
                                    </li>
                                    <li class="item-lead sf-with-ul">
		                                <a href="/contact/qna" class="sf-with-ul">회사정보</a>
		                                <ul>
		                                    <!-- <li><a href="/cs/teamInfo">회사 소개</a></li> -->
		                                    <li><a href="/cs/location/">오시는 길</a></li>
		                                </ul>
		                            </li>
                                </ul>
                                <!-- End .menu-vertical -->
                            </nav>
                            <!-- End .side-nav -->
                        </div>
                        <!-- End .dropdown-menu -->
                    </div>
                    <!-- End .category-dropdown -->
                </div>
                <!-- End .header-left -->

                <div class="header-center">
                    <nav class="main-nav">
                        <ul class="menu sf-arrows">
                            <li class="item-lead sf-with-ul">
                                <a href="/product/listAll">상품</a>
                                <ul>
                                    <li><a href="/product/viewList?classNo=10">예약 상품</a></li>
                                    <li><a href="/product/viewList?classNo=20">신상품</a></li>
                                    <li><a href="/product/viewDCList">할인 상품</a></li>
                                    <li><a href="/product/viewBESTList">베스트 상품</a></li>
                                    <li><a href="/product/viewMDList">MD 추천 상품</a></li>
                                </ul>
                            </li>
                            <li class="sf-with-ul">
                                <a href="/board/eventBoard">이벤트</a>
                            </li>
                            <li class="sf-with-ul">
                                <a href="javascript:void(0);">커뮤니티</a>
                                <ul>
                                    <li><a href="/board/shareBoardOpen">정보 공유 게시판</a></li>
                                    <li><a href="/board/originalBoard">작품별 게시판</a></li>
                                </ul>
                            </li>
                            <li class="sf-with-ul">
                                <a href="/contact/qna" class="sf-with-ul">고객지원</a>
                                <ul>
                                    <li><a href="/contact/qna">문의하기</a></li>
                                    <li><a href="/contact/faq">자주묻는 질문</a></li>
                                    <!-- <li><a href="/cs/terms">이용약관</a></li>
                                    <li><a href="/cs/info">쇼핑몰 이용안내</a></li> -->
                                    <!-- <li><a href="/cs/personalInfo">개인정보 처리방침</a></li>
                                    <li><a href="/contact/findOrder">비회원 주문 조회</a></li> -->
                                </ul>
                            </li>
                             <li class="sf-with-ul">
                                <a href="/contact/qna" class="sf-with-ul">회사정보</a>
                                <ul>
                                    <!-- <li><a href="/cs/teamInfo">회사 소개</a></li> -->
                                    <li><a href="/cs/location/">오시는 길</a></li>
                                </ul>
                            </li>
                        </ul>
                        <!-- End .menu -->
                    </nav>
                    <!-- End .main-nav -->
                </div>
                <!-- End .header-center -->
            </div>
            <!-- End .container -->
        </div>
        <!-- End .header-bottom -->
    </header>
    <!-- End .header -->

    <!-- 최상단으로 이동 -->
    <button id="scroll-top" title="Back to Top">
        <i class="icon-arrow-up"></i>
    </button>

    <!-- Mobile Menu -->
    <div class="mobile-menu-overlay"></div>
    <!-- End .mobil-menu-overlay -->
    <div class="mobile-menu-container mobile-menu-light">
        <div class="mobile-menu-wrapper">
            <span class="mobile-menu-close"><i class="icon-close"></i></span>
            <form action="#" method="get" class="mobile-search">
                <label for="mobile-search" class="sr-only">검색</label>
                <input type="search" class="form-control" name="mobile-search" id="mobile-search" placeholder="검색어를 입력해주세요." required />
                <button class="btn btn-primary" type="submit">
                    <i class="icon-search"></i>
                </button>
            </form>
            <ul class="nav nav-pills-mobile nav-border-anim" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="mobile-menu-link" data-toggle="tab" href="#mobile-menu-tab" role="tab" aria-controls="mobile-menu-tab" aria-selected="true">전체 메뉴</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="mobile-cats-link" data-toggle="tab" href="#mobile-cats-tab" role="tab" aria-controls="mobile-cats-tab" aria-selected="false">마이페이지</a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade show active" id="mobile-menu-tab" role="tabpanel" aria-labelledby="mobile-menu-link">
                    <nav class="mobile-nav">
                        <ul class="mobile-menu">
                            <li class="active">
                                <a href="/product/listAll">상품</a>
                                <ul>
                                    <li><a href="/product/viewList?classNo=20">신상품</a></li>
                                    <li><a href="/product/viewDCList">할인 상품</a></li>
                                    <li><a href="/product/viewBESTList">베스트 상품</a></li>
                                    <li><a href="/product/viewList?classNo=10">예약 상품</a></li>
                                    <li><a href="/product/viewMDList">MD 추천 상품</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="/board/eventBoard">이벤트</a>
                            </li>
                            <li>
                                <a href="javascript:void(0);" class="sf-with-ul">커뮤니티</a>
                                <ul>
                                    <li><a href="/board/shareBoardOpen">정보 공유 게시판</a></li>
                                    <li><a href="/board/originalBoard">작품별 게시판</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="/contact/qna">고객센터</a>
                                <ul>
                                    <li><a href="/contact/qna">문의하기</a></li>
                                    <li><a href="/cs/terms">이용약관</a></li>
                                    <li><a href="/cs/info">쇼핑몰 이용안내</a></li>
                                    <li><a href="/contact/faq">자주묻는 질문</a></li>
                                    <li><a href="/cs/personalInfo">개인정보 처리방침</a></li>
                                    <li><a href="/contact/findOrder">비회원 주문 조회</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                    <!-- End .mobile-nav -->
                </div>
                <!-- .End .tab-pane -->
                <div class="tab-pane fade" id="mobile-cats-tab" role="tabpanel" aria-labelledby="mobile-cats-link">
                    <nav class="mobile-cats-nav">
                        <ul class="mobile-cats-menu">
                            <li><a class="mobile-cats-lead" href="/mypage/openmypage">마이페이지</a></li>
                            <li><a class="mobile-cats-lead" href="/mypage/wishList">찜목록</a></li>
                            <li><a class="mobile-cats-lead" href="/mypage/addressList">배송지 관리</a></li>
                            <li><a class="mobile-cats-lead" href="/mypage/reviewable">리뷰 관리</a></li>
                            <li><a class="mobile-cats-lead" href="#">나의 활동내역</a></li>
                            <li><a class="mobile-cats-lead" href="#">나의 고객센터</a></li>
                            <li><a class="mobile-cats-lead" href="#">개인정보관리</a></li>
                        </ul>
                        <!-- End .mobile-cats-menu -->
                    </nav>
                    <!-- End .mobile-cats-nav -->
                </div>
                <!-- .End .tab-pane -->
            </div>
            <!-- End .tab-content -->
            <div class="social-icons">
                <a href="https://blog.naver.com/PostList.naver?blogId=goottjob" class="social-icon social-naver" title="naverblog" target="_blank">
                    <img src="/resources/assets/images/naver_logo.svg" alt="네이버블로그 bi" style="width: 1.2rem" />
                </a>
                <a href="https://www.instagram.com/goott_academy" class="social-icon social-instagram" title="Instagram" target="_blank"><i class="icon-instagram"></i></a>
                <a href="https://www.youtube.com/@goottacademy9922" class="social-icon social-youtube" title="Youtube" target="_blank"><i class="icon-youtube"></i></a>
            </div>
            <!-- End .social-icons -->
        </div>
        <!-- End .mobile-menu-wrapper -->
    </div>
    <!-- End .mobile-menu-container -->
</body>

</html>