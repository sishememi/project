package paction;

public class ActionForward {
	private boolean redirect;
	private String view;
	
	public ActionForward() {}
	public ActionForward(boolean redirect,String view) {
		this.redirect = redirect;
		this.view = view;
	}
	
	public String getView() {
		return view;
	}
	public void setView(String view) {
		this.view = view;
	}
	public boolean isRedirect() {
		return redirect;
	}
	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}
	
}
