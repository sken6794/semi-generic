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
            // 전체 방문자 수 증가
            dao.setTotalCount();
            // 총 방문자 수
            int totalCount = dao.getTotalCount();
            // 오늘 방문자 수
            int todayCount = dao.getTodayCount();
            
            HttpSession session = sessionEve.getSession();
            
            // 세션에 방문자 수를 담는다.
            
            
            session.setAttribute("totalCount", totalCount);            
            session.setAttribute("todayCount", todayCount);
            
        } catch (Exception e) {
            System.out.println("===== 방문자 카운터 오류 =====\n");
            e.printStackTrace();
        }
    }
 
}
