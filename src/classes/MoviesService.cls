public abstract class MoviesService {
    string result{get; private set;}
    //Get the movies
    public virtual String GetMovies(){
        System.debug(System.LoggingLevel.DEBUG, 'Abstract class GetMovies()');
        return result;
    }    
}