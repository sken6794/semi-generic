<%@page import="generic.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>
<%@include file="/security/login_check.jspf" %>    
	<form id="modify" name="joinForm" action="<%=request.getContextPath() %>/member/info_action.jsp" method="post">
	<div class="site-section">
	<div class="row mb-5"></div>
		<div class="container">
		<h2 class="h3 text-black" style="text-align: center;">회원정보</h2>
		<hr>
			<div class="row">
			<div class="col-md-9 offset-md-3">
					<div class="p-6 p-sm-6 border-light">
					
						<div class="form-group row">  
			
							<div class="col-md-8" >
									<label for="mname" class="text-black"><span	class="text-danger">*</span>이름</label>
									<span><input type="text" class="form-control" id="mname" name="mname" value="<%=loginMember.getMname() %>" readonly="readonly"></span>
									<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-8">
								<label for="mid" class="text-black"><span	class="text-danger">*</span>아이디</label> 
									<input type="text"	class="form-control" id="mid" name="mid" placeholder="아이디 입력" value="<%=loginMember.getMid() %>" readonly="readonly">
									<span id="idMsg" class="error">아이디를 입력해주세요.</span>
									<span id="idRegMsg" class="error">영문자,숫자 조합으로 5~19 범위로만 작성가능합니다</span>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-8">
								<label for="c_companyname" class="text-black"><span	class="text-danger">*</span>패스워드&nbsp;&nbsp;</label> 
									<input type="password"	class="form-control" id="mpw_1" name="mpw_1" placeholder="패스워드 입력" value="">
									<div id="passwdMsg" class="error">패스워드를 입력해주세요.</div>
									<span style="color: red;">패스워드 변경시에만 입력하세요.</span>
									<span id="passwdRegMsg" class="error">영문,숫자,특문포함 6~20 범위로 작성</span>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-8">
								<label for="c_companyname" class="text-black"><span class="text-danger">*</span>패스워드 확인&nbsp;&nbsp;</label> 
									<input type="password"	class="form-control" id="mpw_2" name="mpw_2" placeholder="패스워드 입력" value="">
									<div id="repasswdMsg" class="error">패스워드 확인을 입력해주세요.</div>
									<div id="repasswdMatchMsg" class="error">패스워드 비밀번호 확인이 서로 맞지 않습니다.</div>
							</div>
						</div>
						 <div class="form-group row">
						              <div class="col-md-8">
						                <label for="c_companyname" class="text-black"><span class="text-danger">*</span>전화번호&nbsp;&nbsp;</label>
						                <div class="col-xs-1 form-inline">
						            <% String[] mobile=loginMember.getMphone().split("-"); %>
									
									<select name="mobile1" class="form-control">
										<option value="010" <% if(mobile[0].equals("010")) { %> selected <% } %>>&nbsp;010&nbsp;</option>
										<option value="011" <% if(mobile[0].equals("011")) { %> selected <% } %>>&nbsp;011&nbsp;</option>
										<option value="016" <% if(mobile[0].equals("016")) { %> selected <% } %>>&nbsp;016&nbsp;</option>
										<option value="017" <% if(mobile[0].equals("017")) { %> selected <% } %>>&nbsp;017&nbsp;</option>
										<option value="018" <% if(mobile[0].equals("018")) { %> selected <% } %>>&nbsp;018&nbsp;</option>
										<option value="019" <% if(mobile[0].equals("019")) { %> selected <% } %>>&nbsp;019&nbsp;</option>
									</select>
									&nbsp;&nbsp;-&nbsp;&nbsp; <input type="text" class="form-control" name="mobile2" id="mobile2" size="4" maxlength="4" value="<%=mobile[1]%>">
									&nbsp;&nbsp;-&nbsp;&nbsp; <input type="text" class="form-control" name="mobile3" id="mobile3" size="4" maxlength="4" value="<%=mobile[2]%>">
						          </div>    
									<div id="mobileMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
									<div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
						        </div>
						   </div>
						<div class="form-group row">
							<div class="col-md-8">
								<label for="c_companyname" class="text-black"><span class="text-danger">*</span>이메일&nbsp;&nbsp;</label> 
									<input type="email"	class="form-control" id="memail" name="memail"	placeholder="이메일 입력" value="<%=loginMember.getMemail() %>">
									<div id="emailMsg" class="error">이메일을 입력해주세요.</div>
									<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
							</div>
						</div>
						<div class="form-group row"  style="margin-bottom: -1px;">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="c_companyname" class="text-black"><span	class="text-danger">*</span>우편번호&nbsp;&nbsp;</label> 
						</div>
						<div class="form-group row">
							<div class="col-md-6">
								<input type="text"	class="form-control" id="maddress1" name="maddress1" placeholder="우편번호 입력" readonly="readonly" value="<%=loginMember.getMaddress1() %>"> 
							</div>
							<div class="col-md-2">
								<input	type="button" class="btn btn-outline-dark btn-sm btn-block"	style="height: 38px;" id="postSearch" onClick="daum.Postcode();" value="주소 찾기" />
							</div>
						</div>

						<div class="form-group row">
							<div class="col-md-8">
								<label for="c_address" class="text-black"><span class="text-danger">*</span>기본주소&nbsp;&nbsp;</label> 
									<input type="text" class="form-control" id="maddress2" name="maddress2"	placeholder="기본주소를 입력해주세요." readonly="readonly" value="<%=loginMember.getMaddress2() %>">
									<div id="addMsg" class="error">기본주소를 입력해주세요.</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-8">
								<label for="c_address" class="text-black"><span class="text-danger">*</span>상세주소&nbsp;&nbsp;</label> 
									<input type="text" class="form-control" id="maddress3" name="maddress3"	placeholder="상세주소를 입력해주세요." value="<%=loginMember.getMaddress3() %>">
									<div id="D_addMsg" class="error">상세주소를 입력해주세요.</div>
							</div>
						</div>
						<div class="row">
			              <div class="col-md-8" style="text-align: center;" >
						<div class="row mb-1"></div>
			              &nbsp;<a class="btn btn-outline-dark btn-md" id="withdraw_btn" href="<%=request.getContextPath() %>/order/orderList.jsp">주문내역</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			              <button type="submit" class="btn btn-outline-dark btn-md" >정보 수정</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			              <a class="btn btn-outline-dark btn-md" id="withdraw_btn" href="<%=request.getContextPath() %>/member/remove_confirm.jsp">회원 탈퇴</a>
			              </div>
			            </div>
					</div>
				</div>		
			</div>				
		</div>
	</div> 
</form>
	<script type="text/javascript">
	$("#modify").submit(function() {
		var submitResult=true;
		
		$(".error").css("display","none");
	
		var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
		if($("#mpw_1").val()!="" && !passwdReg.test($("#mpw_2").val())) {
			$("#passwdRegMsg").css("display","block");
			submitResult=false;
		} 
		
		if($("#mpw_2").val()=="" && $("#mpw_1").val()!=$("#mpw_2").val()) {
			$("#repasswdMatchMsg").css("display","block");
			submitResult=false;
		}
	
		var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
		if($("#memail").val()=="") {
			$("#emailMsg").css("display","block");
			submitResult=false;
		} else if(!emailReg.test($("#memail").val())) {
			$("#emailRegMsg").css("display","block");
			submitResult=false;
		}
	
		var mobile2Reg=/\d{3,4}/;
		var mobile3Reg=/\d{4}/;
		if($("#mobile2").val()=="" || $("#mobile3").val()=="") {
			$("#mobileMsg").css("display","block");
			submitResult=false;
		} else if(!mobile2Reg.test($("#mobile2").val()) || !mobile3Reg.test($("#mobile3").val())) {
			$("#mobileRegMsg").css("display","block");
			submitResult=false;
		}
		
		if($("#maddress1").val()=="") {
			$("#addMsg").css("display","block");
			submitResult=false;
		}
		
		if($("#maddress3").val()=="") {
			$("#D_addMsg").css("display","block");
			submitResult=false;
		}
		
		if(submitResult==true) {
			//swal("Good job!", "You clicked the button!", "success");
			//swal("정보가 변경되었습니다.","변경된 정보를 확인해주세요.");
			alert("정보가 변경되었습니다. 변경된 정보를 확인해주세요.");
		} 

		
		return submitResult;
	});
	</script>
	
	<script	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	$("#postSearch").click(function() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
          document.getElementById('maddress1').value = data.zonecode; //5자리 새우편번호 사용
          document.getElementById('maddress2').value = data.roadAddress;
          document.getElementById('maddress3').focus();
        	}
    	}).open();
	});
	</script>

<jsp:include page="/footer.jsp"/>
   