//class CommonAutoOffTimeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonAutoOffTimeDataProvider extends Object
    {
        public function CommonAutoOffTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_OFF"), "data":core.general.AutoOffTimeUnit.OFF}, {"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_5MIN"), "data":core.general.AutoOffTimeUnit.FIVE_MINUTES}, {"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_30MIN"), "data":core.general.AutoOffTimeUnit.THIRTY_MINUTES}, {"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_1HOUR"), "data":core.general.AutoOffTimeUnit.ONE_HOURS}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


