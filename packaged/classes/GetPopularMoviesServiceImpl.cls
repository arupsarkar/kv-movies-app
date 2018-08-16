public with sharing class GetPopularMoviesServiceImpl extends MoviesService{
    string result{get; private set;}
    List<PopularMovies.Results> moviesList = new List<PopularMovies.Results>();
    List<Movie__c> popularMoviesList = new List<Movie__c>();
    final Integer PAGES = 10;
    public override String GetMovies(){
        System.debug(System.LoggingLevel.DEBUG, 'GetPopularMovies.GetMovies()');

        if(Test.isRunningTest()){
            return '';
        }

        Http httpClient = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.themoviedb.org/3/movie/popular?api_key=14f3a773746ea1d08c5ba9df6472cdde&language=en-US');
        req.setMethod('GET');        
        req.setTimeout(60000);
        HttpResponse res = new Http().send(req);
        // If the request is successful, parse the JSON response.
        if(res.getStatusCode() == 200){
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            //get the total number of pages to query.
            for(String key : results.keySet()){
                if(key.equals('total_pages')){
                    System.debug(LoggingLevel.DEBUG, 'Total number of pages = ' + results.get(key));
                }
            }
        }else{
            //handle error

        }

        //now iterate all pages to get all popular movies.
        for(Integer page = 1 ; page <= PAGES ; page++ ){
            System.debug(LoggingLevel.DEBUG, page);
            HttpRequest request = new HttpRequest();            
            request.setEndpoint('https://api.themoviedb.org/3/movie/popular?api_key=14f3a773746ea1d08c5ba9df6472cdde&language=en-US&page=' + page);
            request.setMethod('GET');        
            request.setTimeout(60000);
            HttpResponse response = new Http().send(request);
            PopularMovies movies = PopularMovies.parse(response.getBody());
            for(PopularMovies.Results result : movies.results){
                moviesList.add(result);
            } 
            System.debug(LoggingLevel.DEBUG, moviesList.size());                       
        }

        //display the results
        for(PopularMovies.Results data : moviesList){
            Movie__c movie = new Movie__c();
            movie.movie_id__c = data.id;
            movie.adult__c = data.adult;
            movie.backdrop_path__c = data.backdrop_path;
            movie.Name = data.title;
            movie.original_language__c = data.original_language;
            movie.original_title__c = data.original_title;
            movie.Overview__c = data.overview;
            movie.popular_movies__c = true;
            movie.popularity__c = data.popularity;
            movie.poster_path__c = data.poster_path;
            movie.release_date__c = Date.valueOf(data.release_date);
            movie.title__c = data.title;
            movie.video__c = data.video;
            movie.vote_average__c = data.vote_average;
            movie.vote_count__c = data.vote_count;
            System.debug(LoggingLevel.DEBUG, data.id);
            System.debug(LoggingLevel.DEBUG, data.overview);
            System.debug(LoggingLevel.DEBUG, data.poster_path);
            System.debug(LoggingLevel.DEBUG, data.backdrop_path);  
            popularMoviesList.add(movie);          
        }
        try{
            upsert popularMoviesList;
        }catch(Exception ex){
            System.debug(LoggingLevel.ERROR, 'Error Message: ' + ex.getMessage());
        }

        return result;
    }
}