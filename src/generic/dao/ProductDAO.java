package generic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



import generic.dto.ProductDTO;

public class ProductDAO extends JdbcDAO{

private static ProductDAO _dao;
	
	private ProductDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ProductDAO();
	}
	
	public static ProductDAO getDAO() {
		return _dao;
	}
	
	//페이징 - 테이블에 저장된 게시글의 갯수를 검색하여 반환하는 메소드
	public int productCount(String pct) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			if(pct=="안경") {
				String sql="select count(*)from product where pct='안경'";
				pstmt=con.prepareStatement(sql);
				
			} else if (pct=="선글라스") {
				String sql="select count(*)from product where pct='선글라스'";
				pstmt=con.prepareStatement(sql);				
			}			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] productCount()메소드 sql 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	//상품등록
	public int insertProduct(ProductDTO dto) {
		//String sql="INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL,10,'더미',30,'더미','더미','더미','더미','더미','더미',9,'더미',sysdate)";
		String sql="INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?,sysdate,1)";
		Connection con=null;
		PreparedStatement pstmt=null;
		int result_Code=-1;
		
		try {
			
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getCtno());
			
			pstmt.setString(2, dto.getPname());
			System.out.println("dao1(상품이름)="+dto.getPname());
			
			pstmt.setInt(3, dto.getPprice());
			System.out.println("dao2(상품가격)="+dto.getPprice());
			
			pstmt.setString(4, dto.getPct());
			System.out.println( "dao3(상품카테고리 이름)="+dto.getPct());
			
			pstmt.setString(5, dto.getPcontent());
			System.out.println("dao4(상품설명)="+dto.getPcontent());
			
			pstmt.setString(6, dto.getPimg1());
			System.out.println("dao4(이미지1)="+dto.getPimg1());
			
			pstmt.setString(7, dto.getPimg2());
			System.out.println("dao4(이미지2)="+dto.getPimg2());
			
			pstmt.setString(8, dto.getPimg3());
			System.out.println("dao4(이미지3)="+dto.getPimg3());
			
			pstmt.setString(9, dto.getPimg4());
			System.out.println("dao4(이미지4)="+dto.getPimg4());
			
			pstmt.setInt(10, dto.getPstock());
			System.out.println("dao5(재고수량)="+dto.getPstock());
			//pstmt.setString(8, dto.getPcolor());
			
			pstmt.setString(11, dto.getPcolor());
			System.out.println("dao6(색상)="+dto.getPcolor());
			
			//pstmt.setInt(11, dto.getPstatus());
			
			
			result_Code=pstmt.executeUpdate();
			
			System.out.println(result_Code);
			
			if (result_Code == 1) {
				System.out.println("상품 저장 성공");
				return result_Code;
			} else {
				System.out.println("상품 저장 실패");
				result_Code=0;
				return result_Code;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("오류");
		}finally {
			close(con, pstmt);
		}
		return result_Code;
	}
	
	//상품페이지 - 카테고리별(안경/선글라스)로 전체 상품을 검색하여 업데이트 날짜 기준으로 나열
	public List<ProductDTO> selectCategoryProduct(String pct, int startRow, int endRow){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();		
			
		try {
			con=getConnection();
			
			if(pct=="안경") {
				String sql="select * from(select rownum rn, temp.*from (select *  from product where pct='안경' order by pregdate) temp) where rn between ? and ?";				
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);	
			} else if (pct=="선글라스"){
				String sql="select * from(select rownum rn, temp.*from (select *  from product where pct='선글라스' order by pregdate) temp) where rn between ? and ?";				
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);				
			}
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();				
				product.setPid(rs.getInt("pid"));
				product.setCtno(rs.getInt("ctno"));
				product.setPname(rs.getString("pname"));
				product.setPct(rs.getString("pct"));
				product.setPprice(rs.getInt("pprice"));
				product.setPcontent(rs.getString("pcontent"));
				product.setPimg1(rs.getString("pimg1"));
				product.setPimg2(rs.getString("pimg2"));
				product.setPimg3(rs.getString("pimg3"));
				product.setPimg4(rs.getString("pimg4"));
				product.setPstock(rs.getInt("pstock"));
				product.setPcolor(rs.getString("pcolor"));
				product.setPregdate(rs.getString("pregdate"));
				product.setPstatus(rs.getInt("pstatus"));
				
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] selectCategoryProduct()메소드 sql 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	//상세페이지 - 상품ID로 해당 상품을 검색
	public ProductDTO selectIdProduct(int pid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ProductDTO product=null;
		try {
			con=getConnection();
			
			String sql="select * from product where pid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pid);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				product=new ProductDTO();
				product.setPid(rs.getInt("pid"));
				product.setCtno(rs.getInt("ctno"));
				product.setPname(rs.getString("pname"));
				product.setPct(rs.getString("pct"));
				product.setPprice(rs.getInt("pprice"));
				product.setPcontent(rs.getString("pcontent"));
				product.setPimg1(rs.getString("pimg1"));
				product.setPimg2(rs.getString("pimg2"));
				product.setPimg3(rs.getString("pimg3"));
				product.setPimg4(rs.getString("pimg4"));
				product.setPstock(rs.getInt("pstock"));
				product.setPcolor(rs.getString("pcolor"));
				product.setPregdate(rs.getString("pregdate"));
				product.setPstatus(rs.getInt("pstatus"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectIdProduct() 메소드의 SQL 오류 = "+e.getMessage());

		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}
	
	//메인페이지 - 신상품 5건 검색(등록일 기준 정렬)
	public List<ProductDTO> selectNewProduct(){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();		
			
		try {
			con=getConnection();
			String sql="select * from(select rownum rn, temp.* from(select * from product order by pregdate)temp) where rn <=5";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();				
				product.setPid(rs.getInt("pid"));
				product.setCtno(rs.getInt("ctno"));
				product.setPname(rs.getString("pname"));
				product.setPct(rs.getString("pct"));
				product.setPprice(rs.getInt("pprice"));
				product.setPcontent(rs.getString("pcontent"));
				product.setPimg1(rs.getString("pimg1"));
				product.setPimg2(rs.getString("pimg2"));
				product.setPimg3(rs.getString("pimg3"));
				product.setPimg4(rs.getString("pimg4"));
				product.setPstock(rs.getInt("pstock"));
				product.setPcolor(rs.getString("pcolor"));
				product.setPregdate(rs.getString("pregdate"));
				product.setPstatus(rs.getInt("pstatus"));
				
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] selectNewProduct()메소드 sql 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	//메인페이지 - 추천상품 6건 검색(재고량 기준 정렬 - 재고가 많은 상품을 추천)
		public List<ProductDTO> selectRecommendProduct(){
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ProductDTO> productList=new ArrayList<ProductDTO>();		
				
			try {
				con=getConnection();
				String sql="select * from(select rownum rn, temp.* from(select * from product order by pstock desc)temp) where rn <=6";
				pstmt=con.prepareStatement(sql);
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDTO product=new ProductDTO();				
					product.setPid(rs.getInt("pid"));
					product.setCtno(rs.getInt("ctno"));
					product.setPname(rs.getString("pname"));
					product.setPct(rs.getString("pct"));
					product.setPprice(rs.getInt("pprice"));
					product.setPcontent(rs.getString("pcontent"));
					product.setPimg1(rs.getString("pimg1"));
					product.setPimg2(rs.getString("pimg2"));
					product.setPimg3(rs.getString("pimg3"));
					product.setPimg4(rs.getString("pimg4"));
					product.setPstock(rs.getInt("pstock"));
					product.setPcolor(rs.getString("pcolor"));
					product.setPregdate(rs.getString("pregdate"));
					product.setPstatus(rs.getInt("pstatus"));
					
					productList.add(product);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러] selectNewProduct()메소드 sql 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return productList;
		}
		
	//메인페이지 - 상품 이름으로 관련 상품 검색
	public List<ProductDTO> selectNameProduct(String pname, int startRow, int endRow) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();	
		try {
			con=getConnection();
			
			String sql="select * from(select rownum rn, temp.* from (select *  from product where lower(pname) like lower('%'||?||'%') order by pname) temp) where rn between ? and ? "; 

			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pname);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setPid(rs.getInt("pid"));
				product.setCtno(rs.getInt("ctno"));
				product.setPname(rs.getString("pname"));
				product.setPct(rs.getString("pct"));
				product.setPprice(rs.getInt("pprice"));
				product.setPcontent(rs.getString("pcontent"));
				product.setPimg1(rs.getString("pimg1"));
				product.setPimg2(rs.getString("pimg2"));
				product.setPimg3(rs.getString("pimg3"));
				product.setPimg4(rs.getString("pimg4"));
				product.setPstock(rs.getInt("pstock"));
				product.setPcolor(rs.getString("pcolor"));
				product.setPregdate(rs.getString("pregdate"));
				product.setPstatus(rs.getInt("pstatus"));
				
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectNameProduct() 메소드의 SQL 오류 = "+e.getMessage());

		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	//메인페이지 - 검색된 상품 카운팅	
	public int searchProductCount(String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();			
			
			String sql="select count(*)from product where lower(pname) like lower('%'||?||'%') ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] productCount()메소드 sql 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	public ArrayList<ProductDTO> getProductList(int displayPost,int postNum){
		ArrayList<ProductDTO> list= new ArrayList<ProductDTO>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		 String sql="SELECT PID,PIMG1,PNAME,CTNO,PPRICE,PSTOCK,PREGDATE FROM (" + 
		 		"        SELECT PID,PIMG1,PNAME,CTNO,PPRICE,PSTOCK,PREGDATE, ROWNUM as rnum FROM (" + 
		 		"               SELECT PID,PIMG1,PNAME,CTNO,PPRICE,PSTOCK,PREGDATE FROM PRODUCT "
		 		+ "             WHERE PSTATUS=1 ORDER BY PID DESC" + 
		 		"               )" + 
		 		"        a)  WHERE rnum >= ? and rnum <=? ";
		 try {
			 con=getConnection();
			 pstmt=con.prepareStatement(sql);
			 pstmt.setInt(1, displayPost);
			 pstmt.setInt(2, postNum);
			 
			 rs=pstmt.executeQuery();
			 
			 while(rs.next()) {
				 ProductDTO dto=new ProductDTO();
				 
				 dto.setPid(rs.getInt(1));
				 //System.out.println("상품번호"+rs.getInt(1));
				 
				 dto.setPimg1( rs.getString(2));
				 //System.out.println("이미지1"+rs.getString(2));
				 
				 dto.setPname(rs.getString(3));
				 //System.out.println("삼품이름"+rs.getString(3));
				 
				 dto.setCtno(rs.getInt(4));
				 //System.out.println("카테고리"+rs.getInt(4));
				 
				 dto.setPprice(rs.getInt(5));
				 //System.out.println("상품가격"+rs.getInt(5));
				 
				 dto.setPstock(rs.getInt(6));
				 //System.out.println("상품수량"+rs.getInt(6));
				 
				 dto.setPregdate(rs.getString(7));
				 //System.out.println("상품등록일"+rs.getString(7));
				 list.add(dto);
			 }
				
		} catch (SQLException e) {
			System.out.println("sql구문오류");
		}finally {
			close(con, pstmt, rs);
		}
		 
		 return list;
	}
	
	public int totalCoutn(String type, String keyword) {
		String sql="select count(*) from product";
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		if(type.equals("상품명")&&keyword!=null) {
			sql+=" where PNAME like '%'||?||'%'";
		}else if(type.equals("상품번호")&&!keyword.equals("")) {
			sql+=" where PID like '%'||?||'%'";
		}
		
		int result=0;
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			if(type.equals("상품명")) {
				pstmt.setString(1, keyword);
			}if(type.equals("상품번호")) {
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			close(con, pstmt, rs);
		}
		
		
		return result;
	}
	
	public ArrayList<ProductDTO> getSearchProductList(generic.page.ProductSearchCriteria psc){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<ProductDTO> list= new ArrayList<ProductDTO>();
		System.out.println(psc.getStartDate()+"  "+psc.getEndDate());
		 String sql="SELECT PID,PIMG1,PNAME,CTNO,PPRICE,PSTOCK,PREGDATE FROM (" + 
		 		"        SELECT PID,PIMG1,PNAME,CTNO,PPRICE,PSTOCK,PREGDATE, ROWNUM as rnum FROM (" + 
		 		"               SELECT PID,PIMG1,PNAME,CTNO,PPRICE,PSTOCK,PREGDATE FROM PRODUCT "; 
		 		if(psc.getProductSearchType().equals("상품명")&&psc.getProductSearchKeyword()!=null) {
		 			sql+=" where PNAME like '%'||?||'%'";
		 			if(psc.getProductCategory().equals("안경")) {
		 				sql+=" and CTNO=10\\n";
		 			}if(psc.getProductCategory().equals("선글라스")) {
		 				sql+=" and CTNO=20";
		 				
		 			}else if(!psc.getStartDate().equals("")&&!psc.getEndDate().equals("")) {
		 				sql+=" and PREGDATE between TO_DATE('"+psc.getStartDate()+"','YYYY-MM-DD') and"+
		 			" TO_DATE('"+psc.getEndDate()+"','YYYY-MM-DD')+0.99999";
		 			}else if(psc.getProductStatus()!=2) {
		 				sql+=" and PSTATUS="+psc.getProductStatus();
		 			}
		 			
		 		}else if(psc.getProductSearchType().equals("상품번호")&&psc.getProductSearchKeyword()!=null) {
		 			sql+=" where PID like '%'||?||'%'";
		 			if(psc.getProductCategory().equals("안경")) {
		 				sql+=" and CTNO=10\\n";
		 			}if(psc.getProductCategory().equals("선글라스")) {
		 				sql+=" and CTNO=20";
		 				
		 			}else if(!psc.getStartDate().equals("")&&!psc.getEndDate().equals("")) {
		 				sql+=" and PREGDATE between TO_DATE('"+psc.getStartDate()+"','YYYY-MM-DD') and"+
		 			" TO_DATE('"+psc.getEndDate()+"','YYYY-MM-DD')+0.99999";
		 			}else if(psc.getProductStatus()!=2) {
		 				sql+=" and PSTATUS="+psc.getProductStatus();
		 			}
		 		}
		 			
		 
		 		
		 		sql+=" ORDER BY PID DESC)" + 
		 		"        a)  WHERE rnum between ? and ? ";
		 		System.out.println(sql);
		 		
		 try {
			 con=getConnection();
			 pstmt=con.prepareStatement(sql);
			 if(psc.getProductSearchType().equals("상품명")&&psc.getProductSearchKeyword()!=null) {
				 
				 pstmt.setString(1, psc.getProductSearchKeyword());
				 pstmt.setInt(2, psc.getDisplayPost());
				// System.out.println(psc.getDisplayPost());
				 pstmt.setInt(3, psc.getPostNum());
			 }
			 else if(psc.getProductSearchType().equals("상품번호")&&psc.getProductSearchKeyword()!=null) {
				 pstmt.setString(1, psc.getProductSearchKeyword());
				 pstmt.setInt(2, psc.getDisplayPost());
				 //System.out.println(psc.getDisplayPost());
				 pstmt.setInt(3, psc.getPostNum());
			 }
			 else {
			 pstmt.setInt(1, psc.getDisplayPost());
			 //pstmt.setInt(2, psc.getPostNum()*psc.getNum());
			 pstmt.setInt(2, psc.getPostNum());
			 }
			 rs=pstmt.executeQuery();
			 
			 while(rs.next()) {
				 ProductDTO dto=new ProductDTO();
				 
				 dto.setPid(rs.getInt(1));
				 //System.out.println("상품번호"+rs.getInt(1));
				 
				 dto.setPimg1( rs.getString(2));
				// System.out.println("이미지1"+rs.getString(2));
				 
				 dto.setPname(rs.getString(3));
				 //System.out.println("삼품이름"+rs.getString(3));
				 
				 dto.setCtno(rs.getInt(4));
				 //System.out.println("카테고리"+rs.getInt(4));
				 
				 dto.setPprice(rs.getInt(5));
				 //System.out.println("상품가격"+rs.getInt(5));
				 
				 dto.setPstock(rs.getInt(6));
				// System.out.println("상품수량"+rs.getInt(6));
				 
				 dto.setPregdate(rs.getString(7));
				 //System.out.println("상품등록일"+rs.getString(7));
				 list.add(dto);
			 }
				
		} catch (SQLException e) {
			System.out.println("sql구문오류");
		}finally {
			close(con, pstmt, rs);
		}
		 
		 return list;
	}
	
	public int updateProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows = 0;
		try {
			con = getConnection();
			String sql = "update product set ctno=?, pname=?, pprice=?, pct=?, pcontent=?, "
					+ "pimg1=?, pimg2=?, pimg3=?, pimg4=?, pstock=?, pcolor=? where pid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, product.getCtno());
			pstmt.setString(2, product.getPname());
			pstmt.setInt(3, product.getPprice());
			pstmt.setString(4, product.getPct());
			pstmt.setString(5, product.getPcontent());
			pstmt.setString(6, product.getPimg1());
			pstmt.setString(7, product.getPimg2());
			pstmt.setString(8, product.getPimg3());
			pstmt.setString(9, product.getPimg4());			
			pstmt.setInt(10, product.getPstock());
			pstmt.setString(11, product.getPcolor());
			pstmt.setInt(12, product.getPid());
			rows = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("[에러]updateProduct()의 메소드 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	public int deleteProduct(int pid) {
		String sql="UPDATE product set pstatus=0 where pid=?";
		Connection con=null;
		PreparedStatement pstmt=null;
		int result=0;
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pid);
			result= pstmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			close(con, pstmt);
		}
		return result;
	}
}
