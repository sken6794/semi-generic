package generic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;



import generic.dto.MemberDTO;
import generic.page.MemberSearchCriteria;

public class MemberDAO extends JdbcDAO {
	private static MemberDAO _dao; 
	
	private MemberDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new MemberDAO();
	}
	
	public static MemberDAO getDAO() {
		return _dao;
	}
	
	//회원정보를 전달받아 MEMBER 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	// => 아이디,비밀번호,이름,이메일,전화번호,우편번호,기본주소,상세주소는 입력값을 이용하여 저장
	// => 회원가입일 : 현재, 마지막 로그인 : null, 회원상태 : 1(일반회원)
	public int insertMember(MemberDTO member) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into member values(?,?,?,?,?,?,sysdate,1,null,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member.getMid());
			pstmt.setString(2, member.getMpw());
			pstmt.setString(3, member.getMname());
			pstmt.setInt(4, member.getMgender());
			pstmt.setString(5, member.getMemail());
			pstmt.setString(6, member.getMphone());
			pstmt.setString(7, member.getMaddress1());
			pstmt.setString(8, member.getMaddress2());
			pstmt.setString(9, member.getMaddress3());
			
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원정보를 
	//검색하여 반환하는 메소드 - 단일행 검색
	public MemberDTO selectIdMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberDTO member=null;
		try {
			con=getConnection(); 
			
			String sql="select * from member where mid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				member=new MemberDTO();
				member.setMid(rs.getString("mid"));
				member.setMpw(rs.getString("mpw"));
				member.setMname(rs.getString("mname"));
				member.setMgender(rs.getInt("mgender"));
				member.setMemail(rs.getString("memail"));
				member.setMphone(rs.getString("mphone"));
				member.setMenrolldate(rs.getString("menrolldate"));
				member.setMstatus(rs.getInt("mstatus"));
				member.setMdeletedate(rs.getString("mdeletedate"));
				member.setMaddress1(rs.getString("maddress1"));
				member.setMaddress2(rs.getString("maddress2"));
				member.setMaddress3(rs.getString("maddress3"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectIdMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 회원의 마지막 로그인 날짜를 
	//시스템의 현재 날짜로 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateLastLogin(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set mdeletedate=sysdate where mid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateLastLogin() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//회원정보를 전달받아 MEMBER 테이블에 저장된 회원정보를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateMember(MemberDTO member) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set mpw=?,memail=?,mphone=?,maddress1=?,maddress2=?,maddress3=? where mid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member.getMpw());
			pstmt.setString(2, member.getMemail());
			pstmt.setString(3, member.getMphone());
			pstmt.setString(4, member.getMaddress1());
			pstmt.setString(5, member.getMaddress2());
			pstmt.setString(6, member.getMaddress3());
			pstmt.setString(7, member.getMid());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 해당 회원정보를 삭제
	//하고 삭제행의 갯수를 반환하는 메소드
	public int deleteMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from member where mid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//회원정보를 전달받아 MEMBER 테이블에 저장된 회원정보를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateDelMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set mstatus=2 where mid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//이름과 이메일를 전달받아 MEMBER 테이블에 저장된 해당 아이디를 
	//검색하여 반환하는 메소드 - 단일행 검색
	public MemberDTO findIdMember(String name) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberDTO member=null;
		try {
			con=getConnection();
			
			String sql="select * from member where mname=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, name);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				member=new MemberDTO();
				member.setMid(rs.getString("mid"));
				member.setMpw(rs.getString("mpw"));
				member.setMname(rs.getString("mname"));
				member.setMgender(rs.getInt("mgender"));
				member.setMemail(rs.getString("memail"));
				member.setMphone(rs.getString("mphone"));
				member.setMenrolldate(rs.getString("menrolldate"));
				member.setMstatus(rs.getInt("mstatus"));
				member.setMdeletedate(rs.getString("mdeletedate"));
				member.setMaddress1(rs.getString("maddress1"));
				member.setMaddress2(rs.getString("maddress2"));
				member.setMaddress3(rs.getString("maddress3"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]findIdMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}

	//회원정보를 전달받아 MEMBER 테이블에 저장된 비밀번호를 변경하고 변경행의 갯수를 반환하는 메소드
	public int changePwMember(MemberDTO member) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set mpw=? where mid=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member.getMpw());
			pstmt.setString(2, member.getMid());

			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]changePwMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public ArrayList<MemberDTO> getMemberList(MemberSearchCriteria msc){
		ArrayList<MemberDTO> list =new ArrayList<MemberDTO>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT MNAME,MID,MENROLLDATE,MPHONE,MADDRESS1,MADDRESS2,MADDRESS3,MSTATUS FROM (\r\n" + 
				"		 SELECT MNAME,MID,MENROLLDATE,MPHONE,MADDRESS1,MADDRESS2,MADDRESS3,MSTATUS, ROWNUM as rnum FROM ( \r\n" + 
				"		 	 SELECT MNAME,MID,MENROLLDATE,MPHONE,MADDRESS1,MADDRESS2,MADDRESS3,MSTATUS FROM MEMBER";
				if(msc.getMemberSearchKeyword()!=null) {
					if(msc.getMemberSearchType().equals("아이디")) {
						sql+=" WHERE MID like '%'||?||'%'";		
					}if(msc.getMemberSearchType().equals("이름")) {
						sql+=" WHERE MNAME like '%'||?||'%' ";	
					}if(msc.getMemberSearchType().equals("이메일")) {
						sql+=" WHERE MEMAIL like '%'||?||'%' ";	
					}if(msc.getMemberSearchType().equals("핸트폰번호")) {
						sql+=" WHERE MPHONE like '%'||?||'%' ";	
					}
				}
				
				sql+=" ORDER BY MENROLLDATE DESC )\r\n" + 
				"		 		 )  WHERE rnum >= ? and rnum <=?";
				//System.out.println("memberlist sql문="+sql);
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			
			if(msc.getMemberSearchKeyword()!=null) {
				pstmt.setString(1, msc.getMemberSearchKeyword());
				pstmt.setInt(2, msc.getDisplayPost());
				pstmt.setInt(3, msc.getPostNum());
			}
			
			else {
			pstmt.setInt(1, msc.getDisplayPost());
			pstmt.setInt(2, msc.getPostNum());
			}
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto= new MemberDTO();
			    dto.setMname(rs.getString(1));
			    //System.out.println(rs.getString(1));
			    
			    dto.setMid(rs.getString(2));
			    //System.out.println(rs.getString(2));
			    
			    dto.setMenrolldate(rs.getString(3));
			    //System.out.println(rs.getString(3));
			    
			    dto.setMphone(rs.getString(4));
			    //System.out.println(rs.getString(4));
			    
			    dto.setMaddress1(rs.getString(5));
			    //System.out.println(rs.getString(5));
			    
			    dto.setMaddress2(rs.getString(6));
			    //System.out.println(rs.getString(6));
			    
			    dto.setMaddress3(rs.getString(7));
			    //System.out.println(rs.getString(7));
			    
			    dto.setMstatus(rs.getInt(8));
			    //System.out.println(rs.getInt(8));
			    
			    list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("MEMBERDAO.GETMEMBERLIST 구문오류");
		}finally {
			close(con, pstmt, rs);
		}
		
		return list;
	}
	
	public int totCount(String type, String keyword) {
		String sql="SELECT COUNT(*) FROM MEMBER";
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		if(type.equals("아이디")&&keyword!=null) {
			sql+=" where MID like '%'||?||'%'";
		}else if(type.equals("이름")&&!keyword.equals("")) {
			sql+=" where MNAME like '%'||?||'%'";
		}else if(type.equals("이메일")&&!keyword.equals("")) {
			sql+=" where MEMAIL like '%'||?||'%'";
		}else if(type.equals("핸드폰 번호")&&!keyword.equals("")) {
			sql+=" where MPHONE like '%'||?||'%'";
		}
		int result=0;
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			if(type.equals("아이디")&&keyword!=null) {
				pstmt.setString(1, keyword);
			}else if(type.equals("이름")&&!keyword.equals("")) {
				pstmt.setString(1, keyword);
			}else if(type.equals("이메일")&&!keyword.equals("")) {
				pstmt.setString(1, keyword);
			}else if(type.equals("핸드폰 번호")&&!keyword.equals("")) {
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("MEMBERDAO.TOTCOUNT 구문오류");
		}finally {
			close(con, pstmt, rs);
		}
		
		return result;
	}
	public int getMemeberCount() {
		String sql=" select count(*) from member where mstatus=1";
		int result=0;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
				System.out.println(result);
			}
		} catch (SQLException e) {
			System.out.println("getMemeverCount() sql 구문오류");
		} finally {
			close(con, pstmt, rs);
		}
		
		return result;
	}
}















