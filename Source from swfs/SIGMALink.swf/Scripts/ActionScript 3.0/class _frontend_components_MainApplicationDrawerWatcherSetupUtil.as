//class _frontend_components_MainApplicationDrawerWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.components.*;
    import frontend.components.button.*;
    import handler.*;
    
    public class _frontend_components_MainApplicationDrawerWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_components_MainApplicationDrawerWatcherSetupUtil()
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
            watchers[14] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[21]], null)
            watchers[15] = new feathers.binding.PropertyWatcher("currentTitle", null, [bindings[21]], null);
            watchers[1] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[1]], null)
            watchers[2] = new feathers.binding.PropertyWatcher("navi", null, [bindings[1]], null);
            watchers[11] = new feathers.binding.StaticPropertyWatcher("outerPadding", {"propertyChange":true}, [bindings[16]], null);
            watchers[5] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [bindings[6], bindings[10], bindings[14]], null);
            watchers[4] = new feathers.binding.StaticPropertyWatcher("headerHeight", {"propertyChange":true}, [bindings[4], bindings[5], bindings[8], bindings[11]], null);
            watchers[0] = new feathers.binding.StaticPropertyWatcher("appHeight", {"propertyChange":true}, [bindings[0], bindings[3], bindings[4]], null);
            watchers[7] = new feathers.binding.StaticPropertyWatcher("headerTop", {"propertyChange":true}, [bindings[11], bindings[13]], null);
            watchers[14].updateParent(handler.ViewHandler);
            watchers[14].addChild(watchers[15]);
            watchers[1].updateParent(handler.ViewHandler);
            watchers[1].addChild(watchers[2]);
            watchers[11].updateParent(frontend.components.button.IconButton);
            watchers[5].updateParent(SIGMALink);
            watchers[4].updateParent(SIGMALink);
            watchers[0].updateParent(SIGMALink);
            watchers[7].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.components.MainApplicationDrawer.watcherSetupUtil = new _frontend_components_MainApplicationDrawerWatcherSetupUtil();
            return;
        }
    }
}


