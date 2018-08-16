public abstract class MoviesServiceInjector {
	private MoviesConsumer mConsumer;
    
    public MoviesServiceInjector(){}
    public MoviesServiceInjector(MoviesConsumer mCon){
        this.mConsumer = mCon;
    }
    public virtual MoviesConsumer getMoviesConsumer(){
        return mConsumer;
    }
}