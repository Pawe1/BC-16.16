//class _frontend_screen_videos_YoutubeItemWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.videos.*;
    
    public class _frontend_screen_videos_YoutubeItemWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_videos_YoutubeItemWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[3] = new feathers.binding.PropertyWatcher("transparentBgSkin", {"propertyChange":true}, [arg4[4]], arg2);
            arg5[7] = new feathers.binding.PropertyWatcher("showStats", {"propertyChange":true}, [arg4[9], arg4[10]], arg2);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[0], arg4[2], arg4[5]], null);
            arg5[1] = new feathers.binding.PropertyWatcher("bgImage", {"propertyChange":true}, [arg4[1]], arg2);
            arg5[6] = new feathers.binding.PropertyWatcher("title", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[8] = new feathers.binding.PropertyWatcher("views", {"propertyChange":true}, [arg4[11]], arg2);
            arg5[3].updateParent(arg1);
            arg5[7].updateParent(arg1);
            arg5[0].updateParent(SIGMALink);
            arg5[1].updateParent(arg1);
            arg5[6].updateParent(arg1);
            arg5[8].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.videos.YoutubeItem.watcherSetupUtil = new _frontend_screen_videos_YoutubeItemWatcherSetupUtil();
            return;
        }
    }
}


