@isTest
public class MoviesServiceDI_TEST {
    
    @isTest static void getLatestMoviesTest(){
        System.debug(LoggingLevel.DEBUG, 'MoviesServiceDI_TEST.getLatestMoviesTest()');
        MoviesServiceInjector injector = null;
        MoviesConsumer app = null;
        
        injector = new GetLatestMoviesInjector();
        app = injector.getMoviesConsumer();
        app.processMovies();
    }

    @isTest static void getPopularMoviesTest(){
        System.debug(LoggingLevel.DEBUG, 'MoviesServiceDI_TEST.getPopularMoviesTest()');
        MoviesServiceInjector injector = null;
        MoviesConsumer app = null;
        
        injector = new GetPopularMoviesInjector();
        app = injector.getMoviesConsumer();
        app.processMovies();        
    }
}