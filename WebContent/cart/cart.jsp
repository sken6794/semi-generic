<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.dao.CartDAO"%>
<%@page import="generic.dto.CartDTO"%>
<%@page import="java.text.DecimalFormat"%>

<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//비로그인 사용자라면 로그인페이지로 이동
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

	if(loginMember==null) {
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
		return;	
	} 
	
	int pid = 0;
	if(session.getAttribute("pid")!=null){		
		pid = (Integer)session.getAttribute("pid");
	}
	
	//카트가 비었을 경우 결제페이지 넘어갔다가 다시 돌아오고 메세지를 받아옴
	String message = (String)session.getAttribute("message");
	if(message==null){
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	String mid = loginMember.getMid();
	//세션에 저장된 회원정보에서 아이디를 받아와서 카트테이블에서 검색하여 리스트 반환
	//List<CartDTO> cartList =  CartDAO.getDAO().selectCart(mid);
	
	
	
	
	//전달된 페이지 번호를 반환받아 저장
	// => 전달값이 존재하지 않을 경우 첫번째 페이지 검색
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
		
	//하나의 페이지에 출력될 게시글 갯수 설정
	int pageSize=3;
	
	//CART 테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출	
	//BOARD 테이블에 저장된 전체 게시글 중 검색게시글의 갯수르 검색하여 반환하는 DAO 클래스의 메소드 호출
	int totalCart=CartDAO.getDAO().selectCartCount(mid);
	
	//검색 게시글에 대한 페이지의 갯수를 계산하여 저장	
	int totalPage=(int)Math.ceil((double)totalCart/pageSize);
		
	//전달된 페이지 번호에 검증
	if(pageNum<=0 || pageNum>totalPage) {//페이지 번호가 잘못된 경우
		pageNum=1;
	}
		
	//현재 페이지에 대한 게시글 시작 행번호를 계산하여 저장
	//ex) 1 Page : 1, 2 Page : 4, 3 Page : 7, 4 Page : 10,...
	int startRow=(pageNum-1)*pageSize+1;
		
	//현재 페이지에 대한 게시글 종료 행번호를 계산하여 저장
	//ex) 1 Page : 3, 2 Page : 6, 3 Page : 9, 4 Page : 12,...
	int endRow=pageNum*pageSize;
		
	//마지막 페이지에 대한 게시글 종료 행번호를 검색 게시글의 갯수로 변경
	if(endRow>totalCart) {
		endRow=totalCart;
	}
	
	//게시글의 시작 행번호와 종료 행번호를 전달받아 BOARD 테이블에
	//저장된 게시글에서 시작과 종료 범위에 포함된 게시글만 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	List<CartDTO> cartList=CartDAO.getDAO().selectCart2(mid, startRow, endRow);
	
		
	//현재 페이지의 게시글 목록에 출력될 시작 글번호를 계산하여 저장
	int number=totalCart-(pageNum-1)*pageSize;
	
	//카트의 합계를 구하기 위한 메소드 호출
	int cartprice = 0;
	String cartMessage="";
	if(cartList.size()<0){
		cartMessage = "장바구니가 비었습니다.";
				
	} else {
		cartprice = CartDAO.getDAO().selectTotalPrice(mid);
	}
%>  

    <jsp:include page="/header.jsp"/>
  <div class="site-wrap" >
<form  id="cartForm" >
 <input type="hidden" name="startRow" value="<%=startRow%>">
 <input type="hidden" name="endRow" value="<%=endRow%>">
 <input type="hidden" name="pageNum" value="<%=pageNum%>">
 
    <div class="site-section">
      <div class="container">
        <div class="row mb-5">
         <div class="col-md-12">
          
            <div class="site-blocks-table">
              <table class="table" style="margin-top:100px;">
                <thead>
                  <tr>
                    <th class="product-thumbnail">Image</th>
                    <th class="product-name">상품명</th>
                    <th class="product-price">가격</th>
                    <th class="product-quantity">수량</th>
                   	<th class="product-total">합계</th>
                    <th class="product-remove">목록에서 제거</th>
                  </tr>
                </thead>
                <tbody>
                <% for(CartDTO cart : cartList) { %>
               
                  <tr>
                    <td class="product-thumbnail">
                      <img src="<%=request.getContextPath() %>/images/<%=cart.getProduct().getPimg1() %>" alt="Image" class="img-fluid">
                    </td>
                    <td class="product-name center-block">
                      <h2 class="h5 text-black"><%=cart.getCpname() %></h2>
                    </td>
                    <td><%=DecimalFormat.getInstance().format(cart.getCprice()) %></td>
                    <td>
                      <div class="input-group mb-3" style="max-width: 120px;">
                        <div class="input-group-prepend">
                          <button class="btn btn-outline-dark js-btn-minus" type="button">&minus;</button>
                        </div>
                        <input type="text" class="form-control text-center" name="cqty" value="<%=cart.getCqty() %>"  min="1 !important" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1">
		                <input type="hidden" name="pstock" value="<%=cart.getProduct().getPstock() %>">
                        <div class="input-group-append">
                          <button class="btn btn-outline-dark js-btn-plus" type="button">&plus;</button>
                        </div>
                      </div>
                    </td>
                    <td><%=DecimalFormat.getInstance().format(cart.getCqty()*cart.getCprice()) %></td>                    
                    <td><a href="cart_delete.jsp?cno=<%=cart.getCno()%>" class="btn btn-outline-dark height-auto btn-sm">X</a></td>
                  </tr>
				 <% }  %>	
                  
                </tbody>
              </table>
            </div>
           </div>
          
        </div>
	<%-- 페이지 번호 출력(페이징 처리)과 하이퍼 링크 설정 --%>
		<%
			//하나의 블럭에 출력될 시작 페이지 번호의 갯수 설정
			int blockSize = 5;
		
			//블럭에 출력될 시작 페이지 번호를 계산하여 저장
			// => 1 Block : 1, 2 Block : 6, 3 Block : 11, ....
			int startPage=(pageNum-1)/blockSize*blockSize+1;
			
			//블럭에 출력될 시작 페이지 번호를 계산하여 저장
			// => 1 Block : 5, 2 Block : 10, 3 Block : 15, ....
			int endPage = startPage+blockSize-1;
			
			//마지막 블럭의 종료 페이지 번호 변경
			if(endPage>totalPage) {
				endPage=totalPage;
						
			}
		%>
		
		
	<div class="row">
      <div class="col-md-12 text-center">
         <div class="site-block-27">
            <ul>
			<% if(startPage>blockSize) { %>
			<li><a href="<%=startPage-blockSize%>">&lt;</a></li>
			<% } else { %>
			<li><a>&lt;</a></li>
			<% } %>
			
			<% for(int i=startPage;i<=endPage;i++) { %>
				<% if(pageNum!=i) { %>
				<li><a href="<%=request.getContextPath() %>/cart/cart.jsp?pageNum=<%=i%>"><%=i %></a></li>
				<%-- 선택된 번호 --%>
				<% } else { %>
				<li class="active"><span><%=i %></span></li>
				<% } %>							
			<% } %>
			
			<% if(endPage!=totalPage) { %>
				<li><a href="<%=startPage+blockSize%>">&gt;</a></li>
			<% } else { %>
				<li><a>&gt;</a></li>
			<% } %>
				</ul>
         </div>
      </div>        
    </div>
    <br>
    
        <div class="row">
          <div class="col-md-6">
            <div class="row mb-5">
              <div class="col-md-3 mb-3 mb-md-0 col-sm-3" >
                <button class="btn btn-outline-dark btn-sm btn-block" id="cartUpdate" type="submit">카트 수정</button>
              </div>
              <div class="col-md-4 col-sm-4">
                <a href="<%=request.getContextPath() %>/main/productList_glasses.jsp" class="btn btn-outline-dark btn-sm btn-block">계속 쇼핑하기</a>
              </div>
              <div class="col-md-3 col-sm-3">
                <a id="cartDeletebtn" class="btn btn-outline-dark btn-sm btn-block" >카트 비우기</a>                
              </div>
            </div>            
          </div>
          
          <div class="col-md-6 pl-5">
            <div class="row justify-content-end">
              <div class="col-md-7">
                <div class="row">
                  <div class="col-md-12 text-right border-bottom mb-5">
                    <h3 class="text-black h4 text-uppercase">장바구니 합계</h3>
                  </div>
                </div>
                
                <div class="row mb-5">
                  <div class="col-md-6">
                    <span class="text-black">총 합계</span>
                  </div>
                  <div class="col-md-6 text-right">
                    <strong class="text-black"><%=DecimalFormat.getCurrencyInstance().format(cartprice) %></strong>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-12">
                    <button class="btn btn-outline-dark btn-lg btn-block" id="checkoutBtn">결제하기</button>
                    <br>
                    <span id="message" style="color:red;"><%=message %></span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    </form>

    
  </div>
<script>
$("#cartUpdate").click(function() {
	$("#cartForm").attr("method", "post")
	$("#cartForm").attr("action", "<%=request.getContextPath() %>/cart/cart_update.jsp")
	$("#cartForm").submit()	
})

$("#checkoutBtn").click(function() {
	
	$("#cartForm").attr("action", "<%=request.getContextPath() %>/order/checkout.jsp")
		
})
$("#cartDeletebtn").click(function() {
	var result = confirm("정말로삭제하시겠습니까?");
	if(result){
		location.href="<%=request.getContextPath()%>/cart/cart_delete.jsp?mid=<%=mid%>";		
	} else {
		
	}
})

</script>
    <jsp:include page="/footer.jsp"/>

  