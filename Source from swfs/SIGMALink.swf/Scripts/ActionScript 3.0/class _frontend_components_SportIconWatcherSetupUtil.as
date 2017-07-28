//class _frontend_components_SportIconWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.*;
    
    public class _frontend_components_SportIconWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_components_SportIconWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[0] = new feathers.binding.PropertyWatcher("color", {"propertyChange":true}, [arg4[0]], arg2);
            arg5[1] = new feathers.binding.PropertyWatcher("_hLayout", {"propertyChange":true}, [arg4[1]], arg2);
            arg5[2] = new feathers.binding.PropertyWatcher("textureName", {"propertyChange":true}, [arg4[2]], arg2);
            arg5[0].updateParent(arg1);
            arg5[1].updateParent(arg1);
            arg5[2].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.components.SportIcon.watcherSetupUtil = new _frontend_components_SportIconWatcherSetupUtil();
            return;
        }
    }
}


