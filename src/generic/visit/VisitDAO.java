package generic.visit;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import generic.dao.JdbcDAO;



public class VisitDAO extends JdbcDAO {
private static VisitDAO _dao;
	
	private  VisitDAO() {
		
	}
	
	static {
		_dao = new VisitDAO();
	}
	
	public static VisitDAO getDAO() {
		return _dao;
	}
	
	/**
     * �ѹ湮�ڼ��� ������Ų��.
     */
	public void setTotalCount() {
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            
            // ��������
            // �� �湮�ڼ��� ������Ű�� ���� ���̺� ���� ��¥ ���� �߰���Ų��.
            String sql ="INSERT INTO VISIT (V_DATE) VALUES (sysdate)";
            
            // Ŀ�ؼ��� �����´�.
            con = getConnection();
                        
            // �ڵ� Ŀ���� false�� �Ѵ�.
            con.setAutoCommit(false);
            
            pstmt = con.prepareStatement(sql.toString());
            // ���� ����
            pstmt.executeUpdate();
            // �Ϸ�� Ŀ��
            con.commit(); 
            
        } catch (SQLException sqle) {
            System.out.println("���� setTotalCount()�޼ҵ� ���� = "+sqle.getMessage());
        } finally {
            close(con, pstmt);
        }
    } // end setTotalCount()
	
	/**
     * �� �湮�ڼ��� �����´�.
     * @return totalCount : �� �湮�� ��
     */
	
	public int getTotalCount() {
    
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int totalCount = 0;
        
        try {
            
            // ���̺��� ������ ���� �����´�.
            // ������ �� = �� �湮�� ��
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT COUNT(*) AS TotalCnt FROM VISIT");
            
            con = getConnection();
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();
            
            // �湮�� ���� ������ ��´�.
            if (rs.next()) 
                totalCount = rs.getInt("TotalCnt");
            
            return totalCount;
            
        } catch (Exception sqle) {
            throw new RuntimeException(sqle.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
    } // end getTotalCount()
	
	/**
     * ���� �湮�� ���� �����´�.
     * @return todayCount : ���� �湮��
     */
    public int getTodayCount()
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int todayCount = 0;
        
        try {
            
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT COUNT(*) AS TodayCnt FROM VISIT");
            sql.append(" WHERE TO_DATE(V_DATE, 'YYYY-MM-DD') = TO_DATE(sysdate, 'YYYY-MM-DD')");
            
            con = getConnection();
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();
            
            // �湮�� ���� ������ ��´�.
            if (rs.next()) 
                todayCount = rs.getInt("TodayCnt");
            
            return todayCount;
            
        } catch (Exception sqle) {
            throw new RuntimeException(sqle.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
    }// end getTodayCount()
	
    public int getTodayQboard() {
    	Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int todayQboard = 0;
        try {
			con = getConnection();
			String sql = "SELECT COUNT(*) AS TodayCnt FROM q_board\r\n" + 
					"WHERE TO_DATE(qDATE, 'YYYY-MM-DD') = TO_DATE(sysdate, 'YYYY-MM-DD')";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				todayQboard = rs.getInt("TodayCnt");
			}
		} catch (SQLException e) {
			System.out.println("[����]getTodayQboard() = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
        return todayQboard;
    }
	
}
