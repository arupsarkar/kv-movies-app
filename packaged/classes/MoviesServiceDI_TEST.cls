@isTest
public class MoviesServiceDI_TEST {
    
    @isTest static void getLatestMoviesTest(){
        MoviesServiceInjector injector = null;
        MoviesConsumer app = null;
        
        injector = new GetLatestMoviesInjector();
        app = injector.getMoviesConsumer();
        app.processMovies();
    }
}