package project;

public class Youlike {
	String id;
	int bnum;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	@Override
	public String toString() {
		return "Youlike [id=" + id + ", bnum=" + bnum + "]";
	}
}
