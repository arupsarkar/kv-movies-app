public class MoviesClient {

    public void getLatestMovies(){
        MoviesServiceInjector injector = null;
        MoviesConsumer app = null;
        
        injector = new GetLatestMoviesInjector();
        app = injector.getMoviesConsumer();
        app.processMovies();        
    }
    
    public void getPopularMovies(){
        MoviesServiceInjector injector = null;
        MoviesConsumer app = null;
        
        injector = new GetPopularMoviesInjector();
        app = injector.getMoviesConsumer();
        app.processMovies();                
    }
    
    public void getNowPlayingMovies(){
        MoviesServiceInjector injector = null;
        MoviesConsumer app = null;
        
        injector = new GetNowPlayingMoviesInjector();
        app = injector.getMoviesConsumer();
        app.processMovies();                
    }    
    
}