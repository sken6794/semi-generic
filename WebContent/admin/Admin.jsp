<%@page import="generic.dao.OrderDAO"%>
<%@page import="generic.visit.VisitDAO"%>
<%@page import="generic.dao.MemberDAO"%>
<%@page import="generic.dto.MemberDTO"%>
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
<script type="text/javascript">

$(document).ready(function() {
    var queryObject = "";
    var queryObjectLen = "";
    $.ajax({
        type : 'POST',
        url : 'ChartData.jsp',
        dataType : 'json',
        success : function(data) {
        	//alert("success");
            
            queryObject = eval('(' + JSON.stringify(data,null, 2) + ')');             
            
            // eval: javascript 코드가 맞는지 검증하고 문자열을 자바스크립트 코드로 처리하는 함수 
          
 
            queryObjectLen = queryObject.chartdata.length;
            queryObjectLen1 = queryObject.visitdata.length;
            //alert(queryObjectLen1);
            
 			
          
            var ctx = document.getElementById('myChart').getContext('2d');
            var ctx1 = document.getElementById('myChart1').getContext('2d');
            var count =[];
            var hour =[];
            
            var visitdatacount =[];
            var visitdathour =[];
            for(var i=0;i<queryObjectLen;i++){
            	count.push(queryObject.chartdata[i].count);
            	hour.push(queryObject.chartdata[i].hour+"시");
            	
            }
            for(var i=0;i<queryObjectLen1;i++){
            	visitdatacount.push(queryObject.visitdata[i].count);
            	visitdathour.push(queryObject.visitdata[i].hour+"시");
            	
            }
          // alert(score);
    		
    		var chart = new Chart(ctx, {
    			type : 'line',
    			data : {
    				labels : hour
    					,
    					
    				datasets : [ {
    					label : '주문수',
    					backgroundColor : 'transparent',
    					borderColor : 'red',
    					data : count
    				
    				}]
    			},

    			options : {}
    		});
    		
    		var chart = new Chart(ctx1, {
    			type : 'line',
    			data : {
    				labels : visitdathour
    					,
    					
    				datasets : [{
    					label : '방문자수',
    					backgroundColor : 'transparent',
    					borderColor : 'blue',
    					data : visitdatacount
    				} ]
    			},

    			options : {}
    		});
        },
        error : function(xhr, type) {
            alert('server error occoured')
        }
    });
}); 
</script>
<%
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
    if(loginMember==null){
    	response.sendRedirect(request.getContextPath()+"/member/login.jsp");
    }else{
    	if(loginMember.getMstatus()!=0){
    		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
    	}
    }
    
    int todayQboard = VisitDAO.getDAO().getTodayQboard();
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
				<!-- Page Heading -->
				<div class="row" id="main">
					<div class="col-md-3 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="panel-left pull-left">
									<i class="fa fa-bar-chart-o fa-5x"></i>

								</div>
								<div class="panel-right pull-right">
									<h3><%=VisitDAO.getDAO().getTodayCount()%></h3>
									<strong>오늘 방문자수</strong>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-3 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="panel-left pull-left blue">
									<i class="fa fa-shopping-cart fa-5x"></i>
								</div>

								<div class="panel-right pull-right">
									<h3><%=OrderDAO.getDAO().getTodayCnt() %></h3>
									<strong> 당일판매량</strong>

								</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">

								<div class="panel-left pull-left red">
									<i class="fa fa fa-comments fa-5x"></i>

								</div>
								<div class="panel-right pull-right">
									<h3><%=todayQboard %></h3>
									<strong> 당일문의 </strong>

								</div>
							</div>
						</div>

					</div>
					<div class="col-md-3 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">

								<div class="panel-left pull-left brown">
									<i class="fa fa-users fa-5x"></i>

								</div>
								<div class="panel-right pull-right">
									<h3><%=MemberDAO.getDAO().getMemeberCount() %></h3>
									<strong>회원수</strong>

								</div>

							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">
								<b>주문수</b>
							</div>
							<div class="panel-body" >
								<canvas id="myChart" height="300"></canvas>



							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">
								<b>방문자수</b>
							</div>
							<div class="panel-body" >
								<canvas id="myChart1"height="300"></canvas>



							</div>
						</div>
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
	<script>
		
	</script>




	<script type="text/javascript"
		src="http://code.jquery.com/jquery-2.1.4.min.js"></script>



	<script src="http://bootstrapk.com/dist/js/bootstrap.min.js"></script>


</body>
</html>