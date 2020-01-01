package project;

public class Member {
	private String id;
	private String pass;
	private String nickname;
	private String email;
	private String birth;
	private int gender;
	private String national;
	private int travel;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getNational() {
		return national;
	}
	public void setNational(String national) {
		this.national = national;
	}

	public int getTravel() {
		return travel;
	}
	public void setTravel(int travel) {
		this.travel = travel;
	}
	@Override
	public String toString() {
		return "Member [id=" + id + ", pass=" + pass + ", nickname=" + nickname + ", email=" + email + ", birth="
				+ birth + ", gender=" + gender + ", national=" + national + ", travel=" + travel + "]";
	}
	
}
