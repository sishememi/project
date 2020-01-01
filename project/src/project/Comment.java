package project;

public class Comment {
	private int bsection;
	private int bnum;
	private String id;
	private String comment;	
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getBsection() {
		return bsection;
	}
	public void setBsection(int bsection) {
		this.bsection = bsection;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getComment() {
		return comment;
	}
	@Override
	public String toString() {
		return "Comment [bsection=" + bsection + ", bnum=" + bnum + ", id=" + id + ", comment=" + comment + "]";
	}
	
}
