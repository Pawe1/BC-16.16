//class _frontend_screen_tracks_tabs_track_TrackDetailWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.tracks.tabs.track.*;
    
    public class _frontend_screen_tracks_tabs_track_TrackDetailWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_tracks_tabs_track_TrackDetailWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2]], null);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[2].updateParent(SIGMALink);
            arg5[1].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.tracks.tabs.track.TrackDetail.watcherSetupUtil = new _frontend_screen_tracks_tabs_track_TrackDetailWatcherSetupUtil();
            return;
        }
    }
}


