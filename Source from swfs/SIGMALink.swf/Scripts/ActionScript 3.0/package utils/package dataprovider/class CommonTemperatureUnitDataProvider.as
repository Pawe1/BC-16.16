//class CommonTemperatureUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonTemperatureUnitDataProvider extends Object
    {
        public function CommonTemperatureUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CELSIUS"), "data":"celsius"}, {"label":utils.LanguageManager.getString("SETTINGS_FAHRENHEIT"), "data":"fahrenheit"}]);
            V_DATA_PROVIDER_SOFTWARE_SETTINGS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CELSIUS"), "data":"celsius"}, {"label":utils.LanguageManager.getString("SETTINGS_FAHRENHEIT"), "data":"fahrenheit"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARE_SETTINGS:__AS3__.vec.Vector.<Object>;
    }
}


