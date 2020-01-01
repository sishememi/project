package project.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import project.Board;
import project.Comment;

public interface BoardMapper {
	
	@Select("select ifnull(max(bnum),0) from board")
	int maxnum();

	@Insert("insert into board "
			+ " (bsection, bnum, wsection, id, subject, content, file1, regdate, readcnt,youlike,storagenum,img) "
			+ " values(#{bsection},#{bnum},#{wsection},#{id},#{subject},#{content},#{file1},now(),0,#{youlike},#{storagenum},#{img})")
	int insert(Board board);

	@Select({"<script>","select count(*) from board where bsection =#{bsection} ",
		"<if test='col1 != null'> and col1=#{col1} </if>",
		"<if test='col1 != null'> and ( ${col1} like '%${find}%'",
		"<if test='col2 != null'> OR ${col2} like '%${find}%' )</if>",
		"<if test='col2 == null'>)</if>",
		"</if>",
		"<if test='wsection != null'> and wsection=#{wsection} </if>",
		"</script>"})
	int boardcount(Map<String,Object> map);

	@Select({"<script>","select *,(select count(*) from youlike b2 where b2.bnum=b1.bnum and b2.id=#{id}) likechk"
			+ ",(SELECT COUNT(*) FROM storage b3 WHERE b3.bnum=b1.bnum ) stchk" 
		+ " from board b1 where bsection =#{bsection}",
		"<if test='col1 != null'> and ( ${col1} like '%${find}%' ",
		"<if test='col2 != null'> or ${col1} like '%${find}%' )</if>",
		"<if test='col2 == null'>)</if>",
		"</if>",
		"<if test='wsection != null'> and wsection=#{wsection} </if>",
		"<choose>",
		"<when test='bnum != null'>and bnum =#{bnum} </when>",
		"<otherwise>"
		+" order by regdate desc limit #{start},#{limit}"
		+"</otherwise>",
		"</choose>",
		"</script>"})
	List<Board> select(Map<String, Object> map);
	
	@Update("update board set readcnt = readcnt + 1 where bnum =#{bnum}")
	void readcntadd(int bnum);
	
	@Update("update board set num =  bnum where bnum =#{bnum}")
	void getStepAdd(@Param("num") int num);

	@Update("update board set subject=#{subject}, content=#{content}, file1=#{file1} where bsection=#{bsection} and bnum=#{bnum}")
	int update(Board board);

	@Delete("delete from board where bnum=#{bnum}")
	int delete(int bnum);

	@Update("update board set youlike=youlike + 1 where bnum=#{bnum}")
	  void updatelikeadd(int num);//좋아요 수 증가
	   
    @Update("update board set youlike=youlike - 1 where bnum=#{bnum}")
	  void updatelikedle(int num);//좋아요 눌러져있을때 좋아요 수 -1
	   
	@Select("select count(*) from youlike where id=#{id} and bnum=#{bnum} ") 
	  int likeselect(Board b);
	   
    @Insert("insert into youlike (bnum,id) values (#{bnum},#{id})") //youlike에 아이디 번호 지정.
	  boolean likeinsert(Board b);
	   
	@Delete("delete from youlike where bnum=#{bnum} and id=#{id}")
	  boolean likedelete(Board b);

	@Select("select count(*) from storage where id=#{id} and bnum=#{bnum} ")
	int stselect(Board b);
	
	@Update("update board set storagenum=storagenum + 1 where bnum=#{bnum}")
	void stupdateadd(int bnum);

	@Update("update board set storagenum=storagenum - 1 where bnum=#{bnum}")
	void stupdatedle(int bnum);
	
	@Insert("insert into storage (bsection,bnum,id,subject,img) values (#{bsection},#{bnum},#{id},#{subject},#{img})")
	boolean stinsert(Board b);
	
	@Delete("delete from storage where bnum=#{bnum} and id=#{id}") //보관함저장되어있을 시 저장빼기
	boolean stdelete(Board b);

	@Select("select * from board where bsection=4 order by youlike desc") //메인페이지 사진출력
	List<Board> mainlist();

	@Select("select * from storage where bsection=1 and id=#{id}")
	List<Board> tlist(String id);
	
	@Select("select * from storage where bsection=2 and id=#{id}")
	List<Board> rlist(String id);
	
	@Select("select * from storage where bsection=3 and id=#{id}")
	List<Board> elist(String id);
	
	@Select("select * from storage where bsection=4 and id=#{id}")
	List<Board> plist(String id);

	@Delete("delete from storage where bsection=#{bsection} and bnum=#{bnum} and id=#{id}")
	void sdelete (Board b);
	
	@Select({"<script>",
		"SELECT * FROM board WHERE bsection=#{bsection}",
		"<if test='wsection != null'> and wsection=#{wsection} </if>",
		"</script>"})	
	List<Board> nselect(@Param("bsection") int bsection,@Param("wsection") String wsection);
	
	@Insert("Insert into comment "
			+ " (bsection, bnum, id, comment) "
			+ " values(#{bsection},#{bnum},#{id},#{comment}) ")
	boolean reinsert(Board b);

	@Select("select * from comment where bnum=#{bnum}")
	List<Comment> commentlist(int bnum);
	
}
