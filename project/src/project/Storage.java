package project;

public class Storage {
	private int bsection;
	private int bnum;
	private int id;
	private String subject;
	private String img;
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	@Override
	public String toString() {
		return "Storage [bsection=" + bsection + ", bnum=" + bnum + ", id=" + id + ", subject=" + subject + ", img="
				+ img + "]";
	}


}
