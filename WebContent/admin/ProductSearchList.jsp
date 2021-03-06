<%@page import="generic.dto.MemberDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.page.ProductSearchCriteria"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="java.net.URLDecoder"%>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<title>Insert title here</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/AdminStyle.css">


	



<style>
img {
	height: 60px;
	width: 90px;
}

th, td {
	text-align: center;
	vertical-align: middle;
}

.table>tbody>tr>td {
	vertical-align: middle;
}
</style>
<%
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	if(loginMember==null){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
	}else{
	if(loginMember.getMstatus()!=0){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
		}
	}	

    request.setCharacterEncoding("UTF-8");
	ArrayList<ProductDTO> list =null;
	DecimalFormat df=new DecimalFormat("#,###");
	int num;
	if(request.getParameter("num")==null){
		num=1;
	}else{
	num=Integer.parseInt( request.getParameter("num"));
	}
	System.out.println("현제 페이지 번호 = "+num);
	ProductSearchCriteria psc=new ProductSearchCriteria();
	
	if(request.getParameter("ProductSearchKeyword")!=null){
		System.out.println("검색어 있음");
		psc.setNum(num);
		psc.setProductSearchType(request.getParameter("ProductSearchType"));
		psc.setProductSearchKeyword(request.getParameter("ProductSearchKeyword"));
		psc.setProductCategory(request.getParameter("ProductCategory"));
		psc.setStartDate( request.getParameter("startDate"));
		psc.setEndDate( request.getParameter("endDate"));
		psc.setProductStatus(Integer.parseInt(request.getParameter("pstatus")));
		//System.out.println("검색타입"+URLDecoder.decode(request.getParameter("ProductSearchType"))); 
		System.out.println("게시물 총개수"+ProductDAO.getDAO().totalCoutn(request.getParameter("ProductSearchType"),request.getParameter("ProductSearchKeyword")));
		psc.setCount(ProductDAO.getDAO().totalCoutn(request.getParameter("ProductSearchType"),request.getParameter("ProductSearchKeyword")));
		list=ProductDAO.getDAO().getSearchProductList(psc);
	}
	
	else{
		System.out.println("검색어 없음");
	psc.setNum(num);
	psc.setCount(ProductDAO.getDAO().totalCoutn("",""));
	list= ProductDAO.getDAO().getProductList(psc.getDisplayPost(),psc.getPostNum());
	//System.out.println("시작번호="+psc.getDisplayPost()+", 끝번호 ="+psc.getPostNum()*num);
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
					<b>상품목록</b>
				</h2>

				<div class="row">
				<form action="ProductSearchListAction.jsp" method="post">
					<table class="table table-condensed">
						<tr>
							<th style="background-color: #eeeeee;">검색분류</th>

							<td><select class="form-control" name="ProductSearchType">
									<option value="상품명" >상품명</option>
									<option value="상품번호" >상품번호</option>
							</select></td>
							<td colspan="2"><input class="form-control" type="text" name="ProductSearchKeyword"
								value="" placeholder="<%=psc.getProductSearchKeyword()%>" /></td>
						</tr>
						<tr>
							<th style="background-color: #eeeeee;">상품분류</th>

							<td><select class="form-control" name="ProductCategory">
									<option value="전체" >전체 </option>
									<option value="안경" >안경</option>
									<option value="선글라스">선글라스</option>
							</select></td>
							<td colspan="2"></td>

						</tr>
						<tr>
							<th style="background-color: #eeeeee;">상품등록일</th>

							<td><select class="form-control">
									<option value="">상품등록일</option>
									
							</select></td>
							<td>
	
									<div class="btn-group btn-group-toggle "
									data-toggle="buttons">
									<label class="btn date" role="button"class="radio-value"> 
										<input type="radio"name="options" value="0">전체
									</label>
									<label class="btn active" role="button" > 
										<input type="radio" name="options" value="1" >오늘
									</label> 
									<label class="btn date" role="button"> 
										<input type="radio"  name="options" value="3"  >3일
									</label>
									<label class="btn date" role="button"> 
										<input type="radio" name="options" value="7">7일
									</label>
									<label class="btn date" role="button"> 
										<input type="radio" name="options" value="30" >1개월
									</label>
									<label class="btn date" role="button"> 
										<input type="radio" name="options" value="90" >3개월
									</label>
									<label class="btn date" role="button"class="radio-value"> 
										<input type="radio"name="options" value="365" >1년
									</label>
									
									
								</div>

							</td>
							<td><input type="date"id="date1" name="startDate" value="<%=psc.getStartDate() %>" >~<input type="date" id="date2" name="endDate" value="<%=psc.getEndDate()%>">
							</td>
							

						</tr>
						<tr>
							<th style="background-color: #eeeeee;">판매상태</th>

							<td>
								<div class="btn-group btn-group-toggle " >
									<label class="btn active" role="button"> <input
										type="radio" name="stateoptions" value="2" required>전체
									</label> <label class="btn active" role="button"> <input
										type="radio" name="stateoptions" value="1" required>판매중
									</label> <label class="btn active" role="button"> <input
										type="radio" name="stateoptions" value="0" required>판매중지
									</label>
								</div>
							</td>
							<td colspan="2"></td>
							


						</tr>
						<tr>
							<td><button class="btn btn-primary" id="btn">검색</button></td>
						
						</tr>
	
					</table>
				</form>	

				</div>
				<div></div>


				<div class="row">
					<table id="news" class="table table-striped table-responsive">
						<thead>
							<tr>
							    <th style="background-color: #eeeeee;">상품번호</th>
								<th style="background-color: #eeeeee;">이미지</th>
								<th style="background-color: #eeeeee;">상품이름</th>
								<th style="background-color: #eeeeee;">카테고리</th>
								<th style="background-color: #eeeeee;">가격</th>
								<th style="background-color: #eeeeee;">재고수량</th>
								<th style="background-color: #eeeeee;">등록날짜</th>
							</tr>
						</thead>
						<tbody>
						<% for(int i=0;i<list.size();i++){ %>
							<tr>
								<td><%=list.get(i).getPid() %></td>
								<td><img src="<%=request.getContextPath() %>/images/<%=list.get(i).getPimg1() %>"></td>
								<td><a href="<%=request.getContextPath() %>/admin/ProductUpdate.jsp?pid=<%=list.get(i).getPid() %>"><%=list.get(i).getPname() %></a></td>
								<td><%=list.get(i).getCtno()==10?"안경":"선글라스" %></td>
								<td><%=df.format(list.get(i).getPprice()) %>원</td>
								<td><%=list.get(i).getPstock() %></td>
								<td><%=list.get(i).getPregdate().substring(0, 10) %></td>
							</tr>
						<%}%>

						</tbody>

					</table>
				</div>

				<div class="text-center">
					<ul class="pagination">'
					<%if(psc.getPrev()){ %>
						<li><a href="ProductSearchList.jsp?num=<%=psc.getStartPageNum()-1%>">이전</a></li>
					<%}%>	
					<%for(int i=psc.getStartPageNum();i<=psc.getEndPageNum();i++){ %>
						
						<li><a href="ProductSearchList.jsp?num=<%=i%>
						&ProductSearchType=<%=psc.getProductSearchType()%>
						&ProductSearchKeyword=<%=psc.getProductSearchKeyword()%>
						&ProductCategory=<%=psc.getProductCategory() %>
						&startDate=<%=psc.getStartDate()%>
						&endDate=<%=psc.getEndDate()%>">
						<%=i%></a></li>
					<%} %>	
					<%if(psc.getNext()){ %>
						<li><a href="ProductSearchList.jsp?num=<%=psc.getEndPageNum()+1 %>">다음</a></li>
					<%}System.out.println(psc.getEndPageNum()+1);%>	
					</ul>

				</div>

			</div>


		</div>

	</div>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!--<script src="http://bootstrapk.com/dist/js/bootstrap.min.js"></script>-->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	$("div[data-toggle=buttons]").change(function() {
		var value=$(this).find("input[type=radio]:checked").val();
		//alert(value);
		 var today = getToday();
		    var arr1= today.split("-");
		    var date1=new Date(arr1[0],arr1[1],arr1[2]);
		    
		    if(value==1){
		    	 $("#date1").attr('value', today);
		    	 $("#date2").attr('value', today);
		    	
		    }
		    if(value==0){
		    	 $("#date1").attr('value', "");
		    	 $("#date2").attr('value', "");
		    }
		    if(value==3){
		    	//console.log("인터발: " + date1.getFullYear() +"-"+date1.getMonth()+"-"+(date1.getDate()-3)); 
		    	var now = new Date();
		   	    var year = now.getFullYear();
		        var month = now.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
		        var date = now.getDate()-value;  
		        if((month + "").length < 2){month = "0" + month;}
		        else{ month = "" + month;}
			    if((date + "").length < 2){date = "0" + date;}
			    else{ date = "" + date;}
			  var endDate= year+"-"+ month+"-"+ date;
		    	$("#date1").attr('value', endDate);
		    }
		    if(value==7){
		    	var now = new Date();
		   	    var year = now.getFullYear();
		        var month = now.getMonth() +1;    //1월이 0으로 되기때문에 +1을 함.
		        var date = now.getDate()-value;  
		        if(date<0){
		        	var i=Math.abs(date);
		        	
		        	 month = now.getMonth();
		        	 var lastDay = ( new Date( year, month, 0) ).getDate();
		        	 date=lastDay-i;
		        	 //alert(date);
		        }
		        if((month + "").length < 2){month = "0" + month;}
		        else{ month = "" + month;}
			    if((date + "").length < 2){date = "0" + date;}
			    else{ date = "" + date;}
			  var endDate= year+"-"+ month+"-"+ date;
		    	$("#date1").attr('value', endDate);
		    	$("#date2").attr('value', today);
		    }
		    if(value==30){
		    	var now = new Date();
		   	    var year = now.getFullYear();
		        var month = now.getMonth() + 1-1;    //1월이 0으로 되기때문에 +1을 함.
		        var date = now.getDate() 
		        if((month + "").length < 2){month = "0" + month;}
		        else{ month = "" + month;}
			    if((date + "").length < 2){date = "0" + date;}
			    else{ date = "" + date;}
			    var endDate= year+"-"+ month+"-"+ date;
			   
		    	$("#date1").attr('value', endDate);
		    	$("#date2").attr('value', today);
		    }
		    if(value==90){
		    	var now = new Date();
		   	    var year = now.getFullYear();
		        var month = now.getMonth() + 1-3;    //1월이 0으로 되기때문에 +1을 함.
		        var date = now.getDate() 
		        if((month + "").length < 2){month = "0" + month;}
		        else{ month = "" + month;}
			    if((date + "").length < 2){date = "0" + date;}
			    else{ date = "" + date;}
			    var endDate= year+"-"+ month+"-"+ date;
			   
		    	$("#date1").attr('value', endDate);
		    	$("#date2").attr('value', today);
		    }
		    if(value==365){
		    	var now = new Date();
		   	    var year = now.getFullYear()-1;
		        var month = now.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
		        var date = now.getDate() 
		        if((month + "").length < 2){month = "0" + month;}
		        else{ month = "" + month;}
			    if((date + "").length < 2){date = "0" + date;}
			    else{ date = "" + date;}
			    var endDate= year+"-"+ month+"-"+ date;
			    $("#date1").attr('value', endDate);
		    	$("#date2").attr('value', today);
		    
		    }
		    
		    //alert(date);
		   
	});
	 function getToday(){
		    var now = new Date();
		    var year = now.getFullYear();
		    var month = now.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
		    var date = now.getDate();  

		    if((month + "").length < 2){        //2자리가 아니면 0을 붙여줌.
		        month = "0" + month;
		    }else{
		         // ""을 빼면 year + month (숫자+숫자) 됨.. ex) 2018 + 12 = 2030이 리턴됨.
		        month = "" + month;   
		    }
		    if((date + "").length < 2){        //2자리가 아니면 0을 붙여줌.
		    	date = "0" + date;
		    }else{
		         // ""을 빼면 year + month (숫자+숫자) 됨.. ex) 2018 + 12 = 2030이 리턴됨.
		        date = "" + date;   
		    }
		    
		    return today = year+"-"+ month+"-"+ date; 
		}
	
	
	
	 
	</script>
	
	
	



</body>
</html>






