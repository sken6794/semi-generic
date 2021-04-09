<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");

	System.out.println(request.getParameter("OrderSearchType"));
	System.out.println(request.getParameter("OrderSearchKeyword"));
	System.out.println(request.getParameter("orderDateStart"));
	System.out.println(request.getParameter("orderDateEnd"));
	System.out.println(request.getParameter("orderState"));
	
	String orderSearchType=request.getParameter("OrderSearchType");
	String orderSearchKeyword=request.getParameter("OrderSearchKeyword");
	
	String orderDateStart=request.getParameter("orderDateStart");
	String orderDateEnd=request.getParameter("orderDateEnd");
	
	String orderState=request.getParameter("orderState");
	
	response.sendRedirect("OrderList.jsp?orderSearchType="+URLEncoder.encode(orderSearchType,"utf-8")+
			"&orderSearchKeyword="+URLEncoder.encode(orderSearchKeyword,"utf-8")+
			"&orderDateStart="+URLEncoder.encode(orderDateStart,"utf-8")+
			"&orderDateEnd="+URLEncoder.encode(orderDateStart,"utf-8")
			+"&orderState="+URLEncoder.encode(orderState,"utf-8"));
	
%>