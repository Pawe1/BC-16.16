//class _frontend_screen_appsettings_allgemein_GeneralAppSettingsWatcherSetupUtil
package 
{
    import backend.utils.dataprovider.*;
    import configCache.*;
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.appsettings.allgemein.*;
    
    public class _frontend_screen_appsettings_allgemein_GeneralAppSettingsWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_allgemein_GeneralAppSettingsWatcherSetupUtil()
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
            watchers[29] = new feathers.binding.StaticPropertyWatcher("DATA_PROVIDER", {"propertyChange":true}, [bindings[27]], null);
            watchers[25] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[23]], null)
            watchers[20] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[18]], null)
            watchers[34] = new feathers.binding.StaticPropertyWatcher("DATA_PROVIDER_SOFTWARE_SETTINGS", {"propertyChange":true}, [bindings[32]], null);
            watchers[6] = new feathers.binding.StaticPropertyWatcher("SMALLER_ROW_HEIGHT", {"propertyChange":true}, [bindings[4], bindings[9], bindings[14], bindings[19], bindings[24], bindings[29], bindings[34]], null);
            watchers[24] = new feathers.binding.StaticPropertyWatcher("DATA_PROVIDER_SOFTWARE_SETTINGS", {"propertyChange":true}, [bindings[22]], null);
            watchers[3] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[3]], null)
            watchers[35] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[33]], null)
            watchers[14] = new feathers.binding.StaticPropertyWatcher("DATA_PROVIDER", {"propertyChange":true}, [bindings[12]], null);
            watchers[15] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[13]], null)
            watchers[30] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[28]], null)
            watchers[9] = new feathers.binding.StaticPropertyWatcher("DATA_PROVIDER", {"propertyChange":true}, [bindings[7]], null);
            watchers[10] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[8]], null)
            watchers[0] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [bindings[0]], null);
            watchers[19] = new feathers.binding.StaticPropertyWatcher("DATA_PROVIDER_SOFTWARE_SETTINGS", {"propertyChange":true}, [bindings[17]], null);
            watchers[29].updateParent(backend.utils.dataprovider.WeightUnitDataProvider);
            watchers[25].updateParent(configCache.ConfigCache);
            watchers[20].updateParent(configCache.ConfigCache);
            watchers[34].updateParent(backend.utils.dataprovider.TemperatureUnitDataProvider);
            watchers[6].updateParent(frontend.components.menuList.MenuList);
            watchers[24].updateParent(backend.utils.dataprovider.AltitudeUnitDataProvider);
            watchers[3].updateParent(configCache.ConfigCache);
            watchers[35].updateParent(configCache.ConfigCache);
            watchers[14].updateParent(backend.utils.dataprovider.ClockFormatDataProvider);
            watchers[15].updateParent(configCache.ConfigCache);
            watchers[30].updateParent(configCache.ConfigCache);
            watchers[9].updateParent(backend.utils.dataprovider.DateFormatDataProvider);
            watchers[10].updateParent(configCache.ConfigCache);
            watchers[0].updateParent(SIGMALink);
            watchers[19].updateParent(backend.utils.dataprovider.DistanceUnitDataProvider);
            return;
        }

        public static function init():void
        {
            frontend.screen.appsettings.allgemein.GeneralAppSettings.watcherSetupUtil = new _frontend_screen_appsettings_allgemein_GeneralAppSettingsWatcherSetupUtil();
            return;
        }
    }
}


