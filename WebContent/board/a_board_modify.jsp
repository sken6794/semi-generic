<%@page import="generic.dto.RboardDTO"%>
<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.dao.QboardDAO"%>
<%@page import="generic.dto.QboardDTO"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 문의게시글 번호를 전달받아 답변글을 수정하기 위해 처리페이지(a_board_modify_action.jsp)를 요청하는 JSP 문서 --%>

<%--  관리자만 답변수정 가능 --%>
<%@include file="/security/admin_check.jspf" %> 

<%	
	//입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");

	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 검색하여 반환하는 메소드 호출
	int productId=Integer.parseInt(request.getParameter("pid"));
	ProductDTO product=ProductDAO.getDAO().selectIdProduct(productId);
	
	//문의게시판 번호를 전달받아 해당 Q_BOARD 테이블에 저장된 문의글 정보를 검색하여 반환하는 메소드 호출
	int	qno=Integer.parseInt(request.getParameter("qno"));		
	QboardDTO qboard = QboardDAO.getDAO().selectQnoQboard(qno);

	String id=request.getParameter("rmid");
	//문의를 작성한 회원아이디를 전달받아 MEMBER 테이블에 저장된 해당 회원정보를 검색하여 반환하는 메소드
	MemberDTO writer=MemberDAO.getDAO().selectIdMember(id);
	
%>

<jsp:include page="/header.jsp"/>

    <div class="site-section">
      <div class="container">
      
        <div class="row">
          <div class="col-md-6">
          
       	<h2 class="h3 mb-3 text-black" style="font-weight: bold">문의 답변</h2>
			
          </div>
          <div class="col-md-7">

            <form action="<%=request.getContextPath()%>/board/a_board_modify_action.jsp" method="post">            
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
                    <textarea name="acontent" id="acontent" cols="30" rows="7" class="form-control"><%=qboard.getQacontent() %></textarea>
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
