//class DeviceSettingFuelConsumption
package frontend.screen.mydevices.settings 
{
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
    import frontend.formatter.*;
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
    
    public class DeviceSettingFuelConsumption extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingFuelConsumption()
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
            bindings = this._DeviceSettingFuelConsumption_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingFuelConsumptionWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingFuelConsumption[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingFuelConsumption_Label1_c()];
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
            var loc3:*=null;
            dataProvider.removeAll();
            var loc1:*=new utils.converter.FuelConsumptionConverter();
            loc1.inputFormat = utils.format.FuelConsumptionFormat.LITER_PER_HUNDRED_KILOMETER;
            var loc2:*=new frontend.formatter.NumberFormatter();
            loc2.fractionalDigits = 1;
            if ((setting as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit != utils.format.FuelConsumptionFormat.LITER_PER_HUNDRED_KILOMETER) 
            {
                loc1.outputFormat = utils.format.FuelConsumptionFormat.MILES_PER_GALLON;
                loc2.decimalSeparator = ".";
                loc3 = utils.LanguageManager.getString("UNIT_MPG");
            }
            else 
            {
                loc1.outputFormat = utils.format.FuelConsumptionFormat.LITER_PER_HUNDRED_KILOMETER;
                loc2.decimalSeparator = ",";
                loc3 = utils.LanguageManager.getString("UNIT_L_PER_100_KM");
            }
            addListItemNumberInput("DEVICE_SETTING_FUEL_CONSUMPTION", core.settings.SettingsMapper.col_fuelConsumption, (setting as core.settings.interfaces.IFuelConsumption).fuelConsumption, (setting as core.settings.interfaces.IFuelConsumption).fuelConsumptionMin, (setting as core.settings.interfaces.IFuelConsumption).fuelConsumptionMax, loc2, loc1, loc3);
            return;
        }

        internal function _DeviceSettingFuelConsumption_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        internal function _DeviceSettingFuelConsumption_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_FUEL_CONSUMPTION");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingFuelConsumption._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


