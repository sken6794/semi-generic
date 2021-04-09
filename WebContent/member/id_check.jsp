<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 아이디를 전달받아 MEMBER 테이블에 저장된 기존 회원정보의 아이디와
비교하여 사용 가능 여부를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 아이디 사용 가능(미중복) : 사용 가능 메세지 전달 - 부모창의 아이디 관련 입력태그의 입력값 변경 --%>
<%-- => 아이디 사용 불가능(중복) : 사용 불가능 메세지 전달 - 아이디 입력 후 재요청 --%>    
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getParameter("mid")==null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

	//전달값을 반환받아 저장
	String id=request.getParameter("mid");
	
	//아이디를 이용하여 Member 테이블에 저장된 회원정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	// => null 반환 : 회원정보 미검색 - 아이디 사용 가능
	// => 회원정보 반환 : 회원정보 검색 - 아이디 사용 불가능
	MemberDTO member=MemberDAO.getDAO().selectIdMember(id);
%>    
<style type="text/css">
div {
	text-align: center;
}

.mid { 
	color: red;
	font-weight: bold;
 }
</style>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css">
	<% if(member==null) {//아이디 사용이 가능한 경우 %>
		<div><span class="mid">[<%=id %>]</span>는 사용 가능한 
		아이디 입니다.</div>
		<div class="row mb-4"></div>
		<div><button type="button" onclick="windowClose();" class="btn btn-outline-dark btn-sm">아이디 사용</button></div>
	
	<% } else {//아이디 사용이 불가능한 경우 %>
		<div id="message"><span class="mid">[<%=id %>]</span>는
		이미 사용중인 아이디 입니다.<br>
		다른 아이디를 입력하고 [확인]을 눌러 주세요.</div>
		<%-- form 태그의 action 속성이 생략된 경우 브라우저의 현재 URL 주소로 요청 --%>
		<%-- form 태그의 method 속성이 생략된 경우 GET 방식으로 요청 --%>
		<div>
			<form name="form" onsubmit="return submitCheck();">
			<div class="col-md-8" >
				<a><input type="text" name="mid" class="form-control"></a>
				<div class="row mb-3"></div>
				<button type="submit" class="btn btn-outline-dark btn-sm">확인</button>
			</div>		
			</form>
		</div>
	<% } %>
	
	<script type="text/javascript">
	function windowClose() {
		//opener : 부모창을 나타내는 객체
		opener.joinForm.mid.value="<%=id%>";
		opener.joinForm.idCheckResult.value="1";
		window.close();//창닫기
	}
	
	function submitCheck() {
		var mid=form.mid.value;
		if(mid=="") {
			document.getElementById("message").innerHTML="아이디를 입력해 주세요.";
			document.getElementById("message").style="color: red;";
			return false;
		}
		
		var idReg=/^[a-zA-Z]\w{5,19}$/g;
		if(!idReg.test(mid)) {
			document.getElementById("message").innerHTML="아이디는 영문자로 시작되는 영문자,숫자,_의 6~20범위의 문자로만 작성 가능합니다.";
			document.getElementById("message").style="color: red;";
			return false;
		}
		return true;
	}
	</script>