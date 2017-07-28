//class _frontend_screen_activities_share_ActivityShareWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.activities.share.*;
    
    public class _frontend_screen_activities_share_ActivityShareWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_share_ActivityShareWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[9] = new feathers.binding.PropertyWatcher("yPos", {"propertyChange":true}, [arg4[13]], arg2);
            arg5[8] = new feathers.binding.StaticPropertyWatcher("SMALLER_ROW_HEIGHT", {"propertyChange":true}, [arg4[12]], null);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[5], arg4[14], arg4[17]], null);
            arg5[9].updateParent(arg1);
            arg5[8].updateParent(frontend.components.menuList.MenuList);
            arg5[3].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.share.ActivityShare.watcherSetupUtil = new _frontend_screen_activities_share_ActivityShareWatcherSetupUtil();
            return;
        }
    }
}


