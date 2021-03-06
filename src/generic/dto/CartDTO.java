package generic.dto;
/*
 이름     널?       유형           
------ -------- ------------ 
CNO    NOT NULL NUMBER(5)    
MID    NOT NULL VARCHAR2(15) 
CPNAME          VARCHAR2(30) 
CQTY            NUMBER(3)    
CPRICE          NUMBER(7)    
PID    NOT NULL NUMBER(4)  
 */
public class CartDTO {
	private int cno;
	private String mid;
	private String cpname;
	private int cqty;
	private int cprice;
	private int pid;
	private ProductDTO product = new ProductDTO();
	
	public CartDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getCpname() {
		return cpname;
	}

	public void setCpname(String cpname) {
		this.cpname = cpname;
	}

	public int getCqty() {
		return cqty;
	}

	public void setCqty(int cqty) {
		this.cqty = cqty;
	}

	public int getCprice() {
		return cprice;
	}

	public void setCprice(int cprice) {
		this.cprice = cprice;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public ProductDTO getProduct() {
		return product;
	}

	public void setProduct(ProductDTO product) {
		this.product = product;
	}
	
	
}
