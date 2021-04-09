<%@page import="generic.dto.CartDTO"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="generic.dao.CartDAO"%>
<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 인증정보를 전달받아 MEMBER 테이블에 저장된 회원정보를 이용하여
인증 처리후 페이지를 이동하는 JSP 문서 --%>
<%-- => 인증성공 : 세션에 권한 관련 정보를 저장하고 기존 요청페이지로 이동 --%>
<%--    (기존 요청페이지가 없는 경우 메인페이지로 이동) --%>    
<%-- => 인증실패 : 세션에 메세지와 아이디를 저장하고 로그인 입력페이지로 이동 --%>
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
		out.println("</script>");
		return;
	}

	//입력값을 반환받아 저장
	String id=request.getParameter("mid");
	String passwd=Utility.encrypt(request.getParameter("mpw"));
	
	//인증처리 - 아이디와 비밀번호 비교
	
	//아이디에 대한 인증 처리
	//아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	// => null 반환 : 회원정보 미검색 - 아이디에 대한 인증 실패
	// => 회원정보 반환 : 회원정보 검색 - 아이디에 대한 인증 성공
	MemberDTO member=MemberDAO.getDAO().selectIdMember(id);
	if(member==null) {
		session.setAttribute("message_1", "입력한 아이디가 존재하지 않습니다.");
		session.setAttribute("mid", id);
		out.println("<script type='text/javascript'>");
		//out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=member&work=login';");
		out.println("location.href='"+request.getContextPath()+"/member/login.jsp';");
		out.println("</script>");
		return;
	}
	
	//비밀번호에 대한 인증 처리
	if(!member.getMpw().equals(passwd)) {//비밀번호에 대한 인증 실패
		session.setAttribute("message_1", "입력한 아이디가 없거나 패스워드가 맞지 않습니다.");
		session.setAttribute("mid", id);
		 out.println("<script type='text/javascript'>");
		//out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=member&work=login';");
		out.println("location.href='"+request.getContextPath()+"/member/login.jsp';");
		out.println("</script>") ;
		return;
	}
	
	if(member.getMstatus()==2){
		session.setAttribute("message_1", "탈퇴한 회원 입니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/member/login.jsp';");
		out.println("</script>");
		return;
	}
	
	/*if(member.getMstatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/admin/Admin.jsp';");
		out.println("</script>");
		return;
	}  */
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 회원정보 중 마지막 로그인
	//날짜를 변경하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().updateLastLogin(id);
	
	//세션에 권한 관련 정보(회원정보) 저장
	session.setAttribute("loginMember", MemberDAO.getDAO().selectIdMember(id));
	
	//-------------------작업중--------------------
	if(session.getAttribute("pid")!=null){
		ProductDTO product = ProductDAO.getDAO().selectIdProduct(Integer.parseInt((String)session.getAttribute("pid")));
		CartDTO cart = new CartDTO();
		cart.setMid(id);
		cart.setCpname(product.getPname());
		cart.setCqty(Integer.parseInt((String)session.getAttribute("cqty")));
		cart.setCprice(product.getPprice());
		cart.setPid(Integer.parseInt((String)session.getAttribute("pid")));
		
		CartDAO.getDAO().insertCart(cart);
		
		session.removeAttribute("pid");
		session.removeAttribute("cqty");
	}
		
	
	
	
	
	//세션에 저장된 기존 요청페이지의 URL 주소를 반환받아 저장
	String url=(String)session.getAttribute("url");
	
	
	//페이지 이동
	if(url==null) {//기존 요청페이지가 없는 경우 - 메인페이지 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp';");
		out.println("</script>");
	} else {//기존 요청페이지가 있는 경우 - 기존 요청페이지 이동
		session.removeAttribute("url");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+url+"';");
		out.println("</script>");
	}
%>












