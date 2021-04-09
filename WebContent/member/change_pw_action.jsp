<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %> 
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


//전달된 회원정보(입력값)를 반환받아 저장
String id=(request.getParameter("mid"));
String passwd=Utility.encrypt(request.getParameter("mpw_1"));
MemberDTO member=new MemberDTO();
member.setMpw(passwd);
member.setMid(id);

MemberDAO.getDAO().changePwMember(member);

session.setAttribute("loginMember", MemberDAO.getDAO().selectIdMember(passwd));

out.println("<script type='text/javascript'>");
out.println("location.href='"+request.getContextPath()+"/member/logout_action.jsp';");
out.println("</script>");

%>
