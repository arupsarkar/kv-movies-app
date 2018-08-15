public class MoviesTestUtil {

    final string ADMIN_PROFILE_NAME = 'Movies App System Administrator';
    final string STANDARD_USER_PROFILE_NAME = 'Movies App Standard User';


    public MoviesTestUtil() {

    }


    public User getStandardUser(Boolean isUpdateable, Boolean adminFlag){
        
        string profileName = '';
        if(adminFlag){
            profileName = ADMIN_PROFILE_NAME;
        }else{
            profileName = STANDARD_USER_PROFILE_NAME;
        }

        User kvMoviesStandardUser = new User();
        kvMoviesStandardUser.ProfileId = [SELECT Id
                                            FROM Profile
                                            WHERE Name = :profileName].Id;

        kvMoviesStandardUser.Email = 'test@testorg.com';
        kvMoviesStandardUser.UserPermissionsMarketingUser = true;
        kvMoviesStandardUser.Alias = 'test';
        kvMoviesStandardUser.EmailEncodingKey = 'UTF-8';
        kvMoviesStandardUser.FirstName = 'FirstName';
        kvMoviesStandardUser.LastName = 'LastName';
        kvMoviesStandardUser.LanguageLocaleKey = 'en_US';
        kvMoviesStandardUser.LocaleSidKey = 'en_US';
        kvMoviesStandardUser.TimeZoneSidKey = 'America/Los_Angeles';
        kvMoviesStandardUser.UserName = 'test' + Datetime.now().hour() + Datetime.now().minute() + Datetime.now().millisecond() + '@testorg.com';

        if (isUpdateable == false) {
            insert kvMoviesStandardUser;
        }

        return kvMoviesStandardUser;

    }

}