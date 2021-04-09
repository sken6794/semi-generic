package generic.page;

public class OrderSearchCriteria extends Page {
	
	private String orderSearchType="";
	private String orderSearchKeyword;
	
	private String orderDateStart="";
	private String orderDateEnd="";
	
	private String orderState="";

	public String getOrderSearchType() {
		return orderSearchType;
	}

	public void setOrderSearchType(String orderSearchType) {
		this.orderSearchType = orderSearchType;
	}

	public String getOrderSearchKeyword() {
		return orderSearchKeyword;
	}

	public void setOrderSearchKeyword(String orderSearchKeyword) {
		this.orderSearchKeyword = orderSearchKeyword;
	}

	public String getOrderDateStart() {
		return orderDateStart;
	}

	public void setOrderDateStart(String orderDateStart) {
		this.orderDateStart = orderDateStart;
	}

	public String getOrderDateEnd() {
		return orderDateEnd;
	}

	public void setOrderDateEnd(String orderDateEnd) {
		this.orderDateEnd = orderDateEnd;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}
	
	
}
