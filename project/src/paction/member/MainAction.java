package paction.member;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/* 
 * �α����� �Ǿ�߸�  doExecute�޼��� ����
 */
import paction.ActionForward;

import project.BoardDao;

public class MainAction extends UserloginAction {

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		BoardDao b = new BoardDao();
		//List<Board> list = b.mainlist();
		request.setAttribute("mainlist",  b.mainlist());
		return new ActionForward();
	}
}
	
