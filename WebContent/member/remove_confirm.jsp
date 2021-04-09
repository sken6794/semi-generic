<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>  
<%
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>
<%@include file="/security/login_check.jspf" %>    
      <div class="site-section">
      <div class="row mb-5"></div>
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-12">
          </div>
        </div>
        <div class="row">
          <div class="col-md-6 offset-md-3">
            <h2 class="h3 mb-3 text-black" style="text-align: center;">회원탈퇴</h2>
            <div class="row mb-2"></div>
				<form name="passwdForm" action="<%=request.getContextPath()%>/member/remove_action.jsp" method="post" onsubmit="return submitCheck();">
            <div class="p-3 p-lg-5 border">
              <div class="form-group">
              </div>
              <div class="form-group row">
                <div class="col-md-12">
                  <label for="passwd" class="text-black"><span class="text-danger">*</span>패스워드 확인</label>
                  <input type="password" class="form-control" id="passwd" name="passwd">
                  <p id="message" style="color: red;"><%=message %></p> 
                </div>
              </div>
                <div class="form-group">
                <span class="text-danger">*</span><input type="checkbox" value="1" id="remove_box">정말로 회원탈퇴를 하시겠습니까?
                <div id="checkMsg" class="error">회원탈퇴에 동의해야 합니다.</div>
                <div class="collapse" id="create_an_account">
                </div>
			  <button type="submit" class="btn btn-outline-dark btn-lg btn-block" id="remove_btn">회원탈퇴</button>
            </div>
          </div>
		</form>
        </div>
        <!-- </form> -->
      </div>
    </div>
  </div>

<script type="text/javascript"> 
$('#remove_btn').click(function() {
	var submitResult=true;
	
	$(".error").css("display","none");
	if($("#remove_box").prop("checked")){
		$("#remove_box").val(0);
		$("#checkMsg").css("display","none");
	} else {
		$("#remove_box").val(1);
		$("#checkMsg").css("display","block");
		submitResult=false;
	}

	return submitResult;
	
});

passwdForm.passwd.focus();

function submitCheck() {
	if(passwdForm.passwd.value=="") {
		document.getElementById("message").innerHTML="패스워드를 입력해 주세요.";
		passwdForm.passwd.focus();
		return false;
	}else{
		alert("회원탈퇴 되었습니다. 이용해주셔서 감사합니다.");
	}
	return true;
}

 
</script>

<jsp:include page="/footer.jsp"/>  
