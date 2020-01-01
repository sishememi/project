package project;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import project.mapper.BoardMapper;

public class YoulikeDao {
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<BoardMapper> cls = BoardMapper.class;
	
	public Youlike selectOne(String id, int bnum) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("id", id);
			map.put("bnum", bnum);
			session.getMapper(cls).select(map).get(0);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}
	
	/*
	 * public boolean delete(String id,int bnum) { SqlSession session =
	 * DBConnection.getConnection(); try { int cnt =
	 * session.getMapper(cls).delete(id,bnum); if (cnt > 0) return true;
	 * }catch(Exception e) { e.printStackTrace(); }finally {
	 * DBConnection.close(session); } return false; }
	 * 
	 * public boolean update(String id,int bnum) { SqlSession session =
	 * DBConnection.getConnection(); try { int cnt =
	 * session.getMapper(cls).update(id, bnum); if (cnt > 0) return true;
	 * }catch(Exception e) { e.printStackTrace(); }finally {
	 * DBConnection.close(session); } return false; }
	 */
}
