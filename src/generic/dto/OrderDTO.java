package generic.dto;

/*
 이름        널?       유형            
--------- -------- ------------- 
ONO       NOT NULL NUMBER        
MID       NOT NULL VARCHAR2(15)  
ORNAME             VARCHAR2(20)  
OADDRESS           VARCHAR2(100) 
OADDRESS2          VARCHAR2(100) 
OADDRESS3          VARCHAR2(100) 
OPHONE             VARCHAR2(15)  
OREQUIRE           VARCHAR2(100) 
ODATE              DATE          
OSTATE             VARCHAR2(20)  
ONAME              VARCHAR2(30)  
 */
public class OrderDTO {
	private int ono;
	private String mid;
	private String orname;
	private String oaddress;
	private String oaddress2;
	private String oaddress3;
	private String ophone;
	private String orequire;	
	private String odate;
	private String ostate;
	private String oname;
	//private OrderProductDTO orderProduct = new OrderProductDTO();
	private ProductDTO product = new ProductDTO();
	private MemberDTO member = new MemberDTO();
	
	public OrderDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getOno() {
		return ono;
	}

	public void setOno(int ono) {
		this.ono = ono;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getOrname() {
		return orname;
	}

	public void setOrname(String orname) {
		this.orname = orname;
	}

	public String getOaddress() {
		return oaddress;
	}

	public void setOaddress(String oaddress) {
		this.oaddress = oaddress;
	}

	public String getOaddress2() {
		return oaddress2;
	}

	public void setOaddress2(String oaddress2) {
		this.oaddress2 = oaddress2;
	}

	public String getOaddress3() {
		return oaddress3;
	}

	public void setOaddress3(String oaddress3) {
		this.oaddress3 = oaddress3;
	}

	public String getOphone() {
		return ophone;
	}

	public void setOphone(String ophone) {
		this.ophone = ophone;
	}

	public String getOrequire() {
		return orequire;
	}

	public void setOrequire(String orequire) {
		this.orequire = orequire;
	}

	public String getOdate() {
		return odate;
	}

	public void setOdate(String odate) {
		this.odate = odate;
	}

	public String getOstate() {
		return ostate;
	}

	public void setOstate(String ostate) {
		this.ostate = ostate;
	}

	public String getOname() {
		return oname;
	}

	public void setOname(String oname) {
		this.oname = oname;
	}

	

	public ProductDTO getProduct() {
		return product;
	}

	public void setProduct(ProductDTO product) {
		this.product = product;
	}

	public MemberDTO getMember() {
		return member;
	}

	public void setMember(MemberDTO member) {
		this.member = member;
	}
	
	
	
	
}
