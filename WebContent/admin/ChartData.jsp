
<%@page import="generic.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>
<%
	JSONObject responseObj = new JSONObject();
    //JSONObject responseObj1 = new JSONObject();
	ArrayList<JSONObject> list=OrderDAO.getDAO().getChartData();
	ArrayList<JSONObject> list1=OrderDAO.getDAO().getChartVisit();
	
	responseObj.put("chartdata", list);
	responseObj.put("visitdata", list1);
	//responseObj1.put("visitdata", list1);
	
	//System.out.println(responseObj);
	out.print(responseObj.toString());
	
	 //System.out.println(responseObj.toString());
	

%>