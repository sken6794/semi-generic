
<%@page import="generic.dao.OrderDAO"%>
<%@ page import="java.net.URLEncoder" %>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	//request.getParameter("state");
	System.out.println(request.getParameter("ono"));
	System.out.println(request.getParameter("options"));
	OrderDAO.getDAO().modifyDeliveryState(Integer.parseInt(request.getParameter("ono")) , request.getParameter("options"));
	response.sendRedirect("DeliveryManagement.jsp?num="+URLEncoder.encode(request.getParameter("num"),"utf-8"));
%>