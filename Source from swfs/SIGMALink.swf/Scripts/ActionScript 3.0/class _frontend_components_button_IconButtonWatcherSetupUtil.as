//class _frontend_components_button_IconButtonWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.button.*;
    
    public class _frontend_components_button_IconButtonWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_components_button_IconButtonWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("outerPadding", {"propertyChange":true}, [arg4[2]], arg3);
            arg5[2].updateParent(frontend.components.button.IconButton);
            return;
        }

        public static function init():void
        {
            frontend.components.button.IconButton.watcherSetupUtil = new _frontend_components_button_IconButtonWatcherSetupUtil();
            return;
        }
    }
}


