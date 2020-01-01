package paction.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import paction.ActionForward;
import project.Member;
import project.MemberDao;

public class DeleteAction extends UserloginAction{
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		if(id.equals("admin")) {
			request.setAttribute("msg", "관리자는 탈퇴할 수 없습니다.");
			request.setAttribute("url", "mypageForm.me");
			return new ActionForward(false,"../alert.jsp");
		}

		String pass = request.getParameter("pw");
		MemberDao dao = new MemberDao();
		Member mem = dao.selectOne(id);
		String msg = "비밀번호가 틀립니다. 확인하세요";
		String url = "deleteForm.me?id="+id;
		
		 if(login.equals("admin") || pass.equals(mem.getPass()))
	      {
	            if(dao.delete(id) > 0) // 삭제 성공
	            {
	            if(login.equals("admin")) 
	            {
	                 msg = "강제탈퇴 성공";
	               url = "memlist.me";
	            }
	            else 
	            {
	               msg = id + "회원님의 탈퇴가 완료되었습니다";
	               url = "loginForm.jsp";
	               request.getSession().invalidate();
	            }
	         }
	         else // 삭제 실패
	         {
	            msg= id + "님의 탈퇴시 오류 발생";
	            if(login.equals("admin")) {
	               url = "memlist.me";
	            }else { // 일반 사용자의 경우 
	               url = "mypageForm.me?id=" + id;               
	            }   
	         }
	      }
		 request.setAttribute("msg", msg);
	     request.setAttribute("url", url);
	     return new ActionForward(false, "../alert.jsp");
	}

}
