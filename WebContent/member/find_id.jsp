<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인 인증정보를 입력받기 위한 JSP 문서 --%>
<%-- => [로그인]을 클릭한 경우 로그인 처리페이지(member_login_action.jsp) 요청 - 입력값 전달 --%>
<%
	String message=(String)session.getAttribute("message_1");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message_2");
	}
	String id=(String)session.getAttribute("mid");
	String name=(String)session.getAttribute("mname");
	if(name==null) {
		name="";
	} else {
		session.removeAttribute("mname");
	}
%>
   	<jsp:include page="/header.jsp"/>  
    <div class="site-section">
      <div class="container">
      <div class="row mb-5"></div>
   	<form id="find_id" name="findForm" action="<%=request.getContextPath() %>/member/find_id_action.jsp" method="post" onsubmit="return;">
      <h2 class="h3 mb-3 text-black" style="text-align: center;">아이디 찾기</h2>
        <div class="row">
          <div class="col-md-6 offset-md-3">
            <div class="p-3 p-lg-5 border">
              <div class="form-group row">
                <div class="col-md-12">
                  <label for="mname" class="text-black">이름 </label>
                  <input type="text" class="form-control" id="mname" name="mname" value="<%=name %>">
                  <div id="message_1"><%=message %></div>
                </div>
              </div>
              <div class="form-group row">
                <div class="col-md-12">
                  <label for="memail" class="text-black">이메일 </label>
                  <input type="text" class="form-control" id="memail" name="memail">
                  <div id="message_2"></div>
                </div>
              </div>
			  <button type="submit" class="btn btn-outline-dark btn-lg btn-block">아이디 찾기</button>
            </div>
          </div> 
        </div>
          </form>
      </div>
    </div>
    
     <script type="text/javascript">
		$("#mname").focus();
		
		$("#find_id").submit(function() {
			 var checkEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;  //Email 유효성 검사 정규식
			if($("#mname").val()=="") {
				$("#message_1").text("이름을 입력해주세요.");
				$("#mname").focus();
				return false;
			}else if($("#memail").val()=="") {
				$("#message_2").text("이메일을 입력해주세요.");
				$("#memail").focus();
				return false;
			}else if(checkEmail.test($("#memail").val())!=true) {
				alert("올바른 형식의 이메일로 입력해 주세요.");
				$("#memail").focus();
				return false ;
			}

		});
		
	</script>

	<jsp:include page="/footer.jsp"/>  