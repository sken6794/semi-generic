<%@page import="generic.dao.CartDAO"%>
<%@page import="generic.dto.CartDTO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 상품 상세페이지에서 카트 추가 버튼을 클릭했을 시 입력값을 전달받아 
카트 테이블에 추가하고 다시 싱글페이지로 이동하는 JSP --%>
<%
	if(request.getMethod().equals("GET")){
		
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
		return;
	}
	//세션에 저장된 로그인 회원정보 받아오기
	//비로그인 사용자가 카트추가 클릭 시 로그인페이지로 이동
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	String mid ="";
	if(loginMember==null){
		session.setAttribute("pid", request.getParameter("pid"));
		session.setAttribute("cqty", request.getParameter("cqty"));		
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
		return;
	} else {
		 mid = loginMember.getMid();
		
	}
	
	
		
	//입력값 전달받아서 변환 후 저장
	String cpname = request.getParameter("cpname").trim();
	int cprice = Integer.parseInt(request.getParameter("cprice"));
	int pid = Integer.parseInt(request.getParameter("pid"));
	int cqty = Integer.parseInt(request.getParameter("cqty"));
	int pstock = Integer.parseInt(request.getParameter("pstock"));
	
	//수량이 0일경우 다시 되돌림
	if(Integer.parseInt(request.getParameter("cqty"))==0){
		response.sendRedirect(request.getContextPath()+"/main/product_single_page.jsp?pid="+pid);
		session.setAttribute("message", "수량을 다시 확인해주십시오.");
		return;
	}
	
	if(pstock<cqty){
		response.sendRedirect(request.getContextPath()+"/main/product_single_page.jsp?pid="+pid);
		session.setAttribute("message", "재고가 선택하신 수량보다 적게 남았습니다.");
		return;
	}
	
	//카트에 넣기위해 카트 DTO 만들어서 전달값 저장
	CartDTO cart = new CartDTO();
	cart.setMid(mid);
	cart.setCpname(cpname);
	cart.setCqty(cqty);
	cart.setCprice(cprice);
	cart.setPid(pid);
	
	//카트테이블에 삽입하는 메소드 호출
	int result = CartDAO.getDAO().insertCart(cart);

	if(result>0){
		//response.sendRedirect(request.getContextPath()+"/main/product_single_page.jsp?pid="+pid);
		out.println("<script type='text/javascript'>");
		out.println("var result = confirm('장바구니에 상품이 추가되었습니다. 장바구니로 이동하시겠습니까?');");
		out.println("if(result){");		
		out.println("location.href='"+request.getContextPath()+"/cart/cart.jsp';");
		out.println("} else {");
		out.println("location.href='"+request.getContextPath()+"/main/product_single_page.jsp?pid="+pid+"';");
		out.println(" } ");
		out.println("</script>");
		
	} 
%>
