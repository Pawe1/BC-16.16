//class CommonTrackDistanceDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.*;
    import utils.*;
    
    public class CommonTrackDistanceDataProvider extends Object
    {
        public function CommonTrackDistanceDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            if (core.MeasurementConfig.distanceFormat != "kilometer") 
            {
                V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_OFF_TRACK_ALARM_OFF"), "data":0}, {"label":"131 " + utils.LanguageManager.getString("UNIT_FT"), "data":1}, {"label":"262 " + utils.LanguageManager.getString("UNIT_FT"), "data":2}, {"label":"393 " + utils.LanguageManager.getString("UNIT_FT"), "data":3}]);
            }
            else 
            {
                V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_OFF_TRACK_ALARM_OFF"), "data":0}, {"label":"40 " + utils.LanguageManager.getString("UNIT_M"), "data":1}, {"label":"80 " + utils.LanguageManager.getString("UNIT_M"), "data":2}, {"label":"120 " + utils.LanguageManager.getString("UNIT_M"), "data":3}]);
            }
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


