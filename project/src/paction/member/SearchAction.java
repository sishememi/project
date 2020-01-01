package paction.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import paction.Action;
import paction.ActionForward;

import project.MemberDao;

public class SearchAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      String email = request.getParameter("email");
      String birth = request.getParameter("birth");
      String id = request.getParameter("id");
      if(id == null) {  //id 찾기
         return idSearch(request,email,birth);
      }else {  //비밀번호 찾기
         return pwSearch(request,id,email);
      }
   }
   private ActionForward pwSearch(HttpServletRequest request, String id, String email) {
      MemberDao dao = new MemberDao();
      String pw = dao.pwSearch(id,email);
      if(pw != null) { //비밀번호 찾기 성공
         request.setAttribute("pass", pw.substring(2,pw.length()));
         return new ActionForward();
      }else {  //비밀번호 찾기 실패
         request.setAttribute("msg", "정보에 맞는 비밀번호를 찾을 수 없습니다.");
         request.setAttribute("url", "pwForm.me");
         return new ActionForward(false,"../alert.jsp");
      }
   }
   private ActionForward idSearch (HttpServletRequest request, String email, String birth) {
      MemberDao dao = new MemberDao();
      String id = dao.idSearch(email,birth);
      String msg = null;
      String url = null;
      if(id != null) { //id 찾은 경우
         request.setAttribute("id", id);
         return new ActionForward();
      } else { //id 찾기 실패
         msg = "정보에 대한 id가 없습니다.";
         url = "idForm.me";
         request.setAttribute("msg", msg);
         request.setAttribute("url", url);
         return new ActionForward(false,"../alert.jsp");   
      }
   }
}