<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">관리자님  안녕하세요<b class="fa fa-angle-down"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="#"><i class="fa fa-fw fa-user"></i>회원정보 수정</a></li>
                    <li><a href="<%=request.getContextPath() %>/index.jsp"><i class="fa fa-bullseye"></i> 쇼핑몰 이동</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=request.getContextPath() %>/member/logout_action.jsp""><i class="fa fa-fw fa-power-off"></i>로그아웃</a></li>
                </ul>
            </li>