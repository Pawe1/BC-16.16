//class CommonMeasurementDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonMeasurementDataProvider extends Object
    {
        public function CommonMeasurementDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_KMH"), "data":"kmh"}, {"label":utils.LanguageManager.getString("SETTINGS_MPH"), "data":"mph"}]);
            V_DATA_PROVIDER_RC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_KMH"), "data":"kmh"}, {"label":utils.LanguageManager.getString("SETTINGS_MPH"), "data":"mph"}, {"label":utils.LanguageManager.getString("SETTINGS_MIN_KM"), "data":"min/km"}, {"label":utils.LanguageManager.getString("SETTINGS_MIN_MI"), "data":"min/mi"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RC:__AS3__.vec.Vector.<Object>;
    }
}


