<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="generic.dao.RboardDAO"%>
<%@page import="generic.dto.RboardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 변경값을 전달받아 R_BOARD 테이블에 저장된 게시글을 변경하고 후기 게시판(product_single_page.jsp#section2)으로 이동하는 JSP 문서 --%>

<%@include file="/security/login_check.jspf" %>

<%
	//비정상적인 요청에 대한 응답처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
		out.println("</script>");
		return;
	}	

	//전달값을 반환받아 저장
	int rno=Integer.parseInt(request.getParameter("rno"));
	int pid=Integer.parseInt(request.getParameter("pid"));
	
	//서버 디렉토리의 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/review_images");
	
	//입력파일을 서버 디렉토리에 자동으로 업로드 처리하여 저장
	MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
	
	//파일 이름 저장
	String rorigin=mr.getOriginalFileName("rorigin");
	String rrename=mr.getFilesystemName("rorigin");
	
	//입력값에서 태그 관련 기호를 Escape 문자로 변환하여 저장 => XSS 공격에 대한 방어
	String rwriter=mr.getParameter("rwriter").replace("<", "&lt;").replace(">", "&gt;");
	String rtitle=mr.getParameter("rtitle").replace("<", "&lt;").replace(">", "&gt;");
	String rcontent=mr.getParameter("rcontent").replace("<", "&lt;").replace(">", "&gt;");
	
	//전달값을 반환받아 저장2
	String rstars=mr.getParameter("rstars");
	String pageNum=mr.getParameter("pageNum");

	//DTO 인스턴스를 생성하고 필드값 변경
	RboardDTO rboard=new RboardDTO();
	rboard.setRno(rno);
	rboard.setRstars(rstars);
	rboard.setRwriter(rwriter);
	rboard.setRtitle(rtitle);
	rboard.setRcontent(rcontent);
	
	//게시글을 전달받아 BOARD 테이블에 저장된 해당 게시글을 변경하는 메소드 호출
	RboardDAO.getDAO().updateRboard(rboard);
	
	//후기게시글 상세 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/main/product_single_page.jsp?pid="+pid+"&pageNum="+pageNum+"#section2';");
	out.println("</script>");
%>
