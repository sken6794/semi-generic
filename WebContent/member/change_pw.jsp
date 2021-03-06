<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String message=(String)session.getAttribute("message_1");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message_1");
	}
%> 
<%@include file="/security/login_check.jspf" %> 
<jsp:include page="/header.jsp"/>  
    <div class="site-section">
      <div class="container">
      <div class="row mb-5"></div>
      <form id="change_pw" name="findForm" action="<%=request.getContextPath() %>/member/change_pw_action.jsp" method="post" onsubmit="return;">
      <h2 class="h3 mb-3 text-black" style="text-align: center;">패스워드 재설정</h2>
        <div class="row">
          <div class="col-md-6 offset-md-3">
            <div class="p-3 p-lg-5 border">
              <div class="form-group">
              </div>
				<div class="form-group row">
					<div class="col-md-12">
						<label for="mid" class="text-black"><span	class="text-danger">*</span>아이디&nbsp;&nbsp;</label> 
						<input type="text"	class="form-control" id="mid" name="mid"  value="<%=loginMember.getMid() %>" readonly="readonly">
					</div>
				</div>
				<div class="form-group row">
					<div class="col-md-12">
						<label for="mpw_1" class="text-black"><span	class="text-danger">*</span>패스워드&nbsp;&nbsp;</label> 
						<input type="password"	class="form-control" id="mpw_1" name="mpw_1" placeholder="패스워드 입력" value="">
						<div id="message_1"><%=message %></div>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-md-12">
						<label for="mpw_2" class="text-black"><span class="text-danger">*</span>패스워드 확인&nbsp;&nbsp;</label> 
						<input type="password"	class="form-control" id="mpw_2" name="mpw_2" placeholder="패스워드 입력" value="">
						<div id="message_2"><%=message %></div>
					</div>
				</div>
			  <button class="btn btn-outline-dark btn-lg btn-block">패스워드 재설정</button>
            </div>
          </div>
        </div>
        </form>
        <!-- </form> -->
      </div>
    </div>
	<script type="text/javascript">
		$("#mpw_1").focus();
		
		$("#change_pw").submit(function() {
			
			var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
    		if($("#mpw_1").val()=="") {
    			$("#message_1").text("패스워드를 입력해주세요.");
    			return false;
    		} else if(!passwdReg.test($("#mpw_1").val())) {
    			$("#message_1").text("올바른 형식의 패스워드로 입력해 주세요.");
    			return false;
    		} else if($("#mpw_1").val()!=$("#mpw_2").val()) {
    			$("#message_2").text("패스워드가 동일하지 않습니다.");
    			return false;
    		} else {
    			alert("패스워드가 변경되었습니다. 다시 로그인해주세요.");
    		}
    		submitResult=false;
		});
		
	</script>
<jsp:include page="/footer.jsp"/>  