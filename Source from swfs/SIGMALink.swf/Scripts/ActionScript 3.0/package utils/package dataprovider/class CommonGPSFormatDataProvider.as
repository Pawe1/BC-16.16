//class CommonGPSFormatDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    
    public class CommonGPSFormatDataProvider extends Object
    {
        public function CommonGPSFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":"hddd°mm,mmm", "data":"hddd°mm,mmm"}, {"label":"hddd°mm\'ss,s", "data":"hddd°mm\'ss,s"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


