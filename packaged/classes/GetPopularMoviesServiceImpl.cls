public with sharing class GetPopularMoviesServiceImpl extends MoviesService{
    string result{get; private set;}
    List<PopularMovies.Results> moviesList = new List<PopularMovies.Results>();


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
            // // Deserialize the JSON string into collections of primitive data types.
            // Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            // for(String key : results.keySet()){
            //     System.debug(LoggingLevel.DEBUG, '' + key);
            //     System.debug(LoggingLevel.DEBUG, results.get(key));
            //     if(key.equals('results')){
            //         PopularMovies movie = PopularMovies.parse(results.get(key));
            //         System.debug(LoggingLevel.DEBUG, movie.results);
            //     }
            // }
            PopularMovies movies = PopularMovies.parse(res.getBody());
            for(PopularMovies.Results result : movies.results){
                moviesList.add(result);
            }
            System.debug(LoggingLevel.DEBUG, moviesList.size());            
        }else{
            //handle error

        }


        //display the results
        for(PopularMovies.Results data : moviesList){
            System.debug(LoggingLevel.DEBUG, data.id);
            System.debug(LoggingLevel.DEBUG, data.overview);
            System.debug(LoggingLevel.DEBUG, data.poster_path);
            System.debug(LoggingLevel.DEBUG, data.backdrop_path);            
        }

        return result;
    }
}