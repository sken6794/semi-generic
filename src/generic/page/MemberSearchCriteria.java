package generic.page;

public class MemberSearchCriteria extends Page {
	private String MemberSearchType;
	private String MemberSearchKeyword;
	
	public String getMemberSearchType() {
		return MemberSearchType;
	}
	public void setMemberSearchType(String memberSearchType) {
		MemberSearchType = memberSearchType;
	}
	public String getMemberSearchKeyword() {
		return MemberSearchKeyword;
	}
	public void setMemberSearchKeyword(String memberSearchKeyword) {
		MemberSearchKeyword = memberSearchKeyword;
	}
	
	
}
