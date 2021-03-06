<%@page import="generic.dao.CartDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인 사용자과 비로그인 사용자를 구분하여 응답 --%>
<%
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//헤더에 표시되는 카트 갯수를 표시하기 위해 세션에 저장된 아이디 받아서 카트 목록 출력 메소드 호출
	//String mid = loginMember.getMid();
	//int count = CartDAO.getDAO().selectCartCount(mid); 
%>  
<!DOCTYPE html>
<html>
<head>
    <title>GENERIC MONSTER</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Anton&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Mukta:300,400,700"> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/fonts/icomoon/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/jquery-ui.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/owl.theme.default.min.css">

    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/aos.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css">  
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/generic.css">  
    
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
	<script src="<%=request.getContextPath() %>/js/jquery-ui.js"></script>
	<script src="<%=request.getContextPath() %>/js/popper.min.js"></script>
	<script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/js/owl.carousel.min.js"></script>
	<script src="<%=request.getContextPath() %>/js/jquery.magnific-popup.min.js"></script>
	<script src="<%=request.getContextPath() %>/js/aos.js"></script>
	<script src="<%=request.getContextPath() %>/js/main.js"></script> 
	<script src=" http://maps.google.com/maps/api/js?v=3.3&sensor=true"></script>

</head>
<body> 
    <header>
        <div class="site-wrap">
          <div class="site-navbar bg-white py-2">
            <div class="search-wrap">
              <div class="container">
                <a href="#" class="search-close js-search-close"><span class="icon-close2"></span></a>
                <form action="<%=request.getContextPath() %>/main/header_search_product.jsp" method="post">
                  <input type="text" name="keyword" id="keyword" class="form-control" 
                  placeholder="찾으시는 상품명을 입력해주세요.">
                </form>	               
              </div>
            </div>
            <div class="container">
              <div class="d-flex align-items-center justify-content-between">
                <div class="logo">
                  <div class="site-logo">
                    <a href="<%=request.getContextPath() %>/index.jsp">GENERIC MONSTER</a>
                  </div>
                </div>
                <div class="main-nav d-none d-lg-block">
                  <nav class="site-navigation text-right text-md-center" role="navigation">
                    <ul class="site-menu js-clone-nav d-none d-lg-block">
	                    <li><a href="<%=request.getContextPath() %>/main/about.jsp">제네릭몬스터</a></li>
                        <li><a href="<%=request.getContextPath() %>/main/productList_glasses.jsp">안경</a></li>
                        <li><a href="<%=request.getContextPath() %>/main/productList_sunglasses.jsp">선글라스</a></li>
	                    <li><a href="<%=request.getContextPath() %>/notice/notice_list.jsp">공지사항</a></li>		                
                    </ul>
                  </nav>
                </div>
                
                <div class="icons">
                  <a href="#" class="icons-btn d-inline-block js-search-open"><span class="icon-search"></span></a>
                  <% if(loginMember==null) {//비로그인 사용자 %>
		           <a href="<%=request.getContextPath() %>/member/login.jsp" class="icons-btn d-inline-block"><span class="icon-user"></span></a>
		          <% } else if(loginMember.getMstatus()==1){//회원 로그인 사용자 %>
		           <a href="<%=request.getContextPath() %>/member/info_pw_check.jsp" class="icons-btn d-inline-block"><span class="icon-user"></span></a>
		           <a href="<%=request.getContextPath() %>/member/logout_action.jsp" class="icons-btn d-inline-block"><span class="icon-sign-out"></span></a>
		          <% } else {//관리자 로그인 %>
		          <a href="<%=request.getContextPath() %>/admin/Admin.jsp" class="icons-btn d-inline-block"><span class="icon-gears"></span></a>
		          <a href="<%=request.getContextPath() %>/member/info_pw_check.jsp" class="icons-btn d-inline-block"><span class="icon-user"></span></a>
		          <a href="<%=request.getContextPath() %>/member/logout_action.jsp" class="icons-btn d-inline-block"><span class="icon-sign-out"></span></a>
		          <% } %>
                  <a href="<%=request.getContextPath() %>/cart/cart.jsp" class="icons-btn d-inline-block bag">
                    <span class="icon-shopping-bag"></span>
                    <% if(loginMember==null){//비로그인 사용자 %>                    
                   
                    <% } else { %>
                    <span class="number"> <%=CartDAO.getDAO().selectCartCount(loginMember.getMid()) %></span>
                    <% } %>
                  </a>
                  <a href="#" class="site-menu-toggle js-menu-toggle ml-3 d-inline-block d-lg-none"><span class="icon-menu"></span></a>
                </div>
              </div>
            </div>
          </div>
        </div>
   </header>
 
