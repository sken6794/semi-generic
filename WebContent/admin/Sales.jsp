
<%@page import="java.text.DecimalFormat"%>
<%@page import="generic.dao.OrderDAO"%>
<%@page import="generic.dto.OrderProductDTO"%>
<%@page import="generic.page.DeliveryManagementSearchCriteria"%>
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
DecimalFormat df=new DecimalFormat("#,###");
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
					<b>매출분석</b>
				</h2>
				<!-- Page Heading -->
				<div class="row" id="main">
					<div class="col-md-4 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="panel-left pull-left">
									<i class="glyphicon glyphicon-signal fa-5x"></i>

								</div>
								<div class="panel-right pull-right">
								
									<h3><%=df.format(OrderDAO.getDAO().getTodaySales())%>원</h3>
									<strong>당일매출</strong>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-4 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="panel-left pull-left blue">
									<i class="glyphicon glyphicon-signal fa-5x"></i>
								</div>

								<div class="panel-right pull-right">
									<h3><%=df.format(OrderDAO.getDAO().getMonthSales())%>원</h3>
									<strong> 당월매출</strong>

								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">

								<div class="panel-left pull-left red">
									<i class="glyphicon glyphicon-signal fa-5x"></i>

								</div>
								<div class="panel-right pull-right">
									<h3><%=df.format(OrderDAO.getDAO().getYearSales())%>원</h3>
									<strong> 당연도매출 </strong>

								</div>
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


	<script type="text/javascript"
		src="http://code.jquery.com/jquery-2.1.4.min.js"></script>



	<script src="http://bootstrapk.com/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		

		$("div[data-toggle=buttons]").change(function() {
			var value = $(this).find("input[type=radio]:checked").val();
			//alert(value);
			var today = getToday();
			var arr1 = today.split("-");
			var date1 = new Date(arr1[0], arr1[1], arr1[2]);

			if (value == 1) {
				$("#date1").attr('value', today);
				$("#date2").attr('value', today);
			}
			if (value == 3) {
				//console.log("인터발: " + date1.getFullYear() +"-"+date1.getMonth()+"-"+(date1.getDate()-3)); 
				var now = new Date();
				var year = now.getFullYear();
				var month = now.getMonth() + 1; //1월이 0으로 되기때문에 +1을 함.
				var date = now.getDate() - value;
				if ((month + "").length < 2) {
					month = "0" + month;
				} else {
					month = "" + month;
				}
				if ((date + "").length < 2) {
					date = "0" + date;
				} else {
					date = "" + date;
				}
				var endDate = year + "-" + month + "-" + date;
				$("#date1").attr('value', endDate);
				$("#date2").attr('value', today);
			}
			if (value == 7) {
				var now = new Date();
				var year = now.getFullYear();
				var month = now.getMonth() + 1; //1월이 0으로 되기때문에 +1을 함.
				var date = now.getDate() - value;
				if (date < 0) {
					var i = Math.abs(date);

					month = now.getMonth();
					var lastDay = (new Date(year, month, 0)).getDate();
					date = lastDay - i;
					//alert(date);
				}
				if ((month + "").length < 2) {
					month = "0" + month;
				} else {
					month = "" + month;
				}
				if ((date + "").length < 2) {
					date = "0" + date;
				} else {
					date = "" + date;
				}
				var endDate = year + "-" + month + "-" + date;
				$("#date1").attr('value', endDate);
				$("#date2").attr('value', today);
			}
			if (value == 30) {
				var now = new Date();
				var year = now.getFullYear();
				var month = now.getMonth() + 1 - 1; //1월이 0으로 되기때문에 +1을 함.
				var date = now.getDate()
				if ((month + "").length < 2) {
					month = "0" + month;
				} else {
					month = "" + month;
				}
				if ((date + "").length < 2) {
					date = "0" + date;
				} else {
					date = "" + date;
				}
				var endDate = year + "-" + month + "-" + date;

				$("#date1").attr('value', endDate);
				$("#date2").attr('value', today);
			}
			if (value == 90) {
				var now = new Date();
				var year = now.getFullYear();
				var month = now.getMonth() + 1 - 3; //1월이 0으로 되기때문에 +1을 함.
				var date = now.getDate()
				if ((month + "").length < 2) {
					month = "0" + month;
				} else {
					month = "" + month;
				}
				if ((date + "").length < 2) {
					date = "0" + date;
				} else {
					date = "" + date;
				}
				var endDate = year + "-" + month + "-" + date;

				$("#date1").attr('value', endDate);
				$("#date2").attr('value', today);
			}
			if (value == 365) {
				var now = new Date();
				var year = now.getFullYear() - 1;
				var month = now.getMonth() + 1; //1월이 0으로 되기때문에 +1을 함.
				var date = now.getDate()
				if ((month + "").length < 2) {
					month = "0" + month;
				} else {
					month = "" + month;
				}
				if ((date + "").length < 2) {
					date = "0" + date;
				} else {
					date = "" + date;
				}
				var endDate = year + "-" + month + "-" + date;

				$("#date1").attr('value', endDate);
				$("#date2").attr('value', today);
			}

			//alert(date);

		});
		function getToday() {
			var now = new Date();
			var year = now.getFullYear();
			var month = now.getMonth() + 1; //1월이 0으로 되기때문에 +1을 함.
			var date = now.getDate();

			if ((month + "").length < 2) { //2자리가 아니면 0을 붙여줌.
				month = "0" + month;
			} else {
				// ""을 빼면 year + month (숫자+숫자) 됨.. ex) 2018 + 12 = 2030이 리턴됨.
				month = "" + month;
			}
			if ((date + "").length < 2) { //2자리가 아니면 0을 붙여줌.
				date = "0" + date;
			} else {
				// ""을 빼면 year + month (숫자+숫자) 됨.. ex) 2018 + 12 = 2030이 리턴됨.
				date = "" + date;
			}

			return today = year + "-" + month + "-" + date;
		}

		/*$(".ing").click(function() {
			  $(this).attr('value','배송중');
			  $("#form").submit();
		  });*/
	</script>


</body>
</html>