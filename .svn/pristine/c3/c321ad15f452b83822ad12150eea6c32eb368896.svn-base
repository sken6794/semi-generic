<%@page import="java.util.List"%>
<%@page import="generic.dto.NoticeDTO"%>
<%@page import="generic.dao.NoticeDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
	String nimage=request.getParameter("nimg");
	if(request.getParameter(nimage)!=null){//이미지 파일이 있으면
		
		//MultipartRequest 인스턴스 생성 - 모든 입력파일을 서버 디렉토리에 자동으로 업로드 처리하여 저장
		MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
		String nwriter=mr.getParameter("nwriter").replace("<", "&lt;").replace(">", "&gt;");
		String ntitle=mr.getParameter("ntitle").replace("<", "&lt;").replace(">", "&gt;");
		String ncontent=mr.getParameter("ncontent").replace("<", "&lt;").replace(">", "&gt;");	
		//파일 이름 저장
		String nimg=mr.getOriginalFileName("nimg");	
		
		//시퀸스 객체의 다음값 검색 - 글번호 사용
		int nextNum=NoticeDAO.getDAO().selectNextNum();	
		
		//DTO 인스턴스를 생성하고 필드값 변경
		NoticeDTO notice=new NoticeDTO();	
		notice.setNid(nextNum); 
		notice.setNtitle(ntitle);
		notice.setNwriter(nwriter);
		notice.setNcontent(ncontent); 
		notice.setNimg(nimg);
		
		//게시글을 전달받아 저장
		NoticeDAO.getDAO().insertNotice(notice);
		
		
	} else if(request.getParameter(nimage)==null){//이미지 파일 없으면
		String nwriter=request.getParameter("nwriter").replace("<", "&lt;").replace(">", "&gt;");
		String ntitle=request.getParameter("ntitle").replace("<", "&lt;").replace(">", "&gt;");
		String ncontent=request.getParameter("ncontent").replace("<", "&lt;").replace(">", "&gt;");	
		//파일 이름 저장
		String nimg=request.getParameter("nimg");	
		
		//시퀸스
		int nextNum=NoticeDAO.getDAO().selectNextNum();	
		
		//DTO 인스턴스를 생성하고 필드값 변경
		NoticeDTO notice=new NoticeDTO();	
		notice.setNid(nextNum); 
		notice.setNtitle(ntitle);
		notice.setNwriter(nwriter);
		notice.setNcontent(ncontent); 
		notice.setNimg(nimg);
		
		//게시글을 전달받아 저장
		NoticeDAO.getDAO().insertNotice(notice);	
	}
	
	//게시글 목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/notice/notice_list.jsp';");
	out.println("</script>");
	
 %>
    