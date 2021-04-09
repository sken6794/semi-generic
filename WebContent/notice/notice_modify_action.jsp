<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="generic.dto.NoticeDTO"%>
<%@page import="generic.dao.NoticeDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    
<%@include file="/security/login_check.jspf" %>

<%
	//입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");

	//비정상적인 요청에 대한 응답처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
		out.println("</script>");
		return;
	}	
	
	//입력파일을 저장하기 위한 서버 디렉토리의 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/images");
		
	MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
	
	int nid=Integer.parseInt(mr.getParameter("nid"));	
	String ntitle=mr.getParameter("ntitle").replace("<", "&lt;").replace(">", "&gt;");
	String nwriter=mr.getParameter("nwriter").replace("<", "&lt;").replace(">", "&gt;");
	String ncontent=mr.getParameter("ncontent").replace("<", "&lt;").replace(">", "&gt;");

	
	NoticeDTO notice=new NoticeDTO();	 
	notice.setNtitle(ntitle);
	notice.setNwriter(nwriter);
	notice.setNcontent(ncontent); 
	notice.setNid(nid); 
    
	NoticeDAO.getDAO().updateNotice(notice);			
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/notice/notice_detail.jsp?nid="+nid+"';");
	out.println("</script>");	
	
%>