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
String id=request.getParameter("mid");
String email=request.getParameter("memail");

	MemberDTO member=MemberDAO.getDAO().selectIdMember(id);
	if(member==null) {
		session.setAttribute("message_1", "입력한 사용자 이름이 존재하지 않습니다.");
		session.setAttribute("mname", name);
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/member/find_pw.jsp';");
		out.println("</script>");
		return; 
	}
	//이메일에 대한 인증 처리
	if(!member.getMemail().equals(email)) {//이메일에 대한 인증 실패
		session.setAttribute("message_1", "입력한 내용의 회원이 존재하지 않습니다.");
		session.setAttribute("mname", name);
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/member/find_pw.jsp';");
		out.println("</script>");
		return;
	}else if
		(!member.getMid().equals(id)) {//아이디에 대한 인증 실패
			session.setAttribute("message_1", "입력한 내용의 회원이 존재하지 않습니다.");
			session.setAttribute("mname", name);
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+request.getContextPath()+"/member/find_pw.jsp';");
			out.println("</script>");
			return;
	}

	session.setAttribute("loginMember", MemberDAO.getDAO().selectIdMember(id));
	
 	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/member/change_pw.jsp';");
	out.println("</script>");

%>
