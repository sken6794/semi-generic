<%@page import="generic.dao.NoticeDAO"%>
<%@page import="generic.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_check.jspf" %>
<%
	//입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");
	
	int nid=Integer.parseInt(request.getParameter("nid"));
	NoticeDTO notice=NoticeDAO.getDAO().selectIdNotice(nid);	
	
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("nid")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/error/error_400.jsp';");
		out.println("</script>");
		return;
	}
	String pageNum="1";		
	if(request.getParameter("pageNum")!=null) {
		pageNum=request.getParameter("pageNum");
	}
%>

<jsp:include page="/header.jsp"/>


	<form action="<%=request.getContextPath()%>/notice/notice_modify_action.jsp" method="post" id="noticeForm" enctype="multipart/form-data">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">  
	<input type="hidden" name="nid" value="<%=notice.getNid()%>">  
	<input type="hidden" name="nimg" value="<%=notice.getNimg()%>">  
	
    <div class="site-section">
      <div class="container">
        <div class="row">
          <div class="col-md-6 offset-md-3" >
			<br><br><br>
            <h2 class="h3 mb-3 text-black" style="font-weight: bold">공지사항 수정</h2><br>            
          </div>
          
          <div class="col-md-6 offset-md-3">                       
           <div class="form-group row">
             <div class="col-md-12">
               <label for="ntitle" class="text-black" style="font-weight: bold">제목<span style="color: red;">*</span></label>
                <input type="text" class="form-control" id="ntitle" name="ntitle" value="<%=notice.getNtitle() %>">
                <div id="ntitleMsg" class="error" style="margin-top: 10px;">제목을 입력해주세요.</div>
              </div>
            </div><br>
            
           <div class="form-group row">
             <div class="col-md-12">
               <label for="nwriter" class="text-black" style="font-weight: bold">작성자<span style="color: red;">*</span></label>
              <input type="text" class="form-control" id="nwriter" name="nwriter" value="<%=notice.getNwriter() %>" readonly="readonly">
             </div>
           </div><br>
           
            <div class="form-group row">
              <div class="col-md-12">
                <label for="ncontent" class="text-black" style="font-weight: bold">내용</label>
                <%if(notice.getNcontent()==null){ %>
                	<textarea name="ncontent" id="ncontent" cols="30" rows="7" class="form-control" ></textarea>
                <%} else { %>
               		<textarea name="ncontent" id="ncontent" cols="30" rows="7" class="form-control" ><%=notice.getNcontent() %></textarea>   
               <%} %>          
             </div>
           </div><br>
           
           <div class="form-group row">
             <div class="col-md-12">
             	<label for="nimg" class="text-black" style="font-weight: bold">파일첨부</label><br>
                  </div>  
             <div class="col-md-12">
            	<img src="<%=request.getContextPath() %>/images/<%=notice.getNimg() %>" width="300"><br>       
           
				<span style="color: #fc7945;" class="icon-times-circle"></span>&nbsp;파일 수정은 불가능합니다.                          	
          	</div>
          	</div>
           
           <div class="form-group row">
             <div class="col-lg-12">
               <input type="submit" class="btn btn-outline-dark btn-lg btn-block" value="수정">
             </div>
           </div>                
              </div>
          </div>         
        </div>
      </div>
     </form>    


<script type="text/javascript">
$("#ntitle").focus();

$(".error").css("display","none");

$("#noticeForm").submit(function() {
	if($("#ntitle").val()=="") {
		$("#ntitleMsg").css("display","block");	
		$("#ntitle").focus();
		return false;
	}	
	
	  var result = confirm("작성하신 내용으로 수정하시겠습니까 ?");      
      if(result){          
          return true;
      } else {
          return false;
      }
});

</script>

<jsp:include page="/footer.jsp"/>

