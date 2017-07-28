//class CommonDistanceUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonDistanceUnitDataProvider extends Object
    {
        public function CommonDistanceUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("DISTANCE_FORMAT_KILOMETER"), "data":"kilometer"}, {"label":utils.LanguageManager.getString("DISTANCE_FORMAT_MILE"), "data":"mile"}]);
            V_DATA_PROVIDER_SOFTWARE_SETTINGS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("DISTANCE_FORMAT_KILOMETER"), "data":"kilometer"}, {"label":utils.LanguageManager.getString("DISTANCE_FORMAT_MILE"), "data":"mile"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARE_SETTINGS:__AS3__.vec.Vector.<Object>;
    }
}


