package paction.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import paction.ActionForward;
import project.Member;
import project.MemberDao;

public class MypageAction extends UserloginAction{

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		Member info = new MemberDao().selectOne(id);
		request.setAttribute("info", info);
		return new ActionForward();
	}
}
