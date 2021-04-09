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
	

	//��ǰ��ȣ�� ���޹޾� R_BOARD ���̺��� ����� �Խñ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]selectQboardCount() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
			   
	
	//Q_BOARD ���̺��� ����� �Խñ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]selectQboardCount() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//�Խñ��� ���� ���ȣ�� ���� ���ȣ�� ���޹޾� Q_BOARD ���̺��� ����� 
	//	�Խñۿ��� ���۰� ���� ������ ���Ե� �Խñ۸� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]selectQboard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qboardList;
	}
	
	//��ǰ��ȣ�� ���޹޾� �������� ���� �Խñ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]selectNoDeleteQCount() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	//Q_BOARD_SEQ ������ ��ü�� �������� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]selectQNextNum() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		} 
		return nextNum;
	}
		
	//�Խñ��� ���޹޾� Q_BOARD ���̺��� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]insertQboard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//�θ���� ������ ���޹޾� Q_BOARD ���̺��� ����� �Խñ� ������ �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
	// => �Խñ��� �׷��ȣ�� �θ���� �׷��ȣ�� ���� �Խñ��� �� ������ 
	//	  �θ���� �� �������� ū �Խñ��� �� ���� �÷����� 1 �����ǵ��� ����
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
			System.out.println("[����]updateQReStep() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
		
	}
					
	//�Խñ� ��ȣ�� ���޹޾� Q_BOARD ���̺��� ����� �Խñ��� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
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
			
			if(rs.next()) { //������
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
			System.out.println("[����]selectQnoQboard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qboard;
		
	}
	
	//�Խñ� ��ȣ�� ���޹޾� BOARD ���̺��� ����� �ش� �Խñ��� ����ó���ϰ� ó�� ���� ������ ��ȯ�ϴ� �޼ҵ�
	// => �Խñ��� ���� �÷����� ���� ���·� ����(������ ����x, �����Ȱ�ó���� ������)
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
			System.out.println("[����]deleteQboard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//�Խñ� ��ȣ�� �亯������ ���޹޾� �ش� �Խñ��� �亯������ ����,���� �� �������� ���� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]updateQboardAnswer() �޼ҵ��� SQL ���� = "+e.getMessage());

		} finally {
			close(con, pstmt);
		}
		return rows;
	}

}