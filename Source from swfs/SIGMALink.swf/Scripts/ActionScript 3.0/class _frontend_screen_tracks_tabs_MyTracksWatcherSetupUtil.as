//class _frontend_screen_tracks_tabs_MyTracksWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.tracks.tabs.*;
    
    public class _frontend_screen_tracks_tabs_MyTracksWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_tracks_tabs_MyTracksWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[3] = new feathers.binding.PropertyWatcher("_trackList", {"propertyChange":true}, [arg4[2]], arg2);
            arg5[4] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3]], null);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[3].updateParent(arg1);
            arg5[4].updateParent(SIGMALink);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.tracks.tabs.MyTracks.watcherSetupUtil = new _frontend_screen_tracks_tabs_MyTracksWatcherSetupUtil();
            return;
        }
    }
}


