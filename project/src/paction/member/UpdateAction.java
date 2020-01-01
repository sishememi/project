package paction.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.Member;
import project.MemberDao;
import paction.ActionForward;

public class UpdateAction extends UserloginAction {

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		Member mem = new Member(); //usebean액션태그를 사용할수없기때문에 일일히 집어 넣음. 
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setNickname(request.getParameter("nickname"));
		mem.setGender(Integer.parseInt(request.getParameter("gender")));
		mem.setEmail(request.getParameter("email"));
		mem.setBirth(request.getParameter("birth"));
		mem.setTravel(Integer.parseInt(request.getParameter("travel")));
		
		String[] values= request.getParameterValues("national");
		 String national ="";
		  for(int i=0; i<values.length; i++) { 
			 national += values[i]+(i == values.length -1 ? "":","); 
		  } 
		mem.setNational(national); 
		/* mem.setNational(request.getParameter("national")); */

		MemberDao dao=new MemberDao();
		Member dbmem = dao.selectOne(id);
		String msg =  "비밀번호가 틀렸습니다.";
		String url = "updateForm.me?id="+mem.getId();
		if(!login.equals("admin") && mem.getPass().equals(dbmem.getPass())) {
			if(dao.update(mem) > 0 ) {
				msg="수정이 완료되었습니다.";
				url="mypageForm.me?id="+mem.getId();
				
			}else {
				msg="수정을 완료하지 못하였습니다.";
				url="mainForm.me";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}

}
