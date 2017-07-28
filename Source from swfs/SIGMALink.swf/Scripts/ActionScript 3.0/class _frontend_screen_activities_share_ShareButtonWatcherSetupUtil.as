//class _frontend_screen_activities_share_ShareButtonWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.activities.share.*;
    
    public class _frontend_screen_activities_share_ShareButtonWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_share_ShareButtonWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[13] = new feathers.binding.PropertyWatcher("shared", {"propertyChange":true}, [arg4[13]], arg2);
            arg5[5] = new feathers.binding.PropertyWatcher("textureName", {"propertyChange":true}, [arg4[4]], arg2);
            arg5[8] = new feathers.binding.PropertyWatcher("title", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[14] = new feathers.binding.PropertyWatcher("loading", {"propertyChange":true}, [arg4[14]], arg2);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[2], arg4[6]], null);
            arg5[9] = new feathers.binding.PropertyWatcher("selected", {"propertyChange":true}, [arg4[9]], arg2);
            arg5[13].updateParent(arg1);
            arg5[5].updateParent(arg1);
            arg5[8].updateParent(arg1);
            arg5[14].updateParent(arg1);
            arg5[2].updateParent(SIGMALink);
            arg5[9].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.share.ShareButton.watcherSetupUtil = new _frontend_screen_activities_share_ShareButtonWatcherSetupUtil();
            return;
        }
    }
}


