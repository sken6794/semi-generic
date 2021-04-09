package generic.visit;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class VisitSessionListener  implements HttpSessionListener {
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		if(se.getSession().isNew()){
            execute(se);
        }
	}
	private void execute(HttpSessionEvent sessionEve) 
    {
        VisitDAO dao = VisitDAO.getDAO();
        
        try {
            // ��ü �湮�� �� ����
            dao.setTotalCount();
            // �� �湮�� ��
            int totalCount = dao.getTotalCount();
            // ���� �湮�� ��
            int todayCount = dao.getTodayCount();
            
            HttpSession session = sessionEve.getSession();
            
            // ���ǿ� �湮�� ���� ��´�.
            
            
            session.setAttribute("totalCount", totalCount);            
            session.setAttribute("todayCount", todayCount);
            
        } catch (Exception e) {
            System.out.println("===== �湮�� ī���� ���� =====\n");
            e.printStackTrace();
        }
    }
 
}
