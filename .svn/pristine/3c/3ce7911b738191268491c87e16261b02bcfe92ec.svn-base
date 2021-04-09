<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	String MemberSearchType= request.getParameter("MemberSearchType");
	String MemberSearchKeyword=request.getParameter("MemberSearchKeyword");
	
	System.out.println("회원 검색 타입= "+MemberSearchType);
	System.out.println("회원 검색 키워드"+MemberSearchKeyword);
	
	response.sendRedirect("MemberList.jsp?MemberSearchType="+URLEncoder.encode(MemberSearchType,"utf-8")+
			"&MemberSearchKeyword="+URLEncoder.encode(MemberSearchKeyword,"utf-8"));
%>