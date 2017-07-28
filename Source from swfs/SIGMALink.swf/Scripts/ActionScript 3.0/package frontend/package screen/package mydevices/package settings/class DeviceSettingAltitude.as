//class DeviceSettingAltitude
package frontend.screen.mydevices.settings 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import core.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.converter.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class DeviceSettingAltitude extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingAltitude()
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
            bindings = this._DeviceSettingAltitude_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingAltitudeWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingAltitude[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingAltitude_Label1_c()];
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
            var loc2:*=null;
            dataProvider.removeAll();
            var loc1:*=new utils.converter.AltitudeConverter();
            loc1.inputFormat = utils.format.AltitudeFormat.MILLIMETER;
            loc1.outputFormat = core.MeasurementConfig.altitudeFormat;
            loc1.toInt = true;
            if (setting is core.settings.interfaces.IActualAltitude) 
            {
                addListItemNumberInput("DEVICE_SETTING.ACTUAL_ALTITUDE", core.settings.SettingsMapper.col_actual_altitude, (setting as core.settings.interfaces.IActualAltitude).actualAltitude, (setting as core.settings.interfaces.IActualAltitude).actualAltitudeMin, (setting as core.settings.interfaces.IActualAltitude).actualAltitudeMax, backend.utils.DataUtils.altitudeFormatter, loc1, backend.utils.DataUtils.unitStringAltitude);
            }
            if (setting is core.settings.interfaces.ISeaLevel) 
            {
                addListItemNumberInput("DEVICE_SETTING.SEA_LEVEL", core.settings.SettingsMapper.col_seaLevel, (setting as core.settings.interfaces.ISeaLevel).seaLevel, (setting as core.settings.interfaces.ISeaLevel).seaLevelMin, (setting as core.settings.interfaces.ISeaLevel).seaLevelMax, backend.utils.DataUtils.seaLevelFormatter, null, backend.utils.DataUtils.unitStringSeaLevel);
            }
            if (setting is core.settings.interfaces.IHomeAltitude1) 
            {
                loc2 = setting is core.settings.interfaces.IHomeAltitude2 ? "DEVICE_SETTING.HOME_ALTITUDE_1" : "DEVICE_SETTING.HOME_ALTITUDE";
                addListItemNumberInput(loc2, core.settings.SettingsMapper.col_homeAltitude1, (setting as core.settings.interfaces.IHomeAltitude1).homeAltitude1, (setting as core.settings.interfaces.IHomeAltitude1).homeAltitude1Min, (setting as core.settings.interfaces.IHomeAltitude1).homeAltitude1Max, backend.utils.DataUtils.altitudeFormatter, loc1, backend.utils.DataUtils.unitStringAltitude);
            }
            if (setting is core.settings.interfaces.IHomeAltitude2) 
            {
                addListItemNumberInput("DEVICE_SETTING.HOME_ALTITUDE_2", core.settings.SettingsMapper.col_homeAltitude2, (setting as core.settings.interfaces.IHomeAltitude2).homeAltitude2, (setting as core.settings.interfaces.IHomeAltitude2).homeAltitude2Min, (setting as core.settings.interfaces.IHomeAltitude2).homeAltitude2Max, backend.utils.DataUtils.altitudeFormatter, loc1, backend.utils.DataUtils.unitStringAltitude);
            }
            if (setting is core.settings.interfaces.IHomeAltitude3) 
            {
                addListItemNumberInput("DEVICE_SETTING.HOME_ALTITUDE_3", core.settings.SettingsMapper.col_homeAltitude3, (setting as core.settings.interfaces.IHomeAltitude3).homeAltitude3, (setting as core.settings.interfaces.IHomeAltitude3).homeAltitude3Min, (setting as core.settings.interfaces.IHomeAltitude3).homeAltitude3Max, backend.utils.DataUtils.altitudeFormatter, loc1, backend.utils.DataUtils.unitStringAltitude);
            }
            if (setting is core.settings.interfaces.IAltitudeReference) 
            {
                addListItem("DEVICE_SETTING.ALTITUDE_REFERENCE", core.settings.SettingsMapper.col_altitudeReference, (setting as core.settings.interfaces.IAltitudeReference).altitudeReference, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.AltitudeReferenceMarkDataProvider.DATA_PROVIDER);
            }
            return;
        }

        internal function _DeviceSettingAltitude_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        internal function _DeviceSettingAltitude_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_ALTITUDE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingAltitude._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


