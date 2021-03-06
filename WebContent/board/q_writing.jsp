<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.dao.QboardDAO"%>
<%@page import="generic.dto.QboardDTO"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 제품번호를 전달받아 문의글을 등록하기 위해 입력처리페이지(q_writing_action.jsp)를 요청하는 JSP 문서 --%>

<%--  로그인 사용자만 글쓰기 기능 제공 --%>
<%@include file="/security/login_check.jspf" %> 

<%	
	//입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");
	
	String pageNum="1";//부모글의 요청페이지 번호 저장
	
	//부모글의 전달값을 반환받아 저장
	if(request.getParameter("qref")!=null) {//부모글이 있는 경우(답글 - only 관리자)	
		pageNum=request.getParameter("pageNum");
	}	

	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 검색하여 반환하는 메소드 호출
	int productId=Integer.parseInt(request.getParameter("pid"));
	ProductDTO product=ProductDAO.getDAO().selectIdProduct(productId);
	
	int qno = 0;
	QboardDTO qboard =null;
	if(request.getParameter("qno")!=null){
		qno=Integer.parseInt(request.getParameter("qno"));		
		qboard = QboardDAO.getDAO().selectQnoQboard(qno);
	} 

	String id=request.getParameter("rmid");
	//문의를 작성한 회원아이디를 전달받아 MEMBER 테이블에 저장된 해당 회원정보를 검색하여 반환하는 메소드
	MemberDTO writer=MemberDAO.getDAO().selectIdMember(id);
	
%>

<jsp:include page="/header.jsp"/>

    <div class="site-section">
      <div class="container">
      
        <div class="row">
          <div class="col-md-6">
          
<%-- 로그인 사용자가 클라이언트인 경우 새 문의글 작성 페이지 --%>
 <% if(loginMember!=null && loginMember.getMstatus()!=0) { %> 
            	<h2 class="h3 mb-3 text-black" style="font-weight: bold">문의 사항</h2>
			
          </div>
          <div class="col-md-7">

            <form action="<%=request.getContextPath()%>/board/q_writing_action.jsp" method="post" id="boardForm" >
            <input type="hidden" name="pid" value="<%=product.getPid()%>">            		
			<input type="hidden" name="pageNum" value="<%=pageNum %>">
              
              <div class="p-3 p-lg-5 border">
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="rpname" class="text-black" aria-disabled="false" style="font-weight: bold">제품명 </label>
                    <p id="qpname"><%=product.getPname() %> 
                    	&nbsp;&nbsp;&nbsp;/<%=product.getPcolor() %></p>
                  </div>
   
                </div>
             
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="qwriter" class="text-black" style="font-weight: bold">작성자  <span style="color: red;">*</span></label>
                   <input type="text" class="form-control" id="qwriter" name="qwriter" >
                  </div>
                </div>
               
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="qtitle" class="text-black" style="font-weight: bold">문의 제목 <span style="color: red;">*</span></label>
                    <input type="text" class="form-control" id="qtitle" name="qtitle">
                  </div>
                </div>

                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="qcontent" class="text-black" style="font-weight: bold">문의 내용 <span style="color: red;">*</span></label>
                    <textarea name="qcontent" id="qcontent" cols="30" rows="7" class="form-control"></textarea>
                  </div>
                </div>              
                
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
	             &nbsp;<span style="font-weight: bold">산업안전보건법 제41조</span>에 따라 서비스를 제공하는 업무에 종사하는 근로자(이하 "고객응대근로자"라 한다)에 대하여 
				 고객의 폭언, 폭행, 그 밖에 적정 범위를 벗어난 신체적ㆍ정신적 고통을 유발하는 행위(이하 "폭언등"이라 한다)를
				 포함한 글은 <span style="color: red">무응답, 미통보 삭제, 회원 탈퇴</span> 조치로 이어질 수 있습니다.
			 </p>
			  <br>
              <p class="mb-0">&nbsp;평일 10:00 ~ 19:00에는 고객센터 <span style="font-weight: bold">1588-1588</span>로 빠른 유선 문의 가능합니다.</p>
        	</div>
        
<%-- 로그인 사용자가 클라이언트인 경우 답변 작성 페이지 --%>        
 <% } else if(loginMember!=null	&& loginMember.getMstatus()==0) { %>    
 <!-- 답변작성이 가능한 사람 = 관리자 -->

            	<h2 class="h3 mb-3 text-black" style="font-weight: bold">문의 답변</h2>
			
          </div>
          <div class="col-md-7">

            <form action="<%=request.getContextPath()%>/board/q_writing_action.jsp" method="post">            
            <input type="hidden" name="pid" value="<%=product.getPid()%>">           
            <input type="hidden" name="qno" value="<%=request.getParameter("qno")%>">
           
              <div class="p-3 p-lg-5 border">
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="qpname" class="text-black" aria-disabled="false" style="font-weight: bold">제품명 </label>
                    <p id="qpname"><%=product.getPname() %> 
                    	&nbsp;&nbsp;&nbsp;/<%=product.getPcolor() %></p>
                  </div>
   
                </div>
             
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="qwriter" class="text-black" style="font-weight: bold">(관리자)답변자ID </label>
                    <p id="qwriter"><%=loginMember.getMid() %></p>
                   
                  </div>
                </div>
               
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="atitle" class="text-black" style="font-weight: bold">문의 제목 <span style="color: red;">*</span></label>
                    <input type="text" class="form-control" id="atitle" name="atitle" readonly="readonly" value="<%=qboard.getQtitle()%>">
                  </div>
                </div>

                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="acontent" class="text-black" style="font-weight: bold">답변 내용 <span style="color: red;">*</span></label>
                    <textarea name="acontent" id="acontent" cols="30" rows="7" class="form-control"></textarea>
                  </div>
                </div>
                              
                <div class="form-group row">
                  <div class="col-lg-12">
                    <input type="submit" class="btn btn-outline-dark btn-lg btn-block" value="작성 완료">
                  </div>
                </div>
                
              </div>
            </form>
          </div>
          
          <div class="col-md-5 ml-auto">
            <div class="p-4 border mb-3">
            
              <span class="d-block text-primary h4 text-uppercase" style="font-weight: bold">고객 문의 내역</span>
              
               <div class="info_th">
              <table>
	              <tr>	
	              	<th>작성자</th>
	              	<td><%=qboard.getQwriter() %> </td>
	              </tr> 
	          
	              <tr>	
	              	<th>문의제목</th>
	              	<td><%=qboard.getQtitle() %></td>
	              </tr>
	              <tr>	
	              	<th>문의내용</th>
	              	<td><%=qboard.getQcontent() %></td>
	              </tr>
              </table>
              </div>

            </div>
          </div>
        </div>
      <% } %> 
      
    </div>

</div>
</div>

<jsp:include page="/footer.jsp"/>

<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#qwriter").val()=="") {
		$("#message").text("작성자명을 입력해 주세요.");
		$("#qwriter").focus();
		return false;
	}
	
	if($("#qtitle").val()=="") {
		$("#message").text("문의제목을 입력해 주세요.");
		$("#qtitle").focus();
		return false;
	}
	
	if($("#qcontent").val()=="") {
		$("#message").text("문의내용을 입력해 주세요.");
		$("#qcontent").focus();
		return false;
	}
});

</script>
