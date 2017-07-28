//class _frontend_screen_cloud_CloudViewWatcherSetupUtil
package 
{
    import configCache.*;
    import feathers.binding.*;
    import frontend.screen.cloud.*;
    
    public class _frontend_screen_cloud_CloudViewWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_cloud_CloudViewWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            var target:Object;
            var propertyGetter:Function;
            var staticPropertyGetter:Function;
            var bindings:Array;
            var watchers:Array;

            var loc1:*;
            target = arg1;
            propertyGetter = arg2;
            staticPropertyGetter = arg3;
            bindings = arg4;
            watchers = arg5;
            watchers[19] = new feathers.binding.PropertyWatcher("logoLayout", {"propertyChange":true}, [bindings[31]], propertyGetter);
            watchers[2] = new feathers.binding.PropertyWatcher("leftBtnLayout", {"propertyChange":true}, [bindings[2], bindings[6]], propertyGetter);
            watchers[14] = new feathers.binding.StaticPropertyWatcher("scaleFactor", {"propertyChange":true}, [bindings[21], bindings[23], bindings[25], bindings[34], bindings[35]], null);
            watchers[7] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[10]], null)
            watchers[15] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [bindings[27]], null);
            watchers[4] = new feathers.binding.PropertyWatcher("rightBtnLayout", {"propertyChange":true}, [bindings[4], bindings[8]], propertyGetter);
            watchers[17] = new feathers.binding.PropertyWatcher("shapeLayout", {"propertyChange":true}, [bindings[29]], propertyGetter);
            watchers[16] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [bindings[28], bindings[37], bindings[39]], null);
            watchers[21] = new feathers.binding.PropertyWatcher("statusGroupLayout", {"propertyChange":true}, [bindings[33]], propertyGetter);
            watchers[19].updateParent(target);
            watchers[2].updateParent(target);
            watchers[14].updateParent(SIGMALink);
            watchers[7].updateParent(configCache.ConfigCache);
            watchers[15].updateParent(SIGMALink);
            watchers[4].updateParent(target);
            watchers[17].updateParent(target);
            watchers[16].updateParent(SIGMALink);
            watchers[21].updateParent(target);
            return;
        }

        public static function init():void
        {
            frontend.screen.cloud.CloudView.watcherSetupUtil = new _frontend_screen_cloud_CloudViewWatcherSetupUtil();
            return;
        }
    }
}


