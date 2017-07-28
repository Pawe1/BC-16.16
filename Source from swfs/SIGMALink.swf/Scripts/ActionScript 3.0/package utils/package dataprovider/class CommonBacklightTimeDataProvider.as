//class CommonBacklightTimeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonBacklightTimeDataProvider extends Object
    {
        public function CommonBacklightTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("BACKLIGHT_TIME_PERMANENT"), "data":0}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_5_MIN_ON"), "data":1}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_2_MIN_ON"), "data":2}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_30_SEC_ON"), "data":3}]);
            DATA_PROVIDER_ROX70_ROX110 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("BACKLIGHT_TIME_PERMANENT"), "data":3}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_5_MIN_ON"), "data":2}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_2_MIN_ON"), "data":1}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_30_SEC_ON"), "data":0}]);
            return;
        }

        public static var DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;

        public static var DATA_PROVIDER_ROX70_ROX110:__AS3__.vec.Vector.<Object>;
    }
}


