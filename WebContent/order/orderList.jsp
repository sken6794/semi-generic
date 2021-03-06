<%@page import="generic.dao.OrderDAO"%>
<%@page import="generic.dto.OrderDTO"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	String mid = loginMember.getMid();
	List<OrderDTO> orderList = new ArrayList<OrderDTO>();
	orderList = OrderDAO.getDAO().selectOrder(mid);
	
%>

    <style type="text/css">
    th, td {text-align: center !important;}
    .contents {
  width: 700px ;
  padding-right: 15px;
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto; }
  @media (min-width: 576px) {
    .container {
      max-width: 540px; } }
  @media (min-width: 768px) {
    .container {
      max-width: 720px; } }
  @media (min-width: 992px) {
    .container {
      max-width: 960px; } }
  @media (min-width: 1200px) {
    .container {
      max-width: 1140px; } }
      
     #totprice {
     	text-align: right;
     }
    </style>
  
 

  
  <div class="site-wrap">
    <jsp:include page="/header.jsp"/>
	<div class="row mb-5">
          <div class="col-md-12">
            <div class="border p-4 rounded" role="alert">
               ???
            </div>
          </div>
        </div>
        
        
    <div class="site-section">
     <div class="container">
     <div class="contents"> 
     <%-- container 1번째 행 --%>
      <div class="row mb-5">
       <%-- container 1번째 행의 1번째 div --%>
       <%--
		<th class="product-name">주문번호</th>
        <th class="product-name">주문자이름</th>
        <th class="product-name">배송지</th>
        <th class="product-name">주문자번호</th>
        <th class="product-name">받는분이름</th>
        <th class="product-name">받는분번호</th>
        <th class="product-name">상품명</th>
        <th class="product-price">가격</th>
        <th class="product-quantity">수량</th>       
        --%>
       <div class="site-blocks-table col-md-12">
       <form action="orderList2" method="post">
        <table class="table">
 		 <tr>
 		  <th>주문번호</th>
 		  <th>받는분 이름</th>
 		  <th>주문날짜</th> 		  
 		  <th>배송상태</th>
 		  <th>주문상세보기</th>
 		 </tr>
 		 <% for(OrderDTO order : orderList){ %> 		     
 		 <tr>
 		  <td><%=order.getOno() %> </td>
   		  <td><%=order.getOrname() %> </td>             
          <td><%=order.getOdate().substring(0,10) %> </td>
          <td><%=order.getOstate() %> </td> 
          <td><input class="btn btn-outline-dark" type="button" value="주문상세보기" onclick="detailOrder(<%=order.getOno()%>)"></td>
 		 </tr>
 		 <% } %>	
        </table>
        </form>        
       </div>
      </div>
      <%--container 2번째 행 --%>             
     </div>
     </div>
    </div>
    
    
    <%@include file="/footer.jsp" %>
    <%-- <jsp:include page="/footer.jsp"/> --%>

    
  </div>

  

 
  <script type="text/javascript">
  function detailOrder(ono) {		
		location.href="orderList_detail.jsp?ono="+ono;		
	}	
  </script>  
  