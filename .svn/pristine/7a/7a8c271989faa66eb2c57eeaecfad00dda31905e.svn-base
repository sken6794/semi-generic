<%@page import="javafx.scene.control.Alert"%>
<%@page import="generic.util.Utility"%>
<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%-- 회원정보를 전달받아 MEMBER 테이블에 저장하고 로그인 입력페이지
(member_login.jsp)로 이동하는 JSP 문서 --%>    

<%
request.setCharacterEncoding("utf-8");
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
    

	//Content 영역에 포함되는 JSP 문서이므로 입력값에 대한 캐릭터셋 변경 불가능
	// => 템플릿 페이지에서 입력값에 대한 캐릭터셋 변경
	//request.setCharacterEncoding("utf-8");

	//전달된 회원정보(입력값)를 반환받아 저장
	String mid=request.getParameter("mid");
	//반환받은 입력값을 암호화 처리하여 저장
	String mpw=Utility.encrypt(request.getParameter("mpw_1"));
	//반환받은 입력값에서 태그 관련 문자열을 제거하여 저장
	String mname=Utility.stripTag(request.getParameter("mname"));
	int mgender=Integer.parseInt(request.getParameter("mgender"));
	String memail=request.getParameter("memail");
	String mphone=request.getParameter("mphone1")
		+"-"+request.getParameter("mphone2")
		+"-"+request.getParameter("mphone3");
	String maddress1=request.getParameter("maddress1");
	String maddress2=request.getParameter("maddress2");
	String maddress3=Utility.stripTag(request.getParameter("maddress3"));
	//System.out.println("address2 = "+address2);

	//DTO 인스턴스를 생성하여 입력값으로 필드값 변경
	MemberDTO member=new MemberDTO();
	member.setMid(mid);
	member.setMpw(mpw);
	member.setMname(mname);
	member.setMgender(mgender);
	member.setMemail(memail);
	member.setMphone(mphone);
	member.setMaddress1(maddress1);
	member.setMaddress2(maddress2);
	member.setMaddress3(maddress3);
	
	
	//MEMBER 테이블에 회원정보를 삽입하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().insertMember(member);
	
	//로그인 입력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/member/login.jsp';");
	out.println("</script>");
	
%>
