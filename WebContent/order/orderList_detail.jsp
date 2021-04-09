<%@page import="java.text.DecimalFormat"%>
<%@page import="generic.dto.OrderProductDTO"%>
<%@page import="generic.dao.OrderDAO"%>
<%@page import="generic.dto.OrderDTO"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>  
<%
		


	if(request.getParameter("ono")==null){
		response.sendRedirect(request.getContextPath()+"orderList.jsp");
	}
	
	int ono = Integer.parseInt(request.getParameter("ono"));
	List<OrderProductDTO> orderList = OrderDAO.getDAO().selectNoOrder(ono);
%>

    
  </head>
 
  <body>
  
  
    <jsp:include page="/header.jsp"/>
	<div class="row mb-5">
          <div class="col-md-12">
            <div class="border p-4 rounded" role="alert">
               ???
            </div>
          </div>
        </div>      
        
    
     <div class="container">      
     <%-- container 1번째 행 --%>
      <div class="row mb-5">
       <%-- container 1번째 행의 1번째 div --%>
       <div class="site-blocks-table col-md-12">
        <table class="table">
 		 <tr style="text-align:center;">
 		  <th>상품명</th> 		  
 		  <th>상품 가격</th> 		  
 		  <th>주문수량</th> 		  
 		  <th>배송상태</th>
 		  <th>결제 금액</th>
 		 </tr>
 		 <% for(OrderProductDTO order : orderList) { %> 			    
 		 <tr>
 		  <td><%=order.getProduct().getPname() %></td>
 		  <td><%=DecimalFormat.getInstance().format(order.getProduct().getPprice()) %></td>
 		  <td><%=order.getOpqty() %></td> 		  
 		  <td><%=order.getOrder().getOstate() %></td>
 		  <td><%=DecimalFormat.getInstance().format(order.getProduct().getPprice()*order.getOpqty()) %></td>
 		 </tr>
 		 <% } %>	
        </table>        
       </div>
      </div>
      <%--container 2번째 행 --%>
      <div class="row mb-5">
       <div class="site-blocks-table col-md-12">
        <table class="table">
 		 <tr style="text-align:center;">
 		  <th>배송지</th>
 		  <th>주문인</th>
 		  <th>수령인</th>
 		  <th>받는사람번호</th>
 		  <th>배송상태</th>
 		 </tr>	    
 		<%-- 배송지, 주문인, 받는사람,받는사람번호는 동일하니 한번만[0] 요소만  --%>
 		 <tr>
 		  <td>[<%=orderList.get(0).getOrder().getOaddress() %>] <%=orderList.get(0).getOrder().getOaddress2() +" "+ orderList.get(0).getOrder().getOaddress3() %></td>
 		  <td><%=orderList.get(0).getOrder().getOname() %></td>
 		  <td><%=orderList.get(0).getOrder().getOrname() %></td>
 		  <td><%=orderList.get(0).getOrder().getOphone() %></td>
 		  <td><%=orderList.get(0).getOrder().getOstate() %></td>
 		 </tr>	
 		 
        </table>
        
       </div>
      </div>        
     
     </div>
    
    
    
   
    
  
     <jsp:include page="/footer.jsp"/> 
<script type="text/javascript">
$("#asdfimnas").click(function() {
	window.
});
</script>
  