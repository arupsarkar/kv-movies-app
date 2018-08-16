public with sharing class GetPopularMovies extends MoviesService{
    string result{get; private set;}
    public override String GetMovies(){
        System.debug(System.LoggingLevel.DEBUG, 'GetPopularMovies.GetMovies()');        
        return result;
    }
}