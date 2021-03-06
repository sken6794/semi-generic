<%@page import="generic.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="generic.page.Page"%>
<%@page import="generic.dao.QboardDAO"%>
<%@page import="generic.dto.QboardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.RboardDTO"%>
<%@page import="generic.dao.RboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
	상품번호를 전달받아 Q_BOARD 테이블에 저장된 관련 문의 게시판 목록을 출력하는 JSP 문서
	=> product_single_page.jsp 의 #section3 위치 
--%>    

 <%
	//로그인 사용자에게만 글쓰기 권한 부여
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
 	
	//상품번호 가져오기
	int productId=Integer.parseInt(request.getParameter("pid"));
	
	//상품번호를 전달받아 Q_BOARD 테이블에 저장된 게시글을 검색하여 반환하는 메소드
	int qboardCount=QboardDAO.getDAO().selectPidQboardCount(productId);
			
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 검색하여 반환하는 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectIdProduct(productId);
 	
 	//-----페이징-----
 	//전달된 페이지 번호를 반환받아 저장 => 전달값이 존재하지 않을 경우 첫번째 페이지 검색
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나의 페이지에 출력될 게시글 갯수 설정
	int pageSize=5;

	//Q_BOARD 테이블에 저장된 전체 게시글 중 제품번호를 전달받아 해당 문의글 갯수를 반환하는 메소드
	int totalBoard=QboardDAO.getDAO().selectPidQboardCount(productId);
	//Q_BOARD 테이블에 저장된 전체 게시글 중 제품번호를 전달받아 삭제되지 않은 문의글 갯수를 반환하는 메소드
	int noDeleteQ=QboardDAO.getDAO().selectNoDeleteQCount(productId);
	      
	//검색 게시글에 대한 페이지의 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalBoard/pageSize);
	
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
	if(endRow>totalBoard) {
		endRow=totalBoard;
	}
	
 	List<QboardDTO> qboardList=QboardDAO.getDAO().selectQboard(productId, startRow, endRow);
 	
	//현재 페이지의 게시글 목록에 출력될 시작 글번호를 계산하여 저장
	int number=totalBoard-(pageNum-1)*pageSize;

 %>

	<h2 style="font-weight: bold">상품문의(<%=noDeleteQ %>)</h2>

	<% if(loginMember!=null && loginMember.getMstatus()!=0) { //관리자일 경우 문의작성 버튼 비가시화 %>
	    <a href="<%=request.getContextPath() %>/board/q_writing.jsp?pid=<%=product.getPid()%>">
	    <button type="button" class="btn btn-dark" style="float: right; height: 33px;">문의작성</button></a>
	<% } %>
	<br><br>
		
	<table class="table table-hover tbcenter">
	<thead>
		<tr style="text-align: center;">
			<th scope="col" style="width: 15%">답변여부</th>
			<th scope="col" style="width: 50%;">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">작성날짜</th>
		</tr>
	</thead>


	<% if(totalBoard==0) { %>
		<tr>
			<th colspan="4"> 등록된 상품문의가 없습니다.</th>
		</tr>
			  
	<% } else if(totalBoard!=0) { %>
		  <% for(QboardDTO question:qboardList) { %>
				<tbody>
				<% if(question.getQstatus()==9) {//삭제글인 경우 %>
					  	<tr>
					  	<td colspan="4">
							<span class="remove">
							작성자 또는 관리자에 의해 삭제된 게시글입니다.
							</span>
						</td>
						</tr>
				<% } else if(question.getQstatus()==0) { //비삭제글인 경우 %>	
				
				  		<% 	//답변대기중인 상태인 경우
				   		if (question.getQacontent()==null) { %>
							<tr>
			    		
								<th scope="row">대기중 
									<%-- 로그인 사용자가 관리인인 경우 [답변 작성]버튼 송출 --%>
									<% if(loginMember!=null	&& loginMember.getMstatus()==0) { %>
										<a href="<%=request.getContextPath()%>/board/q_writing.jsp?pid=<%=product.getPid()%>&qno=<%=question.getQno() %>">
										<span id="r_modify" class="icon-pencil"></span></a>
									<% } %>
								</th>
								
								<td id="qslide" class="qslide board_title"><%=question.getQtitle() %>
						     	 	<div style="display: none" id="qboard_content" class="qboard_content" >
										<br>
										<!-- 내용 출력부 -->
										<%=question.getQcontent().replace("\n", "<br>") %>
										
										<% //로그인 사용자이고, 관리자거나 게시글 작성자인 경우에 버튼 송출 
										if(loginMember!=null && (loginMember.getMstatus()==0 || loginMember.getMid().equals(question.getQmid()))) { %>
											<%-- 문의글 삭제 --%>
											<a id="deleteBtn" onclick="deleteBoard(<%=question.getQno() %>,<%=product.getPid()%>)";>											
											<span id="q_delete" class="icon-delete_forever"></span></a>
											
										<% } %>
							
									</div>
								</td>
								
								<!-- 사용자가 게시글 작성시 입력한 이름 출력부 -->
							    <td><%=question.getQwriter() %></td>
							    
							    <!-- 게시글 작성 시간 출력부 -->
							    <td><%=question.getQdate().substring(0,11)  %></td>
							</tr>
							
						<%  } else if(question.getQacontent()!=null) { //답변완료 상태인 경우 %>
							<tr>
					     		<th scope="row">답변완료</th>
						
						     	<td id="qslide" class="qslide board_title"><%=question.getQtitle() %>
							      	<div style="display: none" id="qboard_content" class="qboard_content" >
							      	
										<br>
										<!-- 내용 출력부 -->
										<%=question.getQcontent().replace("\n", "<br>") %>
										
										<% //로그인 사용자이고, 관리자거나 게시글 작성자인 경우에 버튼 송출 
										if(loginMember!=null && (loginMember.getMstatus()==0 || loginMember.getMid().equals(question.getQwriter()))) { %>
											<%-- 문의글 삭제 --%>
											<a id="deleteBtn" onclick="deleteBoard(<%=question.getQno() %>,<%=product.getPid()%>)";>	
											<span id="q_delete" class="icon-delete_forever"></span></a>
										<% } %>
										
										<br>
										<!-- 관리자 답변 -->
										<hr>
										<p style="font-weight: bold;">관리자</p>
										<span class="icon-subdirectory_arrow_right"></span>&nbsp;<%=question.getQacontent() %>
										<%-- 답글 수정 버튼 --%>
										<% //로그인 사용자이고, 관리자인 경우 
										if(loginMember!=null && loginMember.getMstatus()==0) { %>																	
											<a href="<%=request.getContextPath()%>/board/a_board_modify.jsp?pid=<%=product.getPid()%>&qno=<%=question.getQno() %>">
											<span id="a_modify" class="icon-pencil"></span></a> 
										<% } %>
										<br>	
									</div>	
								</td>
								
								<!-- 사용자가 게시글 작성시 입력한 이름 출력부 -->
								<td><%=question.getQwriter() %></td>
								
								<!-- 게시글 작성 시간 출력부 -->
								<td><%=question.getQdate().substring(0,11)  %></td>
							</tr>
							
						<% } //답변완료 상태인 경우 %>
			<% } //삭제되지 않은 게시판 %>
		<% } //List반복해서 출력 %>
	<% } //totalboard!=0  %>
	
				</tbody>
			</table>	
      
<%-- 페이징 --%>
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
	<!-- 페이지 버튼 -->
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
				<li><a href="<%=request.getContextPath() %>/main/product_single_page.jsp?pid=<%=productId %>&pageNum=<%=i%>#section3"><%=i %></a></li>
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
	<script>
	function deleteBoard(qno, pid) {
		var result = confirm("정말로삭제하시겠습니까?");
		if(result){
			location.href="<%=request.getContextPath()%>/board/q_board_delete_action.jsp?pid="+pid+"&qno="+qno;			
		} else {
			
		}
	}
	
	</script>
	