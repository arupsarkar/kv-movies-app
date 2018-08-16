public class Movies {

	public Integer page;
	public Integer total_results;
	public Integer total_pages;
	public List<Results> results;

	public class Results {
		public Integer vote_count;
		public Integer id;
		public Boolean video;
		public Double vote_average;
		public String title;
		public Double popularity;
		public String poster_path;
		public String original_language;
		public String original_title;
		public List<Integer> genre_ids;
		public String backdrop_path;
		public Boolean adult;
		public String overview;
		public String release_date;
	}

	public static Movies parse(String json) {
		return (Movies) System.JSON.deserialize(json, Movies.class);
	}    
}