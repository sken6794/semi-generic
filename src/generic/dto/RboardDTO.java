package generic.dto;
/*
 이름       널?       유형             
-------- -------- -------------- 
RNO      NOT NULL NUMBER(4)      
PID      NOT NULL NUMBER(4)      
RPNAME            VARCHAR2(30)   
RWRITER           VARCHAR2(30)   
RMID              VARCHAR2(15)   
RSTARS            VARCHAR2(20)     
RTITLE            VARCHAR2(90)   
RCONTENT          VARCHAR2(1500) 
RDATE             DATE           
RORIGIN           VARCHAR2(100)  
RRENAME           VARCHAR2(100)  
RSTATUS           NUMBER(1)   
 */
public class RboardDTO {
	private int rno;
	private int pid;
	private String rpname;
	private String rwriter;
	private String rmid;
	private String rstars;
	private String rtitle;
	private String rcontent;
	private String rdate;
	private String rorigin;
	private String rrename;
	private int rstatus;
	
	public RboardDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getRpname() {
		return rpname;
	}

	public void setRpname(String rpname) {
		this.rpname = rpname;
	}

	public String getRwriter() {
		return rwriter;
	}

	public void setRwriter(String rwriter) {
		this.rwriter = rwriter;
	}

	public String getRmid() {
		return rmid;
	}

	public void setRmid(String rmid) {
		this.rmid = rmid;
	}

	public String getRstars() {
		return rstars;
	}

	public void setRstars(String rstars) {
		this.rstars = rstars;
	}

	public String getRtitle() {
		return rtitle;
	}

	public void setRtitle(String rtitle) {
		this.rtitle = rtitle;
	}

	public String getRcontent() {
		return rcontent;
	}

	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public String getRorigin() {
		return rorigin;
	}

	public void setRorigin(String rorigin) {
		this.rorigin = rorigin;
	}

	public String getRrename() {
		return rrename;
	}

	public void setRrename(String rrename) {
		this.rrename = rrename;
	}

	public int getRstatus() {
		return rstatus;
	}

	public void setRstatus(int rstatus) {
		this.rstatus = rstatus;
	}
	
	
	
	
}
