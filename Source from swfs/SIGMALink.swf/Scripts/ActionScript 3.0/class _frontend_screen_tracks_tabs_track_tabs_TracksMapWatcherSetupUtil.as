//class _frontend_screen_tracks_tabs_track_tabs_TracksMapWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.tracks.tabs.track.tabs.*;
    
    public class _frontend_screen_tracks_tabs_track_tabs_TracksMapWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_tracks_tabs_track_tabs_TracksMapWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[4] = new feathers.binding.StaticPropertyWatcher("footerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2]], null);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("headerHeight", {"propertyChange":true}, [arg4[1], arg4[3]], null);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[4].updateParent(SIGMALink);
            arg5[5].updateParent(SIGMALink);
            arg5[2].updateParent(SIGMALink);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.tracks.tabs.track.tabs.TracksMap.watcherSetupUtil = new _frontend_screen_tracks_tabs_track_tabs_TracksMapWatcherSetupUtil();
            return;
        }
    }
}


