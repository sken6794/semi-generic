<%@page import="java.io.File"%>
<%@page import="generic.dao.ProductDAO"%>
<%@page import="generic.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
    
<%
	request.setCharacterEncoding("utf-8");
	String saveDirectory=request.getServletContext().getRealPath("/images");
	MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024,"utf-8",new DefaultFileRenamePolicy());
	
	String pct = "";
	if(Integer.parseInt(mr.getParameter("pct"))==20){
		pct = "선글라스";
	} else if(Integer.parseInt(mr.getParameter("pct"))==10){
		pct = "안경";
	}
	
	
	
	int pid = Integer.parseInt(mr.getParameter("pid"));
	String pname = mr.getParameter("pname");
	String pcolor = mr.getParameter("pcolor");
	int pprice = Integer.parseInt(mr.getParameter("pprice"));
	int pstock = Integer.parseInt(mr.getParameter("pstock"));
	
	String pcontent = mr.getParameter("pcontent");
	String currentPcontent = mr.getParameter("currentPcontent");
	
	System.out.println("내용 = "+pcontent);
	System.out.println("내용2 = "+currentPcontent);
	
	String pimg1 = mr.getFilesystemName("img1");
	String pimg2 = mr.getFilesystemName("img2");
	String pimg3 = mr.getFilesystemName("img3");
	String pimg4 = mr.getFilesystemName("img4");
	
	String currentPimg1 = mr.getParameter("currentImg1");
	String currentPimg2 = mr.getParameter("currentImg2");
	String currentPimg3 = mr.getParameter("currentImg3");
	String currentPimg4 = mr.getParameter("currentImg4");
	
	int ctno = Integer.parseInt(mr.getParameter("ctno"));
	
	ProductDTO product = new ProductDTO();
	product.setPid(pid);
	product.setPname(pname);
	product.setPcolor(pcolor);
	product.setPprice(pprice);
	product.setPstock(pstock);
	
	if(pcontent!=null){
		product.setPcontent(pcontent);
	}else {
		product.setPcontent(currentPcontent);
	}
	
	if(pimg1!=null){
		product.setPimg1(pimg1);
		
		new File(saveDirectory,currentPimg1).delete();
	} else {
		product.setPimg1(currentPimg1);
	}
	
	if(pimg2!=null){
		product.setPimg2(pimg2);
		
		new File(saveDirectory,currentPimg2).delete();
	} else {
		product.setPimg2(currentPimg2);
	}
	
	if(pimg3!=null){
		product.setPimg3(pimg3);
		
		new File(saveDirectory,currentPimg3).delete();
	} else {
		product.setPimg3(currentPimg3);
	}
	
	if(pimg4!=null){
		product.setPimg4(pimg4);
		
		new File(saveDirectory,currentPimg4).delete();
	} else {
		product.setPimg4(currentPimg4);
	}
	
	product.setPct(pct);
	product.setCtno(ctno);
	
	int result = ProductDAO.getDAO().updateProduct(product);
	if(result>0){
		response.sendRedirect(request.getContextPath()+"/admin/ProductList.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/ProductUpdate.jsp");
	}
	
%>