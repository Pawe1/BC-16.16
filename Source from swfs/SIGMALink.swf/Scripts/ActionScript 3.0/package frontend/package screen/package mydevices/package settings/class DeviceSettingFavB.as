//class DeviceSettingFavB
package frontend.screen.mydevices.settings 
{
    import __AS3__.vec.*;
    import backend.utils.dataprovider.*;
    import core.general.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.units.*;
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
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class DeviceSettingFavB extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingFavB()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.customItems = new flash.utils.Dictionary();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._DeviceSettingFavB_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingFavBWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingFavB[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingFavB_Label1_c()];
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
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            dataProvider.removeAll();
            if (setting is core.settings.SettingsROX) 
            {
                loc1 = backend.utils.dataprovider.FavoritesRoxDataProvider.DATA_PROVIDER;
            }
            else if (setting is core.settings.SettingsROX100 && setting is core.settings.interfaces.IFavoriteTrip1) 
            {
                loc1 = backend.utils.dataprovider.FavoritesRox100DataProvider.DATA_PROVIDER_TRIP;
            }
            else if (setting is core.settings.SettingsROX2010) 
            {
                if (setting.unitType != core.general.UnitType.ROX81) 
                {
                    loc1 = backend.utils.dataprovider.FavoritesRox2010DataProvider.DATA_PROVIDER;
                }
                else 
                {
                    loc1 = backend.utils.dataprovider.FavoritesRox2010DataProvider.DATA_PROVIDER_ROX8_1;
                }
            }
            if (setting is core.settings.interfaces.IFavoriteTrip2) 
            {
                loc4 = (setting as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2;
                loc3 = loc4.length;
                addHeadline(utils.LanguageManager.getString("SETTINGS_FAVORITES_TRIP_VIEW"));
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    addFavListItem((loc2 + 1).toString(), "favoritesTrip2_" + loc2, loc4[loc2], loc1);
                    ++loc2;
                }
            }
            if (setting is core.settings.interfaces.IFavoritesTrack) 
            {
                loc4 = Vector.<String>((setting as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1].toString().split(","));
                loc3 = loc4.length;
                addHeadline(utils.LanguageManager.getString("SETTINGS_FAVORITES_TRACK_VIEW"));
                if (setting is core.settings.SettingsROX100) 
                {
                    loc1 = backend.utils.dataprovider.FavoritesRox100DataProvider.DATA_PROVIDER_TRACK_ALTI;
                }
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = (Math.floor(loc2 / 2) + 1).toString();
                    loc6 = loc2 % 2 != 0 ? "B" : "A";
                    addFavListItem(loc5 + loc6, "favoritesTrack2_" + loc5 + "_" + loc6, loc4[loc2], loc1);
                    ++loc2;
                }
            }
            if (setting is core.settings.interfaces.IFavoritesAltitude) 
            {
                loc4 = Vector.<String>((setting as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1].toString().split(","));
                loc3 = loc4.length;
                addHeadline(utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTI_VIEW"));
                if (setting is core.settings.SettingsROX100) 
                {
                    loc1 = backend.utils.dataprovider.FavoritesRox100DataProvider.DATA_PROVIDER_TRACK_ALTI;
                }
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = (Math.floor(loc2 / 2) + 1).toString();
                    loc6 = loc2 % 2 != 0 ? "B" : "A";
                    addFavListItem(loc5 + loc6, "favoritesAltitude2_" + loc5 + "_" + loc6, loc4[loc2], loc1);
                    ++loc2;
                }
            }
            if (setting is core.settings.interfaces.IFavoritesLap) 
            {
                loc4 = Vector.<String>((setting as core.settings.interfaces.IFavoritesLap).favoritesLap[1].toString().split(","));
                loc3 = loc4.length;
                addHeadline(utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_VIEW"));
                if (setting is core.settings.SettingsROX100) 
                {
                    loc1 = backend.utils.dataprovider.FavoritesRox100DataProvider.DATA_PROVIDER_LAP;
                }
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = (Math.floor(loc2 / 2) + 1).toString();
                    loc6 = loc2 % 2 != 0 ? "B" : "A";
                    addFavListItem(loc5 + loc6, "favoritesLap2_" + loc5 + "_" + loc6, loc4[loc2], loc1);
                    ++loc2;
                }
            }
            if (setting is core.settings.interfaces.IFavoritesCustom && setting is core.settings.SettingsROX100 && core.units.UnitROX100.getSoftwareRevisionNumber(setting.unit.softwareRevision) >= 1403271) 
            {
                addHeadline(utils.LanguageManager.getString("SETTINGS_FAVORITES_CUSTOM_VIEW"));
                this.customFavCountItem = addFavListItem(utils.LanguageManager.getString("SETTINGS_FAVORITES_CUSTOM_PAGECOUNT_LABEL"), core.settings.SettingsMapper.col_favoritesCustomB_PageCount, (setting as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[1], backend.utils.dataprovider.FavoritesRox100DataProvider.DATA_PROVIDER_PAGE_COUNT);
                this.validateCustomPagecountItems();
            }
            return;
        }

        internal function validateCustomPagecountItems():void
        {
            var loc1:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc2:*=(setting as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[1];
            var loc3:*=6;
            var loc4:*=Vector.<String>((setting as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1].toString().split(","));
            loc1 = 0;
            while (loc1 < loc3) 
            {
                loc5 = (loc1 + 1).toString();
                loc6 = "B";
                loc7 = this.customItems[loc1];
                if (loc7) 
                {
                    loc7.defaultValue = loc4[loc1];
                    this.customItems[loc1] = loc7;
                }
                else 
                {
                    loc7 = addFavListItem(loc5, "favoritesCustom" + loc5 + "_" + loc6, loc4[loc1], backend.utils.dataprovider.FavoritesRox100DataProvider.DATA_PROVIDER_CUSTOM);
                    this.customItems[loc1] = loc7;
                }
                loc7.editable = loc1 < loc2;
                validateEditableElement(this.customFavCountItem, loc7, loc1 + 1);
                ++loc1;
            }
            return;
        }

        protected override function onFavSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            super.onFavSettingsChanged(arg1, arg2);
            var loc1:*=arg1.saveToDbUseUpdateObject.updateField;
            switch (loc1) 
            {
                case core.settings.SettingsMapper.col_favoritesCustomB_PageCount:
                {
                    this.validateCustomPagecountItems();
                    break;
                }
            }
            return;
        }

        internal function _DeviceSettingFavB_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        internal function _DeviceSettingFavB_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_FAVORITES_B");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingFavB._watcherSetupUtil = arg1;
            return;
        }

        internal var customFavCountItem:frontend.components.menuList.MenuListItem;

        internal var customItems:flash.utils.Dictionary;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


