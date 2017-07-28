//class ActivityShareObject
package core.activities 
{
    public class ActivityShareObject extends Object
    {
        public function ActivityShareObject(arg1:core.activities.Activity=null)
        {
            super();
            if (arg1 != null) 
            {
                fromActivity(arg1);
            }
            return;
        }

        public function fromJson(arg1:String):void
        {
            var loc1:*=JSON.parse(arg1);
            if (loc1) 
            {
                var loc4:*=0;
                var loc3:*=loc1;
                for (var loc2:* in loc3) 
                {
                    if (!(serviceAllowed(loc2) && this.hasOwnProperty(loc2))) 
                    {
                        continue;
                    }
                    this[loc2] = loc1[loc2];
                }
            }
            return;
        }

        public function toJson():String
        {
            return JSON.stringify(this);
        }

        public function isShared(arg1:String):Boolean
        {
            if (!serviceAllowed(arg1)) 
            {
                return false;
            }
            return !(this[arg1] == "0");
        }

        internal function serviceAllowed(arg1:String):Boolean
        {
            return ALLOWED_SHARING_SERVICES.indexOf(arg1) >= 0;
        }

        public function isAnyShared():Boolean
        {
            var loc1:*=0;
            while (loc1 < ALLOWED_SHARING_SERVICES.length) 
            {
                if (isShared(ALLOWED_SHARING_SERVICES[loc1])) 
                {
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public function saveToActivity(arg1:core.activities.Activity):void
        {
            arg1.sharedToFacebookId = facebookId;
            arg1.sharedToFacebook = !(facebookId == "0");
            arg1.sharedToStravaId = stravaId;
            arg1.sharedToStrava = !(stravaId == "0");
            arg1.sharedToTrainingPeaksId = trainingPeaksId;
            arg1.sharedToTrainingPeaks = !(trainingPeaksId == "0");
            arg1.sharedToTwitterId = twitterId;
            arg1.sharedToTwitter = !(twitterId == "0");
            arg1.sharedTo2PeakId = twoPeaksId;
            arg1.sharedTo2Peak = !(twoPeaksId == "0");
            arg1.shared = arg1.sharedToStrava || arg1.sharedToTrainingPeaks || arg1.sharedTo2Peak || arg1.sharedToFacebook || arg1.sharedToTwitter;
            return;
        }

        public function reset():void
        {
            facebookId = "0";
            stravaId = "0";
            trainingPeaksId = "0";
            twitterId = "0";
            twoPeaksId = "0";
            return;
        }

        public function fromActivity(arg1:core.activities.Activity):void
        {
            if (arg1 != null) 
            {
                facebookId = arg1.sharedToFacebookId;
                stravaId = arg1.sharedToStravaId;
                trainingPeaksId = arg1.sharedToTrainingPeaksId;
                twitterId = arg1.sharedToTwitterId;
                twoPeaksId = arg1.sharedTo2PeakId;
            }
            return;
        }

        public static const DEFAULT_SHARING_ID:String="0";

        public static const SERVICE_FACEBOOK:String="facebookId";

        public static const SERVICE_STRAVA:String="stravaId";

        public static const SERVICE_TRAININGPEAKS:String="trainingPeaksId";

        public static const SERVICE_TWITTER:String="twitterId";

        public static const SERVICE_TWOPEAKS:String="twoPeaksId";

        internal static const ALLOWED_SHARING_SERVICES:Array=["facebookId", "stravaId", "trainingPeaksId", "twitterId", "twoPeaksId"];

        public var facebookId:String="0";

        public var stravaId:String="0";

        public var trainingPeaksId:String="0";

        public var twitterId:String="0";

        public var twoPeaksId:String="0";
    }
}


