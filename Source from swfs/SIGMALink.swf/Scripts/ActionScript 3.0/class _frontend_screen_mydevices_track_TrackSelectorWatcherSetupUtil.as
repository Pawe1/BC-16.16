//class _frontend_screen_mydevices_track_TrackSelectorWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.mydevices.track.*;
    
    public class _frontend_screen_mydevices_track_TrackSelectorWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_track_TrackSelectorWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[2]], null);
            arg5[9] = new feathers.binding.PropertyWatcher("_listTitle", {"propertyChange":true}, [arg4[10]], arg2);
            arg5[11] = new feathers.binding.PropertyWatcher("download", {"propertyChange":true}, [arg4[13]], arg2);
            arg5[7] = new feathers.binding.StaticPropertyWatcher("ROW_PADDING", {"propertyChange":true}, [arg4[8]], arg3);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("ROW_HEIGHT_SMALL", {"propertyChange":true}, [arg4[5]], null);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3], arg4[7], arg4[12]], null);
            arg5[10] = new feathers.binding.PropertyWatcher("_customList", {"propertyChange":true}, [arg4[11]], arg2);
            arg5[2].updateParent(SIGMALink);
            arg5[9].updateParent(arg1);
            arg5[11].updateParent(arg1);
            arg5[7].updateParent(frontend.screen.mydevices.track.TrackSelector);
            arg5[5].updateParent(frontend.components.menuList.MenuList);
            arg5[3].updateParent(SIGMALink);
            arg5[10].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.track.TrackSelector.watcherSetupUtil = new _frontend_screen_mydevices_track_TrackSelectorWatcherSetupUtil();
            return;
        }
    }
}


