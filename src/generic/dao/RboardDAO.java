package generic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import generic.dto.RboardDTO;

public class RboardDAO extends JdbcDAO {
	private static RboardDAO _dao;
	
	private RboardDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new RboardDAO();
	}
	
	public static RboardDAO getDAO() {
		return _dao;
	}

		//R_BOARD ���̺� ����� �Խñ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
		public int selectRboardCount() {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			
			try {
				con=getConnection();
				
				String sql="select count(*) from r_board";
				pstmt=con.prepareStatement(sql);
	
				rs=pstmt.executeQuery();
						
				if(rs.next()) {
					count=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[����]selectRboardCount() �޼ҵ��� SQL ���� = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return count;
		}
		
		//��ǰ��ȣ�� ���޹޾� R_BOARD ���̺� ����� �Խñ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
		public int selectPidRboardCount(int pid) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			
			try {
				con=getConnection();
				
				String sql="select count(*) from r_board where pid=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, pid);

				rs=pstmt.executeQuery();
						
				if(rs.next()) {
					count=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[����]selectRboardCount() �޼ҵ��� SQL ���� = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return count;
		}

		//��ǰ��ȣ�� ���޹޾� �������� ���� �Խñ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
		public int selectNoDeleteRCount(int pid) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			
			try {
				con=getConnection();
				
				String sql="select count(*) from r_board where pid=? and rstatus=0";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, pid);

				rs=pstmt.executeQuery();
						
				if(rs.next()) {
					count=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[����]selectNoDeleteRCount() �޼ҵ��� SQL ���� = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return count;
		}
		
		//R_BOARD_SEQ ������ ��ü�� �������� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
		public int selectRNextNum() {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int nextNum=0;
			
			try {
				con=getConnection();
				
				String sql="select r_board_seq.nextval from dual";
				pstmt=con.prepareStatement(sql);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					nextNum=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[����]selectRNextNum() �޼ҵ��� SQL ���� = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			} 
			return nextNum;
		}
			
		//�Խñ��� ���޹޾� R_BOARD ���̺� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
		public int insertRboard(RboardDTO rboard) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="insert into r_board  values(r_board_seq.nextval , ?, ?, ?, ?, ?, ?, sysdate, ?, ?, 0, ?)";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1, rboard.getPid());
				pstmt.setString(2, rboard.getRpname());
				pstmt.setString(3, rboard.getRwriter());
				pstmt.setString(4, rboard.getRmid());
				pstmt.setString(5, rboard.getRtitle());
				pstmt.setString(6, rboard.getRcontent());
				pstmt.setString(7, rboard.getRorigin());
				pstmt.setString(8, rboard.getRrename());
				pstmt.setString(9, rboard.getRstars());
				
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[����]insertRboard() �޼ҵ��� SQL ���� = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
					
		//�Խñ��� ���� ���ȣ�� ���� ���ȣ�� ���޹޾� BOARD ���̺� ����� 
		//�Խñۿ��� ���۰� ���� ������ ���Ե� �Խñ۸� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
		public List<RboardDTO> selectRboard(int pid, int startRow, int endRow) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<RboardDTO> rboardList=new ArrayList<RboardDTO>();
			try {
				con=getConnection();
				
					String sql="select * from (select rownum rn,temp.* from "
						    +"(select * from r_board where pid=? order by rstatus, rdate desc) temp) where rn between ? and ? order by rstatus";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, pid);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
				
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					RboardDTO rboard=new RboardDTO();
					rboard.setRno(rs.getInt("rno"));
					rboard.setPid(rs.getInt("pid"));
					rboard.setRpname(rs.getString("rpname"));
					rboard.setRwriter(rs.getString("rwriter"));
					rboard.setRmid(rs.getString("rmid"));
					rboard.setRstars(rs.getString("rstars"));
					rboard.setRtitle(rs.getString("rtitle"));
					rboard.setRcontent(rs.getString("rcontent"));
					rboard.setRdate(rs.getString("rdate"));
					rboard.setRorigin(rs.getString("rorigin"));
					rboard.setRrename(rs.getString("rrename"));					
					rboard.setRstatus(rs.getInt("rstatus"));
					rboardList.add(rboard);
				}
			} catch (SQLException e) {
				System.out.println("[����]selectRboard() �޼ҵ��� SQL ���� = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return rboardList;
		}
		
		//�Խñ� ��ȣ�� ���޹޾� R_BOARD ���̺� ����� �Խñ��� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
		public RboardDTO selectRnoRboard(int rno) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			RboardDTO rboard=null;
			
			try {
				con=getConnection();
				
				String sql="select * from r_board where rno=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, rno);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) { //������
					rboard=new RboardDTO();
					rboard.setRno(rs.getInt("rno"));
					rboard.setPid(rs.getInt("pid"));
					rboard.setRpname(rs.getString("rpname"));
					rboard.setRwriter(rs.getString("rwriter"));
					rboard.setRmid(rs.getString("rmid"));
					rboard.setRstars(rs.getString("rstars"));
					rboard.setRtitle(rs.getString("rtitle"));
					rboard.setRcontent(rs.getString("rcontent"));
					rboard.setRdate(rs.getString("rdate"));
					rboard.setRorigin(rs.getString("rorigin"));
					rboard.setRrename(rs.getString("rrename"));					
					rboard.setRstatus(rs.getInt("rstatus"));
				}
				
			} catch (SQLException e) {
				System.out.println("[����]selectRnoRboard() �޼ҵ��� SQL ���� = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return rboard;
			
		}
		
		//�Խñ��� ���޹޾� R_BOARD ���̺� ����� �ش� �Խñ��� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
		public int updateRboard(RboardDTO rboard) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			
			try {
				con=getConnection();
				
				String sql="update r_board set rwriter=?, rtitle=?, rcontent=?, rstars=? where rno=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, rboard.getRwriter());
				pstmt.setString(2, rboard.getRtitle());
				pstmt.setString(3, rboard.getRcontent());
				pstmt.setString(4, rboard.getRstars());
				pstmt.setInt(5, rboard.getRno());
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[����]updateRboard() �޼ҵ��� SQL ���� = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		
		//�Խñ� ��ȣ�� ���޹޾� R_BOARD ���̺� ����� �ش� �Խñ��� ����ó���ϰ� ó�� ���� ������ ��ȯ�ϴ� �޼ҵ�
		// => �Խñ��� ���� �÷����� ���� ���·� ����(������ ����x, �����Ȱ�ó���� ������)
		public int deleteRboard(int rno) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			
			try {
				con=getConnection();
				
				String sql="update r_board set rstatus=9 where rno=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, rno);
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[����]deleteRboard() �޼ҵ��� SQL ���� = "+e.getMessage());
				} finally {
					close(con, pstmt);
				}
				return rows;
			}

}
