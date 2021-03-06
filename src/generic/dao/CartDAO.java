package generic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import generic.dto.CartDTO;

public class CartDAO  extends JdbcDAO {
	private static CartDAO _dao;
	
	private  CartDAO() {
		
	}
	
	static {
		_dao = new CartDAO();
	}
	
	public static CartDAO getDAO() {
		return _dao;
	}
	
	//CART 테이블에 장바구니 정보를 입력받아 삽입하고 삽입행의 갯수 반환
	public int insertCart(CartDTO cart) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			String sql = "insert into cart values (CART_SEQ.NEXTVAL,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cart.getMid());
			pstmt.setString(2, cart.getCpname());
			pstmt.setInt(3, cart.getCqty());
			pstmt.setInt(4, cart.getCprice());
			pstmt.setInt(5, cart.getPid());			
			rows = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.out.println("[에러]insertCart()메소드의 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//CART 테이블에 회원 아이디를 전달하여 검색하고 카트 정보를 반환하는 메소드
	public List<CartDTO> selectCart(String mid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CartDTO> cartList = new ArrayList<CartDTO>();
		
		try {
			con=getConnection();
			String sql = "select c.cno, c.mid, c.cpname, c.cqty, c.cprice, c.pid, p.pimg1 from cart c\r\n" + 
					"join product p on (c.pid=p.pid)\r\n" + 
					"where mid = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs= pstmt.executeQuery();
			while(rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setCno(rs.getInt("cno"));
				cart.setMid(rs.getString("mid"));
				cart.setCpname(rs.getString("cpname"));
				cart.setCqty(rs.getInt("cqty"));
				cart.setCprice(rs.getInt("cprice"));
				cart.setPid(rs.getInt("pid"));
				cart.getProduct().setPimg1(rs.getString("pimg1"));
				cartList.add(cart);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectCart()메소드의 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cartList;
	}
	
	//카트 번호를 전달받아 카트 테이블에서 해당 행 삭제하고 삭제한 행의 갯수 반환 메소드
	public int deleteCart(int cno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows= 0;
		try {
			con=getConnection();
			String sql = "delete from cart where cno=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cno);
			rows=pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("[에러]deleteCart()메소드의 오류 = "+e.getMessage());

		} finally {
			close(con, pstmt);
		}
		return rows;
		
	}
	
	//회원 아이디를 전달하여 카트 테이블의 상품들 합계를 구하고 반환하는 메소드
	public int selectTotalPrice(String mid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cartPrice = 0;
		try {
			con = getConnection();
			String sql = "SELECT SUM(TOTPRICE) TOTPRICE \r\n" + 
					"FROM (select mid, cqty, cprice, cqty*cprice as totprice from cart where mid=?) \r\n" + 
					"WHERE MID=? GROUP BY MID";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cartPrice=rs.getInt("TOTPRICE");
			}
				
				
			
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalPrice()메소드의 오류 = "+e.getMessage());

		} finally {
			close(con, pstmt, rs);
		}
		return cartPrice;
		
	}
	
	//카트번호와 변경 수량을 전달받아 CART 테이블에서 해당 품목 카트수량 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateCart(int cqty, int cno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			String sql = "update cart set cqty = ? where cno = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cqty);
			pstmt.setInt(2, cno);
			rows = pstmt.executeUpdate();
					
		} catch (SQLException e) {
			
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//회원아이디를 전달받아 카트테이블의 갯수를 반환하는 메소드
	public int selectCartCount(String mid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select count(*) from cart where mid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
					
		} catch (SQLException e) {
			
		} finally {
			close(con, pstmt);
		}
		return count;
	}
	
	//카트목록의 시작 행, 종료 행 전달받아 검색 하고 목록 반환하는 메소드
		public List<CartDTO> selectCart2(String mid,int startRow, int endRow){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<CartDTO> cartList = new ArrayList<CartDTO>();
			CartDTO cart = null;
			try {
				con = getConnection();
				String sql = "select * from\r\n" + 
						"(select rownum rn, temp.* from(select c.cno, c.mid, c.cpname, c.cqty, c.cprice, c.pid, p.pimg1, p.pstock from cart c\r\n" + 
						"join product p on (c.pid=p.pid)\r\n" + 
						"where mid = ?) temp)\r\n" + 
						"where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					cart = new CartDTO();
					cart.setCno(rs.getInt("cno"));
					cart.setMid(rs.getString("mid"));
					cart.setCpname(rs.getString("cpname"));
					cart.setCqty(rs.getInt("cqty"));				
					cart.setCprice(rs.getInt("cprice"));
					cart.setPid(rs.getInt("pid"));
					cart.getProduct().setPimg1(rs.getString("pimg1"));
					cart.getProduct().setPstock(rs.getInt("pstock"));
					cartList.add(cart);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectCart2()메소드의 오류 = "+e.getMessage());

			} finally {
				close(con, pstmt, rs);
			}
			return cartList;
		}
		
		//장바구니 목록을 주문하고 난 후 장바구니 테이블을 비우기 위해
		// 사용자 아이디를 받아서 장바구니 목록에서 해당 아이디 목록 삭제하는 메소드
		public int deleteCartId(String mid) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;
			try {
				con =getConnection();
				String sql = "delete from cart where mid = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, mid);
				rows= pstmt.executeUpdate();
			} catch (SQLException e) {
				
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
	
}
