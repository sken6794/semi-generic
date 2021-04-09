<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>    
<%
	request.setCharacterEncoding("utf-8");
	System.out.println(request.getParameter("deliverySearchType"));
	System.out.println(request.getParameter("deliverySearchKeywrod"));
	System.out.println(request.getParameter("deliveryDateStart"));
	System.out.println(request.getParameter("deliveryDateEnd"));
	
	String deliverySearchType=request.getParameter("deliverySearchType");
	String deliverySearchKeywrod=request.getParameter("deliverySearchKeywrod");
	
	String deliveryDateStart=request.getParameter("deliveryDateStart");
	String deliveryDateEnd=request.getParameter("deliveryDateEnd");
	
	response.sendRedirect("DeliveryManagement.jsp?deliverySearchType="+URLEncoder.encode(deliverySearchType,"utf-8")+
						"&deliverySearchKeywrod="+URLEncoder.encode(deliverySearchKeywrod,"utf-8")+
						"&deliveryDateStart="+URLEncoder.encode(deliveryDateStart,"utf-8")+
						"&deliveryDateEnd="+URLEncoder.encode(deliveryDateEnd,"utf-8")
			);
%>