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
     * 총방문자수를 증가시킨다.
     */
	public void setTotalCount() {
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            
            // 쿼리생성
            // 총 방문자수를 증가시키기 위해 테이블에 현재 날짜 값을 추가시킨다.
            String sql ="INSERT INTO VISIT (V_DATE) VALUES (sysdate)";
            
            // 커넥션을 가져온다.
            con = getConnection();
                        
            // 자동 커밋을 false로 한다.
            con.setAutoCommit(false);
            
            pstmt = con.prepareStatement(sql.toString());
            // 쿼리 실행
            pstmt.executeUpdate();
            // 완료시 커밋
            con.commit(); 
            
        } catch (SQLException sqle) {
            System.out.println("에러 setTotalCount()메소드 오류 = "+sqle.getMessage());
        } finally {
            close(con, pstmt);
        }
    } // end setTotalCount()
	
	/**
     * 총 방문자수를 가져온다.
     * @return totalCount : 총 방문자 수
     */
	
	public int getTotalCount() {
    
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int totalCount = 0;
        
        try {
            
            // 테이블의 테이터 수를 가져온다.
            // 데이터 수 = 총 방문자 수
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT COUNT(*) AS TotalCnt FROM VISIT");
            
            con = getConnection();
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();
            
            // 방문자 수를 변수에 담는다.
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
     * 오늘 방문자 수를 가져온다.
     * @return todayCount : 오늘 방문자
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
            
            // 방문자 수를 변수에 담는다.
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
			System.out.println("[에러]getTodayQboard() = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
        return todayQboard;
    }
	
}
