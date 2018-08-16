public abstract class MoviesConsumer {
    String result{get; private set;}
    public virtual String processMovies(){
        return result;
    }
}