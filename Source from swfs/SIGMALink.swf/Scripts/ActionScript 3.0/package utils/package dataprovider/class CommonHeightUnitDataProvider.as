//class CommonHeightUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonHeightUnitDataProvider extends Object
    {
        public function CommonHeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CM"), "data":"centimeter"}, {"label":utils.LanguageManager.getString("SETTINGS_INCH"), "data":"inch"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


