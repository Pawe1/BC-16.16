//class _frontend_components_TextureImageWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.*;
    
    public class _frontend_components_TextureImageWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_components_TextureImageWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[1] = new feathers.binding.StaticPropertyWatcher("textureCache", {"propertyChange":true}, [arg4[1]], arg3);
            arg5[0] = new feathers.binding.PropertyWatcher("source", {"propertyChange":true}, [arg4[0]], arg2);
            arg5[1].updateParent(frontend.components.TextureImage);
            arg5[0].updateParent(arg1);
            return;
        }

        public static function init():void
        {
            frontend.components.TextureImage.watcherSetupUtil = new _frontend_components_TextureImageWatcherSetupUtil();
            return;
        }
    }
}


