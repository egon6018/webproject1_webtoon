package myBean;

public class File {
	private String title;
	private String date;
	
	public File() {
		title="";
		date="";
	}

	public String getTitle() {
		return title;
	}

	public String getDate() {
		return date;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setDate(String date) {
		this.date = date;
	}
}
