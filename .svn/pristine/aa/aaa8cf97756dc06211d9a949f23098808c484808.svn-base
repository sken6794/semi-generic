<%@page import="generic.dao.CartDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%

	if(request.getParameter("mid")!=null){
		CartDAO.getDAO().deleteCartId(request.getParameter("mid"));
	} else {
		int cno = Integer.parseInt(request.getParameter("cno"));
		int result =CartDAO.getDAO().deleteCart(cno);
		
		if(result<=0){
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
	}
	
	
	
	response.sendRedirect("cart.jsp");
	
%>