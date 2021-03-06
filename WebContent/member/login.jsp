<%@page import="generic.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인 인증정보를 입력받기 위한 JSP 문서 --%>
<%-- => [로그인]을 클릭한 경우 로그인 처리페이지(member_login_action.jsp) 요청 - 입력값 전달 --%>
<%
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	if(loginMember!=null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		 return;
	}

	String message=(String)session.getAttribute("message_1");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message_1");
	}
	
	String id=(String)session.getAttribute("mid");
	if(id==null) {
		id="";
	} else {
		session.removeAttribute("mid");
	}
%>

<jsp:include page="/header.jsp"/>    
<form id="login" name="loginForm" action="login_action.jsp" method="post" onsubmit="return;">
  <main> 
      <div class="site-section">
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <div class="container">
        <div class="row">
          <div class="col-md-6 mb-5 mb-md-0">
            <h2 class="h3 mb-3 text-black">로그인</h2>
            <div class="p-3 p-lg-5 border">
              <div class="form-group row">
                <div class="col-md-12">
                  <label for="mid" class="text-black">아이디</label>
                  <input type="text" class="form-control" id="mid" name="mid" value="<%=id %>">
                  <div id="message_1"><%=message %></div>
                </div>
              </div>
              <div class="form-group row">
                <div class="col-md-12">
                  <label for="mpw" class="text-black">패스워드 </label>
                  <input type="password" class="form-control" id="mpw" name="mpw">
                  <div id="message_2"></div>
                </div>
              </div>
                <div class="form-group row">
                <div class="col-md-12">
              <div class="find-pw margin_b20 text_l" ><a href="<%=request.getContextPath() %>/member/find_id.jsp" style="text-decoration: underline;">아이디 찾기</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath() %>/member/find_pw.jsp" style="text-decoration: underline;">패스워드 찾기</a> </div>							
              							
			  </div>
			  </div>
			  <button type="submit" class="btn btn-outline-dark btn-lg btn-block" id="login_btn">로그인</button>
            </div>
          </div>
          <div class="col-md-6">
            <div class="row mb-5">
              <div class="col-md-12">
                <h2 class="h3 mb-3 text-black">회원가입</h2>
                <div class="p-3 p-lg-5 border">
                  <label for="c_code" class="text-black mb-3">회원가입을 하시면, 주문 조회와 개인정보 관리 및 위시리스트 확인 등 다양한 혜택을 누리실 수 있습니다.</label>
                    <a class="btn btn-outline-dark btn-lg btn-block" href="<%=request.getContextPath() %>/member/join.jsp">신규가입</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
 	</div>
 	
 </main>  
 </form>

 <script type="text/javascript">
$("#mid").focus();

$("#login_btn").click(function() {
	
	$("#message_1").text("");
	
	if($("#mid").val()=="") {
		$("#message_1").text("아이디를 입력해 주세요.");
		$("#mid").focus();
		return false;
	}
	
	if($("#mpw").val()=="") {
		$("#message_2").text("비밀번호를 입력해 주세요.");
		$("#mpw").focus();
		return false;
	}
	
	$("#login").submit();
});

</script>
<jsp:include page="/footer.jsp"/>    