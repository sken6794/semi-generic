package generic.page;

public class DeliveryManagementSearchCriteria extends Page {
	private String deliverySearchType="";
	private String deliverySearchKeywrod;
	
	private String deliveryDateStart="";
	private String deliveryDateEnd="";
	
	
	public String getDeliverySearchType() {
		return deliverySearchType;
	}
	public void setDeliverySearchType(String deliverySearchType) {
		this.deliverySearchType = deliverySearchType;
	}
	public String getDeliverySearchKeywrod() {
		return deliverySearchKeywrod;
	}
	public void setDeliverySearchKeywrod(String deliverySearchKeywrod) {
		this.deliverySearchKeywrod = deliverySearchKeywrod;
	}
	public String getDeliveryDateStart() {
		return deliveryDateStart;
	}
	public void setDeliveryDateStart(String deliveryDateStart) {
		this.deliveryDateStart = deliveryDateStart;
	}
	public String getDeliveryDateEnd() {
		return deliveryDateEnd;
	}
	public void setDeliveryDateEnd(String deliveryDateEnd) {
		this.deliveryDateEnd = deliveryDateEnd;
	}
}
