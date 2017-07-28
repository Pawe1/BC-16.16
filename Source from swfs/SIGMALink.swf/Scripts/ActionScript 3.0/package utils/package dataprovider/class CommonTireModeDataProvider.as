//class CommonTireModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonTireModeDataProvider extends Object
    {
        public function CommonTireModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("TIRE_SIZE_16INCH"), "data":core.general.TireSize.S_16INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_18INCH"), "data":core.general.TireSize.S_18INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_20INCH"), "data":core.general.TireSize.S_20INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_22INCH"), "data":core.general.TireSize.S_22INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_24INCH"), "data":core.general.TireSize.S_24INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_26INCH"), "data":core.general.TireSize.S_26INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_27INCH"), "data":core.general.TireSize.S_27INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_275INCH"), "data":core.general.TireSize.S_275INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_28INCH"), "data":core.general.TireSize.S_28INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_29INCH"), "data":core.general.TireSize.S_29INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_700C"), "data":core.general.TireSize.S_700C}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


