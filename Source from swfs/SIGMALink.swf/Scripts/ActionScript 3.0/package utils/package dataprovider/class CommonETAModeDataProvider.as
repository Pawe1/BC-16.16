//class CommonETAModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonETAModeDataProvider extends Object
    {
        public function CommonETAModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_DETAIL_BICYCLE_ETA_MODE_TIME"), "data":false}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_BICYCLE_ETA_MODE_CLOCK"), "data":true}]);
            return;
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


