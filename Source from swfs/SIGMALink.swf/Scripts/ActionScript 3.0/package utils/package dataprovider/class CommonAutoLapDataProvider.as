//class CommonAutoLapDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonAutoLapDataProvider extends Object
    {
        public function CommonAutoLapDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_OFF"), "data":0}, {"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_BASEDON_DISTANCE"), "data":1}, {"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_BASEDON_TIME"), "data":2}, {"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_BASEDON_CALORIES"), "data":3}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


