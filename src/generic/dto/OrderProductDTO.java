package generic.dto;
/*
이름      널?       유형           
------- -------- ------------ 
OPN     NOT NULL NUMBER       
ONO     NOT NULL NUMBER       
PID     NOT NULL NUMBER(4) 
OPQTY   NOT NULL NUMBER(10) 
 */
public class OrderProductDTO {
	
	private int opn;
	private int ono;
	private int pid;
	private int opqty;
	private ProductDTO product = new ProductDTO();
	private OrderDTO order = new OrderDTO();
	
	
	public OrderProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getOpn() {
		return opn;
	}

	public void setOpn(int opn) {
		this.opn = opn;
	}

	public int getOno() {
		return ono;
	}

	public void setOno(int ono) {
		this.ono = ono;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getOpqty() {
		return opqty;
	}

	public void setOpqty(int opqty) {
		this.opqty = opqty;
	}

	public ProductDTO getProduct() {
		return product;
	}

	public void setProduct(ProductDTO product) {
		this.product = product;
	}

	public OrderDTO getOrder() {
		return order;
	}

	public void setOrder(OrderDTO order) {
		this.order = order;
	}
	
	
	
}
