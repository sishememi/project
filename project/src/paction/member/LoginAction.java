package paction.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import paction.Action;
import paction.ActionForward;
import project.Member;
import project.MemberDao;

public class LoginAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//1.id,pass 파라미터 저장
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String msg = "해당 id가 존재하지 않습니다.";
		String url = "loginFrom.jsp";
		Member mem = new MemberDao().selectOne(id);
		if(mem != null) { 
			//로그인 성공
			if(pass.equals(mem.getPass())) {
				request.getSession().setAttribute("login",id); //session.setAttribute("login",id); session은 jsp내장객체라 requset.getsession()
				msg = mem.getNickname() + "님이 로그인하셨습니다.";
				url = "mainForm.me";
			}else {
			//로그인 실패
				msg = "비밀번호가 틀립니다.";
				url = "loginForm.jsp";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);

		return new ActionForward(false,"../alert.jsp");
	}
}
