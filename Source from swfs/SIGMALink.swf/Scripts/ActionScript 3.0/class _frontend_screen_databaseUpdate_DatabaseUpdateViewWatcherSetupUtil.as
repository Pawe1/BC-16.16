//class _frontend_screen_databaseUpdate_DatabaseUpdateViewWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import feathers.themes.*;
    import frontend.screen.databaseUpdate.*;
    
    public class _frontend_screen_databaseUpdate_DatabaseUpdateViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_databaseUpdate_DatabaseUpdateViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[5] = new feathers.binding.PropertyWatcher("_progressLabel", {"propertyChange":true}, [arg4[8]], arg2);
            arg5[6] = new feathers.binding.PropertyWatcher("_progressBGSkin", {"propertyChange":true}, [arg4[9]], arg2);
            arg5[4] = new feathers.binding.PropertyWatcher("TEXT_STYLE_NORMAL_BOLD", null, [arg4[7]], null);
            arg5[7] = new feathers.binding.PropertyWatcher("_progressFillSkin", {"propertyChange":true}, [arg4[10]], arg2);
            arg5[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3], arg4[13]], null);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("appHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[5].updateParent(arg1);
            arg5[6].updateParent(arg1);
            arg5[4].updateParent(feathers.themes.CustomSIGMATheme);
            arg5[7].updateParent(arg1);
            arg5[1].updateParent(SIGMALink);
            arg5[0].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.databaseUpdate.DatabaseUpdateView.watcherSetupUtil = new _frontend_screen_databaseUpdate_DatabaseUpdateViewWatcherSetupUtil();
            return;
        }
    }
}


