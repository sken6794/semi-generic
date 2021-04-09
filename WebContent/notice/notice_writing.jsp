<%@page import="generic.dao.NoticeDAO"%>
<%@page import="generic.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_check.jspf" %>
<%
	//입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");
%>
<jsp:include page="/header.jsp"/>


	<form action="<%=request.getContextPath()%>/notice/notice_writing_action.jsp" method="post" id="noticeForm">  
    <div class="site-section">
      <div class="container">
        <div class="row">
          <div class="col-md-6 offset-md-3" >
			<br><br><br>
            <h2 class="h3 mb-3 text-black" style="font-weight: bold">공지사항 작성</h2><br>            
          </div>
          
          <div class="col-md-6 offset-md-3">                       
           <div class="form-group row">
             <div class="col-md-12">
               <label for="ntitle" class="text-black" style="font-weight: bold">제목<span style="color: red;">*</span></label>
                <input type="text" class="form-control" id="ntitle" name="ntitle">
                <div id="ntitleMsg" class="error" style="margin-top: 10px;">제목을 입력해주세요.</div>
              </div>
            </div><br>
            
           <div class="form-group row">
             <div class="col-md-12">
               <label for="nwriter" class="text-black" style="font-weight: bold">작성자<span style="color: red;">*</span></label>
              <input type="text" class="form-control" id="nwriter" name="nwriter" >
              <div id="nwriterMsg" class="error" style="margin-top: 10px;">작성자를 입력해주세요.</div>
             </div>
           </div><br>
           
         <div class="form-group row">
              <div class="col-md-12">
                <label for="ncontent" class="text-black" style="font-weight: bold">내용</label>                
                	<textarea name="ncontent" id="ncontent" cols="30" rows="7" class="form-control" ></textarea>                       
             </div>
           </div><br>
           
           <div class="form-group row">
             <div class="col-md-12">
             	<label for="nimg" class="text-black" style="font-weight: bold">파일첨부</label><br>
             </div>                    	
             <div class="col-md-12">
               <input type="file" name="nimg" value="불러오기">
             </div>                  
           </div><br>
           
           <div class="form-group row">
             <div class="col-lg-12">
               <input type="submit" class="btn btn-outline-dark btn-lg btn-block" value="작성 완료">
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
	if($("#nwriter").val()=="") {
		$("#nwriterMsg").css("display","block");	
		$("#rwriter").focus();
		return false;
	}	
		
	  var result = confirm("공지사항으로 등록하시겠습니까 ?");      
      if(result){          
          return true;
      } else {
          return false;
      }
});

</script>


<jsp:include page="/footer.jsp"/>


