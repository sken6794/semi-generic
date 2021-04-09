package generic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;



import generic.dto.OrderDTO;
import generic.dto.OrderProductDTO;

public class OrderDAO extends JdbcDAO{
	private static OrderDAO _dao;
	
	private OrderDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new OrderDAO();
	}
	
	public static OrderDAO getDAO() {
		return _dao;
	}
	
	//주문정보를 입력받아서 order_item 테이블에 삽입하고 삽입행의 갯수 반환
	public int insertOrder(OrderDTO order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			String sql = "INSERT INTO ORDER_ITEM VALUES(ORDER_ITEM_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, sysdate, '배송준비중', ?)";
			pstmt=con.prepareStatement(sql);			
			
			pstmt.setString(1, order.getMid());
			pstmt.setString(2, order.getOrname());
			pstmt.setString(3, order.getOaddress());
			pstmt.setString(4, order.getOaddress2());
			pstmt.setString(5, order.getOaddress3());
			pstmt.setString(6, order.getOphone());
			pstmt.setString(7, order.getOrequire());					
			pstmt.setString(8, order.getOname());
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertOrder()메소드의 오류 = "+e.getMessage());
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//회원정보를 전달받아 간단한 결제내역만 출력하는 메소드
	public List<OrderDTO> selectOrder(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderDTO order = null;
		List<OrderDTO> orderList = new ArrayList<OrderDTO>();
		try {
			con = getConnection();
			String sql = "select * from order_item where mid=? order by ono desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				order = new OrderDTO();
				order.setOno(rs.getInt("ono"));
				order.setMid(rs.getNString("mid"));
				order.setOrname(rs.getNString("orname"));
				order.setOaddress(rs.getNString("oaddress"));
				order.setOaddress2(rs.getString("oaddress2"));
				order.setOaddress2(rs.getString("oaddress3"));
				order.setOphone(rs.getNString("ophone"));
				order.setOrequire(rs.getString("orequire"));
				order.setOdate(rs.getString("odate"));
				order.setOstate(rs.getString("ostate"));
				order.setOname(rs.getString("oname"));
				orderList.add(order);
				
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectOrder()메소드의 오류 = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
				
	//주문번호를 전달받아 해당 주문정보를 반환하는 메소드
	public List<OrderProductDTO> selectNoOrder(int ono) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderProductDTO order =null;
		List<OrderProductDTO> orderList = new ArrayList<OrderProductDTO>();
		try {
			con = getConnection();
			String sql = "select p.pname, p.pprice, op.opqty, o.ostate, o.oaddress, o.oaddress2, o.oaddress3, o.oname, o.orname, o.ophone from order_product op\r\n" + 
					"join order_item o on (op.ono=o.ono)\r\n" + 
					"join product p on (p.pid=op.pid)\r\n" + 
					"where o.ono = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ono);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				order = new OrderProductDTO();
				order.getProduct().setPname(rs.getString("pname"));
				order.getProduct().setPprice(rs.getInt("pprice"));
				order.setOpqty(rs.getInt("opqty"));
				order.getOrder().setOstate(rs.getString("ostate"));
				order.getOrder().setOaddress(rs.getString("oaddress"));
				order.getOrder().setOaddress2(rs.getString("oaddress2"));
				order.getOrder().setOaddress3(rs.getString("oaddress3"));
				order.getOrder().setOname(rs.getString("oname"));
				order.getOrder().setOrname(rs.getString("orname"));
				order.getOrder().setOphone(rs.getString("ophone"));
				orderList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoOrder()메소드의 오류 = "+e.getMessage());

		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
	
	//ORDER_PRODUCT 테이블에 행을 편하게 삽입하기 위해 회원 아이디를 받아 값을 추출해오는 메소드
	public List<OrderProductDTO> selectOrderCart(String mid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderProductDTO orderproduct = null;
		List<OrderProductDTO> orderproductList = new ArrayList<OrderProductDTO>();
		try {
			con = getConnection();
			String sql = "SELECT O.MID, O.ONO, C.PID, C.CQTY FROM ORDER_ITEM O JOIN CART C ON (O.MID=C.MID) WHERE O.MID=? ORDER BY O.ONO";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				orderproduct = new OrderProductDTO();
				orderproduct.setOno(rs.getInt("ono"));
				orderproduct.setPid(rs.getInt("pid"));
				orderproduct.setOpqty(rs.getInt("cqty"));
				orderproductList.add(orderproduct);
				
			}
		} catch (SQLException e) {
		System.out.println("[에러]selectOrderCart()메소드의 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderproductList;
	}
	
	
	//ORDER_ITEM 테이블에 저장하고 같이 ORDER_PRODUCT 테이블에 삽입하는 메소드
	public int insertOrderProduct(int ono, int pid, int opqty) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows=0;
		
		try {
			con=getConnection();
			String sql = "insert into order_product values(order_product_seq.nextval,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ono);
			pstmt.setInt(2, pid);
			pstmt.setInt(3, opqty);		
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertOrderProduct()메소드의 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	public ArrayList<JSONObject> getChartVisit() throws JSONException{
		ArrayList<JSONObject> list= new ArrayList<JSONObject>();
		String sql="select TO_CHAR(v_date,'HH24'),COUNT(TO_CHAR(v_date,'HH24')) from visit\r\n" + 
				"		 		where TO_CHAR(v_date,'YYYYMMDD')= TO_CHAR(SYSDATE,'YYYYMMDD')\r\n" + 
				"		 		GROUP BY  TO_CHAR(v_date,'HH24')\r\n" + 
				"		 		ORDER BY TO_CHAR(v_date,'HH24')";
		JSONObject lineObj = null;
		 Connection con=null;
		 PreparedStatement pstmt=null;
		 ResultSet rs =null;
		 try {
			 con= getConnection();
			 pstmt=con.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 lineObj=new JSONObject();
					
				 lineObj.put("hour", rs.getString(1));
				 //System.out.println("시간"+rs.getString(1));
				 
				 lineObj.put("count", rs.getString(2));
				 //System.out.println("방문자"+rs.getString(2));
				 list.add(lineObj);
			 }
		} catch (SQLException e) {
			System.out.println("sql구문오류");
		}finally {
			
			close(con, pstmt, rs);
		}
		 
		return list;
	}
	
	public ArrayList<JSONObject> getChartData() throws JSONException{
		JSONObject barObj = null;
		 Connection con=null;
		 PreparedStatement pstmt=null;
		 ResultSet rs =null;
		ArrayList<JSONObject> list= new ArrayList<JSONObject>();
		 String sql="select TO_CHAR(odate,'HH24'),COUNT(TO_CHAR(odate,'HH24')) from order_item\r\n" + 
		 		"		 		where TO_CHAR(odate,'YYYYMMDD')= TO_CHAR(SYSDATE,'YYYYMMDD')\r\n" + 
		 		"		 		GROUP BY  TO_CHAR(odate,'HH24')\r\n" + 
		 		"		 		ORDER BY TO_CHAR(odate,'HH24')";
		 try {
			 con= getConnection();
			 pstmt=con.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 
			
			 
			 while(rs.next()) {
				
				 barObj=new JSONObject();
				
				 barObj.put("hour", rs.getString(1));
				 
				 barObj.put("count", rs.getString(2));

				 list.add(barObj);
			 }
				
		} catch (SQLException e) {
			System.out.println("sql구문오류");
		}finally {
			
			close(con, pstmt, rs);
		}
		 
		 return list;
	}
	public int totCount(String type, String keyword) {
		Connection con=null;
		 PreparedStatement pstmt=null;
		 ResultSet rs =null;
		String sql="select count(*) from order_product op join order_item o on(op.ono=o.ono)";
		 if(type.equals("주문번호")&&keyword!="") {
			sql+=" where o.ono like '%'||"+keyword+"||'%'";
		}else if(type.equals("주문자아이디")&&keyword!=null) {
			sql+=" where o.mid like '%'||'"+keyword+"'||'%'";
		}else if(type.equals("주문자명")&&keyword!=null) {
			sql+=" where o.oname like '%'||'"+keyword+"'||'%'";
		}
		 System.out.println(sql);
		int result=0;
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("totCount() = sql구문오류  :" +e);
		}finally {
			close(con, pstmt, rs);
		}
		
		return result;
	}
	
	public ArrayList<OrderProductDTO> getOrderList(generic.page.OrderSearchCriteria osc){
		Connection con=null;
		 PreparedStatement pstmt=null;
		 ResultSet rs =null;
		ArrayList<OrderProductDTO> list= new ArrayList<OrderProductDTO>();
		 String sql="SELECT ODATE,ONO,ONAME,PNAME,PPRICE,OSTATE,OREQUIRE FROM (\r\n" + 
		 		"     SELECT ODATE,ONO,ONAME,PNAME,PPRICE,OSTATE,OREQUIRE, ROWNUM as rnum FROM (\r\n" + 
		 		"		 SELECT O.ODATE,O.ONO,O.ONAME,P.PNAME,P.PPRICE,O.OSTATE,O.OREQUIRE FROM \r\n" + 
		 		"         ORDER_PRODUCT OP JOIN ORDER_ITEM O ON(OP.ONO=O.ONO)\r\n" + 
		 		"         JOIN PRODUCT P ON(OP.PID=P.PID)\r\n";
		 
		 	if(osc.getOrderSearchType().equals("주문번호")&&osc.getOrderSearchKeyword()!="") {
		 		sql+=" where O.ONO like '%'||"+osc.getOrderSearchKeyword()+"||'%' ";
		 		if(!osc.getOrderDateStart().equals("")&&!osc.getOrderDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+osc.getOrderDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+osc.getOrderDateEnd()+"','YYYY-MM-DD')+0.99999";
	 			}else if(!osc.getOrderState().equals("")) {
	 				sql+=" and O.STATE="+osc.getOrderState();
	 			}	
		 	}else if(osc.getOrderSearchType().equals("주문자아이디")&&osc.getOrderSearchKeyword()!="") {
		 		sql+=" where O.MID like '%'||'"+osc.getOrderSearchKeyword()+"'||'%' ";
		 		if(!osc.getOrderDateStart().equals("")&&!osc.getOrderDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+osc.getOrderDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+osc.getOrderDateEnd()+"','YYYY-MM-DD')+0.99999";
	 			}else if(!osc.getOrderState().equals("")) {
	 				sql+=" and O.STATE="+osc.getOrderState();
	 			}	
		 	}else if(osc.getOrderSearchType().equals("주문자명")&&osc.getOrderSearchKeyword()!="") {
		 		sql+=" where O.ONAME like '%'||'"+osc.getOrderSearchKeyword()+"'||'%' ";
		 		if(!osc.getOrderDateStart().equals("")&&!osc.getOrderDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+osc.getOrderDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+osc.getOrderDateEnd()+"','YYYY-MM-DD')+0.99999";
	 			}else if(!osc.getOrderState().equals("")) {
	 				sql+=" and O.STATE="+osc.getOrderState();
	 			}	
		 	}
		 		sql+="      ORDER BY o.odate DESC\r\n" + 
		 		"		 	)  a)  WHERE rnum BETWEEN ? AND ?";
		 System.out.println(sql);
		 try {
			 con=getConnection();
			 pstmt=con.prepareStatement(sql);
			
			 pstmt.setInt(1, osc.getDisplayPost());
			 pstmt.setInt(2, osc.getPostNum());
			 
			 rs=pstmt.executeQuery();
			 
			 while(rs.next()) {
				 OrderProductDTO dto=new OrderProductDTO();
				 
				 dto.getOrder().setOdate(rs.getString(1));
				 dto.getOrder().setOno(rs.getInt(2));
				 dto.getOrder().setOname(rs.getString(3));
				 dto.getProduct().setPname(rs.getString(4));
				// System.out.println(rs.getString(4));
				 dto.getProduct().setPprice(rs.getInt(5));
				// System.out.println(rs.getInt(5));
				 dto.getOrder().setOstate(rs.getString(6));
				 dto.getOrder().setOrequire(rs.getString(7));
				 
				 
				 list.add(dto);
			 }
				
		} catch (SQLException e) {
			System.out.println("getOrderList() = sql구문오류 : "+e);
		}finally {
			close(con, pstmt, rs);
		}
		 
		 return list;
	}
	
	public ArrayList<OrderProductDTO> getDeliveryList(generic.page.DeliveryManagementSearchCriteria dmsc){
		Connection con=null;
		 PreparedStatement pstmt=null;
		 ResultSet rs =null;
		ArrayList<OrderProductDTO> list= new ArrayList<OrderProductDTO>();
		 String sql="SELECT ODATE,ONO,ONAME,PNAME,PPRICE*OPQTY,OSTATE,OADDRESS,OADDRESS2,OADDRESS3,OREQUIRE FROM (\r\n" + 
		 		"     SELECT ODATE,ONO,ONAME,PNAME,a.PPRICE,OPQTY,OSTATE,OADDRESS,OADDRESS2,OADDRESS3,OREQUIRE, ROWNUM as rnum FROM (\r\n" + 
		 		"		 SELECT O.ODATE,O.ONO,O.ONAME,P.PNAME,P.PPRICE,OP.OPQTY,O.OSTATE,O.OADDRESS,O.OADDRESS2,O.OADDRESS3,O.OREQUIRE FROM \r\n" + 
		 		"         ORDER_PRODUCT OP JOIN ORDER_ITEM O ON(OP.ONO=O.ONO)\r\n" + 
		 		"         JOIN PRODUCT P ON(OP.PID=P.PID)";
		 
		 if(dmsc.getDeliverySearchType().equals("주문번호")&&dmsc.getDeliverySearchKeywrod()!="") {
			 sql+=" where O.ONO like '%'||"+dmsc.getDeliverySearchKeywrod()+"||'%' ";
			 if(!dmsc.getDeliveryDateStart().equals("")&&!dmsc.getDeliveryDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+dmsc.getDeliveryDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+dmsc.getDeliveryDateEnd()+"','YYYY-MM-DD')+0.99999 ";
	 			}
		 }else if(dmsc.getDeliverySearchType().equals("주문자아이디")&&dmsc.getDeliverySearchKeywrod()!="") {
			 sql+=" where O.MID like '%'||'"+dmsc.getDeliverySearchKeywrod()+"'||'%' ";
			 if(!dmsc.getDeliveryDateStart().equals("")&&!dmsc.getDeliveryDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+dmsc.getDeliveryDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+dmsc.getDeliveryDateEnd()+"','YYYY-MM-DD')+0.99999";
	 			}
		 }else if(dmsc.getDeliverySearchType().equals("주문자명")&&dmsc.getDeliverySearchKeywrod()!="") {
			 sql+=" where O.ONAME like '%'||'"+dmsc.getDeliverySearchKeywrod()+"'||'%' ";
			 if(!dmsc.getDeliveryDateStart().equals("")&&!dmsc.getDeliveryDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+dmsc.getDeliveryDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+dmsc.getDeliveryDateEnd()+"','YYYY-MM-DD')+0.99999";
	 			}
		 }				
		 		sql+=" ORDER BY o.odate DESC\r\n" + 
		 		"		 	)  a) a WHERE rnum BETWEEN ? AND ?";
		 		System.out.println(sql);
		 try {
			 con=getConnection();
			 pstmt=con.prepareStatement(sql);
			
			 pstmt.setInt(1, dmsc.getDisplayPost());
			 //System.out.println("displaypost="+dmsc.getDisplayPost());
			 pstmt.setInt(2, dmsc.getPostNum());
			 //System.out.println("postnum="+dmsc.getPostNum());
			 
			 rs=pstmt.executeQuery();
			 
			 while(rs.next()) {
				 OrderProductDTO dto=new OrderProductDTO();
				 dto.getOrder().setOdate(rs.getString(1));
				 dto.getOrder().setOno(rs.getInt(2));
				 dto.getOrder().setOname(rs.getString(3));
				 dto.getProduct().setPname(rs.getString(4));
				 dto.getProduct().setPprice(rs.getInt(5));
				 dto.getOrder().setOstate(rs.getString(6));
				 dto.getOrder().setOaddress(rs.getString(7));
				 dto.getOrder().setOaddress2(rs.getString(8));
				 dto.getOrder().setOaddress3(rs.getString(9));
				 dto.getOrder().setOrequire(rs.getString(10));
				 
				 list.add(dto);
			 }
				
		} catch (SQLException e) {
			System.out.println("getDeliveryList() = sql구문오류 : "+e);
		}finally {
			close(con, pstmt, rs);
		}
		 
		return list;
	}
	
	public int modifyDeliveryState(int ono, String state) {
		String sql="update ORDER_ITEM set ostate=? where ono=?";
		Connection con=null;
		 PreparedStatement pstmt=null;
		 ResultSet rs =null;
		int result=0;
		
		try {
			 con=getConnection();
			 pstmt=con.prepareStatement(sql);

			 pstmt.setString(1, state);
			 pstmt.setInt(2, ono);
			 System.out.println("결과="+result);
			 result=pstmt.executeUpdate();
			 
			 if(result==1) {
				 System.out.println("배송상태 수정 성공");
			 }else {
				 System.out.println("배송상태 수정 실패");
			 }
		} catch (SQLException e) {
			// TODO: handle exception
		}finally {
			close(con, pstmt, rs);
		}
		return result;
	}
	
	public int[] getOrderState() {
		String sql="  select (select count(ostate) from  order_item where ostate='배송준비중')as done, \r\n" + 
				"            (select count(ostate) from  order_item where ostate='배송중')as ing,\r\n" + 
				"            (select count(ostate) from  order_item where ostate='배송완료')as preper\r\n" + 
				"            from order_item\r\n" + 
				"            GROUP BY ostate";
		 Connection con=null;
		 PreparedStatement pstmt=null;
		 ResultSet rs =null;
		 int [] result= {0,0,0};
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result[0]=rs.getInt(1);
				//System.out.println("배송준비중"+result[0]);
				result[1]=rs.getInt(2);
				//System.out.println("배송중"+result[1]);
				result[2]=rs.getInt(3);
				//System.out.println("배송완료"+result[2]);
			}
			 
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			close(con, pstmt, rs);
		}
		
		return result;
	}
	
	public int getTodayCnt() {
		String sql="SELECT COUNT(*)  FROM order_item\r\n" + 
				"WHERE TO_DATE(odate, 'YYYY-MM-DD') = TO_DATE(sysdate, 'YYYY-MM-DD')";
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		int result =0;
		
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}finally {
			close(con, pstmt, rs);
		}
		
		return result;
	}
	
	public int getTodaySales() {
		String sql="SELECT SUM(P.PPRICE*OP.OPQTY)  FROM ORDER_ITEM O JOIN order_product OP ON(O.ONO=OP.ONO) JOIN product P ON(OP.PID=P.PID)\r\n" + 
				"WHERE TO_DATE(O.odate, 'YYYY-MM-DD') = TO_DATE(sysdate, 'YYYY-MM-DD')";
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		int result =0;
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}finally {
			close(con, pstmt, rs);
		}
		return result;
	}
	public int getMonthSales() {
		String sql="SELECT TO_CHAR(SYSDATE,'YYYY-MM'),SUM(P.PPRICE*OP.OPQTY)FROM ORDER_ITEM O JOIN order_product OP ON(O.ONO=OP.ONO) JOIN product P ON(OP.PID=P.PID)\r\n" + 
				"GROUP BY TO_CHAR(SYSDATE+0.99999,'YYYY-MM')";
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		int result =0;
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				
				result=rs.getInt(2);
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}finally {
			close(con, pstmt, rs);
		}
		
		return result;
	}
	public int getYearSales() {
		String sql="SELECT TO_CHAR(SYSDATE,'YYYY'),SUM(P.PPRICE*OP.OPQTY)FROM ORDER_ITEM O JOIN order_product OP ON(O.ONO=OP.ONO) JOIN product P ON(OP.PID=P.PID)\r\n" + 
				"GROUP BY TO_CHAR(SYSDATE+0.99999,'YYYY')";
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		int result =0;
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();

			if(rs.next()) {
				result=rs.getInt(2);
				//System.out.println(rs.getInt(2));
			}
		} catch (SQLException e) {
			System.out.println("sql구문 오류");
		}finally {
			close(con, pstmt, rs);
		}
		return result;
	}
	
	//주문 성공하면 재고수량 (-)
	public int updatePstock(int pid, int cqty) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows= 0;
		try {
			con = getConnection();
			String sql = "update product set pstock=pstock-? where pid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cqty);
			pstmt.setInt(2, pid);
			rows= pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("[에러]updatePstock()메소드의 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}
