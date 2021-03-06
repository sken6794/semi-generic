<%@page import="generic.dao.CartDAO"%>
<%@page import="generic.dto.CartDTO"%>
<%@page import="generic.dao.OrderDAO"%>
<%@page import="generic.dto.OrderDTO"%>


<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%

	request.setCharacterEncoding("utf-8");
	//결제정보 입력창(checkout.jsp)에서 정보를 전달받아
	//order 테이블에 삽입하고 완료페이지(thankyou.jsp)로 이동
	
	String mid = loginMember.getMid();
	String mphone = request.getParameter("mphone")+"-"+request.getParameter("mphone2")
					+"-"+request.getParameter("mphone3");
	String oname = request.getParameter("mname");
	String ophone = request.getParameter("ophone")+"-"+request.getParameter("ophone2")
					+"-"+request.getParameter("ophone3");
	String oaddress = request.getParameter("oaddress");
	String oaddress2 = request.getParameter("oaddress2");
	String oaddress3 = request.getParameter("oaddress3");
	String orequire = request.getParameter("orequire");
	String orname = request.getParameter("orname");
	
	//DTO 생성해서 order 정보 변환 후 저장
	OrderDTO order = new OrderDTO();
	order.setMid(mid);
	order.setOname(oname);
	order.setOrname(orname);
	order.setOphone(ophone);
	order.setOaddress(oaddress);
	order.setOaddress2(oaddress2);
	order.setOaddress3(oaddress3);
	order.setOrequire(orequire);
	
	//ORDER_ITEM 테이블에 삽입
	int result = OrderDAO.getDAO().insertOrder(order);
	
	
	//ORDERPRODUCT 테이블에 값을 넣기 위해 넣을 값들을 불러옴
	//List<OrderProductDTO> orderproductList =  OrderDAO.getDAO().selectOrderCart(mid);
	List<CartDTO> cartList = CartDAO.getDAO().selectCart(mid);
	
	
	
	if(result>0){
		//위에서 새로 삽입된 ono를 가져오기
		List<OrderDTO> orderList = OrderDAO.getDAO().selectOrder(mid);
		int ono = orderList.get(0).getOno();
		
		for (CartDTO cart : cartList){
			OrderDAO.getDAO().insertOrderProduct(ono, cart.getPid(), cart.getCqty());
			OrderDAO.getDAO().updatePstock(cart.getPid(), cart.getCqty());
		}
		/* for(OrderProductDTO orderproduct : orderproductList){
			System.out.println("orderproduct.getOno() = "+orderproduct.getOno()+
					"orderproduct.getPid() = "+orderproduct.getPid()+
					"orderproduct.getOpqty() = "+orderproduct.getOpqty());
			OrderDAO.getDAO().insertOrderProduct(orderproduct.getOno(), orderproduct.getPid(), orderproduct.getOpqty());
			
			
		} */
		CartDAO.getDAO().deleteCartId(mid);
	}
	
	response.sendRedirect(request.getContextPath()+"/thankyou.jsp");
	
	
%>