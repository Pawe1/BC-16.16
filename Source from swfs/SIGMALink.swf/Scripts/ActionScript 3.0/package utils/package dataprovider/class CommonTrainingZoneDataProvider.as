//class CommonTrainingZoneDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonTrainingZoneDataProvider extends Object
    {
        public function CommonTrainingZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_FIT_FAT = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FIT_ZONE"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_FAT_ZONE"), "data":"fatZone"}]);
            V_DATA_PROVIDER_HEARTRATE_LIMITS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FIT_ZONE"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_FAT_ZONE"), "data":"fatZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OWN_ZONE"), "data":"ownZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OFF"), "data":"off"}]);
            V_DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FIT_ZONE"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_FAT_ZONE"), "data":"fatZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OWN_ZONE"), "data":"ownZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OFF"), "data":"off"}]);
            V_DATA_PROVIDER_RCMOVE = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_FIT"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_FAT"), "data":"fatZone"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_OWN_1"), "data":"ownZone1"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_OWN_2"), "data":"ownZone2"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_OWN_3"), "data":"ownZone3"}, {"label":utils.LanguageManager.getString("SETTINGS_OFF"), "data":"off"}]);
            return;
        }

        public static var V_DATA_PROVIDER_FIT_FAT:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_HEARTRATE_LIMITS:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RCMOVE:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;
    }
}


