<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="generic.dto.RboardDTO"%>
<%@page import="generic.dao.RboardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달된 문의게시글을 반환받아 R_BAORD 테이블에 저장하고 문의게시글 목록 위치(product_single_page.jsp#section2)로 이동하는 JSP 문서 --%>

<%-- 로그인 사용자만 게시글 쓰기 기능 제공 --%>
<%@include file="/security/login_check.jspf" %>
 
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("alert('[에러]비정상적인 요청입니다. 메인페이지로 이동합니다.');");
		out.println("location.href='"+request.getContextPath()+"/index.jsp';");
		out.println("</script>");
		return;
	}

	//입력파일을 저장하기 위한 서버 디렉토리의 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/review_images");
	
	//MultipartRequest 인스턴스 생성 
	//	=> 모든 입력파일을 서버 디렉토리에 자동으로 업로드 처리하여 저장
	MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
	
	//사용자가 올린 파일 이름 저장(입력 파일명)
	String rorigin=mr.getOriginalFileName("rorigin");
	//저장된 파일 이름 저장(업로드 파일명)
	String rrename=mr.getFilesystemName("rorigin");
	
	//전달값을 받아 저장
	int pid=Integer.parseInt(request.getParameter("pid"));
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 검색하여 반환하는 메소드 호출
	ProductDTO productInfo=ProductDAO.getDAO().selectIdProduct(pid);
	
	//입력값에서 태그 관련 기호를 Escape 문자로 변환하여 저장 => XSS 공격에 대한 방어
	String rwriter=mr.getParameter("rwriter").replace("<", "&lt;").replace(">", "&gt;");
	String rtitle=mr.getParameter("rtitle").replace("<", "&lt;").replace(">", "&gt;");
	String rcontent=mr.getParameter("rcontent").replace("<", "&lt;").replace(">", "&gt;");
	String rstars=mr.getParameter("rstars");
	
	//Q_BOARD_SEQ 시퀸스 객체의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출 - 글번호
	int rno=RboardDAO.getDAO().selectRNextNum();
	
	//세션에 저장된 관련 정보를 반환받아 저장
	String rpname=(String)session.getAttribute("rpname");
	String pageNum=mr.getParameter("pageNum");
	
	//DTO 인스턴스를 생성하고 필드값 변경
	RboardDTO rboard=new RboardDTO();
	rboard.setRno(rno);//자동증가값
	rboard.setPid(pid); //제품번호
	rboard.setRmid(loginMember.getMid());//로그인 사용자 아이디
	rboard.setRpname(rpname); //제품이름
	rboard.setRwriter(rwriter);//입력값
	rboard.setRtitle(rtitle); //문의 제목 - 입력값
	rboard.setRorigin(rorigin); //업로드한 이미지 파일 이름 - 입력값
	rboard.setRrename(rrename); //저장될 이미지 파일 이름
	rboard.setRstars(rstars); //별점 - 입력값
	rboard.setRcontent(rcontent); //문의 내용 - 입력값
	
	//게시글을 전달받아 BOARD 테이블에 저장하는 DAO 클래스의 메소드 호출
	RboardDAO.getDAO().insertRboard(rboard);
	
	//게시글 목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("alert('[작성완료]상품상세페이지로 넘어갑니다.');");
	out.println("location.href='"+request.getContextPath()+"/main/product_single_page.jsp?pid="+pid+"&pageNum="+pageNum+"#section2';");
	out.println("</script>");
	
 %>
