<%@page import="generic.dao.NoticeDAO"%>
<%@page import="generic.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_check.jspf" %>

 
<%	
	int nid=Integer.parseInt(request.getParameter("nid"));
	NoticeDTO notice=NoticeDAO.getDAO().selectIdNotice(nid);	

	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("nid")==null) {
		out.println("<script type='text/javascript'>");	
		out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
		out.println("</script>");
		return;
	}	
	
	//검색된 게시글이 없거나 삭제글인 경우 >> 비정상적인 요청
	if(notice==null) {
		out.println("<script type='text/javascript'>");
		out.println("alert('[에러] 이미 삭제된 게시글입니다.')");		
		out.println("location.href='"+request.getContextPath()+"/notice/notice_list.jsp';");
		out.println("</script>");
		return;
	}

	//로그인 사용자가 관리자가 아닌 경우 >> 비정상적인 요청
	if(loginMember.getMstatus()!=0) {		
		out.println("<script type='text/javascript'>");
		out.println("alert('[에러] 관리자의 권한으로 삭제 가능합니다.')");		
		out.println("location.href='"+request.getContextPath()+"/notice/notice_list.jsp';");
		out.println("</script>");
		return;	
	}	
	
	//정상적인 요청
	if(loginMember.getMstatus()==0){			
		NoticeDAO.getDAO().deleteNotice(notice);	
	
	//게시글 목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/notice/notice_list.jsp';");
	out.println("</script>");
	} 
%>