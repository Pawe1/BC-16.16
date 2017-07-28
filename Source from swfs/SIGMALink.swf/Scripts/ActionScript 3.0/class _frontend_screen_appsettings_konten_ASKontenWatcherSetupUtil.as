//class _frontend_screen_appsettings_konten_ASKontenWatcherSetupUtil
package 
{
    import backend.oauth.*;
    import feathers.binding.*;
    import frontend.components.menuList.*;
    import frontend.screen.appsettings.konten.*;
    
    public class _frontend_screen_appsettings_konten_ASKontenWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_appsettings_konten_ASKontenWatcherSetupUtil()
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
            watchers[5] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[6]], null)
            watchers[6] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[6]], null);
            watchers[23] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[30]], null)
            watchers[24] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[30]], null);
            watchers[15] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[18]], null)
            watchers[16] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[18]], null);
            watchers[4] = new feathers.binding.PropertyWatcher("_destinationObject", {"propertyChange":true}, [bindings[5], bindings[11], bindings[17], bindings[23], bindings[29]], propertyGetter);
            watchers[8] = new feathers.binding.StaticPropertyWatcher("ROW_HEIGHT", {"propertyChange":true}, [bindings[8], bindings[14], bindings[20], bindings[26], bindings[32]], null);
            watchers[1] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [bindings[1]], null);
            watchers[11] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[12]], null)
            watchers[12] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[12]], null);
            watchers[19] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[24]], null)
            watchers[20] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[24]], null);
            watchers[2] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [bindings[2], bindings[3]], null);
            watchers[5].updateParent(backend.oauth.StravaOAuth);
            watchers[5].addChild(watchers[6]);
            watchers[23].updateParent(backend.oauth.TwitterOAuth);
            watchers[23].addChild(watchers[24]);
            watchers[15].updateParent(backend.oauth.TwoPeakOAuth);
            watchers[15].addChild(watchers[16]);
            watchers[4].updateParent(target);
            watchers[8].updateParent(frontend.components.menuList.MenuList);
            watchers[1].updateParent(SIGMALink);
            watchers[11].updateParent(backend.oauth.TrainingPeaksOAuth);
            watchers[11].addChild(watchers[12]);
            watchers[19].updateParent(backend.oauth.FacebookGoViralHandler);
            watchers[19].addChild(watchers[20]);
            watchers[2].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.appsettings.konten.ASKonten.watcherSetupUtil = new _frontend_screen_appsettings_konten_ASKontenWatcherSetupUtil();
            return;
        }
    }
}


