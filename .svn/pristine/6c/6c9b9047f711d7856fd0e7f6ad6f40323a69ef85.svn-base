<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
<%@page import="generic.page.MemberSearchCriteria"%>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/AdminStyle.css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<%
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	if(loginMember==null){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
	}else{
	if(loginMember.getMstatus()!=0){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
	}
	}

	int num=0;
	MemberSearchCriteria msc=new MemberSearchCriteria();
	ArrayList<MemberDTO> list;
	String mstate="";
	if(request.getParameter("num")==null){
		num=1;
	}else{
	num=Integer.parseInt( request.getParameter("num"));
	}
	if(request.getParameter("MemberSearchKeyword")!=null){
		System.out.println("검색어 있음");
		msc.setNum(num);
		msc.setMemberSearchType(request.getParameter("MemberSearchType"));
		msc.setMemberSearchKeyword(request.getParameter("MemberSearchKeyword"));
		
		//System.out.println("검색타입"+URLDecoder.decode(request.getParameter("ProductSearchType"))); 
		System.out.println("게시물 총개수"+MemberDAO.getDAO().totCount(request.getParameter("MemberSearchType"),request.getParameter("MemberSearchKeyword")));
		msc.setCount(MemberDAO.getDAO().totCount(request.getParameter("MemberSearchType"),request.getParameter("MemberSearchKeyword")));
		list=MemberDAO.getDAO().getMemberList(msc);
	}else{
		System.out.println("검색어 없음");
		msc.setNum(num);
		msc.setCount(MemberDAO.getDAO().totCount("",""));
		list= MemberDAO.getDAO().getMemberList(msc);
		System.out.println(msc.getDisplayPost()+"  "+msc.getPostNum());
	}
%>




</head>
<body>
	<div id="throbber" style="display: none; min-height: 120px;"></div>
	<div id="noty-holder"></div>
	<div id="wrapper">
		<!-- Navigation -->
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<%@ include file="include/header.jsp"%>
			</div>
			<!-- Top Menu Items -->

			<ul class="nav navbar-right top-nav">
				<%@ include file="include/nav.jsp"%>
			</ul>

			<!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<%@include file="include/sidebar.jsp"%>
			</div>
			<!-- /.navbar-collapse -->
		</nav>

		<div id="page-wrapper">
			<div class="container">
			<h2>
					<b>고객관리</b>
				</h2>
				<!-- Page Heading -->
				<div class="row" id="main">
				<form action="MemberListAction.jsp" method="post">
					<table class="table table-condensed">
						<tr>
							<th style="background-color: #eeeeee;">검색분류</th>

							<td><select class="form-control"name="MemberSearchType" >
									<option value="아이디">아이디</option>
									<option value="이름">이름</option>
									<option value="이메일">이메일</option>
									<option value="핸드폰">핸드폰 번호</option>
							</select></td>
							<td colspan="2"><input class="form-control" type="text"
								name="MemberSearchKeyword"  placeholder="검색어를 입력하세요" /></td>
							<td><button class="btn btn-primary">검색</button></td>
						</tr>
						
						

					</table>
					</form>

				</div>
				<div></div>


				<div class="row">
					<table id="news" class="table table-striped table-responsive">
						<thead>
							<tr>
								<th style="background-color: #eeeeee;">이름</th>
								<th style="background-color: #eeeeee;">아이디</th>
								<th style="background-color: #eeeeee;">가입일</th>
								<th style="background-color: #eeeeee;">전화번호</th>
								<th style="background-color: #eeeeee;">주소</th>
								<th style="background-color: #eeeeee;">상태</th>
								
							</tr>
						</thead>
						<tbody>
						<% for(int i=0;i<list.size();i++){ %>
							<tr>
								<td><%=list.get(i).getMname() %></td>
								<td><%=list.get(i).getMid() %></td>
								<td><%=list.get(i).getMenrolldate().substring(0, 10) %></td>
								<td><%=list.get(i).getMphone() %></td>
								<td><%=list.get(i).getMaddress1()+" "+list.get(i).getMaddress2()+" "+list.get(i).getMaddress3() %></td>
								<td>
								<%if(list.get(i).getMstatus()==1){mstate="회원";}
								else if(list.get(i).getMstatus()==0){mstate="관리자";}
								else{mstate="탈퇴회원";}%>
								<%=mstate %>
								</td>
							</tr>
							<%}%>
							
						</tbody>

					</table>
				
				</div>

				<div class="text-center">
					<ul class="pagination">
						<%if(msc.getPrev()){ %>
						<li><a href="MemberList.jsp?num=<%=msc.getStartPageNum()-1%>">이전</a></li>
						<%}%>	
						<%for(int i=msc.getStartPageNum();i<=msc.getEndPageNum();i++){ %>
						<li><a href="MemberList.jsp?num=<%=i%>"><%=i%></a></li>
						<%} %>	
						<%if(msc.getNext()){ %>
						<li><a href="MemberList.jsp?num=<%=msc.getEndPageNum()+1 %>">다음</a></li>
						<%}System.out.println(msc.getEndPageNum()+1);%>	
					</ul>

				</div>

			</div>
					
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
	



	<script type="text/javascript"
		src="http://code.jquery.com/jquery-2.1.4.min.js"></script>



	<script src="http://bootstrapk.com/dist/js/bootstrap.min.js"></script>


</body>
</html>