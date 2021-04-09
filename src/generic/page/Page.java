package generic.page;

public class Page {
	public int num;//���� ������ ��ȣ
	private int count;//�Խù� �Ѱ���
	private int postNum=10;//�� �������� ����� �Խù� ����
	private int pageNum;//�ϴ� ����¡ ��ȣ �Խù��Ѱ��� / ���������� ����Ұ��� �� �ø�
	private int displayPost;//����� �Խù�
	private int pageNumCnt=10;//�ѹ��� ǥ���� ����¡ ��ȣ�� ����
	private int endPageNum;//ǥ�õǴ� ������ ��ȣ �� ������ ��ȣ
	private int startPageNum;//ǥ�õǴ� ������ ��ȣ�� ù��° ��ȣ
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
		//��������ȣ
		endPageNum = (int)(Math.ceil((double)num/(double)pageNumCnt)*pageNumCnt);
		//���۹�ȣ
		startPageNum=endPageNum-(pageNumCnt-1);
		//������ ��ȣ ����
		endPageNum_tmp=(int)(Math.ceil((double)count/(double)pageNumCnt));
		
		if(endPageNum>endPageNum_tmp) {
			endPageNum=endPageNum_tmp;
		}
		//postNum*=num;
		prev=startPageNum==1?false:true;
		next=endPageNum*pageNumCnt>=count?false:true;
		displayPost =(num-1)*postNum+1;//����� �Խù�
		postNum*=num;
		
	}
}