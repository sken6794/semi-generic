<%@page import="generic.dao.RboardDAO"%>
<%@page import="generic.dto.RboardDTO"%>
<%@page import="generic.dao.QboardDAO"%>
<%@page import="generic.dto.QboardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 게시글번호를 전달받아 Q_BOARD 테이블에 저장된 해당 게시글을 삭제하고 문의 게시판(product_single_page.jsp#section3)으로 이동하는 JSP 문서 --%>    

<%@include file="/security/login_check.jspf"%>

<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("qno")==null) {
		out.println("<script type='text/javascript'>");	
		out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	int qno=Integer.parseInt(request.getParameter("qno"));
	int pid=Integer.parseInt(request.getParameter("pid"));
	
	//게시글번호를 전달받아 BOARD 테이블에 저장된 해당 게시글을 검색하여 반환
	QboardDTO qboard=QboardDAO.getDAO().selectQnoQboard(qno);
	
	//검색된 게시글이 없거나 삭제글인 경우 >> 비정상적인 요청
	if(qboard==null || qboard.getQstatus()==9) {
		out.println("<script type='text/javascript'>");
		out.println("alert('[에러]이미 삭제된 게시글입니다.')");		
		out.println("location.href='"+request.getContextPath()+"/main/product_single_page.jsp?pid="+pid+"#section3';");
		out.println("</script>");
		return;
	}

	//로그인 사용자가 작성자 또는 관리자가 아닌 경우 >> 비정상적인 요청
	if(!loginMember.getMid().equals(qboard.getQmid()) && loginMember.getMstatus()!=0) {
		out.println("<script type='text/javascript'>");
		out.println("alert('[에러]작성자와 관리자만 삭제가능합니다.')");		
		out.println("location.href='"+request.getContextPath()+"/main/product_single_page.jsp?pid="+pid+"#section3';");
		out.println("</script>");
		return;
	}

	//게시글번호를 전달받아 BOARD 테이블에 저장된 해당 게시글을 삭제처리 메소드 호출
	QboardDAO.getDAO().deleteQboard(qno);
	
	//게시글 목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("alert('[완료]선택한 문의글을 삭제하였습니다.')");		
	out.println("location.href='"+request.getContextPath()+"/main/product_single_page.jsp?pid="+pid+"#section3';");
	out.println("</script>");
%>
