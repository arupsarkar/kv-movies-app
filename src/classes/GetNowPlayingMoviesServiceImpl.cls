public with sharing class GetNowPlayingMoviesServiceImpl extends MoviesService{

    string result{get; private set;}
    List<Movies.Results> moviesList = new List<Movies.Results>();
    List<Movie__c> nowPlayingMoviesList = new List<Movie__c>();
    final Integer PAGES = 10;
    //get a list of all genres to decode fromthe API.
    List<Genre__c> genreList = [SELECT Id, Name, Genre_Id__c from Genre__c];
    Map<Decimal, String> genreMap = new Map<Decimal, String>();
    //List to capture the genres from the API.
    List<Integer> genreIds = new List<Integer>();
    String genreData = '';
    Date nowPlayingStartDate;
    Date nowPlayingEndDate;

    public override String GetMovies(){

        System.debug(System.LoggingLevel.DEBUG, 'GetNowPlayingMovies.GetMovies()');

        if(Test.isRunningTest()){
            return '';
        }

        Http httpClient = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.themoviedb.org/3/movie/now_playing?api_key=14f3a773746ea1d08c5ba9df6472cdde&language=en-US');
        req.setMethod('GET');        
        req.setTimeout(60000);
        HttpResponse res = new Http().send(req);
        // If the request is successful, parse the JSON response.
        if(res.getStatusCode() == 200){
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            //get the total number of pages to query.
            for(String key : results.keySet()){
                System.debug(LoggingLevel.DEBUG, 'key = ' + key);
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
            request.setEndpoint('https://api.themoviedb.org/3/movie/now_playing?api_key=14f3a773746ea1d08c5ba9df6472cdde&language=en-US&page=' + page);
            request.setMethod('GET');        
            request.setTimeout(60000);
            HttpResponse response = new Http().send(request);
            Movies movies = Movies.parse(response.getBody());
            System.debug(LoggingLevel.DEBUG, 'Minimum Date = ' + String.valueOf(movies.dates.minimum));            
            System.debug(LoggingLevel.DEBUG, 'Maximum Date = ' + String.valueOf(movies.dates.maximum));                        
            nowPlayingStartDate = Date.valueOf(movies.dates.minimum);
            nowPlayingEndDate = Date.valueOf(movies.dates.maximum);
            for(Movies.Results result : movies.results){
                moviesList.add(result);
            }
            System.debug(LoggingLevel.DEBUG, moviesList.size());                       
        }

        //display the results
        for(Movies.Results data : moviesList){
            Movie__c movie = new Movie__c();
            movie.movie_id__c = data.id;
            movie.adult__c = data.adult;
            movie.backdrop_path__c = data.backdrop_path;
            movie.Name = data.title;
            movie.original_language__c = data.original_language;
            movie.original_title__c = data.original_title;
            movie.Overview__c = data.overview;
            movie.Now_Playing__c = true;
            movie.popularity__c = data.popularity;
            movie.poster_path__c = data.poster_path;
            movie.release_date__c = Date.valueOf(data.release_date);
            movie.title__c = data.title;
            movie.video__c = data.video;
            movie.vote_average__c = data.vote_average;
            movie.vote_count__c = data.vote_count;
            genreData = '';
            //check for null for genres
            if(data.genre_ids.size() > 0){
                //populate the genre map
                for(Genre__c g : genreList){
                    genreMap.put(g.Genre_Id__c, g.Name);
                }
                //decode
                for(Integer genreId : data.genre_ids){
                    genreData = genreData + genreMap.get(genreId) + ',';
                }
                //remove the last comma from the string
                Integer lengthOfData = genreData.length();
                Integer lastIndexOfComma = genreData.indexOf(',', lengthOfData-1);
                if(lastIndexOfComma != -1){
                    genreData = genreData.left(lengthOfData-1);
                }                
                System.debug(LoggingLevel.DEBUG, genreData);
            }
            movie.Genre__c = genreData;
            movie.now_playing_start_date__c = nowPlayingStartDate;
            movie.now_playing_end_date__c = nowPlayingEndDate;
            System.debug(LoggingLevel.DEBUG, data.id);
            System.debug(LoggingLevel.DEBUG, data.overview);
            System.debug(LoggingLevel.DEBUG, data.poster_path);
            System.debug(LoggingLevel.DEBUG, data.backdrop_path);  
            nowPlayingMoviesList.add(movie);
            
        }        
        try{
            upsert nowPlayingMoviesList;
        }catch(Exception ex){
            System.debug(LoggingLevel.ERROR, 'Error Message: ' + ex.getMessage());
        }
        return result;
    }

}