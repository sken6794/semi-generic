<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호를 전달받아 로그인 사용자의 비밀번호와 비교하고 같은 경우
MEMBER 테이블에서 해당 회원정보를 삭제하고 로그아웃 처리페이지로 이동하는 JSP 문서 --%>
<%-- => 비로그인 사용자가 요청한 경우 에러페이지로 이동 - 비정상적인 요청 --%>
<%-- => 비밀번호가 맞지 않을 경우 비밀번호 입력페이지로 이동 --%>
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

	//입력값을 반환받아 저장
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	
	//로그인 사용자의 비밀번호와 입력 비밀번호 비교
	if(!loginMember.getMpw().equals(passwd)) {//비밀번호가 틀린 경우
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/member/remove_confirm.jsp';");
		out.println("</script>");
		
		return;
	}
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원정보를 
	//삭제하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().updateDelMember(loginMember.getMid());  
	
	//로그아웃 처리페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/member/logout_action.jsp';");
	out.println("</script>");
	
%>    







