//class DeviceSettingUnit
package frontend.screen.mydevices.settings 
{
    import backend.utils.dataprovider.*;
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
    
    use namespace mx_internal;
    
    public class DeviceSettingUnit extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingUnit()
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
            bindings = this._DeviceSettingUnit_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingUnitWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingUnit[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingUnit_Label1_c()];
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
            dataProvider.removeAll();
            if (setting is core.settings.interfaces.ISpeedUnit) 
            {
                addListItem("DEVICE_SETTING.SPEED_UNIT", core.settings.SettingsMapper.col_speedUnit, (setting as core.settings.interfaces.ISpeedUnit).speedUnit, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.MeasurementDataProvider.getDataProviderByUnit(setting.unitType));
            }
            if (setting is core.settings.interfaces.IDistanceUnit) 
            {
                addListItem("DEVICE_SETTING.DISTANCE_UNIT", core.settings.SettingsMapper.col_distanceUnit, (setting as core.settings.interfaces.IDistanceUnit).distanceUnit, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.DistanceUnitDataProvider.DATA_PROVIDER_BC);
            }
            if (setting is core.settings.interfaces.IAltitudeUnit) 
            {
                addListItem("DEVICE_SETTING.ALTITUDE_UNIT", core.settings.SettingsMapper.col_altitudeUnit, (setting as core.settings.interfaces.IAltitudeUnit).altitudeUnit, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.AltitudeUnitDataProvider.DATA_PROVIDER_BC);
            }
            if (setting is core.settings.interfaces.ITemperatureUnit) 
            {
                addListItem("DEVICE_SETTING.TEMPERATURE_UNIT", core.settings.SettingsMapper.col_temperatureUnit, (setting as core.settings.interfaces.ITemperatureUnit).temperatureUnit, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.TemperatureUnitDataProvider.DATA_PROVIDER_BC);
            }
            if (setting is core.settings.interfaces.IWeightUnit) 
            {
                addListItem("DEVICE_SETTING.WEIGHT_UNIT", "weightUnit", (setting as core.settings.interfaces.IWeightUnit).weightUnit, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.WeightUnitDataProvider.DATA_PROVIDER);
            }
            else if (setting is core.settings.interfaces.IBodyWeightUnit) 
            {
                addListItem("DEVICE_SETTING.WEIGHT_UNIT", core.settings.SettingsMapper.col_bodyWeightUnit, (setting as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.WeightUnitDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IBodyHeightUnit) 
            {
                addListItem("DEVICE_SETTING.HEIGHT_UNIT", core.settings.SettingsMapper.col_bodyHeightUnit, (setting as core.settings.interfaces.IBodyHeightUnit).bodyHeightUnit, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.HeightUnitDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IDateFormat) 
            {
                addListItem("DEVICE_SETTING.DATE_UNIT", core.settings.SettingsMapper.col_dateFormat, (setting as core.settings.interfaces.IDateFormat).dateFormat, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.DateFormatDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IClockMode) 
            {
                addListItem("DEVICE_SETTING.CLOCK_UNIT", core.settings.SettingsMapper.col_clockMode, (setting as core.settings.interfaces.IClockMode).clockMode, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.ClockFormatDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IFuelConsumptionUnit) 
            {
                addListItem("DEVICE_SETTING.FUEL_CONSUMPTION_UNIT", core.settings.SettingsMapper.col_fuelConsumptionUnit, (setting as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.FuelConsumptionDataProvider.DATA_PROVIDER);
            }
            return;
        }

        internal function _DeviceSettingUnit_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        internal function _DeviceSettingUnit_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_UNIT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingUnit._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


