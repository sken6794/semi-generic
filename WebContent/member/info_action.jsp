<%@page import="generic.util.Utility"%>
<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 회원정보를 전달받아 MEMBER 테이블에 저장된 회원정보를 변경하고 
회원정보 상세페이지(member_detail.jsp)로 이동하는 JSP 문서 --%>
<%-- => 비로그인 사용자가 요청한 경우 에러페이지로 이동 - 비정상적인 요청 --%>
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
	String id=request.getParameter("mid");
	String passwd=request.getParameter("mpw_1");
	//비밀번호가 입력된 경우 - 새로운 비밀번호로 변경
	if(passwd!=null && !passwd.equals("")) {
		passwd=Utility.encrypt(passwd);
	} else {//비밀번호가 입력되지 않은 경우 - 기존 비밀번호 사용
		passwd=loginMember.getMpw();
	} 
	
	String name=Utility.stripTag(request.getParameter("mname"));
	String email=request.getParameter("memail");
	String mobile=request.getParameter("mobile1")
		+"-"+request.getParameter("mobile2")
		+"-"+request.getParameter("mobile3");
	String address1=request.getParameter("maddress1");
	String address2=request.getParameter("maddress2");
	String address3=Utility.stripTag(request.getParameter("maddress3"));

	//DTO 인스턴스를 생성하여 입력값으로 필드값 변경
	MemberDTO member=new MemberDTO();
	member.setMid(id);
	member.setMpw(passwd);
	member.setMname(name);
	member.setMemail(email);
	member.setMphone(mobile);
	member.setMaddress1(address1);
	member.setMaddress2(address2);
	member.setMaddress3(address3);
	
	//회원정보를 전달받아 MEMBER 테이블에 저장된 회원정보를 변경하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().updateMember(member);
	
	//세션에 저장된 권한 관련 정보 변경
	session.setAttribute("loginMember", MemberDAO.getDAO().selectIdMember(id));
	
	//회원정보 상세페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/member/memberinfo.jsp';");
	out.println("</script>");
%>
