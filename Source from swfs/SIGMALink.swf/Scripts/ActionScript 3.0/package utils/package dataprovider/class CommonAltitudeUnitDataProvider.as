//class CommonAltitudeUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonAltitudeUnitDataProvider extends Object
    {
        public function CommonAltitudeUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_METER"), "data":"meter"}, {"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_FEET"), "data":"feet"}]);
            V_DATA_PROVIDER_SOFTWARE_SETTINGS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_METER"), "data":"meter"}, {"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_FEET"), "data":"feet"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARE_SETTINGS:__AS3__.vec.Vector.<Object>;
    }
}


