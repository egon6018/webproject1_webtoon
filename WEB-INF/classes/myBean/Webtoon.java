package myBean;

public class Webtoon {
	private String webtitle;
	private String name;
	private String genre;
	private String plot;
	private String words;
	
	public Webtoon() {
		webtitle="";
		name="";
		genre="";
		plot="";
		words="";
	}

	public String getWebtitle() {
		return webtitle;
	}

	public String getName() {
		return name;
	}

	public String getGenre() {
		return genre;
	}

	public String getPlot() {
		return plot;
	}

	public String getWords() {
		return words;
	}

	public void setWebtitle(String webtitle) {
		this.webtitle = webtitle;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public void setPlot(String plot) {
		this.plot = plot;
	}

	public void setWords(String words) {
		this.words = words;
	}
	
	
}
