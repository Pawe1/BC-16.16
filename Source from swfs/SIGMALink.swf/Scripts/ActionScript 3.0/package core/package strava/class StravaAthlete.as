//class StravaAthlete
package core.strava 
{
    public class StravaAthlete extends core.strava.StravaApiBase
    {
        public function StravaAthlete()
        {
            super();
            return;
        }

        public function isPremium():Boolean
        {
            return premium;
        }

        public static const FIELD_CITY:String="city";

        public static const FIELD_COUNTRY:String="country";

        public static const FIELD_CREATED_AT:String="created_at";

        public static const FIELD_FIRSTNAME:String="firstname";

        public static const FIELD_FOLLOWER:String="follower";

        public static const FIELD_FRIEND:String="friend";

        public static const FIELD_ID:String="id";

        public static const FIELD_LASTNAME:String="lastname";

        public static const FIELD_PREMIUM:String="premium";

        public static const FIELD_PROFILE:String="profile";

        public static const FIELD_PROFILE_MEDIUM:String="profile_medium";

        public static const FIELD_RESOURCE_STATE:String="resource_state";

        public static const FIELD_SEX:String="sex";

        public static const FIELD_STATE:String="state";

        public static const FIELD_UPDATED_AT:String="updated_at";

        public var city:String;

        public var country:String;

        public var created_at:String;

        public var firstname:String;

        public var follower:String;

        public var friend:String;

        public var id:int;

        public var lastname:String;

        public var premium:Boolean;

        public var profile:String;

        public var profile_medium:String;

        public var resource_state:int;

        public var sex:String;

        public var state:String;

        public var updated_at:String;
    }
}


