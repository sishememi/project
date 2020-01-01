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
	 * 1. multipart/form.data Ÿ���� �����̹Ƿ� MultipartRequest ��ü ����
	 * 2. �Ķ���� ����
	 * model.Board ��ü ����. useBean ���Ұ�: request ������ �Ķ���Ϳ� ��Ŭ������ ������Ƽ �� request ��ü��
	 * ��� �� �� ����. 
	 * 3. �Խù� ��ȣ num ���� ��ϵ� num�� �ִ밪�� ��ȸ. �ִ밪 +1 ��ϵ� �Խù��� ��ȣ. db����
	 * maxnum�� ���ؼ� +1 ������ num �����ϱ�. 
	 * 4. board ������ DB�� ����ϱ� ��� ����: �޼��� ���. list.do ������
	 * �̵� ��� ����: �޼��� ���. writeForm.do ������ �̵�
	 * 
	 * @throws ServletException
	 * 
	 */
	public ActionForward write(HttpServletRequest request, HttpServletResponse reseponse) throws ServletException {
		String msg = "�Խù� ��� ����";
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
			int num = dao.maxnum(); // �ִ밪�� �������Ե�
			b.setBnum(++num);
			if (dao.insert(b)) {
				msg = "�Խù� ��� ����";
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
	 * 1. ���������� 10���� �Խù��� ����ϱ�. pageNum �Ķ���Ͱ��� ���� => ���� ���� 1�� �����ϱ�. 
	 * 2. �ֱ� ��ϵ� �Խù���
	 * ���� ���� ��ġ��. 3. ȭ�鿡 �ʿ��� ������ �Ӽ����� ���. view�� ����.
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
	 * 1. num �Ķ���� ������ ������ ����. 
	 * 2. num�� �̿��Ͽ� db���� �Խù� ������ ��ȸ Board
	 * BoardDao.selectOne(num) 
	 * 3. ��ȸ�� ������Ű�� void BoardDao.readcntadd(num) 
	 * 4. ��ȸ�ȰԽù��� ȭ�鿡 ���.
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
	 * 1.�Ķ���� ���� Board ��ü�� �����ϱ�. ��������: num, grp, grplevel, grpstep �������: name, pass,
	 * subject, content => ������� 
	 * 2.���� grp ���� ����ϴ� �Խù����� grpstep ���� 1 �����ϱ� void
	 * BoardDao.grpSetAdd(grp,grpstep) 
	 * 3.Board ��ü�� db�� insert �ϱ� num : maxnum + 1
	 * grp : ���۰� ���� grplevel : ���� + 1 grpstep : ���� + 1
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
		String msg = "�亯 ��Ͻ� �����߻�";
		String url = "replyForm.do?bsection="+bsection+"&bnum="+bnum;
		if (dao.reinsert(b)) {
			msg = "�亯 ���";
			url = "info.do?bsection="+bsection+"&bnum="+bnum;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	/*
	 * 1.�Ķ���� �������� Board ��ü�� ����. 
	 * 2.��й�ȣ ���� ��й�ȣ ��ġ�ϴ°�� ���� �Ķ������ �������� �ش� �Խù��� �����������ϱ�. 
	 * ÷�� �����Ǻ����� ���� ��� file2 �Ķ������ ������ �ٽ� �����ϱ� ��й�ȣ ����ġ ��й�ȣ ���� �޼��� ����ϰ�,
	 * updateForm.do�� ������ �̵� 
	 * 3. �������� : �������� �޼��� ��� ��. info.do ������ �̵� �������� : �������� �޼���
	 * ��� ��. updateForm.do ������ �̵�
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
		b.setFile1(multi.getFilesystemName("file1")); // ÷�����Ͽ� �ش��ϴ� ������ �ȵȰ��.
		if (b.getFile1() == null || b.getFile1().equals("")) {
			b.setFile1(multi.getParameter("file2"));
		}
		BoardDao dao = new BoardDao();
		Board db = dao.selectOne(bsection,bnum);
		String msg = "";
		String url = "";
		msg="�Խñ� ���� ����.";
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
				msg = "�Խù� �����Ϸ�";
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
		msg = "�Խù� ���� ����";
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
			msg = "���� ,�����ڸ� �Խñ� ���������մϴ�!!";
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
					msg = "�Խù� �����Ϸ�";
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
	 * CKEDITOR���� �̹����� �Խ��� ���뿡 �߰��ϱ�
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
	
	public ActionForward like(HttpServletRequest request, HttpServletResponse reseponse) { //���� ���ƿ� ���
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
		int c = dao.likeselect(b); //c�� ��ü b(bnum,id)�� ����
		if (c == 0) { //bnum,��id�� ������ insert�ȵǾ�������
			dao.likeupdate(bnum,"add");
			if(dao.likeinsert(b)) {
				msg="���ƿ� :)";
				url="photoForm.do?bsection=4";
			}
		}else if(c==1){
			dao.likeupdate(bnum,"dle");
			if(dao.likedelete(b)) {
				msg=":( ���ƿ� ���";
				url="photoForm.do?bsection=4";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	public ActionForward storage(HttpServletRequest request, HttpServletResponse reseponse) { //����������
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
				msg="������ ���� �Ϸ�;)";
				if(bsection==4) {
					url="photoForm.do?bsection="+bsection+"&id="+id+"&img="+img;
				}else {
					url="info.do?bsection="+bsection+"&id"+id+"&bnum="+bnum+"&subject"+subject;
				}
			}
		}else if(y==1) {
				dao.stupdate(bnum,"dle");
				if(dao.stdelete(b)) {
					msg=":( �����Կ��� ����";
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
	public ActionForward stlist(HttpServletRequest request, HttpServletResponse reseponse) { //������������ ����Ʈ
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