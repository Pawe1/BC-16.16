//class CommonAltitudeReferenceDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonAltitudeReferenceDataProvider extends Object
    {
        public function CommonAltitudeReferenceDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_ACTUAL_ALTITUDE"), "data":core.general.AltitudeReference.ACTUAL_ALTITUDE}, {"label":utils.LanguageManager.getString("SETTINGS_AIR_PRESSURE"), "data":core.general.AltitudeReference.SEA_LEVEL}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


