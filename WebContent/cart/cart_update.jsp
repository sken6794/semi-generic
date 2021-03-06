<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.dto.CartDTO"%>
<%@page import="generic.dao.CartDAO"%>
<%@page import="java.util.Arrays"%>

<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- cart.jsp에서 수량변경 정보를 받아와서 CART 테이블의 해당 품목 수량 변경 --%>
<%
		
	//세션에 있는 회원정보에서 아이디 받아서 카트에서 해당아이디의 카트목록 검색 후 리스트 반환
	MemberDTO loginmember = (MemberDTO)session.getAttribute("loginMember");
	String mid = loginmember.getMid(); 
	int startRow = Integer.parseInt(request.getParameter("startRow"));
	int endRow = Integer.parseInt(request.getParameter("endRow"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	//cart.jsp 에서 순서대로 cqty 값 받아서 배열로 반환 정리
	//String 배열을 받아서 int 배열로 변환
	String[] cqties = request.getParameterValues("cqty");
	String[] pstocks = request.getParameterValues("pstock");
 	
	if(cqties==null){
		response.sendRedirect(request.getContextPath()+"/cart/cart.jsp?pageNum="+pageNum);
		return;
	}
	int[] cqty = Arrays.stream(cqties).mapToInt(Integer::parseInt).toArray();
	int[] pstock = Arrays.stream(pstocks).mapToInt(Integer::parseInt).toArray();
	
	for(int i=0;i<pstock.length;i++){
		if(cqty[i]>pstock[i]) {
			response.sendRedirect(request.getContextPath()+"/cart/cart.jsp?pageNum="+pageNum);
			session.setAttribute("message", "변경하고자 하는 수량이 재고 수량보다 많습니다.");
			return;
		}
	}
	
	List<CartDTO> cartList =  CartDAO.getDAO().selectCart2(mid, startRow, endRow);
			
	
	
	
	for(int i=0;i<cqties.length;i++){
		//System.out.println("cartList "+i+ "= "+cartList.get(i).getCno());
		//System.out.println("cqty "+i+ "= "+cqty[i]);
		//Integer.parseInt(cqty[i]);
		//CartDAO.getDAO().updateCart(cqty[i], cartList.get(i).getCno());		
		if(cqty[i]==0){
			response.sendRedirect(request.getContextPath()+"/cart/cart.jsp?pageNum="+pageNum);
			session.setAttribute("message", "상품 수량은 1 미만으로 수정하실 수 없습니다.");
			return;
		}
		CartDAO.getDAO().updateCart(cqty[i], cartList.get(i).getCno());
	}
	
	response.sendRedirect("cart.jsp?pageNum="+pageNum);
%>