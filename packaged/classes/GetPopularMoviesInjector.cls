public class GetPopularMoviesInjector extends MoviesServiceInjector{
    public override MoviesConsumer getMoviesConsumer(){
        return new MoviesApplication(new GetPopularMoviesServiceImpl());
    }
}