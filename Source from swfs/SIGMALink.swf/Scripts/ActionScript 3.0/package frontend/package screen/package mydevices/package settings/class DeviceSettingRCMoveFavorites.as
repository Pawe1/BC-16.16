//class DeviceSettingRCMoveFavorites
package frontend.screen.mydevices.settings 
{
    import __AS3__.vec.*;
    import backend.utils.dataprovider.*;
    import core.settings.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class DeviceSettingRCMoveFavorites extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingRCMoveFavorites()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._DeviceSettingRCMoveFavorites_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingRCMoveFavoritesWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingRCMoveFavorites[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingRCMoveFavorites_Label1_c()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected override function validateProperties():void
        {
            var loc4:*=0;
            var loc6:*=null;
            var loc7:*=null;
            dataProvider.removeAll();
            var loc1:*=backend.utils.dataprovider.FavoritesPC2812DataProvider.DATA_PROVIDER_TRIP;
            var loc2:*=(setting as core.settings.SettingsPC2814).favoritesTrip1;
            var loc3:*=(setting as core.settings.SettingsPC2814).favoritesTrip2;
            var loc5:*=loc2.length;
            loc4 = 0;
            while (loc4 < loc5) 
            {
                addHeadline(utils.LanguageManager.getString("DEVICE_SETTING.FAVORITE_" + (loc4 + 1)));
                addFavListItem("1", "favoritesTrip1_" + loc4, loc2[loc4], loc1);
                addFavListItem("2", "favoritesTrip2_" + loc4, loc3[loc4], loc1);
                ++loc4;
            }
            return;
        }

        internal function _DeviceSettingRCMoveFavorites_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        internal function _DeviceSettingRCMoveFavorites_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_RC_MOVE_FAVORITES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingRCMoveFavorites._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


