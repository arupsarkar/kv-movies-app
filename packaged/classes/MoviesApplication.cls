public class MoviesApplication extends MoviesConsumer{

    private MoviesService mService;
    String result{get; private set;}
    public MoviesApplication(MoviesService mSvc){
        this.mService = mSvc;
    }
    
    public override String processMovies(){
        this.mService.GetMovies();
        return result;
    }
}