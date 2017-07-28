//class CommonAlarmModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonAlarmModeDataProvider extends Object
    {
        public function CommonAlarmModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_OFF"), "data":"off"}, {"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_DAILY"), "data":"everyDay"}, {"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_WORK_DAYS"), "data":"workDay"}, {"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_ONCE"), "data":"oneTime"}]);
            return;
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


