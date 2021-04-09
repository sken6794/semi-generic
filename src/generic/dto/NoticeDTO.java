package generic.dto;
/*
이름       널?       유형             
-------- -------- -------------- 
NID      NOT NULL NUMBER(4)      - 공지사항 번호
NTITLE            VARCHAR2(90)   - 제목
NDATE             DATE           - 작성일
NWRITER           VARCHAR2(30)   - 작성자
NCONTENT          VARCHAR2(1500) - 내용
NSTATUS           NUMBER(2)      - 상태(0:일반글, 9: 삭제글)
NCOUNT            NUMBER(10)     - 조회수
NIMG              VARCHAR2(1500) - 이미지 등록 
*/
public class NoticeDTO {
   private int nid;
   private String ntitle;
   private String ndate;
   private String nwriter;
   private String ncontent;
   private int nstatus;
   private int ncount;
   private String nimg;
   
   public NoticeDTO() {
      // TODO Auto-generated constructor stub
   }

public int getNid() {
	return nid;
}

public void setNid(int nid) {
	this.nid = nid;
}

public String getNtitle() {
	return ntitle;
}

public void setNtitle(String ntitle) {
	this.ntitle = ntitle;
}

public String getNdate() {
	return ndate;
}

public void setNdate(String ndate) {
	this.ndate = ndate;
}

public String getNwriter() {
	return nwriter;
}

public void setNwriter(String nwriter) {
	this.nwriter = nwriter;
}

public String getNcontent() {
	return ncontent;
}

public void setNcontent(String ncontent) {
	this.ncontent = ncontent;
}

public int getNstatus() {
	return nstatus;
}

public void setNstatus(int nstatus) {
	this.nstatus = nstatus;
}

public int getNcount() {
	return ncount;
}

public void setNcount(int ncount) {
	this.ncount = ncount;
}

public String getNimg() {
	return nimg;
}

public void setNimg(String nimg) {
	this.nimg = nimg;
}

	
}