//class _frontend_components_menuList_editors_base_OnOffToggleButtonWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.menuList.editors.base.*;
    
    public class _frontend_components_menuList_editors_base_OnOffToggleButtonWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_components_menuList_editors_base_OnOffToggleButtonWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[0] = new feathers.binding.PropertyWatcher("texture", {"propertyChange":true}, [arg4[0]], arg2);
            arg5[1] = new feathers.binding.PropertyWatcher("editable", {"propertyChange":true}, [arg4[1]], arg2);
            arg5[0].updateParent(arg1);
            arg5[1].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.components.menuList.editors.base.OnOffToggleButton.watcherSetupUtil = new _frontend_components_menuList_editors_base_OnOffToggleButtonWatcherSetupUtil();
            return;
        }
    }
}


