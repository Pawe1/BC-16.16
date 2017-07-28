//class _frontend_screen_initialAppStart_InitialSocialNetworkConnectWatcherSetupUtil
package 
{
    import backend.oauth.*;
    import feathers.binding.*;
    import frontend.*;
    import frontend.components.menuList.*;
    import frontend.screen.initialAppStart.*;
    
    public class _frontend_screen_initialAppStart_InitialSocialNetworkConnectWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_initialAppStart_InitialSocialNetworkConnectWatcherSetupUtil()
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
            watchers[12] = new feathers.binding.StaticPropertyWatcher("scaleFactor", {"propertyChange":true}, [bindings[12]], null);
            watchers[4] = new feathers.binding.PropertyWatcher("hl", {"propertyChange":true}, [bindings[5]], propertyGetter);
            watchers[23] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[26]], null)
            watchers[24] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[26]], null);
            watchers[26] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[30]], null)
            watchers[27] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[30]], null);
            watchers[20] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[22]], null)
            watchers[21] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[22]], null);
            watchers[18] = new feathers.binding.StaticPropertyWatcher("SMALLER_ROW_HEIGHT", {"propertyChange":true}, [bindings[20], bindings[24], bindings[28], bindings[32], bindings[36]], null);
            watchers[29] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[34]], null)
            watchers[30] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[34]], null);
            watchers[5] = new feathers.binding.StaticPropertyWatcher("PADDING", {"propertyChange":true}, [bindings[6], bindings[9], bindings[12], bindings[14]], null);
            watchers[7] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[8]], null)
            watchers[14] = new feathers.binding.PropertyWatcher("scrollerHeight", {"propertyChange":true}, [bindings[15]], propertyGetter);
            watchers[15] = new feathers.binding.FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return [];
            }, null, [bindings[18]], null)
            watchers[16] = new feathers.binding.PropertyWatcher("loggedOut", {"propertyChange":true}, [bindings[18]], null);
            watchers[1] = new feathers.binding.PropertyWatcher("vl", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [bindings[4], bindings[7], bindings[14], bindings[16], bindings[17]], null);
            watchers[12].updateParent(SIGMALink);
            watchers[4].updateParent(target);
            watchers[23].updateParent(backend.oauth.TwoPeakOAuth);
            watchers[23].addChild(watchers[24]);
            watchers[26].updateParent(backend.oauth.FacebookGoViralHandler);
            watchers[26].addChild(watchers[27]);
            watchers[20].updateParent(backend.oauth.TrainingPeaksOAuth);
            watchers[20].addChild(watchers[21]);
            watchers[18].updateParent(frontend.components.menuList.MenuList);
            watchers[29].updateParent(backend.oauth.TwitterOAuth);
            watchers[29].addChild(watchers[30]);
            watchers[5].updateParent(frontend.screen.initialAppStart.InitialAppStart);
            watchers[7].updateParent(frontend.AssetsManagerCustom);
            watchers[14].updateParent(target);
            watchers[15].updateParent(backend.oauth.StravaOAuth);
            watchers[15].addChild(watchers[16]);
            watchers[1].updateParent(target);
            watchers[3].updateParent(SIGMALink);
            return;
        }

        public static function init():void
        {
            frontend.screen.initialAppStart.InitialSocialNetworkConnect.watcherSetupUtil = new _frontend_screen_initialAppStart_InitialSocialNetworkConnectWatcherSetupUtil();
            return;
        }
    }
}


