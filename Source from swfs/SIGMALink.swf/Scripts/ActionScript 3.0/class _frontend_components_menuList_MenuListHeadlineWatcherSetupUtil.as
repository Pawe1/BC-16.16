//class _frontend_components_menuList_MenuListHeadlineWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.*;
    import frontend.components.menuList.*;
    
    public class _frontend_components_menuList_MenuListHeadlineWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_components_menuList_MenuListHeadlineWatcherSetupUtil()
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
            watchers[2] = new feathers.binding.PropertyWatcher("padding", {"propertyChange":true}, [bindings[2], bindings[3]], propertyGetter);
            watchers[10] = new feathers.binding.PropertyWatcher("displayText", {"propertyChange":true}, [bindings[10], bindings[13]], propertyGetter);
            watchers[12] = new feathers.binding.PropertyWatcher("_leftLabelText", {"propertyChange":true}, [bindings[12]], propertyGetter);
            watchers[7] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[9]], null)
            watchers[4] = new feathers.binding.PropertyWatcher("showArrow", {"propertyChange":true}, [bindings[5], bindings[6]], propertyGetter);
            watchers[1] = new feathers.binding.StaticPropertyWatcher("HEADLINE_HEIGHT", {"propertyChange":true}, [bindings[1]], null);
            watchers[2].updateParent(target);
            watchers[10].updateParent(target);
            watchers[12].updateParent(target);
            watchers[7].updateParent(frontend.AssetsManagerCustom);
            watchers[4].updateParent(target);
            watchers[1].updateParent(frontend.components.menuList.MenuList);
            return;
        }

        public static function init():void
        {
            frontend.components.menuList.MenuListHeadline.watcherSetupUtil = new _frontend_components_menuList_MenuListHeadlineWatcherSetupUtil();
            return;
        }
    }
}


