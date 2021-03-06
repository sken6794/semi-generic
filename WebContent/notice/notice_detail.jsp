<%@page import="generic.dao.NoticeDAO"%>
<%@page import="generic.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int nid=Integer.parseInt(request.getParameter("nid"));
	NoticeDTO notice=NoticeDAO.getDAO().selectIdNotice(nid);
	
	NoticeDAO.getDAO().updateCountNotice(nid);
%>
<jsp:include page="/header.jsp"/>


<%=notice.getNcount()+1 %>
  
<br><br><br><br><br><br>              
<div class="container">       
   <div class="form-group row"> 
       &nbsp;&nbsp;<div class="col-md-11" >
           <h2 style="font-weight: bold">공지사항</h2>        
    </div>            
   
   <br><br><br>                 
      <table class="table tbcenter" >   
          <tr>
            <th scope="col" style="width: 100%; text-align: left;"> &nbsp;&nbsp;제목 ㅣ <%=notice.getNtitle() %></th>
          </tr>
           <tr>
            <th scope="col" style="width: 15%; text-align: left; font-weight: 400;">
            &nbsp;&nbsp;<%=notice.getNwriter() %>&nbsp;&nbsp;<%=notice.getNdate() %>	        
            </th>                     
          </tr>
          <tr>
            <th scope="col" style="font-weight: 400;">
            <br>          
            	<%if(notice.getNimg()==null && notice.getNcontent()!=null){ //이미지가 없을때 글만 출력되고 %>
            		<%=notice.getNcontent().replace("\n", "<br>")  %>  
            	          		
            	<%} else if(notice.getNimg()!=null && notice.getNcontent()!=null){ //이미지와 글이 있을때 모두 출력 %>
	            	<img src="<%=request.getContextPath()%>/images/<%=notice.getNimg() %>" alt="img">
	            	<br><br><br>
            		<%=notice.getNcontent().replace("\n", "<br>")  %>  
            	<%} else if(notice.getNimg()!=null && notice.getNcontent()==null){ //이미지만 있고 글이 없을때 이미지만 출력 %>             		
	            	<img src="<%=request.getContextPath()%>/images/<%=notice.getNimg()%>" alt="img">  	             	         	          	
	            <%} %>
            <br><br><br>       
            </th>
          </tr>
          <tr>
            <th scope="col" style="text-align: right;"><a href="<%=request.getContextPath()%>/notice/notice_list.jsp" class="btn btn-dark">목록</a></button></th>
          </tr>
          
   </table>
   </div>
   </div> 
   
<jsp:include page="/footer.jsp"/>