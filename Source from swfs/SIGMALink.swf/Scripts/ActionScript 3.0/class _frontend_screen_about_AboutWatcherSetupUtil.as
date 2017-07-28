//class _frontend_screen_about_AboutWatcherSetupUtil
package 
{
    import feathers.binding.*;
    import frontend.screen.about.*;
    import handler.*;
    
    public class _frontend_screen_about_AboutWatcherSetupUtil extends Object implements feathers.binding.IWatcherSetupUtil
    {
        public function _frontend_screen_about_AboutWatcherSetupUtil()
        {
            super();
            return;
        }

        public function setup(arg1:Object, arg2:Function, arg3:Function, arg4:Array, arg5:Array):void
        {
            arg5[2] = new feathers.binding.StaticPropertyWatcher("containerHeight", {"propertyChange":true}, [arg4[2]], null);
            arg5[15] = new feathers.binding.StaticPropertyWatcher("versionLabel", {"propertyChange":true}, [arg4[19]], null);
            arg5[3] = new feathers.binding.StaticPropertyWatcher("appWidth", {"propertyChange":true}, [arg4[3], arg4[7], arg4[11], arg4[20], arg4[25], arg4[41], arg4[58], arg4[63], arg4[64], arg4[68], arg4[71], arg4[75]], null);
            arg5[22] = new feathers.binding.PropertyWatcher("iconWidth", {"propertyChange":true}, [arg4[32], arg4[38], arg4[48], arg4[55]], arg2);
            arg5[26] = new feathers.binding.PropertyWatcher("maxLabelWidth", {"propertyChange":true}, [arg4[45], arg4[52], arg4[78], arg4[81], arg4[84], arg4[87], arg4[90], arg4[93], arg4[96], arg4[99], arg4[102], arg4[105], arg4[108], arg4[111], arg4[114], arg4[117], arg4[120], arg4[123], arg4[126], arg4[129], arg4[132], arg4[135], arg4[138], arg4[141], arg4[144], arg4[147], arg4[150], arg4[153], arg4[156], arg4[159]], arg2);
            arg5[17] = new feathers.binding.StaticPropertyWatcher("versionNumber", {"propertyChange":true}, [arg4[19]], null);
            arg5[2].updateParent(SIGMALink);
            arg5[15].updateParent(handler.ApplicationHandler);
            arg5[3].updateParent(SIGMALink);
            arg5[22].updateParent(arg1);
            arg5[26].updateParent(arg1);
            arg5[17].updateParent(handler.ApplicationHandler);
            return;
        }

        public static function init():void
        {
            frontend.screen.about.About.watcherSetupUtil = new _frontend_screen_about_AboutWatcherSetupUtil();
            return;
        }
    }
}


