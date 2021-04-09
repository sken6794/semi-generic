<%@page import="generic.dto.QboardDTO"%>
<%@page import="generic.dao.QboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 답글 수정내용을 Q_BAORD 테이블에 저장하고 문의게시글 목록 위치(product_single_page.jsp#section3)로 이동하는 JSP 문서 --%>

<%-- 로그인 사용자만 게시글 쓰기 기능 제공 --%>
<%@include file="/security/login_check.jspf" %>
 
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("alert('[에러]비정상적인 요청입니다. 메인페이지로 이동합니다.');");
		out.println("location.href='"+request.getContextPath()+"/index.jsp#section3';");
		out.println("</script>");
		return;
	} 

	//입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");
	int pid = Integer.parseInt(request.getParameter("pid"));;
	
	//전달값을 반환받아 저장
	if(request.getParameter("acontent")==null){ //답변 내용이 있을 경우
		String pageNum=request.getParameter("pageNum");	
		System.out.println(request.getParameter("qwriter"));
		//입력값에서 태그 관련 기호를 Escape 문자로 변환하여 저장 => XSS 공격에 대한 방어
		String qacontent=request.getParameter("qcontent").replace("<", "&lt;").replace(">", "&gt;");
		pid=Integer.parseInt(request.getParameter("pid"));
		String qpname=request.getParameter("qpname");

		//Q_BOARD_SEQ 시퀸스 객체의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출 - 글번호
		int qno=QboardDAO.getDAO().selectQNextNum();
		 		
		//DTO 인스턴스를 생성하고 필드값 변경
		QboardDTO qboard=new QboardDTO();
		qboard.setQno(qno);
		qboard.setPid(pid);
		qboard.setQmid(loginMember.getMid());//로그인 사용자 아이디
		qboard.setQpname(qpname); //제품이름
		qboard.setQcontent(qacontent);//문의 내용 - 입력값	

		//게시글을 전달받아 BOARD 테이블에 저장하는 DAO 클래스의 메소드 호출
		QboardDAO.getDAO().updateQboardAnswer(qacontent, qno);

	} else {
		String acontent = request.getParameter("acontent");
		int qno = Integer.parseInt(request.getParameter("qno"));
		int result = QboardDAO.getDAO().updateQboardAnswer(acontent, qno);
	}
		
	//게시글 목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("alert('[수정완료]이전페이지로 돌아갑니다.');");
	out.println("location.href='"+request.getContextPath()+"/main/product_single_page.jsp?pid="+pid+"#section3';");
	out.println("</script>");
 %>