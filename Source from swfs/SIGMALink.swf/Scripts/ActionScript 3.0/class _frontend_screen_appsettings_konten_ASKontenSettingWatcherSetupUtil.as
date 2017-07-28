//class _frontend_screen_appsettings_konten_ASKontenSettingWatcherSetupUtil
package 
{
    import configCache.*;
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.appsettings.konten.*;
    
    public class _frontend_screen_appsettings_konten_ASKontenSettingWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_konten_ASKontenSettingWatcherSetupUtil()
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
            watchers[13] = new feathers.binding.PropertyWatcher("_listLayoutData", {"propertyChange":true}, [bindings[15]], propertyGetter);
            watchers[9] = new feathers.binding.PropertyWatcher("_autoSharingEnabledProperty", {"propertyChange":true}, [bindings[9]], propertyGetter);
            watchers[7] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[9]], null)
            watchers[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [bindings[5], bindings[16]], null);
            watchers[1] = new feathers.binding.StaticPropertyWatcher("ROW_HEIGHT", {"propertyChange":true}, [bindings[3]], null);
            watchers[11] = new feathers.binding.PropertyWatcher("autoShareOption", {"propertyChange":true}, [bindings[13]], propertyGetter);
            watchers[12] = new feathers.binding.PropertyWatcher("checked", {"propertyChange":true}, [bindings[13]], null);
            watchers[13].updateParent(target);
            watchers[9].updateParent(target);
            watchers[7].updateParent(configCache.ConfigCache);
            watchers[2].updateParent(SIGMALink);
            watchers[1].updateParent(frontend.components.menuList.MenuList);
            watchers[11].updateParent(target);
            watchers[11].addChild(watchers[12]);
            return;
        }

        public static function init():void
        {
            frontend.screen.appsettings.konten.ASKontenSetting.watcherSetupUtil = new _frontend_screen_appsettings_konten_ASKontenSettingWatcherSetupUtil();
            return;
        }
    }
}


