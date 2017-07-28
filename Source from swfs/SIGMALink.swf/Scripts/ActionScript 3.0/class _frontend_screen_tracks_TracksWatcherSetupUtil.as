//class _frontend_screen_tracks_TracksWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.tracks.*;
    
    public class _frontend_screen_tracks_TracksWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_tracks_TracksWatcherSetupUtil()
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
            frontend.screen.tracks.Tracks.watcherSetupUtil = new _frontend_screen_tracks_TracksWatcherSetupUtil();
            return;
        }
    }
}


