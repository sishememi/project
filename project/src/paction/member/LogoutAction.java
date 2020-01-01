package paction.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import paction.ActionForward;
import paction.member.UserloginAction;

public class LogoutAction  extends UserloginAction {

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		String msg = login + "´ÔÀÌ ·Î±×¾Æ¿ô ÇÏ¼Ì½À´Ï´Ù.";
		String url = "loginForm.jsp";
		request.getSession().invalidate();
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}
}
