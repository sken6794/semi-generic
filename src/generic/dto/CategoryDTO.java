package generic.dto;
/*
 이름     널?       유형           
------ -------- ------------ 
CTNO   NOT NULL NUMBER(2)    
CTNAME          VARCHAR2(20) 
 */
public class CategoryDTO {
	private int ctno;
	private String ctname;
	
	public CategoryDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getCtno() {
		return ctno;
	}

	public void setCtno(int ctno) {
		this.ctno = ctno;
	}

	public String getCtname() {
		return ctname;
	}

	public void setCtname(String ctname) {
		this.ctname = ctname;
	}
	
}
