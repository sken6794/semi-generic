<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>
<form action="<%=request.getContextPath() %>/member/login.jsp">
    <div class="site-section">
      <div class="container">    
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      <h1 class="h3 mb-3 text-black" style="text-align: center;">ERROR PAGE (NullPointerException)</h1>
      <hr>
      <p style="text-align: center;">요청하신 프로그램에서 예기치 못한 오류가 발생하였습니다.<br>
		 빠른 시일내로 조치 하겠습니다.</p>
      <div class="row mb-5"></div>
      <div class="col-md-12 text-center">
      <p><a type="submit" class="btn btn-lg height-auto px-4 py-3 btn-outline-dark" href="<%=request.getContextPath() %>/member/login.jsp">메인페이지로 이동</a></p>
      </div>
      <div class="row mb-5"></div>
      <div class="row mb-5"></div>
      </div>
    </div>
</form>
<jsp:include page="/footer.jsp"/>