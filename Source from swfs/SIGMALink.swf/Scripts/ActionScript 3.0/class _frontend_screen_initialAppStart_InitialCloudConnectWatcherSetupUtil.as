//class _frontend_screen_initialAppStart_InitialCloudConnectWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.*;
    import frontend.screen.initialAppStart.*;
    
    public class _frontend_screen_initialAppStart_InitialCloudConnectWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_initialAppStart_InitialCloudConnectWatcherSetupUtil()
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
            watchers[4] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[4]], null)
            watchers[8] = new feathers.binding.StaticPropertyWatcher("scaleFactor", {"propertyChange":true}, [bindings[6]], null);
            watchers[10] = new feathers.binding.PropertyWatcher("hl", {"propertyChange":true}, [bindings[10]], propertyGetter);
            watchers[11] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[12]], null)
            watchers[7] = new feathers.binding.PropertyWatcher("vl", {"propertyChange":true}, [bindings[5]], propertyGetter);
            watchers[1] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [bindings[2], bindings[7], bindings[9], bindings[11]], null);
            watchers[2] = new feathers.binding.StaticPropertyWatcher("PADDING", {"propertyChange":true}, [bindings[3], bindings[6], bindings[13]], null);
            watchers[4].updateParent(frontend.AssetsManagerCustom);
            watchers[8].updateParent(SIGMALink);
            watchers[10].updateParent(target);
            watchers[11].updateParent(frontend.AssetsManagerCustom);
            watchers[7].updateParent(target);
            watchers[1].updateParent(SIGMALink);
            watchers[2].updateParent(frontend.screen.initialAppStart.InitialAppStart);
            return;
        }

        public static function init():void
        {
            frontend.screen.initialAppStart.InitialCloudConnect.watcherSetupUtil = new _frontend_screen_initialAppStart_InitialCloudConnectWatcherSetupUtil();
            return;
        }
    }
}


