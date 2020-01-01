package project;

import java.util.Date;
import java.util.List;

public class Board {
	private int bsection;
	private int bnum;
	private String wsection;
	private String id;
	private String subject;
	private String content;
	private String file1;
	private Date regdate;
	private int readcnt;
	private int youlike;
	private int storagenum;
	private String img;
	private int likechk;
	private int stchk;
	private String comment;
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getStchk() {
		return stchk;
	}
	public void setStchk(int stchk) {
		this.stchk = stchk;
	}
	public int getLikechk() {
		return likechk;
	}
	public void setLikechk(int likechk) {
		this.likechk = likechk;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
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
	public String getWsection() {
		return wsection;
	}
	public void setWsection(String wsection) {
		this.wsection = wsection;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFile1() {
		return file1;
	}
	public void setFile1(String file1) {
		this.file1 = file1;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public int getYoulike() {
		return youlike;
	}
	public void setYoulike(int youlike) {
		this.youlike = youlike;
	}
	public int getStoragenum() {
		return storagenum;
	}
	public void setStoragenum(int storagenum) {
		this.storagenum = storagenum;
	}
	
	@Override
	public String toString() {
		return "Board [bsection=" + bsection + ", bnum=" + bnum + ", wsection=" + wsection + ", id=" + id + ", subject="
				+ subject + ", content=" + content + ", file1=" + file1 + ", regdate=" + regdate + ", readcnt="
				+ readcnt + ", youlike=" + youlike + ", storagenum=" + storagenum + ", img=" + img + ", likechk="
				+ likechk + ", stchk=" + stchk + ", comment=" + comment + "]";
	}	

}