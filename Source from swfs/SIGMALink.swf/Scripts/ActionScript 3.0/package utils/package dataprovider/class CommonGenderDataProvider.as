//class CommonGenderDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonGenderDataProvider extends Object
    {
        public function CommonGenderDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_MALE"), "data":"male"}, {"label":utils.LanguageManager.getString("SETTINGS_FEMALE"), "data":"female"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


