//class _frontend_components_menuList_MenuListWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.*;
    
    public class _frontend_components_menuList_MenuListWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_components_menuList_MenuListWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[0] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[0]], null);
            arg5[0].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.components.menuList.MenuList.watcherSetupUtil = new _frontend_components_menuList_MenuListWatcherSetupUtil();
            return;
        }
    }
}


