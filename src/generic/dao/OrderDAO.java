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
	
	//�ֹ������� �Է¹޾Ƽ� order_item ���̺� �����ϰ� �������� ���� ��ȯ
	public int insertOrder(OrderDTO order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			String sql = "INSERT INTO ORDER_ITEM VALUES(ORDER_ITEM_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, sysdate, '����غ���', ?)";
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
			System.out.println("[����]insertOrder()�޼ҵ��� ���� = "+e.getMessage());
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//ȸ�������� ���޹޾� ������ ���������� ����ϴ� �޼ҵ�
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
			System.out.println("[����]selectOrder()�޼ҵ��� ���� = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
				
	//�ֹ���ȣ�� ���޹޾� �ش� �ֹ������� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]selectNoOrder()�޼ҵ��� ���� = "+e.getMessage());

		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
	
	//ORDER_PRODUCT ���̺� ���� ���ϰ� �����ϱ� ���� ȸ�� ���̵� �޾� ���� �����ؿ��� �޼ҵ�
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
		System.out.println("[����]selectOrderCart()�޼ҵ��� ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderproductList;
	}
	
	
	//ORDER_ITEM ���̺� �����ϰ� ���� ORDER_PRODUCT ���̺� �����ϴ� �޼ҵ�
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
			System.out.println("[����]insertOrderProduct()�޼ҵ��� ���� = "+e.getMessage());
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
				 //System.out.println("�ð�"+rs.getString(1));
				 
				 lineObj.put("count", rs.getString(2));
				 //System.out.println("�湮��"+rs.getString(2));
				 list.add(lineObj);
			 }
		} catch (SQLException e) {
			System.out.println("sql��������");
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
			System.out.println("sql��������");
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
		 if(type.equals("�ֹ���ȣ")&&keyword!="") {
			sql+=" where o.ono like '%'||"+keyword+"||'%'";
		}else if(type.equals("�ֹ��ھ��̵�")&&keyword!=null) {
			sql+=" where o.mid like '%'||'"+keyword+"'||'%'";
		}else if(type.equals("�ֹ��ڸ�")&&keyword!=null) {
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
			System.out.println("totCount() = sql��������  :" +e);
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
		 
		 	if(osc.getOrderSearchType().equals("�ֹ���ȣ")&&osc.getOrderSearchKeyword()!="") {
		 		sql+=" where O.ONO like '%'||"+osc.getOrderSearchKeyword()+"||'%' ";
		 		if(!osc.getOrderDateStart().equals("")&&!osc.getOrderDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+osc.getOrderDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+osc.getOrderDateEnd()+"','YYYY-MM-DD')+0.99999";
	 			}else if(!osc.getOrderState().equals("")) {
	 				sql+=" and O.STATE="+osc.getOrderState();
	 			}	
		 	}else if(osc.getOrderSearchType().equals("�ֹ��ھ��̵�")&&osc.getOrderSearchKeyword()!="") {
		 		sql+=" where O.MID like '%'||'"+osc.getOrderSearchKeyword()+"'||'%' ";
		 		if(!osc.getOrderDateStart().equals("")&&!osc.getOrderDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+osc.getOrderDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+osc.getOrderDateEnd()+"','YYYY-MM-DD')+0.99999";
	 			}else if(!osc.getOrderState().equals("")) {
	 				sql+=" and O.STATE="+osc.getOrderState();
	 			}	
		 	}else if(osc.getOrderSearchType().equals("�ֹ��ڸ�")&&osc.getOrderSearchKeyword()!="") {
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
			System.out.println("getOrderList() = sql�������� : "+e);
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
		 
		 if(dmsc.getDeliverySearchType().equals("�ֹ���ȣ")&&dmsc.getDeliverySearchKeywrod()!="") {
			 sql+=" where O.ONO like '%'||"+dmsc.getDeliverySearchKeywrod()+"||'%' ";
			 if(!dmsc.getDeliveryDateStart().equals("")&&!dmsc.getDeliveryDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+dmsc.getDeliveryDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+dmsc.getDeliveryDateEnd()+"','YYYY-MM-DD')+0.99999 ";
	 			}
		 }else if(dmsc.getDeliverySearchType().equals("�ֹ��ھ��̵�")&&dmsc.getDeliverySearchKeywrod()!="") {
			 sql+=" where O.MID like '%'||'"+dmsc.getDeliverySearchKeywrod()+"'||'%' ";
			 if(!dmsc.getDeliveryDateStart().equals("")&&!dmsc.getDeliveryDateEnd().equals("")) {
	 				sql+=" and O.ODATE between TO_DATE('"+dmsc.getDeliveryDateStart()+"','YYYY-MM-DD') and"+
	 			" TO_DATE('"+dmsc.getDeliveryDateEnd()+"','YYYY-MM-DD')+0.99999";
	 			}
		 }else if(dmsc.getDeliverySearchType().equals("�ֹ��ڸ�")&&dmsc.getDeliverySearchKeywrod()!="") {
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
			System.out.println("getDeliveryList() = sql�������� : "+e);
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
			 System.out.println("���="+result);
			 result=pstmt.executeUpdate();
			 
			 if(result==1) {
				 System.out.println("��ۻ��� ���� ����");
			 }else {
				 System.out.println("��ۻ��� ���� ����");
			 }
		} catch (SQLException e) {
			// TODO: handle exception
		}finally {
			close(con, pstmt, rs);
		}
		return result;
	}
	
	public int[] getOrderState() {
		String sql="  select (select count(ostate) from  order_item where ostate='����غ���')as done, \r\n" + 
				"            (select count(ostate) from  order_item where ostate='�����')as ing,\r\n" + 
				"            (select count(ostate) from  order_item where ostate='��ۿϷ�')as preper\r\n" + 
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
				//System.out.println("����غ���"+result[0]);
				result[1]=rs.getInt(2);
				//System.out.println("�����"+result[1]);
				result[2]=rs.getInt(3);
				//System.out.println("��ۿϷ�"+result[2]);
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
			System.out.println("sql���� ����");
		}finally {
			close(con, pstmt, rs);
		}
		return result;
	}
	
	//�ֹ� �����ϸ� ������ (-)
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
			System.out.println("[����]updatePstock()�޼ҵ��� ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}
