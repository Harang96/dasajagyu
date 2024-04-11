<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>쇼핑몰 이용안내</title>
</head>

<body>
    <jsp:include page="../header.jsp"></jsp:include>
    <main class="main mainFontStyle">
        <div class="page-header text-center">
            <!-- <div class="page-header text-center" style="background-image: url('assets/images/page-header-bg.jpg')"> -->
            <div class="container">
                <h1 class="page-title">쇼핑몰 이용안내
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
                    <!-- <li class="breadcrumb-item">
                        <a href="/">고객 서비스</a>
                    </li> -->
                    <li class="breadcrumb-item active" aria-current="page">쇼핑몰 이용안내</li>
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
                                            <dl class="gd-dsc tab_loc1">
                                                <dt>회원정보·혜택</dt>
                                                <dd>
                                                    <ul>
                                                        <li>
                                                            <p class="sub_title">1. 회원가입안내</p>
                                                            <div class="sub_box">
                                                                <p>- 다사자규는 기본적으로 회원제로 운영하고 있습니다.</p>
                                                                <p>- 회원가입비나 월회비, 연회비 등 어떠한 비용도 청구하지 않는 100% 무료입니다. </p>
                                                                <!-- <p>- 회원가입시 3,000원의 할인쿠폰이 지급 됩니다.</p> -->
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p class="sub_title">2. 적립금 제도</p>
                                                            <div class="sub_box">
                                                                <p>- 모든 회원분들께 구매 금액의 1%를 적립금으로 지급해 드리고 있습니다. <!-- (구매 후 3일이 지나면 자동으로 배송 완료 처리되며, 그 이후 적립금이 지급됩니다.) --></p>
                                                                <p>- 적립금은 금액 제한 없이 현금처럼 바로 사용하실 수 있습니다.</p>
                                                                <!-- 으며, 적립금을 적용한 총 결제 금액이 30,000원 미만일 경우 배송비 3,000원이 부과됩니다. -->
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </dd>
                                            </dl>
                                            <dl class="gd-dsc tab_loc2">
                                                <dt>주문 · 결제</dt>
                                                <dd>
                                                    <ul>
                                                        <li>
                                                            <p class="sub_title">1. 상품 주문 방법</p>
                                                            <div class="sub_box">
                                                                <p>① 상품 검색</p>
                                                                <p>② 장바구니 담기</p>
                                                                <p>③ 회원 ID 로그인 또는 비회원 주문</p>
                                                                <p>④ 주문서 작성</p>
                                                                <p>⑤ 결제 방법 선택 및 결제</p>
                                                                <p>⑥ 주문 성공화면 (주문번호)</p>
                                                                <p>※ 비회원 주문시 주문번호와 승인번호를 꼭 메모해 두시기 바랍니다.</p>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p class="sub_title">2. 결제 방법</p>
                                                            <div class="sub_box">
                                                                <p>- 다사자규는 무통장입금, 실시간 계좌이체, 신용카드, 핸드폰 결제, KB에스크로 결제, 카카오페이를 통한 결제방법을 제공하고 있습니다.</p>
                                                                <p>- 무통장 입금 : 인터넷 뱅킹, 모바일 뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금</p>
                                                                <p>- 신용카드 결제 : 보안 걱정 없는 이니시스(INICIS) 전자 결제를 이용, 이용 내역서는 (주)INICIS로 표기됩니다.</p>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </dd>
                                            </dl>
                                            <dl class="gd-dsc tab_loc3">
                                                <dt>배송</dt>
                                                <dd>
                                                    <ul>
                                                        <li>
                                                            <p class="sub_title">1. 배송 기간 및 배송 방법</p>
                                                            <div class="sub_box">
                                                                <p>- 다사자규는 CJ대한통운 택배를 이용하고 있으며, 배송 관련 사항들은 택배사 원칙에 따라 운영되고 있습니다.</p>
                                                                <p>- 고객님께서 무통장 입금으로 구매하신 경우에는 입금확인이 된 날로부터, 신용카드로 구매 하신 경우에는 구매하신 날로부터 2-3일 이내에(최장 7일 이내) 입력하신 배송지로 부터
                                                                    주문상품이 도착하게 됩니다. 주문하신 상품 또는 배송지에 따라 배송기간이 상이할 수 있습니다.</p>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p class="sub_title">2. 주문확인 및 배송조회 시스템</p>
                                                            <div class="sub_box">
                                                                <p>- 다사자규 공식 홈페이지에서 주문시 마이페이지 → 주문·배송 관리를 통해 주문확인 및 배송조회가 가능합니다.</p>
                                                                <p>- CJ대한통운 홈페이지에서 실시간으로 배송 추적이 가능합니다. (CJ 대한통운 고객센터 1588-1255)</p>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </dd>
                                            </dl>
                                            <dl class="gd-dsc tab_loc4">
                                                <dt>취소·교환·반품</dt>
                                                <dd>
                                                    <ul>
                                                        <li>
                                                            <p class="sub_title">1. 주문취소</p>
                                                            <div class="sub_box">
                                                                <p>- 주문취소는 미결제인 상태에서는 직접 취소가 가능합니다.</p>
                                                                <p>- 결제 후 주문취소는 다사자규 고객센터(02-837-9922) 혹은 1:1문의 게시판으로 요청 바랍니다.(오전 10시 30분 전 까지)</p>
                                                                <p>- 무통장 입금의 경우, 일정 기간동안 송금을 하지 않으면 자동으로 주문이 취소되며, 입금 전 구매자가 취소를 원하는 경우 홈페이지에서 직접 취소가 가능합니다.</p>
                                                                <p>- 카드로 결제하신 경우, 매입 전 취소(당일 결제건 당일 취소)는 카드사에서 당일날 취소 처리가 이루어지거나, 매입 후 취소(결제일 다음날 이후의 취소)일 경우
                                                                    은행영업일 기준으로 3~5일 소요되어 카드사에서 취소됩니다.</p>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p class="sub_title">2. 교환/반품</p>
                                                            <div class="sub_box">
                                                                <p>- 교환, 반품 요청 기한은 상품 수령 후 최대 14일 이내이며 미개봉 상품에 한하여 가능합니다. (상품에 하자가 있는 경우 수령 후 7일)</p>
                                                                <p>- 변심으로 인한 교환, 반품일 경우 왕복 택배비는 고객 부담이며, 반드시 저희 고객센터 (02-837-9922)을 통해 접수 후 상담원의 안내에 따라 반품 진행해 주시기 바랍니다.</p>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </dd>
                                            </dl>
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