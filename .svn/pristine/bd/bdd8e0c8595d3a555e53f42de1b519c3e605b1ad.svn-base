<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="org.omg.PortableInterceptor.PolicyFactoryOperations"%>


<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf8");
	ProductDTO productdto = new ProductDTO();
	//ImgDTO imgdto=new ImgDTO(); 
	//String uploadPath="D:/프로그램/apache-tomcat-9.0.37/webapps/Admin/upload/";
	//String uploadPath="D:/tmp/";
	String[] file=new String[4];
	//String uploadPath1="D:/tmp2";
	//String pname="";
	System.out.println();
	
	String saveDirectory=request.getServletContext().getRealPath("/images");
	MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024,"utf-8",new DefaultFileRenamePolicy());
	
	productdto.setPname(mr.getParameter("pname"));
	//pname=mr.getParameter("pname");
	productdto.setPcolor(mr.getParameter("pcolor"));
	productdto.setPprice(Integer.parseInt(mr.getParameter("pprice")));
	productdto.setPct(mr.getParameter("pct"));
	
	if(mr.getParameter("pct").equals("선글라스")){
		productdto.setCtno(20);	
	}else{
		productdto.setCtno(10);	
	}
	productdto.setPcontent(mr.getParameter("pcontent"));
	
	for(int i=0;i<4;i++){
		if(mr.getFilesystemName("img"+(i+1))!=null){
		file[i]=mr.getFilesystemName("img"+(i+1));
		System.out.println(file[i]);
		}
		
	}
	
	productdto.setPimg1(file[0]);
	productdto.setPimg2(file[1]);
	productdto.setPimg3(file[2]);
	productdto.setPimg4(file[3]);
	productdto.setPstock(Integer.parseInt(mr.getParameter("pstock")));
	
	int result=ProductDAO.getDAO().insertProduct(productdto);
	//System.out.println(result);
	
	
	
	if(result==1){
		response.sendRedirect("Admin.jsp");
	}else if(result==-1){
		response.sendRedirect("ProductRegistration.jsp");
	}
	
%>