package paction.board;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.oreilly.servlet.MultipartRequest;

import paction.ActionForward;
import project.Board;
import project.BoardDao;
import project.Comment;
import project.Member;
import project.Storage;

public class BoardAllAction {
	private BoardDao dao = new BoardDao();

	/**
	 * 1. multipart/form.data 타입의 전송이므로 MultipartRequest 객체 생성
	 * 2. 파라미터 값을
	 * model.Board 객체 저장. useBean 사용불가: request 정보의 파라미터와 빈클래스의 프로퍼티 비교 request 객체를
	 * 사용 할 수 없음. 
	 * 3. 게시물 번호 num 현재 등록된 num의 최대값을 조회. 최대값 +1 등록된 게시물의 번호. db에서
	 * maxnum을 구해서 +1 값으로 num 설정하기. 
	 * 4. board 내용을 DB에 등록하기 등록 성공: 메세지 출력. list.do 페이지
	 * 이동 등록 실패: 메세지 출력. writeForm.do 페이지 이동
	 * 
	 * @throws ServletException
	 * 
	 */
	public ActionForward write(HttpServletRequest request, HttpServletResponse reseponse) throws ServletException {
		String msg = "게시물 등록 실패";
		String url = "writeForm.do";
		String path = request.getServletContext().getRealPath("") + "europe/board/file/";
		try {
			File f = new File(path);
			if (!f.exists())
				f.mkdirs();
			MultipartRequest multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "euc-kr");
			// 2
			Board b = new Board();
			b.setBsection(Integer.parseInt(multi.getParameter("bsection")));
			b.setWsection(multi.getParameter("wsection"));
			b.setId(multi.getParameter("id"));
			b.setSubject(multi.getParameter("subject"));
			b.setContent(multi.getParameter("content"));
			b.setFile1(multi.getFilesystemName("file1"));
			b.setImg(multi.getParameter("img"));
		
			// 3
			int num = dao.maxnum(); // 최대값을 가져오게됨
			b.setBnum(++num);
			if (dao.insert(b)) {
				msg = "게시물 등록 성공";
				if(Integer.parseInt(multi.getParameter("bsection"))==1) {
					url = "tourForm.do?bsection=1";
				}else if(Integer.parseInt(multi.getParameter("bsection"))==2) {
					url = "restaurantForm.do?bsection=2";
				}else if(Integer.parseInt(multi.getParameter("bsection"))==3){
					url = "etcForm.do?bsection=3";
				}else if(Integer.parseInt(multi.getParameter("bsection"))==4) {
					url = "photoForm.do?bsection=4";
				}
			}
		} catch (IOException e) {
			throw new ServletException(e);
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	/*
	 * 1. 한페이지당 10건의 게시물을 출력하기. pageNum 파라미터값을 저장 => 없는 경우는 1로 설정하기. 
	 * 2. 최근 등록된 게시물이
	 * 가장 위에 배치함. 3. 화면에 필요한 정보를 속성으로 등록. view로 전송.
	 * 
	 */
	public ActionForward list(HttpServletRequest request, HttpServletResponse reseponse) throws ServletException {
		int limit = 10;
		int pageNum = 1;
		int bsection = 0;
		String login =(String)request.getSession().getAttribute("login");
		String wsection = request.getParameter("wsection");
		try {
			bsection = Integer.parseInt(request.getParameter("bsection"));
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		} catch (NumberFormatException e) {}
		String column = request.getParameter("column");
		String find = request.getParameter("find");
		if (column != null && column.trim().equals(""))
			column = null;
		if (find != null && find.trim().equals(""))
			find = null;
		if (column == null || find == null) {
			column = null;
			find = null;
		}
		int boardcnt = dao.boardCount(bsection,column, find,wsection);
		List<Board> list = dao.list(bsection, pageNum, limit, column, find, login,wsection);
		int maxpage = (int) ((double) boardcnt / limit + 0.95);
		int startpage = ((int) (pageNum / 10.0 + 0.9) - 1) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardnum = boardcnt - (pageNum - 1) * limit;
		request.setAttribute("boardcnt", boardcnt);
		request.setAttribute("list", list);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("boardnum", boardnum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("bsection", bsection);
		return new ActionForward();
	}
	
	/*
	 * 1. num 파라미터 정보를 변수에 저장. 
	 * 2. num을 이용하여 db에서 게시물 정보를 조회 Board
	 * BoardDao.selectOne(num) 
	 * 3. 조회수 증가시키기 void BoardDao.readcntadd(num) 
	 * 4. 조회된게시물을 화면에 출력.
	 * 
	 */
	public ActionForward info(HttpServletRequest request, HttpServletResponse reseponse) {
		int bsection = Integer.parseInt(request.getParameter("bsection"));
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String comment = request.getParameter(("comment"));
		String img = request.getParameter("img");
		Board b = dao.selectOne(bsection,bnum);
		List<Comment> list = dao.commentselect(bnum);
		String msg="";
		String url="";
		if (request.getRequestURI().contains("info.do")) {
			dao.readcntadd(bnum);
		}
		request.setAttribute("b", b);
		request.setAttribute("list", list);
		return new ActionForward();
	}
	
	public ActionForward picture(HttpServletRequest request, HttpServletResponse reseponse) {
		 String path = request.getServletContext().getRealPath("/") + "europe/board/picture";
	      String fname = null;
	      try {
	            File f = new File(path);
	            if(!f.exists()) 
	            {
	               f.mkdirs();
	            }
	            MultipartRequest multi = new MultipartRequest(request,path,10*1024*1024,"euc-kr");
	            fname = multi.getFilesystemName("pic");
	         } 
	      catch (IOException e) 
	      {
	         e.printStackTrace();
	      }
	      request.setAttribute("fname", fname);
	      return new ActionForward();
	}
	
	/*
	 * 1.파라미터 값을 Board 객체에 저장하기. 원글정보: num, grp, grplevel, grpstep 답글정보: name, pass,
	 * subject, content => 등록정보 
	 * 2.같은 grp 값을 사용하는 게시물들의 grpstep 값을 1 증가하기 void
	 * BoardDao.grpSetAdd(grp,grpstep) 
	 * 3.Board 객체를 db에 insert 하기 num : maxnum + 1
	 * grp : 원글과 동일 grplevel : 원글 + 1 grpstep : 원글 + 1
	 */

	public ActionForward reply(HttpServletRequest request, HttpServletResponse reseponse) {
		int bsection = Integer.parseInt(request.getParameter("bsection"));
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String login = (String)request.getSession().getAttribute("login");
		Board b = new Board();
		b.setBnum(Integer.parseInt(request.getParameter("bnum")));
		b.setId(login);
		b.setBsection(Integer.parseInt(request.getParameter("bsection")));
		b.setComment(request.getParameter("comment"));
		String msg = "답변 등록시 오류발생";
		String url = "replyForm.do?bsection="+bsection+"&bnum="+bnum;
		if (dao.reinsert(b)) {
			msg = "답변 등록";
			url = "info.do?bsection="+bsection+"&bnum="+bnum;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	/*
	 * 1.파라미터 정보들을 Board 객체에 저장. 
	 * 2.비밀번호 검증 비밀번호 일치하는경우 수정 파라미터의 내용으로 해당 게시물의 내용을수정하기. 
	 * 첨부 파일의변경이 없는 경우 file2 파라미터의 내용을 다시 저장하기 비밀번호 불일치 비밀번호 오류 메세지 출력하고,
	 * updateForm.do로 페이지 이동 
	 * 3. 수정성공 : 수정성공 메세지 출력 후. info.do 페이지 이동 수정실패 : 수정실패 메세지
	 * 출력 후. updateForm.do 페이지 이동
	 */

	public ActionForward update(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getServletContext().getRealPath("/") + "europe/board/file/";
		MultipartRequest multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "euc-kr");
		int bsection = Integer.parseInt(request.getParameter("bsection"));
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String login = (String)request.getSession().getAttribute("login");
		String id = request.getParameter("id");
		
		Board b = new Board();
		b.setSubject(multi.getParameter("subject"));
		b.setContent(multi.getParameter("content"));
		b.setFile1(multi.getFilesystemName("file1")); // 첨부파일에 해당하는 수정이 안된경우.
		if (b.getFile1() == null || b.getFile1().equals("")) {
			b.setFile1(multi.getParameter("file2"));
		}
		BoardDao dao = new BoardDao();
		Board db = dao.selectOne(bsection,bnum);
		String msg = "";
		String url = "";
		msg="게시글 수정 실패.";
		if(bsection==1) {
			url = "tourForm.do?bsection=1";
		}else if(bsection==2) {
			url = "restaurantForm.do?bsection=2";
		}else if(bsection==3){
			url = "etcForm.do?bsection=3";
		}else if(bsection==4) {
			url = "photoForm.do?bsection=4";
		}
		if (!login.equals(b.getId())) {
			if (dao.update(b)) {
				msg = "게시물 수정완료";
				if(bsection==1) {
					url = "tourForm.do?bsection=1";
				}else if(bsection==2) {
					url = "restaurantForm.do?bsection=2";
				}else if(bsection==3){
					url = "etcForm.do?bsection=3";
				}else if(bsection==4) {
					url = "photoForm.do?bsection=4";
				}
			} 
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	public ActionForward delete(HttpServletRequest request, HttpServletResponse response) {
		int bsection = Integer.parseInt(request.getParameter("bsection"));
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String login = (String)request.getSession().getAttribute("login");
		String id = request.getParameter("id");
		String msg = "";
		String url = "";
		Board b = dao.selectOne(bsection,bnum);
		msg = "게시물 삭제 실패";
			if(bsection==1) {
				url = "tourForm.do?bsection=1";
			}else if(bsection==2) {
				url = "restaurantForm.do?bsection=2";
			}else if(bsection==3){
				url = "etcForm.do?bsection=3";
			}else if(bsection==4) {
				url = "photoForm.do?bsection=4";
			}
		if (!login.equals(b.getId()) || !login.equals("admin")) {
			msg = "본인 ,관리자만 게시글 삭제가능합니다!!";
			if(bsection==1) {
				url = "tourForm.do?bsection=1";
			}else if(bsection==2) {
				url = "restaurantForm.do?bsection=2";
			}else if(bsection==3){
				url = "etcForm.do?bsection=3";
			}else if(bsection==4) {
				url = "photoForm.do?bsection=4";
			}
		} else if(login.equals(b.getId()) || login.equals("admin")){
				if (dao.delete(bnum)) {
					msg = "게시물 삭제완료";
					if(bsection==1) {
						url = "tourForm.do?bsection=1";
					}else if(bsection==2) {
						url = "restaurantForm.do?bsection=2";
					}else if(bsection==3){
						url = "etcForm.do?bsection=3";
					}else if(bsection==4) {
						url = "photoForm.do?bsection=4";
					}
				}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	/*
	 * CKEDITOR에서 이미지를 게시판 내용에 추가하기
	 */

	public ActionForward imgupload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getServletContext().getRealPath("/") + "europe/board/imgfile/";
		File f = new File(path);
		if (!f.exists())
			f.mkdirs();
		MultipartRequest multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "euc-kr");
		String fileName = multi.getFilesystemName("upload");
		request.setAttribute("fileName", fileName);
		request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
		return new ActionForward(false, "ckeditor.jsp");
	}
	
	public ActionForward like(HttpServletRequest request, HttpServletResponse reseponse) { //사진 좋아요 기능
		int limit = 10;
		int pageNum = 1;
		int bsection = 0;
		String login =(String)request.getSession().getAttribute("login");
		String wsection = request.getParameter("wsection");
		try {
			bsection = Integer.parseInt(request.getParameter("bsection"));
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		} catch (NumberFormatException e) {}
		String column = request.getParameter("column");
		String find = request.getParameter("find");
		if (column != null && column.trim().equals(""))
			column = null;
		if (find != null && find.trim().equals(""))
			find = null;
		if (column == null || find == null) {
			column = null;
			find = null;
		}
		int boardcnt = dao.boardCount(bsection,column, find,wsection);
		List<Board> list = dao.list(bsection, pageNum, limit, column, find, login,wsection);
		int maxpage = (int) ((double) boardcnt / limit + 0.95);
		int startpage = ((int) (pageNum / 10.0 + 0.9) - 1) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		int boardnum = boardcnt - (pageNum - 1) * limit;
		request.setAttribute("boardcnt", boardcnt);
		request.setAttribute("list", list);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("boardnum", boardnum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("bsection", bsection);
		
		String id = request.getParameter("id");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		Board b = new Board();
		String msg = "";
		String url = "";
		b.setBnum(bnum);
		b.setId(id); 
		int c = dao.likeselect(b); //c에 객체 b(bnum,id)를 넣음
		if (c == 0) { //bnum,과id가 같은게 insert안되어있을때
			dao.likeupdate(bnum,"add");
			if(dao.likeinsert(b)) {
				msg="좋아요 :)";
				url="photoForm.do?bsection=4";
			}
		}else if(c==1){
			dao.likeupdate(bnum,"dle");
			if(dao.likedelete(b)) {
				msg=":( 좋아요 취소";
				url="photoForm.do?bsection=4";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	public ActionForward storage(HttpServletRequest request, HttpServletResponse reseponse) { //보관함저장
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String id = request.getParameter("id");
		int bsection = Integer.parseInt(request.getParameter("bsection"));
		String subject = request.getParameter("subject");
		String img = request.getParameter("img");
		Storage s = new Storage();
		Board b = new Board();
		String msg="";
		String url="";
		b.setBnum(bnum);
		b.setId(id);
		b.setBsection(bsection);
		b.setSubject(subject);
		b.setImg(img);	
		int y = dao.stselect(b);
		if(y==0) {
			dao.stupdate(bnum,"add");
			if(dao.stinsert(b)) {
				msg="보관함 저장 완료;)";
				if(bsection==4) {
					url="photoForm.do?bsection="+bsection+"&id="+id+"&img="+img;
				}else {
					url="info.do?bsection="+bsection+"&id"+id+"&bnum="+bnum+"&subject"+subject;
				}
			}
		}else if(y==1) {
				dao.stupdate(bnum,"dle");
				if(dao.stdelete(b)) {
					msg=":( 보관함에서 삭제";
					if(bsection==4) {
						url="photoForm.do?bsection="+bsection+"&id="+id+"&img="+img;
					}else {
						url="info.do?bsection="+bsection+"&id"+id+"&bnum="+bnum+"&subject"+subject;
					}
				}
			}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	public ActionForward stlist(HttpServletRequest request, HttpServletResponse reseponse) { //보관함페이지 리스트
		String id = request.getParameter("id");
		BoardDao dao = new BoardDao();
		request.setAttribute("tlist", dao.tlistselect(id));
		request.setAttribute("rlist", dao.rlistselect(id));
		request.setAttribute("elist", dao.elistselect(id));
		request.setAttribute("plist", dao.plistselect(id));
		return new ActionForward();
	}

	public ActionForward nselect(HttpServletRequest request, HttpServletResponse reseponse) {
		int bsection = Integer.parseInt(request.getParameter("bsection"));
		String wsection = request.getParameter("wsection");
		BoardDao dao = new BoardDao();
					
		request.setAttribute("nlist", dao.nselect(bsection,wsection));
		return new ActionForward();
	}

}