<%@page import="generic.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="generic.dto.QboardDTO"%>
<%@page import="generic.dao.QboardDAO"%>
<%@page import="generic.page.Page"%>
<%@page import="java.util.ArrayList"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.RboardDTO"%>
<%@page import="generic.dao.RboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	상품번호를 전달받아 R_BOARD 테이블에 저장된 관련 후기 게시판 목록을 출력하는 JSP 문서
	=> product_single_page.jsp 의 #section2 위치 
--%>        
 
 <%
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
 
 	//상품번호 가져오기
	int productId=Integer.parseInt(request.getParameter("pid"));
 	
 	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 검색하여 반환하는 메소드 호출
 	ProductDTO product=ProductDAO.getDAO().selectIdProduct(productId);
 	 
	//-----페이징-----
 	//전달된 페이지 번호를 반환받아 저장 => 전달값이 존재하지 않을 경우 첫번째 페이지 검색
	int RpageNum=1;
	if(request.getParameter("RpageNum")!=null) {//전달값이 있는 경우
		RpageNum=Integer.parseInt(request.getParameter("RpageNum"));
	}
	
	//하나의 페이지에 출력될 게시글 갯수 설정
	int RpageSize=5;

 	//후기글 갯수 반환
	//R_BOARD 테이블에 저장된 전체 게시글 중 제품번호를 전달받아 해당 후기글 갯수를 반환
	int totalRboard=RboardDAO.getDAO().selectPidRboardCount(productId);
	//R_BOARD 테이블에 저장된 전체 게시글 중 제품번호를 전달받아 삭제되지않은 후기글 갯수만을 반환
	int noDeleteR=RboardDAO.getDAO().selectNoDeleteRCount(productId);
	
	//검색 게시글에 대한 페이지의 갯수를 계산하여 저장
	int totalRpage=(int)Math.ceil((double)totalRboard/RpageSize);
	
	//전달된 페이지 번호에 검증
	if(RpageNum<=0 || RpageNum>totalRpage) {//페이지 번호가 잘못된 경우
		RpageNum=1;
	}

	//현재 페이지에 대한 게시글 시작 행번호를 계산하여 저장
	int startRow=(RpageNum-1)*RpageSize+1;
	
	//현재 페이지에 대한 게시글 종료 행번호를 계산하여 저장
	int endRow=RpageNum*RpageSize;
	
	//마지막 페이지에 대한 게시글 종료 행번호를 검색 게시글의 갯수로 변경
	if(endRow>totalRboard) {
		endRow=totalRboard;
	}
	
 	List<RboardDTO> rboardList=RboardDAO.getDAO().selectRboard(productId, startRow, endRow);
 	
	//현재 페이지의 게시글 목록에 출력될 시작 글번호를 계산하여 저장
	int number=totalRboard-(RpageNum-1)*RpageSize;
 	
 %>
	<h2 style="font-weight: bold">상품후기(<%=noDeleteR %>)</h2>

    <%//비로그인 사용자거나 로그인사용자가 관리자일 경우 후기작성 버튼 비가시화 
    if(loginMember!=null && loginMember.getMstatus()!=0) { %>
    <a href="<%=request.getContextPath() %>/board/r_writing.jsp?pid=<%=product.getPid()%>">
   	<button type="button" class="btn btn-dark" id="RwriteBtn" style="float: right; height: 33px;">후기작성</button></a>
	<% } %>
	<br><br>
	
	<table class="table table-hover tbcenter" >
	 <thead>
	    <tr style="text-align: center;">
	      <th scope="col" style="width: 15%">평점</th>
	      <th scope="col" style="width: 50%">제목</th>
	      <th scope="col">작성자</th>
	      <th scope="col">작성날짜</th>
	    </tr>
	  </thead>
	
	<% if(totalRboard==0) { %>
	  	<tr>
		  	<th colspan="4"> 등록된 상품후기가 없습니다.</th>
		</tr>
	  
	 <% } else if(totalRboard!=0) { %>
		  <% for(RboardDTO review:rboardList) { %>
			  <tbody>  
			  	<% if(review.getRstatus()==9) {//삭제글인 경우 %>
						  	<tr>
						  	<td colspan="4">
								<span class="remove">작성자 또는 관리자에 의해 삭제된 게시글입니다.</span>
							</td>
							</tr>
				<% } else if(review.getRstatus()==0) { //비삭제글인 경우 %>	
				
			    <tr>
			      <th scope="row">
			      	<!-- 별점 출력부 -->
			      	<%=review.getRstars() %>
			      </th>
			      <td id="rslide" class="rslide board_title"><%=review.getRtitle() %>
					<div style="display: none" id="rboard_content" class="rboard_content">
						<br>
																	
						<!-- 이미지 출력부 -->
						<% if(review.getRorigin()!=null) { //저장된 이미지가 있을 때만 img 태그 출력 %>
							<img src="<%=request.getContextPath() %>/review_images/<%=review.getRorigin() %>" style="height: 300px;" class="img-fluid"> 
							<br><br>
						<% } %>
						
						<!-- 내용 출력부 -->
						<%=review.getRcontent().replace("\n", "<br>") %>
					
						<% //로그인 사용자이고, 관리자거나 게시글 작성자인 경우에 버튼 송출 
						if(loginMember!=null && (loginMember.getMstatus()==0 || loginMember.getMid().equals(review.getRmid()))) { %>
													
						<%-- 후기글 수정 --%>
						<a href="<%=request.getContextPath()%>/board/r_board_modify.jsp?pid=<%=product.getPid()%>&rno=<%=review.getRno() %>">
						<span id="r_modify" class="icon-pencil"></span></a> 
						
						<%-- 후기글 삭제 --%>
						<a id="deleteBtn" onclick="deleteRBoard(<%=review.getRno() %>,<%=product.getPid()%>)";>	
						<span id="r_delete" class="icon-delete_forever"></span></a>
						
						<% } %>
						
					</div>
			       
			      </td>
			      <!-- 사용자가 게시글 작성시 입력한 이름 출력부 -->
			      <td><%=review.getRwriter() %></td>
			      
			      <!-- 게시글 작성 시간 출력부 -->
			      <td><%=review.getRdate().substring(0,11) %></td>
			    </tr>
			    
			<% } %>
		<% } %>
	<% } %>
	 
	  </tbody>
	</table>
	
<%-- 페이징 --%>
<%
	//블럭에 출력될 페이지 번호의 갯수 설정
	int RblockSize=5;

	//블럭에 출력될 시작 페이지 번호를 계산하여 저장
	// => 1 Block : 1, 2 Block : 6, 3 Block : 11, 4 Block : 16,...
	int startRpage=(RpageNum-1)/RblockSize*RblockSize+1;
	
	//블럭에 출력될 종료 페이지 번호를 계산하여 저장
	// => 1 Block : 5, 2 Block : 10, 3 Block : 15, 4 Block : 20,...
	int endRpage=startRpage+RblockSize-1;
	
	//마지막 블럭의 종료 페이지 번호 변경
	if(endRpage>totalRpage) {
		endRpage=totalRpage;
	}
%>

	<!-- 페이지 버튼 -->	
	<div class="row">
      <div class="col-md-12 text-center">
         <div class="site-block-27">
            <ul>
			<% if(startRpage>RblockSize) { %>
			<li><a href="<%=startRpage-RblockSize%>">&lt;</a></li>
			<% } else { %>
			<li><a>&lt;</a></li>
			<% } %>
			
			<% for(int i=startRpage;i<=endRpage;i++) { %>
				<% if(RpageNum!=i) { %>
				<li><a href="<%=request.getContextPath() %>/main/product_single_page.jsp?pid=<%=productId %>&RpageNum=<%=i%>#section2"><%=i %></a></li>
				<%-- 선택된 번호 --%>
				<% } else { %>
				<li class="active"><span><%=i %></span></li>
				<% } %>							
			<% } %>
			
			<% if(endRpage!=totalRpage) { %>
				<li><a href="<%=startRpage+RblockSize%>">&gt;</a></li>
			<% } else { %>
				<li><a>&gt;</a></li>
			<% } %>
				</ul>
         </div>
      </div>        
    </div>
    <br>
    <script>
	function deleteRBoard(rno, pid) {
		var result = confirm("정말로삭제하시겠습니까?");
		if(result){
			location.href="<%=request.getContextPath()%>/board/r_board_delete_action.jsp?pid="+pid+"&rno="+rno;			
		} else {
			
		}
	}
	
	</script>
	