//class CommonFuelConsumptionDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonFuelConsumptionDataProvider extends Object
    {
        public function CommonFuelConsumptionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("UNIT_LITER"), "data":"l/100km"}, {"label":utils.LanguageManager.getString("UNIT_GALLON"), "data":"mpg"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


