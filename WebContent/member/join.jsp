<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/header.jsp"/>
	<div class="site-section">
	<div class="row mb-5"></div>
		<div class="container">
		<h2 class="h3 text-black" style="text-align: center;">회원가입</h2>
		<hr>
		<form id="join" name="joinForm" action="<%=request.getContextPath() %>/member/join_action.jsp" method="post">
			<input type="hidden" name="idCheckResult" id="idCheckResult" value="0">
			<div class="row">
			<div class="col-md-9 offset-md-3">
			
					<div class="p-6 p-sm-6 border-light">
						<div class="form-group row">
							<div class="col-md-8" >
									<label for="c_companyname" class="text-black"><span	class="text-danger">*</span>이름</label>
									<span><input type="text" class="form-control" id="mname" name="mname"	placeholder="이름 입력" value=""></span>
									<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
									<div id="nameKorMsg" class="error">2~7자 이내의 한글로만 작성.</div>
							</div>
						</div>
					<div class="form-group row" style="margin-top: -1px;">
							<div class="col-md-8" >
									<label for="c_companyname" class="text-black"><span	class="text-danger">*</span>성별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				              <label for="" class="join_label"><input type="radio" class="male" id="male" checked="checked" name="mgender" value="1">남성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				              <label for="" class="join_label"><input type="radio" class="female" id="female" name="mgender" value="2">여성</label>
									<div id="genderMsg" class="error">성별을 선택해주세요.</div>
							</div> 							
						</div>
						
					<div class="form-group row" style="margin-bottom: -1px; margin-top: -4px;">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="mid" class="text-black"><span class="text-danger">*</span>아이디</label> 
					</div>
						<div class="form-group row" style="margin-bottom: -1px;">							
							<div class="col-md-6">							
								<input type="text"	class="form-control" id="mid" name="mid" placeholder="아이디 입력" value="">
							</div>								
							<div class="col-md-2">
								<input type="button" class="btn btn-outline-dark btn-sm btn-block"	style="height: 38px;" id="idCheck"  value="중복체크" />
							</div>
						</div>	
											
						<div class="form-group row">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="idMsg" class="error">아이디를 입력해주세요.</span>
							<span id="idRegMsg" class="error">영문자,숫자 조합으로 5~19 범위로만 작성가능합니다</span>
							<div id="idCheckMsg" class="error">아이디 중복 검사를 실행해 주세요.
						</div>
						</div>
						
						<div class="form-group row">
							<div class="col-md-8">
								<label for="c_companyname" class="text-black"><span	class="text-danger">*</span>패스워드&nbsp;&nbsp;</label> 
									<input type="password"	class="form-control" id="mpw_1" name="mpw_1" placeholder="패스워드 입력" value="">
									<div id="passwdMsg" class="error">패스워드를 입력해주세요.</div>
									<span id="passwdRegMsg" class="error">영문,숫자,특문포함 6~20 범위로 작성</span>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-8">
								<label for="c_companyname" class="text-black"><span class="text-danger">*</span>패스워드 확인&nbsp;&nbsp;</label> 
									<input type="password"	class="form-control" id="mpw_2" name="mpw_2" placeholder="패스워드 입력" value="">
									<div id="repasswdMsg" class="error">패스워드를 입력해주세요.</div>
									<div id="repasswdMatchMsg" class="error">위 패스워드와 다르게 입력하였습니다.</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-12 ">
								<label for="c_companyname" class="text-black"><span class="text-danger">*</span>전화번호&nbsp;&nbsp;</label> 
									<div class="col-xs-1 form-inline">
									<select name="mphone1" class="form-control"> 
										<option value="010" selected>&nbsp;010&nbsp;</option>
										<option value="011">&nbsp;011&nbsp;</option>
										<option value="016">&nbsp;016&nbsp;</option>
										<option value="017">&nbsp;017&nbsp;</option>
										<option value="018">&nbsp;018&nbsp;</option>
										<option value="019">&nbsp;019&nbsp;</option>
									</select>
									&nbsp;-&nbsp;<input type="text" class="form-control" name="mphone2" id="mphone2" size="4" maxlength="4">
									&nbsp;-&nbsp;<input type="text" class="form-control" name="mphone3" id="mphone3" size="4" maxlength="4">
									</div>
									<div id="mobileMsg" class="error">전화번호를 입력해 입력해주세요.</div>
									<div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-8 ">
								<label for="c_companyname" class="text-black"><span class="text-danger">*</span>이메일&nbsp;&nbsp;</label> 
									<input type="email"	class="form-control" id="memail" name="memail"	placeholder="이메일 입력" value="">
									<div id="emailMsg" class="error">이메일을 입력해주세요.</div>
									<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
							</div>
						</div>
						<div class="form-group row" style="margin-bottom: -1px;">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="c_companyname" class="text-black"><span	class="text-danger">*</span>우편번호&nbsp;&nbsp;</label> 
						</div>
						<div class="form-group row">
							<div class="col-md-6">
								<input type="text"	class="form-control" id="maddress1" name="maddress1" placeholder="우편번호 입력" readonly="readonly"> 		
							</div>						
							<div class="col-md-2">
								<input	type="button" class="btn btn-outline-dark btn-sm btn-block"	id="postSearch" style="height: 38px;" onClick="daum.Postcode();" value="주소 찾기" />
							</div>
						</div>

						<div class="form-group row">
							<div class="col-md-8">
								<label for="c_address" class="text-black"><span class="text-danger">*</span>기본주소&nbsp;&nbsp;</label> 
									<input type="text" class="form-control" id="maddress2" name="maddress2"	placeholder="기본주소를 입력해주세요." readonly="readonly">
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-8">
								<label for="c_address" class="text-black"><span class="text-danger">*</span>상세주소&nbsp;&nbsp;</label> 
									<input type="text" class="form-control" id="maddress3" name="maddress3"	placeholder="상세주소를 입력해주세요.">
									<div id="addMsg" class="error">상세주소를 입력해주세요.</div>
							</div>
						</div>
						<br>
						<div class="form-group row" style="text-align: center;">
 						<div class="col-md-8">
						<input type="checkbox" id="user_check" name="user_check"/>
							<a href="<%=request.getContextPath() %>/main/policy.jsp" target="_blank" >이용약관</a>과 <a href="<%=request.getContextPath() %>/main/personal.jsp" target="_blank">개인정보약관</a>에 동의함
							<div id="checkMsg" class="error">이용약관에 동의해주세요.</div>										
							<button type="submit" class="btn btn-outline-dark btn-md btn-block" id="join_btn"  style="margin-top: 20px;">신규가입</button>
						</div>		
							</div>
						</div>
						</div>
							
						</div>
						</form>	
					</div>
				</div>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	
	<script type="text/javascript">
	$("#mname").focus();
    $('#join_btn').click(function() {
        	
    		var submitResult=true;
    		
    		$(".error").css("display","none");

    		var idReg=/^[a-zA-Z]\w{5,19}$/g;
    		if($("#mid").val()=="") {
    			$("#idMsg").css("display","block");
    			$("#mid").focus();
    			submitResult=false;
    		} else if(!idReg.test($("#mid").val())) {
    			$("#idRegMsg").css("display","block");
    			$("#mid").focus();
    			submitResult=false;
    		} else if($("#idCheckResult").val()=="0") {
    			$("#idCheckMsg").css("display","block");
    			$("#mid").focus();
    			submitResult=false;
    		}
    		
    		var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
    		if($("#mpw_1").val()=="") {
    			$("#passwdMsg").css("display","block");

    			submitResult=false;
    		} else if(!passwdReg.test($("#mpw_1").val())) {
    			$("#passwdRegMsg").css("display","block");
    			submitResult=false;
    		} 
    		
    		if($("#mpw_2").val()=="") {
    			$("#repasswdMsg").css("display","block");
    			submitResult=false;
    		} else if($("#mpw_1").val()!=$("#mpw_2").val()) {
    			$("#repasswdMatchMsg").css("display","block");
    			submitResult=false;
    		}
    		
    		var KorReg = /^[가-힣]{2,7}$/;
    		if($("#mname").val()=="") {
    			$("#nameMsg").css("display","block");
    			$("#mname").focus();
    			submitResult=false;
    		} else if(!KorReg.test($("#mname").val())){
    			$("#nameKorMsg").css("display","block");
    			$("#mname").focus();
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
    		if($("#mphone2").val()=="" || $("#mphone3").val()=="") {
    			$("#mobileMsg").css("display","block");
    			submitResult=false;
    		} else if(!mobile2Reg.test($("#mphone2").val()) || !mobile3Reg.test($("#mphone3").val())) {
    			$("#mobileRegMsg").css("display","block");
    			submitResult=false;
    		}
    		
    		if($("#maddress3").val()=="") {
    			$("#addMsg").css("display","block");
    			submitResult=false;
    		} 
    		 
    		if($("#user_check").prop("checked")){
    			$("#user_check").val(0);
    			$("#checkMsg").css("display","none");
    		} else {
    			$("#user_check").val(1);
    			$("#checkMsg").css("display","block");
    			submitResult=false;
    		} 
    		
    		if(submitResult==true){
    			alert("회원가입을 축하드립니다. 로그인페이지로 이동합니다.");
    		}
    		return submitResult; 
    });
    
    $("#idCheck").click(function() {
    	$("#idMsg").css("display","none");
    	$("#idRegMsg").css("display","none");
    	
    	var idReg=/^[a-zA-Z]\w{5,19}$/g;
    	if($("#mid").val()=="") {
    		$("#idMsg").css("display","block");
    		return;
    	} else if(!idReg.test($("#mid").val())) {
    		$("#idRegMsg").css("display","block");
    		return;
    	}
    	
     	window.open("<%=request.getContextPath()%>/member/id_check.jsp?mid="
    		+$("#mid").val(),"idcheck","width=350,height=150,left=450,top=250"); 
    });

    $("#mid").keyup(function() {
    	if($("#idCheckResult").val()=="1") {
    		$("#idCheckResult").val("0");
    	}
    });
   </script>

	<jsp:include page="/footer.jsp"/>    
