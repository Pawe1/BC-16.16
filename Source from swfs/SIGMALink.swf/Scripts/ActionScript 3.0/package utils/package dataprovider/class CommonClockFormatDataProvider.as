//class CommonClockFormatDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonClockFormatDataProvider extends Object
    {
        public function CommonClockFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("CLOCK_FORMAT_24"), "data":"24"}, {"label":utils.LanguageManager.getString("CLOCK_FORMAT_12"), "data":"12"}]);
            V_AM_PM_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("UNIT_AM"), "data":"AM"}, {"label":utils.LanguageManager.getString("UNIT_PM"), "data":"PM"}]);
            return;
        }

        public static var V_AM_PM_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


