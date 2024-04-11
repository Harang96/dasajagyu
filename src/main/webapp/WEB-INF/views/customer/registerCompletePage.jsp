<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<!-- molla/login.html  22 Nov 2019 10:04:03 GMT -->
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Molla - Bootstrap eCommerce Template</title>
<meta name="keywords" content="HTML5 Template">
<meta name="description" content="Molla - Bootstrap eCommerce Template">
<meta name="author" content="p-themes">
<!-- Favicon -->
<link rel="apple-touch-icon" sizes="180x180"
   href="../resources/assets/images/icons/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32"
   href="../resources/assets/images/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16"
   href="../resources/assets/images/icons/favicon-16x16.png">
<link rel="manifest" href="../resources/assets/images/icons/site.html">
<link rel="mask-icon" href="../resources/assets/images/icons/safari-pinned-tab.svg">
<link rel="shortcut icon" href="../resources/images/icons/favicon.ico">
<meta name="apple-mobile-web-app-title" content="Molla">
<meta name="application-name" content="Molla">
<meta name="msapplication-TileColor" content="#cc9966">
<meta name="msapplication-config"
   content="../resources/assets/images/icons/browserconfig.xml">
<meta name="theme-color" content="#ffffff">
<!-- Plugins CSS File -->
<link rel="stylesheet" href="../resources/assets/css/bootstrap.min.css">
<!-- Main CSS File -->
<link rel="stylesheet" href="../resources/assets/css/style.css">
<link rel="stylesheet" href="/resources/css/customer/login.css">
<script src="/resources/assets/js/jquery.min.js"></script>
<script src="/resources/js/customer/login.js"></script>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<meta charset="KR">
<title>Insert title here</title>
</head>
<script type="text/javascript">

</script>
<style type="text/css">
#shopping{
   padding: 15px 0px 0px 0px;
   font-size : 20px;
   text-align: center;
   justify-content: center;
   
}
#shopping2{
   padding: 10px 0px 20px 0px;
   font-size : 20px;
   text-align: center;
   justify-content: center;
   
}
#welcome{
   padding: 50px 0px 0px 0px;
   text-align: center;
   justify-content: center;

}
#registerBtn{
   padding: 25px 135px 25px 135px;
    border-radius: 5px;
}


</style>
<body>
<div class="page-wrapper">
      <jsp:include page="../header.jsp"></jsp:include>

      <main class="main">
         <nav aria-label="breadcrumb" class="breadcrumb-nav border-0 mb-0">
            <div class="container">
               <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="http://localhost:8081/">Home</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Login</li>
               </ol>
            </div>
            <!-- End .container -->
         </nav>
        <div class="login-page bg-image pt-8 pb-8 pt-md-12 pb-md-12 pt-lg-17 pb-lg-17" style="background-image: url('../resources/assets/images/backgrounds/login-background.png');">
          <div class="container">
            <div class="form-box">
              <div class="form-tab">
                <ul class="nav nav-pills nav-fill" role="tablist">
                  <li class="nav-item">
                    <div class="nav-link active" id="register-tab-2" data-toggle="tab"  role="tab" aria-controls="register-2" aria-selected="true"><h2>다사자규</h2></div>
                  </li>
                </ul>
                <div class="tab-content">
                 
                <form action="completePage" method = "post">
                  <input type="hidden" name="pathR" value="${param.path}">
                  <div class="tab-pane fade show active" id="signin-2" role="tabpanel" aria-labelledby="signin-tab-2">
                      <div class="form-group" >
                         <div id="welcome">
                        <h3>다사자규에 오신것을 환영합니다!</h3>
                       </div>
                      <!-- End .form-group -->

                      <div class="form-group">
                        
                        <div  id ="shopping">회원가입을 완료하셨습니다!</div>
                        <div  id ="shopping2">즐거운 쇼핑 하시길 바랍니다!</div>
                        
                        
                      </div>
                      
                      <div class="form-group" style="justify-content : center; text-align: center; " >
                                 <button type="submit" class="btn btn-primary"
                                     id="registerBtn" ><span style= "font-size: 20px;" >로그인하러 가기</span></button>
                              </div>
                      <!-- End .form-group -->
               </div>
                   
                    <!-- End .form-choice -->
                  </div>
                  <!-- .End .tab-pane -->
                      <!-- End .row -->
                      </form>
                    </div>
                    <!-- End .form-choice -->
                  </div>
                  <!-- .End .tab-pane -->
                </div>
                <!-- End .tab-content -->
              </div>
              <!-- End .form-tab -->
            </div>
            <!-- End .form-box -->
        <!-- End .login-page section-bg -->
            </main>
            </div>         
            
               <jsp:include page="../footer.jsp"></jsp:include>
                     
                        <!-- Plugins JS File -->
   <script src="/resources/assets/js/jquery.min.js"></script>
   <script src="/resources/assets/js/bootstrap.bundle.min.js"></script>
   <script src="/resources/assets/js/jquery.hoverIntent.min.js"></script>
   <script src="/resources/assets/js/jquery.waypoints.min.js"></script>
   <script src="/resources/assets/js/superfish.min.js"></script>
   <script src="/resources/assets/js/owl.carousel.min.js"></script>
   <!-- Main JS File -->
   <script src="/resources/assets/js/main.js"></script>
</body>                  
</html>