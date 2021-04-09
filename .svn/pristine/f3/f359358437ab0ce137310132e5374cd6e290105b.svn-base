<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//비정상적인 요청에 대한 응답 처리 - 에러페이지 이동
	if(request.getMethod().equals("GET")) {
	//Content 영역에 포함되는 JSP 문서이므로 리다이텍트 이동 불가능
	// => 자바스트립트를 이용하여 페이지 이동
	//response.sendRedirect(request.getContextPath()+"/site/index.jsp?workgroup=error&work=error400");
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
	out.println("</script>");
	return;
}  

	request.setCharacterEncoding("utf-8");

String name=request.getParameter("mname");
String email=request.getParameter("memail");


MemberDTO member=MemberDAO.getDAO().findIdMember(name);
if(member==null) {
	session.setAttribute("message_1", "입력한 사용자 이름이 존재하지 않습니다.");
	session.setAttribute("mname", name);
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/member/find_id.jsp';");
	out.println("</script>");
	return; 
}

//이메일에 대한 인증 처리
if(!member.getMemail().equals(email)) {//이메일에 대한 인증 실패
		session.setAttribute("message_1", "입력한 사용자 이름이 존재하지 않거나 이메일이 맞지 않습니다.");
		session.setAttribute("mname", name);
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/member/find_id.jsp';");
		out.println("</script>");
		return;
	}
//탈퇴회원 로그인시 false 처리
if(member.getMstatus()==2){
	session.setAttribute("message_1", "탈퇴한 회원 입니다.");
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/member/find_id.jsp';");
	out.println("</script>");
	return;
}

%>
<jsp:include page="/header.jsp"/>
<form action="<%=request.getContextPath() %>/member/login.jsp">
    <div class="site-section">
      <div class="container">    
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <h2 class="h3 mb-3 text-black" style="text-align: center;">
      <span id="f_mname">[<%=member.getMname() %>]</span> 님의 아이디는 <span id="f_mid">
      [<%=member.getMid() %>]</span>입니다. </h2>
      <div class="row mb-5"></div>
      <div class="col-md-12 text-center">
      <p><a type="submit" class="btn btn-lg height-auto px-4 py-3 btn-outline-dark" href="<%=request.getContextPath() %>/member/login.jsp">로그인페이지로 이동</a></p>
      </div>
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      </div>
    </div>
</form>
<jsp:include page="/footer.jsp"/>