//class _frontend_screen_mydevices_CustomEditListScreenWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.mydevices.*;
    
    public class _frontend_screen_mydevices_CustomEditListScreenWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_mydevices_CustomEditListScreenWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.StaticPropertyWatcher("footerHeight", {"propertyChange":true}, [arg4[1]], null);
            arg5[10] = new feathers.binding.PropertyWatcher("isSortable", {"propertyChange":true}, [arg4[9], arg4[11]], arg2);
            arg5[0] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[0]], null);
            arg5[4] = new feathers.binding.PropertyWatcher("listLoader", {"propertyChange":true}, [arg4[4], arg4[5], arg4[14], arg4[15]], arg2);
            arg5[5] = new feathers.binding.PropertyWatcher("listStateHandler", {"propertyChange":true}, [arg4[4], arg4[5], arg4[14], arg4[15]], null);
            arg5[6] = new feathers.binding.PropertyWatcher("editState", {"propertyChange":true}, [arg4[4], arg4[5], arg4[14], arg4[15]], null);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3]], null);
            arg5[2] = new feathers.binding.PropertyWatcher("_customList", {"propertyChange":true}, [arg4[2]], arg2);
            arg5[1].updateParent(SIGMALink);
            arg5[10].updateParent(arg1);
            arg5[0].updateParent(SIGMALink);
            arg5[4].updateParent(arg1);
            arg5[4].addChild(arg5[5]);
            arg5[5].addChild(arg5[6]);
            arg5[3].updateParent(SIGMALink);
            arg5[2].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.screen.mydevices.CustomEditListScreen.watcherSetupUtil = new _frontend_screen_mydevices_CustomEditListScreenWatcherSetupUtil();
            return;
        }
    }
}


