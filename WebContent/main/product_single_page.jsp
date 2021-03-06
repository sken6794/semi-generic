<%@page import="generic.dao.QboardDAO"%>
<%@page import="generic.dao.RboardDAO"%>
<%@page import="generic.dto.RboardDTO"%>
<%@page import="generic.dto.QboardDTO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	// => 로그인 사용자에게만 글쓰기 권한 부여
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//전달값을 반환받아 저장
	int productId=Integer.parseInt(request.getParameter("pid"));
	ProductDTO product=ProductDAO.getDAO().selectIdProduct(productId);
	
	if(loginMember==null){
		String requestURI = request.getRequestURI();
		String queryString = request.getQueryString();
		if(queryString==null || queryString.equals("")){
			queryString="";
		} else {
			queryString="?"+queryString;
		}
		session.setAttribute("url", requestURI+queryString);
		
		
	} else {		 
		
	}
	

	//세션에 저장된 메세지 받아오기
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
%>   
    
<jsp:include page="/header.jsp"/>
<body class="scrollBody" data-spy="scroll" data-target=".navbar" data-offset="50"> 
<form id="addCartForm">
<input type="hidden" name="cpname" value="<%=product.getPname()%>">
<input type="hidden" name="cprice" value="<%=product.getPprice()%>">
<input type="hidden" name="pid" value="<%=product.getPid()%>">
<input type="hidden" name="pstock" value="<%=product.getPstock()%>">
	
    <div class="site-section">
      <div class="container">
      	<div class="padding_container" style="margin-top: 35px;">
        <div class="row">
          <div class="col-md-6">
            <div class="item-entry">
                <img src="<%=request.getContextPath() %>/images/<%=product.getPimg1() %>" alt="img" class="responsive">                          
            </div>
          </div>
          <div class="col-md-6">
		  <br>
          <h2 class="text-black"><%=product.getPname() %></h2>
          <% DecimalFormat df = new DecimalFormat("###,###,###"); %> 
          <p><strong class="text-primary h4"><%=df.format(product.getPprice()) %>원</strong></p>
          <p><%=product.getPcolor() %></p>
          <br>
          <p><%=product.getPcontent() %></p>           
          <br><br>
            <div class="mb-5">
		      <p style="float:right;"><button id="addCartBtn"  class="buy-now btn btn-sm height-auto px-4 py-3 btn-outline-dark">Add To Cart</button></p>
                <div class="input-group mb-3" style="max-width: 120px;">
                  <div class="input-group-prepend">
                   <button class="btn btn-outline-primary js-btn-minus" type="button">&minus;</button>
                  </div>
                  <input type="text" id="cqty" name="cqty" class="form-control text-center" value="1" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1">
                <div class="input-group-append">
                <button class="btn btn-outline-primary js-btn-plus" type="button">&plus;</button>
              </div>
             <span style="color : red;"><%=message %></span>
          </div>
        </div>       
      </div>      
    </div>  
      
  <div>
  </div>
  <br>
  </div>
  </div>
  </div> 
  </form>
  <!-- 상세페이지 탭 -->
   
  <div class="container">
    <!-- Nav tabs -->
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="#section1">상품보기</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#section2">상품후기</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#section3">상품문의</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#section4">교환 및 환불 규정</a>
          </li>          
        </ul>
      
      
      <div id="section1" class="container-fluid" style="padding-top:70px;padding-bottom:70px">
        <div class="detail_img">
        <img alt="img" src="<%=request.getContextPath() %>/images/<%=product.getPimg2() %>" width="100%"><br><br>
        <img alt="img" src="<%=request.getContextPath() %>/images/<%=product.getPimg3() %>" width="100%"><br><br>
        <img alt="img" src="<%=request.getContextPath() %>/images/<%=product.getPimg4() %>" width="100%"><br><br>
        </div>
        <h4>공식 온라인에서만 제공하는 특별한 선물포장 서비스</h4>
        <h7>공식 온라인스토어에서 상품을 구매하시는 모든 고객님께 특별한 선물포장 서비스가 제공됩니다.<br>리본 포장이 된 케이스에 극세사 섬유 클리너가 동봉되어, 제품을 안전하게 보호해주는 케이스에 담아 무료로 배송됩니다.</h7><br><br>
        <img alt="img" src="<%=request.getContextPath() %>/images/gift.jpg" width="100%">
      </div>
      
      <div id="section2" class="container-fluid" style="padding-top:70px;padding-bottom:70px">
      <br><br>
		<!-- 상품후기 출력영역 -->
		<jsp:include page="/board/r_board_list.jsp"/>

        </div>
      
      <div id="section3" class="container-fluid" style="padding-top:70px;padding-bottom:70px">
      <br><br>
      	<!-- 상품문의 출력영역 -->
      <jsp:include page="/board/q_board_list.jsp"/>
       

      <div id="section4" class="container-fluid" style="padding-top:70px;padding-bottom:70px">
      <br><br>
        <h2 style="font-weight: bold">교환 및 환불 규정</h2><br><br>
        <div class="exchange_cont">
			<div class="left_cont">
				
				<div class="cont">
					<h5><strong>■ 배송 가이드</strong></h5>
					<div class="admin_msg">
						· 배송 방법 택배( CJ 대한통운), 퀵서비스, 해외배송가능 ( 우체국 EMS), 전국 (도서산간 포함) <br>
						· 배송비용 : 5만원 이상 무료배송 / 퀵서비스 후불 (3,000원 지원) / 해외배송 선불 <br>
						· 매장수령 : 직접 매장 수령을 원하시면, 재고 확인을 위해 미리 고객센터로 연락후, 방문바랍니다. <br>
						· 매장주소 : 서울시 금천구 벚꽃로 298 (가산동) 대륭포스트타워 6차 105호
					</div>
				</div>
				<br>

				<div class="cont">
					<h5><strong>■ 배송 기간</strong></h5>
					<div class="admin_msg" style="margin-bottom:0;">
						· 택배 : 입금 일 기준 1~3일 소요 (주말,공휴일 제외 /  도서산간지역 2~5일 추가) <br>
						· 퀵서비스 : 서울 및 수도권 일부지역가능 (그 외 별도문의) <br>
						· 해외배송 : 평균 3~15일 (국가별로 차이있음)
					</div>
				</div>
			</div>
			<br>
			
			<div class="right_cont">
				<div class="cont">
					<h5><strong>■ 교환 및 반품 가이드</strong></h5>
					<div class="admin_msg">
						· 교환 및 반품 절차 안내 <br>
						- 교환 및 반품은 수령 후 2일 이내 게시판 및 고객센터로 사전접수해 주신 후 <br>
						  &nbsp; 7일 이내에 반송해주셔야 처리 가능합니다. <br>						

						· 교환 및 반품이 불가한 경우 <br>
						&nbsp;&nbsp;① 사용방지 텍 제거 및 제품 손상 <br>
						&nbsp;&nbsp;② 제품 수령 후 일주일 경과 <br>
						&nbsp;&nbsp;③ 렌즈교체 및 피팅을 받은 경우 <br>
						&nbsp;&nbsp;④ 정품 구성품 훼손 및 분실 등 <br>
						&nbsp;&nbsp;⑤ 불량미비 <br>
						- 해상도차이로 인한 색상차이, 후공정으로 인한 미세기스, 피팅으로 완화되는 불균형 등 <br>
						- 안경테에 장착되어있는 렌즈는 프레임의 형태의 변형을 막기위한 플라스틱 데모렌즈 입니다. <br>
						&nbsp; 데모렌즈의 미세한 스크래치는 불량사유가 될 수 없습니다. <br>
					</div>
				</div>
				<br>
				<div class="cont">
					<h5><strong>■ 환불 안내</strong></h5>
					<div class="admin_msg">
						· 환불시 반품 여부를 확인한 후 결제 금액을 환블해 드립니다. <br>
						· 신용카드로 결제하신 경우는 신용카드 승인을 취소하여 결제 대금이 청구되지 않게 합니다. <br>
						· 신용카드 결제일자에 맞추어 대금이 청구될 경우, 익월 신용카드 대금청구시 카드사에서 환급처리 <br>
						&nbsp; 됩니다.
					</div>
				</div>
			</div><!-- //right_cont -->
		</div>
      </div>
     </div>
    </div>
<!-- 푸터 -->
<jsp:include page="/footer.jsp"/>


<script type="text/javascript">

$('.rslide').click( function() {
	  $(this).find('.rboard_content').slideToggle();     	
} );

 $( '.qslide' ).click( function() {
	$(this).find( '.qboard_content' ).slideToggle();
} );
 
$("#addCartBtn").click(function() {	
	$("#addCartForm").attr("action","<%=request.getContextPath()%>/cart/cart_add_action.jsp");
	$("#addCartForm").attr("method","post");
	$("#addCartForm").submit();	
	
});
</script>
