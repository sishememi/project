package project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import project.DBConnection;
import project.mapper.BoardMapper;

public class BoardDao {
	private Map<String, Object> map = new HashMap<String, Object>();
	private Class<BoardMapper> cls = BoardMapper.class;

	// 현재 등록된 게시물 번호 중 최대값을 리턴
	public int maxnum() {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).maxnum();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	public boolean insert(Board board) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).insert(board);
			if (cnt > 0)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public int boardCount(int bsection, String column, String find,String wsection) {
		// 게시물 건수
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("bsection", bsection);
			if (column != null) {
				String[] col = column.split(",");
				map.put("col1", col[0]);
				if (col.length == 2) {
					map.put("col2", col[1]);
				}
				map.put("find", find);
				map.put("wsection", wsection);
			}
			return session.getMapper(cls).boardcount(map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	public List<Board> list(int bsection, int pageNum, int limit, String column, String find,String id,String wsection) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("id", id);
			map.put("bsection", bsection);
			map.put("pageNum", pageNum);
			map.put("start", (pageNum - 1) * limit);
			map.put("limit", limit);
			map.put("wsection", wsection);
			if (column != null) {
				String[] col = column.split(",");
				map.put("col1", col[0]);
				if (col.length == 2) {
					map.put("col2", col[1]);
				}
				map.put("find", find);
				
			}
			return session.getMapper(cls).select(map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}
	
	public Board selectOne(int bnum) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("bnum", bnum);
			return session.getMapper(cls).select(map).get(0);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public Board selectOne(String id, int bnum) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("id", id);
			map.put("bnum", bnum);
			return session.getMapper(cls).select(map).get(0);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public Board selectOne(int bsection, int bnum) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("bsection", bsection);
			map.put("bnum", bnum);
			return session.getMapper(cls).select(map).get(0);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public Board selectOne(String id) {
		// id : 화면에서 입력된 아이디
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("id", id);
			List<Board> list = session.getMapper(cls).select(map);
			return list.get(0);// list에있는 첫번째 레코드.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public Board selectOne(String id, int bsection, int bnum) {
		// id : 화면에서 입력된 아이디
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("id", id);
			map.put("bsection", bsection);
			map.put("bnum", bnum);
			List<Board> list = session.getMapper(cls).select(map);
			return list.get(0);// list에있는 첫번째 레코드.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	// 조회수 증가
	public void readcntadd(int bnum) {
		SqlSession session = DBConnection.getConnection();
		try {
			session.getMapper(cls).readcntadd(bnum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
	}

	// 답글의 순서 지정
	public void getStepAdd(int num) {
		SqlSession session = DBConnection.getConnection();
		try {
			session.getMapper(cls).getStepAdd(num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
	}

	// 게시글 수정
	public boolean update(Board board) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).update(board);
			if (cnt > 0)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	// 게시글 삭제
	public boolean delete(int bnum) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).delete(bnum);
			if (cnt > 0)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public boolean likeupdate(int bnum, String string) {
		SqlSession session = DBConnection.getConnection();
		try {
			if (string.equals("add")) {
				session.getMapper(cls).updatelikeadd(bnum);
			} else if (string.equals("dle")) {
				session.getMapper(cls).updatelikedle(bnum);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public int likeselect(Board b) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("b", b);
			return session.getMapper(cls).likeselect(b);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;

	}

	public boolean  likeinsert(Board b) {
		SqlSession session = DBConnection.getConnection();
		try {
			boolean cnt = session.getMapper(cls).likeinsert(b);
			if (cnt)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public boolean likedelete(Board board) {
		SqlSession session = DBConnection.getConnection();
		try {
			boolean cnt = session.getMapper(cls).likedelete(board);
			if (cnt)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public int stselect(Board b) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("b", b);
			return session.getMapper(cls).stselect(b);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	public boolean stupdate(int bnum, String string) {
		SqlSession session = DBConnection.getConnection();
		try {
			if (string.equals("add")) {
				session.getMapper(cls).stupdateadd(bnum);
			} else if (string.equals("dle")) {
				session.getMapper(cls).stupdatedle(bnum);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public boolean stinsert(Board b) {
		SqlSession session = DBConnection.getConnection();
		try {
			boolean cnt = session.getMapper(cls).stinsert(b);
			if (cnt)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public boolean stdelete(Board b) {
		SqlSession session = DBConnection.getConnection();
		try {
			boolean cnt = session.getMapper(cls).stdelete(b);
			if (cnt)
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}
	public List<Board> mainlist() {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).mainlist();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public List<Board> tlistselect(String id) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).tlist(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public List<Board> rlistselect(String id) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).rlist(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public List<Board> elistselect(String id) {
		SqlSession session = DBConnection.getConnection();
		try {
				return session.getMapper(cls).elist(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public Object plistselect(String id) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).plist(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public boolean sdelete(Board b) {
		SqlSession session = DBConnection.getConnection();
		try {
			session.getMapper(cls).sdelete(b);
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public List<Board> nselect(int bsection, String wsection) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).nselect(bsection,wsection);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public boolean reinsert(Board b) {
		SqlSession session = DBConnection.getConnection();
		try {
			session.getMapper(cls).reinsert(b);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}


	public List<Comment> commentselect(int bnum) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).commentlist(bnum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

}