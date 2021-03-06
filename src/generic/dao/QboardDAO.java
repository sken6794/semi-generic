package generic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import generic.dto.QboardDTO;


public class QboardDAO extends JdbcDAO {
	private static QboardDAO _dao;
	
	private QboardDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new QboardDAO();
	}
	
	public static QboardDAO getDAO() {
		return _dao;
	}
	

	//제품번호를 전달받아 R_BOARD 테이블에 저장된 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectPidQboardCount(int pid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			
			String sql="select count(*) from q_board where pid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pid);

			rs=pstmt.executeQuery();
					
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQboardCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
			   
	
	//Q_BOARD 테이블에 저장된 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectQboardCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			
			String sql="select count(*) from q_board";
			pstmt=con.prepareStatement(sql);

			rs=pstmt.executeQuery();
					
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQboardCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//게시글의 시작 행번호와 종료 행번호를 전달받아 Q_BOARD 테이블에 저장된 
	//	게시글에서 시작과 종료 범위에 포함된 게시글만 검색하여 반환하는 메소드
	public List<QboardDTO> selectQboard(int pid, int startQrow, int endQrow) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<QboardDTO> qboardList=new ArrayList<QboardDTO>();
		try {
			con=getConnection();
			
			String sql="select * from (select rownum rn,temp.* from "
				    +"(select * from q_board where pid=? order by qstatus, qdate desc) temp) where rn between ? and ? order by qstatus";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, startQrow);
			pstmt.setInt(3, endQrow);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				QboardDTO qboard=new QboardDTO();
				qboard.setQno(rs.getInt("qno"));
				qboard.setPid(rs.getInt("pid"));
				qboard.setQpname(rs.getString("qpname"));
				qboard.setQwriter(rs.getString("qwriter"));
				qboard.setQmid(rs.getString("qmid"));
				qboard.setQtitle(rs.getString("qtitle"));
				qboard.setQcontent(rs.getString("qcontent"));
				qboard.setQdate(rs.getString("qdate"));				
				qboard.setQstatus(rs.getInt("qstatus"));
				qboard.setQanswer(rs.getInt("qanswer"));
				qboard.setQacontent(rs.getString("qacontent"));
				qboardList.add(qboard);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQboard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qboardList;
	}
	
	//제품번호를 전달받아 삭제되지 않은 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectNoDeleteQCount(int pid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			
			String sql="select count(*) from q_board where pid=? and qstatus=0";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pid);

			rs=pstmt.executeQuery();
					
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoDeleteQCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	//Q_BOARD_SEQ 시퀸스 객체의 다음값을 검색하여 반환하는 메소드
	public int selectQNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		
		try {
			con=getConnection();
			
			String sql="select q_board_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		} 
		return nextNum;
	}
		
	//게시글을 전달받아 Q_BOARD 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertQboard(QboardDTO qboard) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into q_board  values(?, ?, ?, ?, ?, ?, ?, sysdate, 0, 0, null)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, qboard.getQno());
			pstmt.setInt(2, qboard.getPid());
			pstmt.setString(3, qboard.getQpname());
			pstmt.setString(4, qboard.getQwriter());
			pstmt.setString(5, qboard.getQmid());
			pstmt.setString(6, qboard.getQtitle());
			pstmt.setString(7, qboard.getQcontent());
			
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertQboard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//부모글의 정보를 전달받아 Q_BOARD 테이블에 저장된 게시글 정보를 변경하고 변경행의 갯수를 반환하는 메소드
	// => 게시글의 그룹번호가 부모글의 그룹번호와 같고 게시글의 글 순서가 
	//	  부모글의 글 순서보다 큰 게시글의 글 순서 컬럼값을 1 증가되도록 변경
	public int updateQReStep(int ref, int reStep) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="update q_board set qrestep=qrestep+1 where qref=? and qrestep>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, reStep);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateQReStep() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
		
	}
					
	//게시글 번호를 전달받아 Q_BOARD 테이블에 저장된 게시글을 검색하여 반환하는 메소드
	public QboardDTO selectQnoQboard(int qno) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		QboardDTO qboard=null;
		
		try {
			con=getConnection();
			
			String sql="select * from q_board where qno=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qno);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) { //단일행
				qboard=new QboardDTO();
				qboard.setQno(rs.getInt("qno"));
				qboard.setPid(rs.getInt("pid"));
				qboard.setQpname(rs.getString("qpname"));
				qboard.setQwriter(rs.getString("qwriter"));
				qboard.setQmid(rs.getString("qmid"));
				qboard.setQtitle(rs.getString("qtitle"));
				qboard.setQcontent(rs.getString("qcontent"));
				qboard.setQdate(rs.getString("qdate"));					
				qboard.setQstatus(rs.getInt("qstatus"));
				qboard.setQanswer(rs.getInt("qanswer"));
				qboard.setQacontent(rs.getString("qacontent"));
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectQnoQboard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qboard;
		
	}
	
	//게시글 번호를 전달받아 BOARD 테이블에 저장된 해당 게시글을 삭제처리하고 처리 행의 갯수를 반환하는 메소드
	// => 게시글의 상태 컬럼값을 삭제 상태로 변경(실제로 삭제x, 삭제된것처럼만 보여줌)
	public int deleteQboard(int qno) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con=getConnection();
			
			String sql="update q_board set qstatus=9 where qno=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qno);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteQboard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//게시글 번호와 답변내용을 전달받아 해당 게시글의 답변내용을 삽입,변경 후 변경행의 갯수 반환하는 메소드
	public int updateQboardAnswer(String acontent, int qno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows=0;
		try {
			con = getConnection();
			String sql = "update q_board set qacontent=? where qno=?";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1, acontent);
			pstmt.setInt(2, qno);
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateQboardAnswer() 메소드의 SQL 오류 = "+e.getMessage());

		} finally {
			close(con, pstmt);
		}
		return rows;
	}

}
