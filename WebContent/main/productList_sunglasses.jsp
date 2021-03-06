<%@page import="generic.dto.ProductDTO"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/header.jsp"/>
<%	
	//전달받은 페이지 번호 저장(전달값없을시에는 1페이지 검색)
	int pageNum=1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나의 페이지에 출력될 게시글 갯수 설정
	int pageSize=8;
	
	//저장된 전체 게시글의 갯수를 검색하여 반환하는  DAO 클래스의 메소드
	int totalProduct=ProductDAO.getDAO().productCount("선글라스");
	
	//검색 게시글에 대한 페이지의 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalProduct/pageSize);
	
	//전달된 페이지 번호 검증(페이지 번호가 없거나 전체페이지보다 큰값일때 모두 1페이지로 이동)
	if(pageNum<=0||pageNum>totalPage){
		pageNum=1;
	}
	//현재 페이지에 대한 게시글 시작 행번호를 계산하여 저장
	//ex) 1 Page : 1, 2 Page :9, 3 Page : 25, 4 Page : 33,...
	int startRow=(pageNum-1)*pageSize+1;
		
	//현재 페이지에 대한 게시글 종료 행번호를 계산하여 저장
	//ex) 1 Page : 8, 2 Page : 16, 3 Page : 24, 4 Page : 32,...
	int endRow=pageNum*pageSize;
		
	//마지막 페이지에 대한 게시글 종료 행번호를 검색 게시글의 갯수로 변경
	if(endRow>totalProduct) {
		endRow=totalProduct;
	}
	
	//상품리스트 가져오기
	List<ProductDTO> productList=ProductDAO.getDAO().selectCategoryProduct("선글라스", startRow, endRow);	
	
%>
	
    <div class="row">
        <div class="col-xl-12">
          <div class="site-blocks-cover inner-page" style="background-image: url('<%=request.getContextPath() %>/images/sunglasses_main.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center"">
          </div>         
          <div class="custom-border-bottom py-3">
            <div class="container">
              <div class="row">
                <div class="col-md-12 mb-0"><a href="<%=request.getContextPath() %>/index.jsp">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">선글라스</strong></div>
                </div>
              </div>
            </div>
          </div>
   		</div>  	

	<div class="container">
	<div class="row mb-5">
	<% if(totalProduct==0) { %>	
	<div class="title-section text-center mb-5 col-12">
	<br><br><br><br><br>
     	<h6><strong>요청하신 제품을 찾을 수 없습니다.</strong></h6>         
     </div> 	
	<% } else { %>
		<%-- 게시글 목록 출력 - 반복처리 --%>
		<% for(ProductDTO product:productList) { %>
			    <div class="col-lg-3 col-md-4 item-entry mb-6">
			       <a href="<%=request.getContextPath() %>/main/product_single_page.jsp?pid=<%=product.getPid() %>" class="product-item md-height bg-gray d-block">
			         <img src="<%=request.getContextPath() %>/images/<%=product.getPimg1() %>" alt="Image" class="img-fluid">                  
			      </a>
			        <h2 class="item-title2"><a href="<%=request.getContextPath() %>/main/product_single_page.jsp?pid=<%=product.getPid() %>"><%=product.getPname() %></a></h2>
			         <% DecimalFormat df = new DecimalFormat("###,###,###"); %>
			            <div class="item-price"><strong class="item-price"><%=df.format(product.getPprice()) %>원</strong></div>
			    </div>
		<%} %>	
	<%} %>	
		
		</div>
	</div>         
	<%
		//블럭에 출력될 페이지 번호의 갯수 설정
		int blockSize=5;
	
		//블럭에 출력될 시작 페이지 번호를 계산하여 저장
		// => 1 Block : 1, 2 Block : 6, 3 Block : 11, 4 Block : 16,...
		int startPage=(pageNum-1)/blockSize*blockSize+1;
		
		//블럭에 출력될 종료 페이지 번호를 계산하여 저장
		// => 1 Block : 5, 2 Block : 10, 3 Block : 15, 4 Block : 20,...
		int endPage=startPage+blockSize-1;
		
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
				<li><a href="<%=request.getContextPath() %>/main/productList_sunglasses.jsp?pageNum=<%=i%>"><%=i %></a></li>
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
	

<jsp:include page="/footer.jsp"/>
