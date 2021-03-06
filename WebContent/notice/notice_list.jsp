<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.dao.NoticeDAO"%>
<%@page import="generic.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/header.jsp"/>

<%
	//입력값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");
   
	//검색 관련 정보를 반환받아 저장
	String search=request.getParameter("search");
	if(search==null) search="";
	String keyword=request.getParameter("keyword");
	if(keyword==null) keyword="";
	
	//전달된 페이지 번호를 반환받아 저장
	// => 전달값이 존재하지 않을 경우 첫번째 페이지 검색
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
	   pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나의 페이지에 출력될 게시글 갯수 설정
	int pageSize=10;
	
	//검색 게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출
	int totalNotice=NoticeDAO.getDAO().noticeCount(search, keyword);
	      
	//검색 게시글에 대한 페이지의 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalNotice/pageSize);
	
	//전달된 페이지 번호에 검증
	if(pageNum<=0 || pageNum>totalPage) {//페이지 번호가 잘못된 경우
	   pageNum=1;
	}
	
	//현재 페이지에 대한 게시글 시작 행번호를 계산하여 저장
	//ex) 1 Page : 1, 2 Page : 11, 3 Page : 21, 4 Page : 31,...
	int startRow=(pageNum-1)*pageSize+1;
	
	//현재 페이지에 대한 게시글 종료 행번호를 계산하여 저장
	//ex) 1 Page : 10, 2 Page : 20, 3 Page : 30, 4 Page : 40,...
	int endRow=pageNum*pageSize;
	
	//마지막 페이지에 대한 게시글 종료 행번호를 검색 게시글의 갯수로 변경
	if(endRow>totalNotice) {
	   endRow=totalNotice;
	}	
	//시작 행번호와 종료 행번호를 전달받아 테이블에 저장된 게시글에서 해당 범위에 포함된 게시글만 검색
	List<NoticeDTO> noticeList=NoticeDAO.getDAO().selectNoticeList(search, keyword, startRow, endRow);
	
	//현재 페이지의 게시글 목록에 출력될 시작 글번호를 계산하여 저장
	int number=totalNotice-(pageNum-1)*pageSize;
   
	//시스템의 현재 날짜를 반환받아 저장 => 게시글 작성일자를 현재 날짜와 비교하여 출력
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());    
   
	//세션에 저장된 권한 관련 정보를 반환받아 저장 - 관리자에게만 글쓰기/수정/삭제 권한 부여
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
%>
   
   <br><br><br><br><br><br><br>      
   <div class="container">       
   <div class="form-group row"> 
       &nbsp;&nbsp;<div class="col-md-12" >
     
    <h2 style="font-weight: bold; text-align: center;">공지사항</h2><br><br>      
               
    <%-- 게시글 검색 --%>
	   <form action="<%=request.getContextPath()%>/notice/notice_list.jsp" method="post">
    	<div class="col-md-12 text-center">
	      <select name="search" style="height: 34px;">
	         <option value="ntitle" selected="selected">&nbsp;제목&nbsp;</option>
	         <option value="ncontent">&nbsp;내용&nbsp;</option>
	         <option value="nwriter">&nbsp;작성자&nbsp;</option>
	      </select>   
	      &nbsp;<input class="text_box" type="text" name="keyword" style="height: 34px; width: 300px;">
	      &nbsp;<button class="btn btn-dark" type="submit" style="height: 34px;">검색</button>
		</div>    
	   </form>
  	 </div>
    </div> 
   <br><br><br><br>                 
   
	<!-- 관리자로 로그인 했을 시 글쓰기 / 수정 / 삭제 버튼 활성화  -->
	<% if(loginMember!=null && loginMember.getMstatus()==0) { %>
		<div class="col-md-12">        	
        	<button type="button" class="btn btn-dark" id="NwriteBtn" style="height: 34px; float: right;">공지작성</button>       
     	<br><br>
     	</div>			
	<% } %>

      <table class="table table-hover tbcenter" >   
          <tr style="text-align: center;">
            <th scope="col" style="width: 10%;">번호</th>
            <th scope="col" style="width: 55%; text-align: left;">&nbsp;제목</th>
            <th scope="col" style="width: 10%;">작성자</th>
            <th scope="col" style="width: 15%;">날짜</th>
            <th scope="col" style="width: 10%;">조회</th>
          </tr>
          
      <% if(totalNotice==0) { //게시글 없을 경우%>
      <tr>
         <td colspan="5">검색된 게시글이 없습니다.</td>
      </tr>
      <% } else { //게시글이 있을 경우 %>
         <%-- 게시글 목록 출력 - 반복처리 --%>
         <% for(NoticeDTO notice:noticeList) { %>
         <tr>
            <%-- 글번호 --%>
            <td><%=number %></td>
            
            <%-- 제목(링크) --%>
            <td style="text-align: left; font-weight: bold;">
            <%if(loginMember!=null && loginMember.getMstatus()==0){ %>   
           		<a href="<%=request.getContextPath() %>/notice/notice_detail.jsp?nid=<%=notice.getNid()%>" class="counting"><%=notice.getNtitle() %></a>           		
           		<a href="<%=request.getContextPath() %>/notice/notice_delete_action.jsp?nid=<%=notice.getNid()%>"><span id="delete" class="icon-delete_forever delete" style="float: right; color: gray;">&nbsp;</span></a>  
           		<a href="<%=request.getContextPath() %>/notice/notice_modify.jsp?nid=<%=notice.getNid()%>"><span id="modify" class="icon-pencil" style="float: right; color: gray;">&nbsp;</span></a>
           	       	
            <%} else { %> 
           		<a href="<%=request.getContextPath()%>/notice/notice_detail.jsp?nid=<%=notice.getNid()%>&ncount=<%=notice.getNcount()+1 %>" class="counting"><%=notice.getNtitle() %></a>           		     
            <%} %>
            <%if(currentDate.equals(notice.getNdate().substring(0, 10))) { %>
            	<span style="color: #ee4266;" class="icon-fiber_new ">&nbsp;</span>
            </td>                        
            <%} %>
            <%-- 작성자 --%>
            <td><%=notice.getNwriter() %></td>
            
            <%-- 작성일(오늘날짜는 시간만 나오게 출력) --%>
            <td>
               <% if(currentDate.equals(notice.getNdate().substring(0, 10))) { %>
                  <%=notice.getNdate().substring(11, 19) %>   
               <% } else { %>
                  <%=notice.getNdate().substring(0, 11) %>   
               <% } %>
            </td>
            
            <%-- 조회수 --%>
            <td><%=notice.getNcount() %></td>            
         </tr>
         <% number--; %>         
         <% } %>
      <% } %>
      </table>   
   </div>
           
<%-- 페이지 번호 출력(페이징 처리)과 하이퍼 링크 설정 --%>
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
    <%--페이징 --%>
    
    <div class="row" style="margin-top: -30px;">
      <div class="col-md-12 text-center">
         <div class="site-block-27">
            <ul>
         <% if(startPage>blockSize) { %>
         <li><a href="<%=request.getContextPath() %>/notice/notice_list.jsp?pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">&lt;</a></li>
         <% } else { %>
         <li><a>&lt;</a></li>
         <% } %>
         
         <% for(int i=startPage;i<=endPage;i++) { %>
            <% if(pageNum!=i) { %>
            <li><a href="<%=request.getContextPath() %>/notice/notice_list.jsp?pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"><%=i %></a></li>
            <%-- 선택된 번호 --%>
            <% } else { %>
            <li class="active"><span><%=i %></span></li>
            <% } %>                     
         <% } %>
         
         <% if(endPage!=totalPage) { %>
            <li><a href="<%=request.getContextPath() %>/notice/notice_list.jsp?pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">&gt;</a></li>
         <% } else { %>
            <li><a>&gt;</a></li>
         <% } %>
            </ul>
         </div>
      </div>        
    </div>
    <br><br>
    
   <br><br><br><br><br>  
  
<jsp:include page="/footer.jsp"/>

	<script type="text/javascript">
	$("#NwriteBtn").click(function() {
		location.href="<%=request.getContextPath()%>/notice/notice_writing.jsp";
	});
	
	$(".delete").click(function() {
		var result = confirm("정말 삭제 하시겠습니까 ?");      
	      if(result){ 	    	
	        return true;	        
	      } else {
	          return false;
	      }
	});	
	</script>
  