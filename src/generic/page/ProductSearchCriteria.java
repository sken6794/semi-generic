package generic.page;

public class ProductSearchCriteria extends Page {
	private String ProductSearchType;
	private String ProductSearchKeyword;
	
	private String ProductCategory;
	
	private String ProductRegDate;
	private String startDate;
	private String endDate;
	private int ProductStatus=-1;
	
	
	public int getProductStatus() {
		return ProductStatus;
	}
	public void setProductStatus(int productStatus) {
		ProductStatus = productStatus;
	}
	public String getProductSearchType() {
		return ProductSearchType;
	}
	public void setProductSearchType(String productSearchType) {
		ProductSearchType = productSearchType;
	}
	public String getProductSearchKeyword() {
		return ProductSearchKeyword;
	}
	public void setProductSearchKeyword(String productSearchKeyword) {
		ProductSearchKeyword = productSearchKeyword;
	}
	public String getProductCategory() {
		return ProductCategory;
	}
	public void setProductCategory(String productCategory) {
		ProductCategory = productCategory;
	}
	public String getProductRegDate() {
		return ProductRegDate;
	}
	public void setProductRegDate(String productRegDate) {
		ProductRegDate = productRegDate;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	
	
	
	
	
	

}
