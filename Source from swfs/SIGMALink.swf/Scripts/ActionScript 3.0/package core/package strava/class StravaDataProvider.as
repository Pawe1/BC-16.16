//class StravaDataProvider
package core.strava 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class StravaDataProvider extends Object
    {
        public function StravaDataProvider()
        {
            super();
            return;
        }

        public static function get compareToDataProvider():__AS3__.vec.Vector.<Object>
        {
            if (_compareToDataProvider == null) 
            {
                _compareToDataProvider = new __AS3__.vec.Vector.<Object>();
                _compareToDataProvider.push({"label":utils.LanguageManager.getString("UNIT_STRAVA_COMPARE_TO_KOM"), "compareTo":0});
                _compareToDataProvider.push({"label":utils.LanguageManager.getString("UNIT_STRAVA_COMPARE_TO_PR"), "compareTo":1});
                _compareToDataProvider.push({"label":utils.LanguageManager.getString("UNIT_STRAVA_COMPARE_TO_BESTFOLLOW"), "compareTo":2});
            }
            return _compareToDataProvider;
        }

        public static const COMPARE_CONFIG_CACHE_OBJECT:String="stravaCompareTo";

        public static const COMPARE_DP_COMPARETOFIELD:String="compareTo";

        public static const COMPARE_DP_LABELFIELD:String="label";

        public static const COMPARE_TO_BESTFOLLOW:uint=2;

        public static const COMPARE_TO_GOALTIME:uint=3;

        public static const COMPARE_TO_KOM:uint=0;

        public static const COMPARE_TO_PR:uint=1;

        internal static var _compareToDataProvider:__AS3__.vec.Vector.<Object>;
    }
}


