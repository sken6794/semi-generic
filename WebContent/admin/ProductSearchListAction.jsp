<%@ page import="java.net.URLEncoder" %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");

	String ProductSearchType= request.getParameter("ProductSearchType");
	String ProductSearchKeyword=request.getParameter("ProductSearchKeyword");
	String ProductCategory= request.getParameter("ProductCategory");
	String startDate= request.getParameter("startDate");
	String endDate= request.getParameter("endDate");
	int pstatus= Integer.parseInt(request.getParameter("stateoptions")); 
	System.out.println();
	
	
	System.out.println(ProductSearchType);
	System.out.println(ProductSearchKeyword);
	System.out.println(ProductCategory);
	System.out.println(startDate);
	System.out.println(endDate);
	System.out.println(pstatus);

	System.out.println("ProductSearchList.jsp?num=1&ProductSearchType="+ProductSearchType+
			"&ProductSearchKeyword="+ProductSearchKeyword);
	
	response.sendRedirect("ProductSearchList.jsp?num=1&ProductSearchType="+URLEncoder.encode(ProductSearchType,"utf-8")+
	"&ProductSearchKeyword="+URLEncoder.encode(ProductSearchKeyword,"utf-8")+
	"&ProductCategory="+URLEncoder.encode(ProductCategory,"utf-8")+
	"&startDate="+URLEncoder.encode(startDate,"utf-8")+
	"&endDate="+URLEncoder.encode(endDate,"utf-8")+
	"&pstatus="+URLEncoder.encode(request.getParameter("stateoptions"),"utf-8"));
	
	 
%>