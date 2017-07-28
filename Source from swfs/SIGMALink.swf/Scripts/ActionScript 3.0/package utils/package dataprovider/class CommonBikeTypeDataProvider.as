//class CommonBikeTypeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonBikeTypeDataProvider extends Object
    {
        public function CommonBikeTypeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_BIKE_TYPE_RACE_DROP"), "data":"raceDrop"}, {"label":utils.LanguageManager.getString("SETTINGS_BIKE_TYPE_RACE_HOODS"), "data":"raceHoods"}, {"label":utils.LanguageManager.getString("SETTINGS_BIKE_TYPE_MOUNTAIN_BIKE"), "data":"mountainBike"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


