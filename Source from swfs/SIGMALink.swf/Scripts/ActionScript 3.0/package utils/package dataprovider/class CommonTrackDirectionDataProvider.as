//class CommonTrackDirectionDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonTrackDirectionDataProvider extends Object
    {
        public function CommonTrackDirectionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("TRACK_NORTH_DIRECTION"), "data":"north"}, {"label":utils.LanguageManager.getString("TRACK_DRIVING_DIRECTION"), "data":"drivingDirection"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


