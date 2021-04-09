<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %> 
<%
	//비정상적인 요청에 대한 응답처리
/*  	if(request.getMethod().equals("GET")) {
 		System.out.println("dfd");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
		out.println("</script>");
		return;
	}  */
	request.setCharacterEncoding("utf-8");
	
	//입력값을 반환받아 저장
	String id=(request.getParameter("mid"));
	String passwd=Utility.encrypt(request.getParameter("mpw"));
	
	//인증처리 - 아이디와 비밀번호 비교
	//아이디에 대한 인증 처리
	//아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	MemberDTO member=MemberDAO.getDAO().selectIdMember(id);
	
	//비밀번호에 대한 인증 처리
	if(!member.getMpw().equals(passwd)) {//비밀번호에 대한 인증 실패
		session.setAttribute("message", "패스워드가 틀렸습니다. 다시 입력해주세요.");
		session.setAttribute("mid", id);
		 out.println("<script type='text/javascript'>");
		//out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=member&work=login';");
		out.println("location.href='"+request.getContextPath()+"/member/info_pw_check.jsp';");
		out.println("</script>") ;
		return;
	}
	
	//세션에 권한 관련 정보(회원정보) 저장
	session.setAttribute("loginMember", MemberDAO.getDAO().selectIdMember(id));
	
	//세션에 저장된 기존 요청페이지의 URL 주소를 반환받아 저장
	String url=(String)session.getAttribute("url");
	
	//페이지 이동
	if(url==null) {//기존 요청페이지가 없는 경우 - 메인페이지 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/member/memberinfo.jsp';");
		out.println("</script>");
	} else {//기존 요청페이지가 있는 경우 - 기존 요청페이지 이동
		session.removeAttribute("url");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+url+"';");
		out.println("</script>");
	}
%>