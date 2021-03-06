package generic.page;

public class Page {
	public int num;//현제 페이지 번호
	private int count;//게시물 총갯수
	private int postNum=10;//한 페이지에 출력할 게시물 갯수
	private int pageNum;//하단 페이징 번호 게시물총갯수 / 한페이지에 출력할갯수 의 올림
	private int displayPost;//출력할 게시물
	private int pageNumCnt=10;//한번에 표시할 페이징 번호의 갯수
	private int endPageNum;//표시되는 페이지 번호 중 마지막 번호
	private int startPageNum;//표시되는 페이지 번호중 첫번째 번호
	private boolean prev;
	private boolean next;
	
	private int endPageNum_tmp;
	//private String serchType;
	//private String keyword;
	
	
	public void setNum(int num) {
		this.num = num;
		
		
	}
	public int getNum() {
		return num;
	}
	public void setCount(int count) {
		this.count = count;
		dataCalc();
	}

	public int getCount() {
		return count;
	}
	
	public int getPostNum() {
		return postNum;
	}
	public int getPageNum() {
		return pageNum;
	}
	public int getDisplayPost() {
		//System.out.println(displayPost);
		return displayPost;
	}
	public int getPageNumCnt() {
		return pageNumCnt;
	}
	public int getEndPageNum() {
		return endPageNum;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public int getEndPageNum_tmp() {
		return endPageNum_tmp;
	}
	
	public boolean getPrev() {
		return prev;
	}
	public boolean getNext() {
		return next;
	}
	private void dataCalc() {
		//마지막번호
		endPageNum = (int)(Math.ceil((double)num/(double)pageNumCnt)*pageNumCnt);
		//시작번호
		startPageNum=endPageNum-(pageNumCnt-1);
		//마지막 번호 재계산
		endPageNum_tmp=(int)(Math.ceil((double)count/(double)pageNumCnt));
		
		if(endPageNum>endPageNum_tmp) {
			endPageNum=endPageNum_tmp;
		}
		//postNum*=num;
		prev=startPageNum==1?false:true;
		next=endPageNum*pageNumCnt>=count?false:true;
		displayPost =(num-1)*postNum+1;//출력할 게시물
		postNum*=num;
		
	}
}
