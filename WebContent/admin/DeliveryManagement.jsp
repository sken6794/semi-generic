
<%@page import="generic.dto.MemberDTO"%>
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

MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
if(loginMember==null){
	response.sendRedirect(request.getContextPath()+"/member/login.jsp");
}else{
	if(loginMember.getMstatus()!=0){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
	}
}


String[] deliveryState = {"배송준비중", "배송중", "배송완료"};
int[] state = OrderDAO.getDAO().getOrderState();

DecimalFormat df=new DecimalFormat("#,###");

DeliveryManagementSearchCriteria dmsc = new DeliveryManagementSearchCriteria();
ArrayList<OrderProductDTO> list = null;
int num;
if (request.getParameter("num") == null) {
	num = 1;
} else {
	num = Integer.parseInt(request.getParameter("num"));
}

if (request.getParameter("deliverySearchKeywrod") != null) {
	System.out.println("검색어 있음");
	dmsc.setNum(num);
	dmsc.setDeliverySearchType(request.getParameter("deliverySearchType"));
	dmsc.setDeliverySearchKeywrod(request.getParameter("deliverySearchKeywrod"));
	dmsc.setDeliveryDateStart(request.getParameter("deliveryDateStart"));
	dmsc.setDeliveryDateEnd(request.getParameter("deliveryDateEnd"));
	System.out.println("게시물 총개수" + OrderDAO.getDAO().totCount(request.getParameter("deliverySearchType"),
	request.getParameter("deliverySearchKeywrod")));
	dmsc.setCount(OrderDAO.getDAO().totCount(request.getParameter("deliverySearchType"),
	request.getParameter("deliverySearchKeywrod")));
	list = OrderDAO.getDAO().getDeliveryList(dmsc);

} else {
	System.out.println("검색어 없음");
	dmsc.setNum(num);
	dmsc.setCount(OrderDAO.getDAO().totCount("", ""));
	list = OrderDAO.getDAO().getDeliveryList(dmsc);
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
					<b>배송관리</b>
				</h2>
				<!-- Page Heading -->
				<div class="row" id="main">
					<div class="col-md-4 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="panel-left pull-left">
									<i class="glyphicon glyphicon-inbox fa-5x"></i>

								</div>
								<div class="panel-right pull-right">
									<h3><%=state[0]%></h3>
									<strong>배송준비중</strong>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-4 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="panel-left pull-left blue">
									<i class="glyphicon glyphicon-road fa-5x"></i>
								</div>

								<div class="panel-right pull-right">
									<h3><%=state[1]%></h3>
									<strong> 배송중</strong>

								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-body">

								<div class="panel-left pull-left red">
									<i class="glyphicon glyphicon-home fa-5x"></i>

								</div>
								<div class="panel-right pull-right">
									<h3><%=state[2]%></h3>
									<strong> 배송완료 </strong>

								</div>
							</div>
						</div>

					</div>
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-body">
								<form action="DeliveryManagementAction.jsp" method="post">
									<table class="table table-condensed">
										<tr>
											<th style="background-color: #eeeeee;">검색분류</th>

											<td><select class="form-control"
												name="deliverySearchType">
													<option value="주문번호">주문번호</option>
													<option value="주문자아이디">주문자아이디</option>
													<option value="주문자명">주문자명</option>
													<option value="주문자휴대전화">주문자휴대전화</option>
											</select></td>
											<td colspan="2"><input class="form-control" type="text"
												value="" name="deliverySearchKeywrod"
												placeholder="검색어를 입력하세요" /></td>
										</tr>
										<tr>
											<th style="background-color: #eeeeee;">기간</th>

											<td><select class="form-control">
													<option value="">주문일</option>

											</select></td>
											<td>
												<div class="btn-group btn-group-toggle "
													data-toggle="buttons">
													<label class="btn date" role="button" class="radio-value">
														<input type="radio" name="options" value="0">전체
													</label> <label class="btn active" role="button"> <input
														type="radio" name="options" value="1" required>오늘
													</label> <label class="btn date" role="button"> <input
														type="radio" name="options" value="3">3일
													</label> <label class="btn date" role="button"> <input
														type="radio" name="options" value="7">7일
													</label> <label class="btn date" role="button"> <input
														type="radio" name="options" value="30">1개월
													</label> <label class="btn date" role="button"> <input
														type="radio" name="options" value="90">3개월
													</label> <label class="btn date" role="button" class="radio-value">
														<input type="radio" name="options" value="365">1년
													</label>


												</div>





											</td>
											<td><input type="date" id="date1"
												name="deliveryDateStart" value="">~<input
												type="date" id="date2" name="deliveryDateEnd" value="">
											</td>

										</tr>



										<tr>
											<td><button class="btn btn-primary">검색</button></td>
										</tr>

									</table>
							</div>
						</div>
					</div>

					<div class="col-md-12">
						<div class="panel panel-default">



							<div class="panel-body">
								<form action="ModifyDeliveryState.jsp" method="post" id="form">
									<table id="news" class="table table-striped table-responsive">
										<thead>
											<tr>
												<th style="background-color: #eeeeee;">주문일</th>
												<th style="background-color: #eeeeee;">주문번호</th>
												<th style="background-color: #eeeeee;">준문자</th>
												<th style="background-color: #eeeeee;">상품명</th>
												<th style="background-color: #eeeeee;">결제금액</th>
												<th style="background-color: #eeeeee;">배송상태</th>
												<th style="background-color: #eeeeee;">주소</th>
												<th style="background-color: #eeeeee;">요청사항</th>


											</tr>
										</thead>
										<tbody>

											<%
												for (int i = 0; i < list.size(); i++) {
											%>
											<tr>
												<td><%=list.get(i).getOrder().getOdate().substring(0, 10)%></td>
												<td><%=list.get(i).getOrder().getOno()%></td>
												<td><%=list.get(i).getOrder().getOname()%></td>
												<td><%=list.get(i).getProduct().getPname()%></td>
												<td><%=df.format(list.get(i).getProduct().getPprice())%>원</td>
												<td>

													<div class="btn-group btn-group-toggle "
														data-toggle="buttons">

														<label class="btn state" role="button"
															name="<%=list.get(i).getOrder().getOno()%>"
															id="state<%=i + 100%>">배송준비중</label> <label
															class="btn state" role="button"
															name="<%=list.get(i).getOrder().getOno()%>"
															id="state<%=i + 200%>">배송중</label> <label class="btn state"
															role="button" name="<%=list.get(i).getOrder().getOno()%>"
															id="state<%=i + 300%>">배송완료</label>


														<%
															if (list.get(i).getOrder().getOstate().equals(deliveryState[0])) {
														%>

														<script type="text/javascript">
														$("#state<%=i + 100%>").attr('class','btn active');
													</script>
														<%
															}
														%>

														<%
															if (list.get(i).getOrder().getOstate().equals(deliveryState[1])) {
														%>
														<script type="text/javascript">
														$("#state<%=i + 200%>").attr('class','btn active');
													</script>
														<%
															}
														%>

														<%
															if (list.get(i).getOrder().getOstate().equals(deliveryState[2])) {
														%>
														<script type="text/javascript">
														$("#state<%=i + 300%>").attr('class','btn active');
														</script>
														<%
															}
														%>

													</div>

												</td>
												<td><%=list.get(i).getOrder().getOaddress()%> <%=list.get(i).getOrder().getOaddress2()%>
													<%=list.get(i).getOrder().getOaddress3()%></td>
												<td><%=list.get(i).getOrder().getOrequire()%></td>
											</tr>
											<%
												}
											%>



										</tbody>

									</table>
								</form>
								<div class="text-center">
									<ul class="pagination">
										<%
											if (dmsc.getPrev()) {
										%>
										<li><a
											href="DeliveryManagement.jsp?num=<%=dmsc.getStartPageNum() - 1%>">이전</a></li>
										<%
											}
										%>
										<%
											for (int i = dmsc.getStartPageNum(); i <= dmsc.getEndPageNum(); i++) {
										%>
										<li><a
											href="DeliveryManagement.jsp?num=<%=i%>
									&deliverySearchType=<%=dmsc.getDeliverySearchType()%>
									&deliverySearchKeywrod=<%=dmsc.getDeliverySearchKeywrod()%>
									&deliveryDateStart=<%=dmsc.getDeliveryDateStart()%>
									&deliveryDateEnd=<%=dmsc.getDeliveryDateEnd()%>"><%=i%></a></li>
										<%
											}
										%>
										<%
											if (dmsc.getNext()) {
										%>
										<li><a
											href="DeliveryManagement.jsp?num=<%=dmsc.getEndPageNum() + 1%>">다음</a></li>
										<%
											}
										System.out.println(dmsc.getEndPageNum() + 1);
										%>
									</ul>

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
		$(".state").click(
				function() {
					//alert($(this).attr('name')+" - "+$(this).text());

					location.href = "ModifyDeliveryState.jsp?num="+<%=num%>+"&ono="
							+ $(this).attr('name') + "&options="
							+ $(this).text();

				});

		$("div[data-toggle=buttons]").change(function() {
			var value = $(this).find("input[type=radio]:checked").val();
			
			
			var today = getToday();
			//alert(today);
			var arr1 = today.split("-");
			var date1 = new Date(arr1[0], arr1[1], arr1[2]);
			if(value==0){
				$("#date1").attr('value', "");
				$("#date2").attr('value', "");
			}
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