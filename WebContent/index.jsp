<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Recommend Products top 6 검색
	List<ProductDTO>productList1=ProductDAO.getDAO().selectRecommendProduct();			
	//New Arrival top 5 검색
	List<ProductDTO>productList=ProductDAO.getDAO().selectNewProduct();
%>

<jsp:include page="/header.jsp"/>

  <!--메인 슬라이드-->
  <div class="container"></div>
    <div id="demo" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
        <!-- 슬라이드 쇼 -->
        <div class="carousel-item active">
          <!--가로-->
          
          <img class="d-block w-100" src="<%=request.getContextPath() %>/images/main_slide_1.jpg" alt="First slide">
          <div class="carousel-caption d-none d-md-block"></div>
        </div>
        <div class="carousel-item">
          <img class="d-block w-100" src="<%=request.getContextPath() %>/images/main_slide_2.jpg" alt="Second slide">
        </div>
          <div class="carousel-item">
            <img class="d-block w-100" src="<%=request.getContextPath() %>/images/main_slide_3.jpg" alt="Third slide">
          </div>
            <!-- 화살표 버튼 -->
            <a class="carousel-control-prev" href="#demo" data-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="tr
              ue"></span>
            </a>
              <a class="carousel-control-next" href="#demo" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
              </a>
                <!-- 인디케이터 -->
                <ul class="carousel-indicators">
                  <li data-target="#demo" data-slide-to="0" class="active"></li>
                  <li data-target="#demo" data-slide-to="1"></li>
                  <li data-target="#demo" data-slide-to="2"></li>
                </ul>     
      </div>
	</div>
  

  <!--Recommend Products-->
    <div class="site-section">
      <div class="container">
        <div class="row">
          <div class="title-section mb-5 col-12">
            <h2 class="text-uppercase">Recommend Products</h2>
          </div>
        </div>
        <div class="row">
        <% if(productList==null) { %>	
			<p>제품이 없습니다.</p>	
		<% } else { %>
		<%-- 게시글 목록 출력 - 반복처리 --%>
			<% for(ProductDTO product1:productList1) { %>
				    <div class="col-lg-4 col-md-6 item-entry mb-4">
	            <a href="<%=request.getContextPath() %>/main/product_single_page.jsp?pid=<%=product1.getPid() %>" class="product-item md-height bg-gray d-block">
	              <img src="<%=request.getContextPath() %>/images/<%=product1.getPimg4() %>" alt="Image" class="img-fluid">
	            </a>
	            <h2 class="item-title"><a href="<%=request.getContextPath() %>/main/product_single_page.jsp?pid=<%=product1.getPid() %>"><%=product1.getPname() %></a></h2>
	             <% DecimalFormat df = new DecimalFormat("###,###,###"); %>
	            <div class="item-price"><strong class="item-price"><%=df.format(product1.getPprice()) %>원</strong></div>
	          </div>
			<%} %>	         
		<%} %>	         
        </div>
      </div>
    </div>

  <!--video player-->
  <div class="videoplayer">
  <video autoplay muted loop id="myVideo">
    <source src="<%=request.getContextPath() %>/images/video1.mp4" type="video/mp4"></video>  
      <div class="content">
        <span>GENERIC MONSTER x YE RIN ㅣ WEWU
        <button id="myBtn">
        <a href="<%=request.getContextPath() %>/main/product_single_page.jsp?pid=1021">상품보기</a></button></span>
      </div>
  </div>
  
  <!--New Arrival-->  
  <div class="site-section">
    <div class="container">
      <div class="row">
        <div class="title-section text-center mb-5 col-12">
          <h2 class="text-uppercase">New Arrival</h2>
        </div>
      </div>
      
      <div class="row">
        <div class="col-md-12 block-3">
          <div class="nonloop-block-3 owl-carousel">
              <% if(productList==null) { %>	
				<p>제품이 없습니다.</p>	
			  <% } else { %>
				<%-- 게시글 목록 출력 - 반복처리 --%>
				<% for(ProductDTO product:productList) { %>
            	<div class="item">
              	<div class="item-entry">
                <a href="<%=request.getContextPath() %>/main/product_single_page.jsp?pid=<%=product.getPid() %>" class="product-item md-height bg-gray d-block">
                  <img src="<%=request.getContextPath() %>/images/<%=product.getPimg1() %>" alt="Image" class="img-fluid" style="height: -webkit-fill-available;"></a>
                    <h2 class="item-title"><a href="<%=request.getContextPath() %>/main/product_single_page.jsp?pid=<%=product.getPid() %>"><%=product.getPname() %></a></h2>
                    	<% DecimalFormat df = new DecimalFormat("###,###,###"); %>
                    	<div class="item-price"><strong class="item-price"><%=df.format(product.getPprice()) %>원</strong></div>    
	            </div>
            	</div>           
                <%} %>                                        
              <%} %>                                        
          </div>
        </div>
      </div>
    </div>
  </div><br><br>

 <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="height: 600px;">
      <ol class="carousel-indicators">
        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="<%=request.getContextPath() %>/images/store_img1.jpg" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
          <img src="<%=request.getContextPath() %>/images/store_img2.jpg" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
          <img src="<%=request.getContextPath() %>/images/store_img3.jpg" class="d-block w-100" alt="...">
        </div>
      </div>
      <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
    <div class="store_visit">
      <p>매장을 방문하여 제네릭몬스터를 느껴보세요.</p>
      <a href="<%=request.getContextPath() %>/main/about.jsp" class="btn btn-dark">제네릭몬스터</a>
    </div> 


<jsp:include page="footer.jsp"/>

