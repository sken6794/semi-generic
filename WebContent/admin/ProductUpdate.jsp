<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"><!-- 아이콘 -->
<link rel="stylesheet" href="css/AdminStyle.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<link href="./dist/summernote.css" rel="stylesheet">
<script src="./dist/summernote.js"></script>

<script type="text/javascript">
        
function sendFile(file, editor) {
    // 파일 전송을 위한 폼생성
		data = new FormData();
	    data.append("uploadFile", file);
	    $.ajax({ // ajax를 통해 파일 업로드 처리
	        data : data,
	        type : "POST",
	        url : "./upload.do",
	        cache : false,
	        contentType : false,
	        processData : false,
	        success : function(data) { // 처리가 성공할 경우
            // 에디터에 이미지 출력
	        	$(editor).summernote('editor.insertImage', data.url);
	        }
	    });
	}
	</script>


<style>
.inputArea {
	margin: 10px 0;
}

select {
	width: 100px;
}

label {
	display: inline-block;
	width: 70px;
	padding: 5px;
}

label[for='gdsDes'] {
	display: block;
}

input {
	width: 150px;
}

textarea#gdsDes {
	width: 400px;
	height: 180px;
}
</style>
<%
	int pid = Integer.parseInt(request.getParameter("pid"));
	ProductDTO product = ProductDAO.getDAO().selectIdProduct(pid);

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
			<h2><b>상품변경</b></h2>
				<!-- Page Heading -->
				<div class="row" id="main">
					
	
						<table class="table table-condensed">	
						<form role="form" action="ProductUpdateAction.jsp" method="post" enctype="multipart/form-data" id="updateForm">
						<input type="hidden" value="<%=product.getCtno()%>" name="ctno">
						<input type="hidden" value="<%=pid%>" name="pid"> 
							<tr>
							<td>
							<label>분류</label> 
								<select class="category1" name="pct" id="pctOption">
									<option value="20">선글라스</option>
									<option value="10">안경</option>
								</select>
							   	</td>
						</tr>

						<tr>
						<td>
							<label for="productName">상품명</label> <input type="text" id="productName"
								name="pname" value="<%=product.getPname()%>"/>
							<label for="productName">색상</label> <input type="text" id="productName"
								name="pcolor"  value="<%=product.getPcolor()%>"/>	
						</td>
						</tr>
						<tr>
						<td>
							<label for="price">상품가격</label> <input type="text"
								id="price" name="pprice" value="<%=product.getPprice()%>"/>
								</td>
						</tr>

						<tr>
						<td>
							<label for="stock">상품수량</label> <input type="text"
								id="stock" name="pstock" value="<%=product.getPstock()%>" />
						</td>		
						</tr>

						<tr>
						<td>
							<label for="description">상품소개</label>
							
							<textarea id="summernote" name="pcontent" ><%=product.getPcontent() %></textarea>
							
					       		<script>
           							 $(document).ready(function() {
              						 $('#summernote').summernote({ // summernote를 사용하기 위한 선언
                   					 height: 400,
									 callbacks: { // 콜백을 사용
                        // 이미지를 업로드할 경우 이벤트를 발생
					    				onImageUpload: function(files, editor, welEditable) {
						  				  sendFile(files[0], this);
										}
									}
								});
							});
		</script>
							
							</td>
						</tr>
						
						<tr>
						<td>
							<label for="img">이미지1</label>
							<input type="file" id="img1" name="img1"/>
							<input type="hidden" name="currentImg1" value="<%=product.getPimg1() %>">
							<div class="select_img1">
								<img src="<%=request.getContextPath()%>/images/<%=product.getPimg1() %>" style="height: 200px;"/>
								 <script>
								 $("#img1").change(function(){
  									 if(this.files && this.files[0]) {
  										 
    									var reader = new FileReader;
    									reader.onload = function(data) {
     									$(".select_img1 img").attr("src", data.target.result).width(150);        
    									}
    								reader.readAsDataURL(this.files[0]);
   									}
 									 });
									
									</script>
								
							</div>
							</td>
						</tr>
						<tr>
						<td>
							<label for="img">이미지2</label>
							<input type="hidden" name="currentImg2" value="<%=product.getPimg2() %>">
							<input type="file" id="img2" name="img2"/>
							<div class="select_img2">
							
								<img src="<%=request.getContextPath()%>/images/<%=product.getPimg2() %>" style="height: 200px;"/>
								 <script>
								 $("#img2").change(function(){
									 
  									 if(this.files && this.files[0]) {
  										
    									var reader = new FileReader;
    									reader.onload = function(data) {
     									$(".select_img2 img").attr("src", data.target.result).width(150);        
    									}
    								reader.readAsDataURL(this.files[0]);
   									}
 									 });
									
									</script>
							</div>
							</td>
						</tr>
						<tr>
						<td>
							<label for="img">이미지3</label>
							<input type="file" id="img3" name="img3"/>
							<input type="hidden" name="currentImg3" value="<%=product.getPimg3() %>">
							<div class="select_img3">
							
								<img src="<%=request.getContextPath()%>/images/<%=product.getPimg3() %>" style="height: 200px;"/>
								 <script>
								 $("#img3").change(function(){
									 
  									 if(this.files && this.files[0]) {
  										
    									var reader = new FileReader;
    									reader.onload = function(data) {
     									$(".select_img3 img").attr("src", data.target.result).width(150);        
    									}
    								reader.readAsDataURL(this.files[0]);
   									}
 									 });
									
									</script>
							</div>
							</td>
						</tr>
						<tr>
						<td>
							<label for="img">이미지4</label>
							<input type="file" id="img4" name="img4"/>
							<input type="hidden" name="currentImg4" value="<%=product.getPimg4() %>">
							<div class="select_img4">
							
								<img src="<%=request.getContextPath()%>/images/<%=product.getPimg4() %>" style="height: 200px;"/>
								 <script>
								 $("#img4").change(function(){
									 
  									 if(this.files && this.files[0]) {
  										
    									var reader = new FileReader;
    									reader.onload = function(data) {
     									$(".select_img4 img").attr("src", data.target.result).width(150);        
    									}
    								reader.readAsDataURL(this.files[0]);
   									}
 									 });
									
									</script>
							</div>
							</td>
						</tr>

						<tr>
						<td>
							<button type="submit" id="update_Btn" class="btn btn-primary">변경</button>
							<button type="button" id="delete_Btn" class="btn btn-primary">삭제</button>
							</td>
						</tr>
						</form>
					</table>
					
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->

	 <script type="text/javascript">
	$("#delete_Btn").click(function() {
		location.href ="DeleteProductAction.jsp?pid="+<%=request.getParameter("pid")%>;
	})
	 
	 var ctno = <%=product.getCtno()%>
	 
	 $("#pctOption option").each(function() {
	 	if($(this).val()==ctno){
	 		$(this).prop("selected","selected");
	 	}
	 })
	 </script> 
	<script src="http://bootstrapk.com/dist/js/bootstrap.min.js"></script> 
	


</body>
</html>