//class _frontend_screen_activities_activitiesImport_ActivitiesSelectorWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.activities.activitiesImport.*;
    
    public class _frontend_screen_activities_activitiesImport_ActivitiesSelectorWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_activities_activitiesImport_ActivitiesSelectorWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[18] = new feathers.binding.PropertyWatcher("_isLog", {"propertyChange":true}, [arg4[32]], arg2);
            arg5[15] = new feathers.binding.PropertyWatcher("_selectedUserId", {"propertyChange":true}, [arg4[23]], arg2);
            arg5[14] = new feathers.binding.PropertyWatcher("_userDp", {"propertyChange":true}, [arg4[22]], arg2);
            arg5[2] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[2], arg4[29]], null);
            arg5[21] = new feathers.binding.PropertyWatcher("_nextButtonVisible", {"propertyChange":true}, [arg4[33], arg4[34]], arg2);
            arg5[16] = new feathers.binding.StaticPropertyWatcher("SMALLER_ROW_HEIGHT", {"propertyChange":true}, [arg4[25]], null);
            arg5[6] = new feathers.binding.StaticPropertyWatcher("ROW_PADDING", {"propertyChange":true}, [arg4[8], arg4[15], arg4[16], arg4[17]], arg3);
            arg5[5] = new feathers.binding.StaticPropertyWatcher("ROW_HEIGHT_SMALL", {"propertyChange":true}, [arg4[5], arg4[11]], null);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3], arg4[7], arg4[14], arg4[24], arg4[31]], null);
            arg5[10] = new feathers.binding.PropertyWatcher("showRow2", {"propertyChange":true}, [arg4[12], arg4[13]], arg2);
            arg5[18].updateParent(arg1);
            arg5[15].updateParent(arg1);
            arg5[14].updateParent(arg1);
            arg5[2].updateParent(SIGMALink);
            arg5[21].updateParent(arg1);
            arg5[16].updateParent(frontend.components.menuList.MenuList);
            arg5[6].updateParent(frontend.screen.activities.activitiesImport.ActivitiesSelector);
            arg5[5].updateParent(frontend.components.menuList.MenuList);
            arg5[3].updateParent(SIGMALink);
            arg5[10].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.activities.activitiesImport.ActivitiesSelector.watcherSetupUtil = new _frontend_screen_activities_activitiesImport_ActivitiesSelectorWatcherSetupUtil();
            return;
        }
    }
}


