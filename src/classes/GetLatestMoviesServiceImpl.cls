public class GetLatestMoviesServiceImpl extends MoviesService{
    string result{get; private set;}
    public override String GetMovies(){
        System.debug(System.LoggingLevel.DEBUG, 'GetLatestMoviesServiceImpl.GetMovies()');        
        return result;
    }
}