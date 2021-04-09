<%@page import="generic.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	//request.getParameter("pid");
	int pid=Integer.parseInt(request.getParameter("pid"));
	System.out.println("상품번호="+pid);
	int result=ProductDAO.getDAO().deleteProduct(pid);
	if(result==1){
		System.out.println("삭젝성공");
	}
	response.sendRedirect("ProductList.jsp");
%>