//class CommonWeightUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonWeightUnitDataProvider extends Object
    {
        public function CommonWeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("UNIT_KG"), "data":"kg"}, {"label":utils.LanguageManager.getString("UNIT_LB"), "data":"lb"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


