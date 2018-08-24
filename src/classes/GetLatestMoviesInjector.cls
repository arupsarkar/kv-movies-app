public class GetLatestMoviesInjector extends MoviesServiceInjector{

    public override MoviesConsumer getMoviesConsumer(){
        return new MoviesApplication(new GetLatestMoviesServiceImpl());
    }
    
}