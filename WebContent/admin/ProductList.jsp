<%@page import="generic.dto.MemberDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.page.ProductSearchCriteria"%>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="EUC-KR">
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
    
	ProductSearchCriteria psc=new ProductSearchCriteria();
	DecimalFormat df=new DecimalFormat("#,###");
	int num;
	if(request.getParameter("num")==null){
		num=1;
	}else{
	num=Integer.parseInt( request.getParameter("num"));
	}
	System.out.println(num);
	psc.setNum(num);
	psc.setCount(ProductDAO.getDAO().totalCoutn("",""));
	ArrayList<ProductDTO> list= ProductDAO.getDAO().getProductList(psc.getDisplayPost(),psc.getPostNum());
	System.out.println(psc.getDisplayPost()+"  "+psc.getPostNum());
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
					<b>????????????</b>
				</h2>

				<div class="row">
				<form action="ProductSearchListAction.jsp" method="post">
					<table class="table table-condensed">
						<tr>
							<th style="background-color: #eeeeee;">????????????</th>

							<td><select class="form-control" name="ProductSearchType">
									<option value="?????????" >?????????</option>
									<option value="????????????" >????????????</option>
							</select></td>
							<td colspan="2"><input class="form-control" type="text" name="ProductSearchKeyword"
								value="" placeholder="???????????? ???????????????" /></td>
						</tr>
						<tr>
							<th style="background-color: #eeeeee;">????????????</th>

							<td><select class="form-control" name="ProductCategory">
									<option value="??????" >?????? </option>
									<option value="??????" >??????</option>
									<option value="????????????">????????????</option>
							</select></td>
							<td colspan="2"></td>

						</tr>
						<tr>
							<th style="background-color: #eeeeee;">???????????????</th>

							<td><select class="form-control">
									<option value="">???????????????</option>
									
							</select></td>
							<td>
	
									<div class="btn-group btn-group-toggle "
									data-toggle="buttons">
									
									<label class="btn date" role="button"class="radio-value"> 
										<input type="radio"name="options" value="0">??????
									</label>
									<label class="btn active" role="button" > 
										<input type="radio" name="options" value="1" required>??????
									</label> 
									<label class="btn date" role="button"> 
										<input type="radio"  name="options" value="3"  >3???
									</label>
									<label class="btn date" role="button"> 
										<input type="radio" name="options" value="7">7???
									</label>
									<label class="btn date" role="button"> 
										<input type="radio" name="options" value="30" >1??????
									</label>
									<label class="btn date" role="button"> 
										<input type="radio" name="options" value="90" >3??????
									</label>
									<label class="btn date" role="button"class="radio-value"> 
										<input type="radio"name="options" value="365" >1???
									</label>
									
									
								</div>

							</td>
							<td><input type="date"id="date1" name="startDate" value="" >~<input type="date" id="date2" name="endDate" value="">
							</td>
							

						</tr>
						<tr>
							<th style="background-color: #eeeeee;">????????????</th>

							<td>
								<div class="btn-group btn-group-toggle ">
									<label class="btn active" role="button"> <input
										type="radio" name="stateoptions" value="2" checked="checked" >??????
									</label> <label class="btn active" role="button"> <input
										type="radio" name="stateoptions" value="1" >?????????
									</label> <label class="btn active" role="button"> <input
										type="radio" name="stateoptions" value="0" >????????????
									</label>
								</div>
							</td>
							<td colspan="2"></td>
							


						</tr>
						<tr>
							<td><button class="btn btn-primary" id="btn">??????</button></td>
						
						</tr>
	
					</table>
				</form>
				</div>
				<div></div>


				<div class="row">
					<table id="news" class="table table-striped table-responsive">
						<thead>
							<tr>
							    <th style="background-color: #eeeeee;">????????????</th>
								<th style="background-color: #eeeeee;">?????????</th>
								<th style="background-color: #eeeeee;">????????????</th>
								<th style="background-color: #eeeeee;">????????????</th>
								<th style="background-color: #eeeeee;">??????</th>
								<th style="background-color: #eeeeee;">????????????</th>
								<th style="background-color: #eeeeee;">????????????</th>
							</tr>
						</thead>
						<tbody>
						<% for(int i=0;i<list.size();i++){ %>
							<tr>
								<td><%=list.get(i).getPid() %></td>
								<td><img src="<%=request.getContextPath() %>/images/<%=list.get(i).getPimg1() %>"></td>
								<td><a href="<%=request.getContextPath() %>/admin/ProductUpdate.jsp?pid=<%=list.get(i).getPid() %>"><%=list.get(i).getPname() %></a></td>
								<td><%=list.get(i).getCtno()==10?"??????":"????????????" %></td>
								<td><%=df.format(list.get(i).getPprice()) %>???</td>
								<td><%=list.get(i).getPstock() %></td>
								<td><%=list.get(i).getPregdate().substring(0, 10) %></td>
							</tr>
						<%}%>

						</tbody>

					</table>
				</div>

				<div class="text-center">
					<ul class="pagination">
					<%if(psc.getPrev()){ %>
						<li><a href="ProductList.jsp?num=<%=psc.getStartPageNum()-1%>">??????</a></li>
					<%}%>	
					<%for(int i=psc.getStartPageNum();i<=psc.getEndPageNum();i++){ %>
						<li><a href="ProductList.jsp?num=<%=i%>"><%=i%></a></li>
					<%} %>	
					<%if(psc.getNext()){ %>
						<li><a href="ProductList.jsp?num=<%=psc.getEndPageNum()+1 %>">??????</a></li>
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
		    if(value==0){
		    	 $("#date1").attr('value', "");
		    	 $("#date2").attr('value', "");
		    }
		    if(value==1){
		    	 $("#date1").attr('value', today);
		    	 $("#date2").attr('value', today);
		    	
		    }
		    if(value==3){
		    	//console.log("?????????: " + date1.getFullYear() +"-"+date1.getMonth()+"-"+(date1.getDate()-3)); 
		    	var now = new Date();
		   	    var year = now.getFullYear();
		        var month = now.getMonth() + 1;    //1?????? 0?????? ??????????????? +1??? ???.
		        var date = now.getDate()-value;  
		        if((month + "").length < 2){month = "0" + month;}
		        else{ month = "" + month;}
			    if((date + "").length < 2){date = "0" + date;}
			    else{ date = "" + date;}
			  var endDate= year+"-"+ month+"-"+ date;
		    	$("#date1").attr('value', endDate);
		    	$("#date2").attr('value', today);
		    }
		    if(value==7){
		    	var now = new Date();
		   	    var year = now.getFullYear();
		        var month = now.getMonth() +1;    //1?????? 0?????? ??????????????? +1??? ???.
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
		        var month = now.getMonth() + 1-1;    //1?????? 0?????? ??????????????? +1??? ???.
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
		        var month = now.getMonth() + 1-3;    //1?????? 0?????? ??????????????? +1??? ???.
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
		        var month = now.getMonth() + 1;    //1?????? 0?????? ??????????????? +1??? ???.
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
		    var month = now.getMonth() + 1;    //1?????? 0?????? ??????????????? +1??? ???.
		    var date = now.getDate();  

		    if((month + "").length < 2){        //2????????? ????????? 0??? ?????????.
		        month = "0" + month;
		    }else{
		         // ""??? ?????? year + month (??????+??????) ???.. ex) 2018 + 12 = 2030??? ?????????.
		        month = "" + month;   
		    }
		    if((date + "").length < 2){        //2????????? ????????? 0??? ?????????.
		    	date = "0" + date;
		    }else{
		         // ""??? ?????? year + month (??????+??????) ???.. ex) 2018 + 12 = 2030??? ?????????.
		        date = "" + date;   
		    }
		    
		    return today = year+"-"+ month+"-"+ date; 
		}
	
	
	
	 
	</script>
	
	



</body>
</html>






