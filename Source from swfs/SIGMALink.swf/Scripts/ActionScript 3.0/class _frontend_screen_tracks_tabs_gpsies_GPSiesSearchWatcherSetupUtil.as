//class _frontend_screen_tracks_tabs_gpsies_GPSiesSearchWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.tracks.tabs.gpsies.*;
    
    public class _frontend_screen_tracks_tabs_gpsies_GPSiesSearchWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_tracks_tabs_gpsies_GPSiesSearchWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[3], arg4[5], arg4[7]], null);
            arg5[6] = new feathers.binding.PropertyWatcher("_gpsiesInfo", {"propertyChange":true}, [arg4[9]], arg2);
            arg5[4] = new feathers.binding.PropertyWatcher("loading", {"propertyChange":true}, [arg4[6], arg4[10], arg4[11], arg4[12]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[2].updateParent(SIGMALink);
            arg5[6].updateParent(arg1);
            arg5[4].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.tracks.tabs.gpsies.GPSiesSearch.watcherSetupUtil = new _frontend_screen_tracks_tabs_gpsies_GPSiesSearchWatcherSetupUtil();
            return;
        }
    }
}


