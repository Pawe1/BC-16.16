//class CommonDateFormatDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonDateFormatDataProvider extends Object
    {
        public function CommonDateFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_DATEFORMAT_EU"), "data":"eu"}, {"label":utils.LanguageManager.getString("SETTINGS_DATEFORMAT_US"), "data":"us"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


