<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>
    <div class="site-section">
      <div class="container">    
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <h1 class="h3 mb-3 text-black" style="text-align: center;">ERROR PAGE (400)</h1>
      <hr>
      <p style="text-align: center;">비정상적인 방법으로 요청을 시도 하였습니다.<br>
		 정상적인 방법으로 요청해 주세요.</p>
      <div class="row mb-5"></div>
      <div class="col-md-12 text-center">
      <p><a type="submit" class="btn btn-lg height-auto px-4 py-3 btn-outline-dark" href="<%=request.getContextPath() %>/member/login.jsp">메인페이지로 이동</a></p>
      </div>
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      </div>
    </div>
<jsp:include page="/footer.jsp"/>