package generic.dto;

/*
이름          널?       유형            
----------- -------- ------------- 
MID         NOT NULL VARCHAR2(15)  
MPW         NOT NULL VARCHAR2(300) 
MNAME       NOT NULL VARCHAR2(20)  
MGENDER     NOT NULL NUMBER(1)     
MEMAIL      NOT NULL VARCHAR2(30)  
MPHONE      NOT NULL VARCHAR2(15)  
MENROLLDATE NOT NULL DATE          
MSTATUS      NOT NULL NUMBER(1)     
MDELETEDATE NOT NULL DATE          
MADDRESS1   NOT NULL VARCHAR2(200) 
MADDRESS2   NOT NULL VARCHAR2(200) 
MADDRESS3   NOT NULL VARCHAR2(200) 
*/

public class MemberDTO {	
	private String mid;
	private String mpw;
	private String mname;
	private int mgender;
	private String memail;
	private String mphone;
	private String maddress1;
	private String maddress2;
	private String maddress3;
	private String menrolldate;
	private String mdeletedate;
	private int mstatus;
	
public MemberDTO() {
	// TODO Auto-generated constructor stub
}

public String getMid() {
	return mid;
}

public void setMid(String mid) {
	this.mid = mid;
}

public String getMpw() {
	return mpw;
}

public void setMpw(String mpw) {
	this.mpw = mpw;
}

public String getMname() {
	return mname;
}

public void setMname(String mname) {
	this.mname = mname;
}

public int getMgender() {
	return mgender;
}

public void setMgender(int mgender) {
	this.mgender = mgender;
}

public String getMemail() {
	return memail;
}

public void setMemail(String memail) {
	this.memail = memail;
}

public String getMphone() {
	return mphone;
}

public void setMphone(String mphone) {
	this.mphone = mphone;
}

public String getMaddress1() {
	return maddress1;
}

public void setMaddress1(String maddress1) {
	this.maddress1 = maddress1;
}

public String getMaddress2() {
	return maddress2;
}

public void setMaddress2(String maddress2) {
	this.maddress2 = maddress2;
}

public String getMaddress3() {
	return maddress3;
}

public void setMaddress3(String maddress3) {
	this.maddress3 = maddress3;
}

public String getMenrolldate() {
	return menrolldate;
}

public void setMenrolldate(String menrolldate) {
	this.menrolldate = menrolldate;
}

public String getMdeletedate() {
	return mdeletedate;
}

public void setMdeletedate(String mdeletedate) {
	this.mdeletedate = mdeletedate;
}

public int getMstatus() {
	return mstatus;
}

public void setMstatus(int mstatus) {
	this.mstatus = mstatus;
}



}
