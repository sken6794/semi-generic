<%@page import="generic.dao.RboardDAO"%>
<%@page import="generic.dto.RboardDTO"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 
	게시글 번호를 전달받아 R_BOARD 테이블에 저장된 해당 게시글을 정보를 검색하여 입력태그에 출력하여 클라이언트에게 전달하고
	수정할 정보를 입력받아 변경처리페이지(r_board_modify_action.jsp)로 전달하는 JSP 문서
--%>

<%@include file="/security/login_check.jspf" %> 

<%	
	//입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");

	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 검색하여 반환하는 메소드 호출
	int productId=Integer.parseInt(request.getParameter("pid"));
	ProductDTO product=ProductDAO.getDAO().selectIdProduct(productId);
	
	//후기게시판 번호를 전달받아 해당 R_BOARD 테이블에 저장된 후기글 정보를 검색하여 반환하는 메소드 호출
	int rno=Integer.parseInt(request.getParameter("rno"));
	RboardDTO rboard=RboardDAO.getDAO().selectRnoRboard(rno);
	
	String pageNum="1";		
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=request.getParameter("pageNum");
	}
%>
    
<jsp:include page="/header.jsp"/>

    <div class="site-section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <h2 class="h3 mb-3 text-black" style="font-weight: bold">후기 수정</h2>
          </div>
          
          <div class="col-md-7">

          <form action="<%=request.getContextPath()%>/board/r_board_modify_action.jsp?pid=<%=product.getPid()%>&rno=<%=rboard.getRno()%>" method="post" id="boardForm" enctype="multipart/form-data">
			<input type="hidden" name="pid" value="<%=product.getPid()%>">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
              
              <div class="p-3 p-lg-5 border">
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="rpname" class="text-black" aria-disabled="false" style="font-weight: bold">제품명 </label>
                    <p id="rpname"><%=product.getPname() %> 
                    	&nbsp;&nbsp;&nbsp;/<%=product.getPcolor() %></p>
                  </div>
   
                </div>
             
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="rwriter" class="text-black" style="font-weight: bold">작성자 <span style="color: red;">*</span></label>
                   <input type="text" class="form-control" id="rwriter" name="rwriter" value="<%=rboard.getRwriter() %>">
                  </div>
                </div>
                <br>
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="rstars" class="text-black" style="font-weight: bold">별점 <span style="color: red;">*</span></label>
                    <br>
                   	<input type="radio" name="rstars" value="★" <% if(rboard.getRstars().equals("★")) { %> checked="checked" <% } %>>&nbsp;&nbsp;★&nbsp;&nbsp;
                   	<input type="radio" name="rstars" value="★★" <% if(rboard.getRstars().equals("★★")) { %> checked="checked" <% } %>>&nbsp;&nbsp;★★&nbsp;&nbsp;
                   	<input type="radio" name="rstars" value="★★★" <% if(rboard.getRstars().equals("★★★")) { %> checked="checked" <% } %>>&nbsp;&nbsp;★★★&nbsp;&nbsp;
                   	<input type="radio" name="rstars" value="★★★★" <% if(rboard.getRstars().equals("★★★★")) { %> checked="checked" <% } %>>&nbsp;&nbsp;★★★★&nbsp;&nbsp;
                   	<input type="radio" name="rstars" value="★★★★★" <% if(rboard.getRstars().equals("★★★★★")) { %> checked="checked" <% } %>>&nbsp;&nbsp;★★★★★&nbsp;&nbsp;
                  </div>
                </div>
                <br>
                
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="rtitle" class="text-black" style="font-weight: bold">후기 제목 <span style="color: red;">*</span></label>
                    <input type="text" class="form-control" id="rtitle" name="rtitle" value="<%=rboard.getRtitle() %>">
                  </div>
                </div>
				<br>
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="rcontent" class="text-black" style="font-weight: bold">후기 내용 <span style="color: red;">*</span></label>
                    <textarea name="rcontent" id="rcontent" cols="30" rows="7" class="form-control"><%=rboard.getRcontent() %></textarea>
                  </div>
                </div>
                
                <!-- 파일첨부 -->
                <br>
                <div class="form-group row">
                	<div class="col-lg-9">
                  		<label for="rorigin" class="text-black" style="font-weight: bold">후기 사진</label>
                  	</div>  
            	
            		<img src="<%=request.getContextPath() %>/review_images/<%=rboard.getRorigin() %>" style="margin-left: 3%; width: 200px;">
            	  	<br>       
            	</div>
            	
            	<div>          
                  <p>&nbsp;<span style="color: #fc7945;" class="icon-times-circle"></span>&nbsp;첨부 사진 수정은 불가능합니다.</p>
                </div>
           		<br>
                
                <div class="form-group row">
                  <div class="col-lg-12">
                  <div id="message" style="color: red;"></div>
                    <input type="submit" class="btn btn-outline-dark btn-lg btn-block" value="작성 완료">
                  </div>
                </div>
                
              </div>
            </form>
          </div>
          <div class="col-md-5 ml-auto">
            <div class="p-4 border mb-3">
              <span class="d-block text-primary h4 text-uppercase" style="font-weight: bold">주의 사항</span>
              <br>
             <p class="mb-0" style="text-align: justify;">
              &nbsp;&nbsp;<span style="font-weight: bold">산업안전보건법 제41조</span>에 따라 서비스를 제공하는 업무에 종사하는 근로자(이하 "고객응대근로자"라 한다)에 대하여 
			  고객의 폭언, 폭행, 그 밖에 적정 범위를 벗어난 신체적ㆍ정신적 고통을 유발하는 행위(이하 "폭언등"이라 한다)를
			  포함한 글은 <span style="color: red">무응답, 미통보 삭제, 회원 탈퇴</span> 조치로 이어질 수 있습니다.
			  </p>
			  <br>
              <p class="mb-0">
			   &nbsp;또한 해당 상품과 관련 없는 내용이나 사진/동영상, 동일 문자의 지나친 반복 등 부적합한 내용의 후기 작성은 통보없이 삭제 됩니다. </p>
            </div>
          </div>
        </div>
      </div>
    </div>

<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#rwriter").val()=="") {
		$("#message").text("작성자명을 입력해 주세요.");
		$("#rwriter").focus();
		return false;
	}
	
	if($("#rtitle").val()=="") {
		$("#message").text("후기제목을 입력해 주세요.");
		$("#rtitle").focus();
		return false;
	}
	
	if($("#rcontent").val()=="") {
		$("#message").text("후기내용을 입력해 주세요.");
		$("#rcontent").focus();
		return false;
	}
});
</script>

<jsp:include page="/footer.jsp"/>