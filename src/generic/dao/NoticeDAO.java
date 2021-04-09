package generic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import generic.dto.NoticeDTO; 


public class NoticeDAO extends JdbcDAO {
private static NoticeDAO _dao;
   
   private NoticeDAO() {
      // TODO Auto-generated constructor stub
   }
   
   static {
      _dao=new NoticeDAO();
   }
   
   public static NoticeDAO getDAO() {
      return _dao;
   }
   
   //�������� ����¡(ī����)
   public int noticeCount(String search, String keyword) {
      Connection con=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      int count=0;
      try {
         con=getConnection();
         
         if(keyword.equals("")) {
            String sql="select count(*) from notice";
            pstmt=con.prepareStatement(sql);
         } else {//�ϴ� �˻� ����� ����� ���
            String sql="select count(*) from notice where "+search+" like '%'||?||'%'";
            pstmt=con.prepareStatement(sql);
            pstmt.setString(1, keyword);
         }
         rs=pstmt.executeQuery();
         
         if(rs.next()) {
            count=rs.getInt(1);
         }
         
      } catch (SQLException e) {
         System.out.println("[����] noticeCount()�޼ҵ� sql ���� = "+e.getMessage());
      } finally {
         close(con, pstmt, rs);
      }
      return count;
   }   
   
   //�������� ���̺� ��ü ���� ���(�˻���� ����, ����¡ ����)
   public List<NoticeDTO> selectNoticeList(String search, String keyword, int startRow, int endRow){
      Connection con=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      List<NoticeDTO> noticeList=new ArrayList<NoticeDTO>();      
         
      try {
         con=getConnection();
         
         if(keyword.equals("")) {//�˻���� �̻��
            String sql="select * from (select rownum rn,temp.* from ("
               + "select * from notice order by ndate desc"
               + ") temp) where rn between ? and ?";
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);
         } else {//�˻���� ���
            String sql="select * from (select rownum rn,temp.* from ("
					+ "select * from notice where "+search
					+" like '%'||?||'%' order by ndate desc"
					+ ") temp) where rn between ? and ?";
            pstmt=con.prepareStatement(sql);
            pstmt.setString(1, keyword);
            pstmt.setInt(2, startRow);
            pstmt.setInt(3, endRow);
         }
      
         rs=pstmt.executeQuery();
         
         while(rs.next()) {
            NoticeDTO notice=new NoticeDTO();            
            notice.setNid(rs.getInt("nid"));
            notice.setNtitle(rs.getString("ntitle"));
            notice.setNdate(rs.getString("ndate"));            
            notice.setNwriter(rs.getString("nwriter"));
            notice.setNcontent(rs.getString("ncontent"));
            notice.setNimg(rs.getString("nimg"));            
            notice.setNcount(rs.getInt("ncount"));            
            notice.setNstatus(rs.getInt("nstatus"));
            
            noticeList.add(notice);
         }
         
      } catch (SQLException e) {
         System.out.println("[����] selectNoticeList()�޼ҵ� sql ���� = "+e.getMessage());
      } finally {
         close(con, pstmt, rs);
      }
      return noticeList;
   }   
   
   //�������� ���̺� ��ü ���� ���
   public List<NoticeDTO> selectNoticeAllList(){
      Connection con=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      List<NoticeDTO> noticeList=new ArrayList<NoticeDTO>();      
         
      try {
         con=getConnection();         
        
            String sql="select * from notice order by ndate desc";
            pstmt=con.prepareStatement(sql);     
      
         rs=pstmt.executeQuery();
         
         while(rs.next()) {
            NoticeDTO notice=new NoticeDTO();            
            notice.setNid(rs.getInt("nid"));
            notice.setNtitle(rs.getString("ntitle"));
            notice.setNdate(rs.getString("ndate"));            
            notice.setNwriter(rs.getString("nwriter"));
            notice.setNcontent(rs.getString("ncontent"));
            notice.setNimg(rs.getString("nimg"));            
            notice.setNcount(rs.getInt("ncount"));            
            notice.setNstatus(rs.getInt("nstatus"));
            
            noticeList.add(notice);
         }
         
      } catch (SQLException e) {
         System.out.println("[����] selectNoticeList()�޼ҵ� sql ���� = "+e.getMessage());
      } finally {
         close(con, pstmt, rs);
      }
      return noticeList;
   }   
   
   //nid�� ���޹޾� �ش� �Խù� ���� ���(detail, ����, ���� �������� �Ѿ)
   public NoticeDTO selectIdNotice(int nid) {
      Connection con=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      NoticeDTO notice=null;
      try {
         con=getConnection();
         
         String sql="select * from notice where nid=?";
         pstmt=con.prepareStatement(sql);
         pstmt.setInt(1, nid);
         
         rs=pstmt.executeQuery();
         
         if(rs.next()) {
            notice=new NoticeDTO();            
            notice.setNid(rs.getInt("nid"));
            notice.setNtitle(rs.getString("ntitle"));
            notice.setNdate(rs.getString("ndate"));            
            notice.setNwriter(rs.getString("nwriter"));
            notice.setNcontent(rs.getString("ncontent"));
            notice.setNimg(rs.getString("nimg"));            
            notice.setNcount(rs.getInt("ncount"));            
            notice.setNstatus(rs.getInt("nstatus"));

         }
      } catch (SQLException e) {
         System.out.println("[����]selectIdNotice() �޼ҵ��� SQL ���� = "+e.getMessage());

      } finally {
         close(con, pstmt, rs);
      }
      return notice;
   }
   
   //�������� ����
   public int updateNotice(NoticeDTO notice) {
      Connection con=null;
      PreparedStatement pstmt=null;
      int rows=0;
      
      try {
         con=getConnection();
         
         String sql="update notice set ntitle=?, ndate=sysdate, nwriter=?, ncontent=?, nimg=? where nid=?";
         pstmt=con.prepareStatement(sql);
         pstmt.setString(1, notice.getNtitle());
         pstmt.setString(2, notice.getNwriter());
         pstmt.setString(3, notice.getNcontent());
         pstmt.setString(4, notice.getNimg());
         pstmt.setInt(5, notice.getNid());
         
         rows=pstmt.executeUpdate();
      } catch (SQLException e) {
         System.out.println("[����]updateNotice() �޼ҵ��� SQL ���� = "+e.getMessage());
      } finally {
         close(con, pstmt);
      }
      return rows;
   }
   
   //�������� ����
   public int deleteNotice(NoticeDTO notice) {
      Connection con=null;
      PreparedStatement pstmt=null;
      int rows=0;
      
      try {
         con=getConnection();
         
         String sql="delete from notice where nid=?";
         pstmt=con.prepareStatement(sql);         
         pstmt.setInt(1, notice.getNid());
         
         rows=pstmt.executeUpdate();
      } catch (SQLException e) {
         System.out.println("[����]deleteNotice() �޼ҵ��� SQL ���� = "+e.getMessage());
      } finally {
         close(con, pstmt);
      }
      return rows;
   }
   
   //�������� ����(���۾���)
   public int insertNotice(NoticeDTO notice) {
      Connection con=null;
      PreparedStatement pstmt=null;
      int rows=0;
      try {
         con=getConnection();
         
         String sql="insert into notice values(?, ?, sysdate, ?, ?, 0, 0, ?)";
         pstmt=con.prepareStatement(sql);
         pstmt.setInt(1, notice.getNid());
         pstmt.setString(2, notice.getNtitle());
         pstmt.setString(3, notice.getNwriter());       
         pstmt.setString(4, notice.getNcontent());
         pstmt.setString(5, notice.getNimg());
         
         rows=pstmt.executeUpdate();
      } catch (SQLException e) {
         System.out.println("[����]insertNotice() �޼ҵ��� SQL ���� = "+e.getMessage());
      } finally {
         close(con, pstmt);
      }
      return rows;
   }
   
   //NOTICE_SEQ ������ ��ü�� �������� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
      public int selectNextNum() {
         Connection con=null;
         PreparedStatement pstmt=null;
         ResultSet rs=null;
         int nextNum=0;
         try {
            con=getConnection();
            
            String sql="select notice_seq.nextval from dual";
            pstmt=con.prepareStatement(sql);
            
            rs=pstmt.executeQuery();
            
            if(rs.next()) {
               nextNum=rs.getInt(1);
            }
         } catch (SQLException e) {
            System.out.println("[����]selectNextNum() �޼ҵ��� SQL ���� = "+e.getMessage());
         } finally {
            close(con, pstmt, rs);
         } 
         return nextNum;
      }
      
      //�Խñ۹�ȣ�� ���޹޾� ���̺� ����� �ش� �Խñ��� ��ȸ���� 1 �����ǵ��� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
      public int updateCountNotice(int nid) {
      Connection con=null;
      PreparedStatement pstmt=null;
      int rows=0;
      try {
         con=getConnection();
         
         String sql="update notice set ncount=ncount+1 where nid=?";
         pstmt=con.prepareStatement(sql);
         pstmt.setInt(1, nid);
         
         rows=pstmt.executeUpdate();
      } catch (SQLException e) {
         System.out.println("[����]updateCountNotice() �޼ҵ��� SQL ���� = "+e.getMessage());
      } finally {
         close(con, pstmt); 
      }
      return rows;
   }
}