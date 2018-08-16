public class GetNowPlayingMoviesInjector extends MoviesServiceInjector{
    
    public override MoviesConsumer getMoviesConsumer(){
        return new MoviesApplication(new GetNowPlayingMoviesServiceImpl());
    }
    
}