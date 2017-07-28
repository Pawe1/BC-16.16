//class CommonWheelSizeSelectionModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonWheelSizeSelectionModeDataProvider extends Object
    {
        public function CommonWheelSizeSelectionModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("WHEELSIZE_MANUAL"), "data":core.general.WheelSizeSelectionMode.MANUAL.toString()}, {"label":utils.LanguageManager.getString("WHEELSIZE_TIRE"), "data":core.general.WheelSizeSelectionMode.TIRE.toString()}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


