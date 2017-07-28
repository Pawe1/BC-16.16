//package settings
//  class DeviceSettingAltitude
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


//  class DeviceSettingBycicles
package frontend.screen.mydevices.settings 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import core.general.*;
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
    
    public class DeviceSettingBycicles extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingBycicles()
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
            bindings = this._DeviceSettingBycicles_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingByciclesWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingBycicles[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingBycicles_Label1_c()];
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
            var loc2:*=false;
            var loc3:*=false;
            dataProvider.removeAll();
            var loc1:*=setting is core.settings.interfaces.IBikeType1 && setting is core.settings.interfaces.IBikeType2 || setting is core.settings.interfaces.IWheelSize1 && setting is core.settings.interfaces.IWheelSize2 || setting is core.settings.interfaces.IWheelSize1Mode && setting is core.settings.interfaces.IWheelSize2Mode;
            if (loc1) 
            {
                addHeadline(utils.LanguageManager.getString("DEVICE_SETTING.BIKE_1"));
            }
            if (setting is core.settings.interfaces.IWheelSize1Mode) 
            {
                loc2 = core.general.WheelSizeSelectionMode.TIRE.equals((setting as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode);
                addListItem("DEVICE_SETTING.WHEELSIZE_MODE_1", core.settings.SettingsMapper.col_wheelSizeMode1, (setting as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.WheelSizeSelectionModeDataProvider.DATA_PROVIDER);
                if (loc2) 
                {
                    this.wheelSize1Tire = addListItem("DEVICE_SETTING.WHEELSIZE_1", core.settings.SettingsMapper.col_tireSize1, (setting as core.settings.interfaces.ITireSize1).tireSize1, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.TireModeDataProvider.DATA_PROVIDER);
                }
                else 
                {
                    this.wheelSize1Manual = addListItemNumberInput("DEVICE_SETTING.WHEELSIZE_1", core.settings.SettingsMapper.col_wheelSize1, (setting as core.settings.interfaces.IWheelSize1).wheelSize1, (setting as core.settings.interfaces.IWheelSize1).wheelSize1Min, (setting as core.settings.interfaces.IWheelSize1).wheelSize1Max, backend.utils.DataUtils.wheelSizeFormatter, null, utils.LanguageManager.getString("UNIT_MILLIMETER"));
                }
            }
            else if (setting is core.settings.interfaces.IWheelSize1) 
            {
                addListItemNumberInput("DEVICE_SETTING.WHEELSIZE_1", core.settings.SettingsMapper.col_wheelSize1, (setting as core.settings.interfaces.IWheelSize1).wheelSize1, (setting as core.settings.interfaces.IWheelSize1).wheelSize1Min, (setting as core.settings.interfaces.IWheelSize1).wheelSize1Max, backend.utils.DataUtils.wheelSizeFormatter, null, utils.LanguageManager.getString("UNIT_MILLIMETER"));
            }
            if (setting is core.settings.interfaces.IBikeType1) 
            {
                addListItem("DEVICE_SETTING.TYPE_BIKE_1", core.settings.SettingsMapper.col_bikeType1, (setting as core.settings.interfaces.IBikeType1).bikeType1, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.BikeTypeDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IBikeWeight1) 
            {
                addListItemNumberInput("DEVICE_SETTING.BIKE_WEIGHT_1", core.settings.SettingsMapper.col_bikeWeight1, (setting as core.settings.interfaces.IBikeWeight1).bikeWeight1, (setting as core.settings.interfaces.IBikeWeight1).bikeWeight1Min, (setting as core.settings.interfaces.IBikeWeight1).bikeWeight1Max, backend.utils.DataUtils.weightFormatter, backend.utils.DataUtils.weightConverter, backend.utils.DataUtils.unitStringWeight);
            }
            if (loc1) 
            {
                addHeadline(utils.LanguageManager.getString("DEVICE_SETTING.BIKE_2"));
            }
            if (setting is core.settings.interfaces.IWheelSize2Mode) 
            {
                loc3 = core.general.WheelSizeSelectionMode.TIRE.equals((setting as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode);
                addListItem("DEVICE_SETTING.WHEELSIZE_MODE_2", core.settings.SettingsMapper.col_wheelSizeMode2, (setting as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.WheelSizeSelectionModeDataProvider.DATA_PROVIDER);
                if (loc3) 
                {
                    this.wheelSize2Tire = addListItem("DEVICE_SETTING.WHEELSIZE_2", core.settings.SettingsMapper.col_tireSize2, (setting as core.settings.interfaces.ITireSize2).tireSize2, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.TireModeDataProvider.DATA_PROVIDER);
                }
                else 
                {
                    this.wheelSize2Manual = addListItemNumberInput("DEVICE_SETTING.WHEELSIZE_2", core.settings.SettingsMapper.col_wheelSize2, (setting as core.settings.interfaces.IWheelSize2).wheelSize2, (setting as core.settings.interfaces.IWheelSize2).wheelSize2Min, (setting as core.settings.interfaces.IWheelSize2).wheelSize2Max, backend.utils.DataUtils.wheelSizeFormatter, null, utils.LanguageManager.getString("UNIT_MILLIMETER"));
                }
            }
            else if (setting is core.settings.interfaces.IWheelSize2) 
            {
                addListItemNumberInput("DEVICE_SETTING.WHEELSIZE_2", core.settings.SettingsMapper.col_wheelSize2, (setting as core.settings.interfaces.IWheelSize2).wheelSize2, (setting as core.settings.interfaces.IWheelSize2).wheelSize2Min, (setting as core.settings.interfaces.IWheelSize2).wheelSize2Max, backend.utils.DataUtils.wheelSizeFormatter, null, utils.LanguageManager.getString("UNIT_MILLIMETER"));
            }
            if (setting is core.settings.interfaces.IBikeType2) 
            {
                addListItem("DEVICE_SETTING.TYPE_BIKE_2", core.settings.SettingsMapper.col_bikeType2, (setting as core.settings.interfaces.IBikeType2).bikeType2, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.BikeTypeDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IBikeWeight2) 
            {
                addListItemNumberInput("DEVICE_SETTING.BIKE_WEIGHT_2", core.settings.SettingsMapper.col_bikeWeight2, (setting as core.settings.interfaces.IBikeWeight2).bikeWeight2, (setting as core.settings.interfaces.IBikeWeight2).bikeWeight2Min, (setting as core.settings.interfaces.IBikeWeight2).bikeWeight2Max, backend.utils.DataUtils.weightFormatter, backend.utils.DataUtils.weightConverter, backend.utils.DataUtils.unitStringWeight);
            }
            if (setting is core.settings.interfaces.IWheelSize3) 
            {
                addListItemNumberInput("DEVICE_SETTING.WHEELSIZE_3", core.settings.SettingsMapper.col_wheelSize3, (setting as core.settings.interfaces.IWheelSize3).wheelSize3, (setting as core.settings.interfaces.IWheelSize3).wheelSize3Min, (setting as core.settings.interfaces.IWheelSize3).wheelSize3Max, backend.utils.DataUtils.wheelSizeFormatter, null, utils.LanguageManager.getString("UNIT_MILLIMETER"));
            }
            if (setting is core.settings.interfaces.IBikeType3) 
            {
                if (loc1) 
                {
                    addHeadline(utils.LanguageManager.getString("DEVICE_SETTING.BIKE_3"));
                }
                addListItem("DEVICE_SETTING.TYPE_BIKE_3", core.settings.SettingsMapper.col_bikeType3, (setting as core.settings.interfaces.IBikeType3).bikeType3, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.BikeTypeDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IBikeWeight3) 
            {
                addListItemNumberInput("DEVICE_SETTING.BIKE_WEIGHT_3", core.settings.SettingsMapper.col_bikeWeight3, (setting as core.settings.interfaces.IBikeWeight3).bikeWeight3, (setting as core.settings.interfaces.IBikeWeight3).bikeWeight3Min, (setting as core.settings.interfaces.IBikeWeight3).bikeWeight3Max, backend.utils.DataUtils.weightFormatter, backend.utils.DataUtils.weightConverter, backend.utils.DataUtils.unitStringWeight);
            }
            if (setting is core.settings.interfaces.IETADistance) 
            {
                addHeadline(utils.LanguageManager.getString("SETTINGS_DETAIL_BICYCLE_ETA"));
                addListItemNumberInput("SETTINGS_DETAIL_BICYCLE_ETA_DISTANCE", core.settings.SettingsMapper.col_etaDistance, (setting as core.settings.interfaces.IETADistance).etaDistance, (setting as core.settings.interfaces.IETADistance).etaDistanceMin, (setting as core.settings.interfaces.IETADistance).etaDistanceMax, backend.utils.DataUtils.distanceFormatter, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.unitStringDistance);
                if (setting is core.settings.interfaces.IETAArivalFlag) 
                {
                    addListItem("SETTINGS_DETAIL_BICYCLE_ETA_MODE", core.settings.SettingsMapper.col_etaArivalFlag, (setting as core.settings.interfaces.IETAArivalFlag).etaArivalFlag, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.ETAModeDataProvider.DATA_PROVIDER);
                }
            }
            return;
        }

        protected override function onSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            var loc1:*=arg1.saveToDbUseUpdateObject.updateField;
            switch (loc1) 
            {
                case core.settings.SettingsMapper.col_wheelSizeMode1:
                {
                    setting[arg1.saveToDbUseUpdateObject.updateField] = core.general.WheelSizeSelectionMode.fromString(arg2.rawValue.toString());
                    this.validateProperties();
                    break;
                }
                case core.settings.SettingsMapper.col_wheelSizeMode2:
                {
                    setting[arg1.saveToDbUseUpdateObject.updateField] = core.general.WheelSizeSelectionMode.fromString(arg2.rawValue.toString());
                    this.validateProperties();
                    break;
                }
                case core.settings.SettingsMapper.col_tireSize1:
                case core.settings.SettingsMapper.col_tireSize2:
                {
                    setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
                    this.validateProperties();
                    break;
                }
                case core.settings.SettingsMapper.col_etaDistance:
                {
                    setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
                    this.validateProperties();
                    break;
                }
                case core.settings.SettingsMapper.col_etaArivalFlag:
                {
                    setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
                    this.validateProperties();
                    break;
                }
                default:
                {
                    super.onSettingsChanged(arg1, arg2);
                }
            }
            return;
        }

        internal function _DeviceSettingBycicles_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        internal function _DeviceSettingBycicles_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_BYCICLES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingBycicles._watcherSetupUtil = arg1;
            return;
        }

        internal var wheelSize1Manual:frontend.components.menuList.MenuListItem;

        internal var wheelSize1Tire:frontend.components.menuList.MenuListItem;

        internal var wheelSize2Manual:frontend.components.menuList.MenuListItem;

        internal var wheelSize2Tire:frontend.components.menuList.MenuListItem;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class DeviceSettingDevice
package frontend.screen.mydevices.settings 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import core.general.*;
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
    
    public class DeviceSettingDevice extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingDevice()
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
            bindings = this._DeviceSettingDevice_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingDeviceWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingDevice[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingDevice_Label1_c()];
            this.addEventListener("removedFromStage", this.___DeviceSettingDevice_SettingsScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function updateClock():void
        {
            this.clock.value = new Date();
            dataProvider.updateItemAt(dataProvider.getItemIndex(this.clock));
            this.clockUpdateTimeout = flash.utils.setTimeout(this.updateClock, this.clockUpdateDelay);
            return;
        }

        protected function removedFromStageHandler(arg1:starling.events.Event):void
        {
            flash.utils.clearTimeout(this.clockUpdateTimeout);
            return;
        }

        protected override function validateProperties():void
        {
            var loc1:*=null;
            var loc2:*=null;
            dataProvider.removeAll();
            if (setting is core.settings.interfaces.ILanguage) 
            {
                addListItem("DEVICE_SETTING.LANGUAGE", core.settings.SettingsMapper.col_language, (setting as core.settings.interfaces.ILanguage).language, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.LanguageDataProvider.getDataProviderByUnit(setting.unitType));
            }
            if (setting is core.settings.interfaces.IDate) 
            {
                loc1 = new frontend.components.menuList.MenuListItem();
                loc1.text = "DEVICE_SETTING.DATE";
                loc1.title = "DEVICE_SETTING.DATE";
                loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
                loc1.editable = false;
                loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc1.useConfigCache = false;
                loc1.useLocalesForText = true;
                loc1.useLocalesForTitle = true;
                loc1.defaultValue = new Date();
                loc1.formatter = backend.utils.DataUtils.dateFormatter;
                dataProvider.addItem(loc1);
            }
            if (setting is core.settings.interfaces.IClock) 
            {
                this.clock = new frontend.components.menuList.MenuListItem();
                this.clock.text = "DEVICE_SETTING.CLOCK";
                this.clock.title = "DEVICE_SETTING.CLOCK";
                this.clock.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
                this.clock.editable = false;
                this.clock.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                this.clock.useConfigCache = false;
                this.clock.useLocalesForText = true;
                this.clock.useLocalesForTitle = true;
                this.clock.defaultValue = new Date();
                this.clock.formatter = backend.utils.DataUtils.dateTimeFormatter;
                dataProvider.addItem(this.clock);
                this.clockUpdateTimeout = flash.utils.setTimeout(this.updateClock, this.clockUpdateDelay);
            }
            if (setting is core.settings.interfaces.ITimeZone) 
            {
                addListItem("DEVICE_SETTING.TIME_ZONE", core.settings.SettingsMapper.col_timeZone, (setting as core.settings.interfaces.ITimeZone).timeZone, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.TimeZoneDataProvider.getDataProvider(setting));
            }
            if (setting is core.settings.interfaces.ISummerTime) 
            {
                addListItem("DEVICE_SETTING.SUMMER_TIME", core.settings.SettingsMapper.col_summerTime, (setting as core.settings.interfaces.ISummerTime).summerTime, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IVolume) 
            {
                addListItem("DEVICE_SETTING.VOLUME", core.settings.SettingsMapper.col_volume, (setting as core.settings.interfaces.IVolume).volume, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.VolumeDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IContrast) 
            {
                addListItem("DEVICE_SETTING.CONTRAST", core.settings.SettingsMapper.col_contrast, (setting as core.settings.interfaces.IContrast).contrast, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.ContrastDataProvider.generateDataProvider(setting as core.settings.interfaces.IContrast));
            }
            if (setting is core.settings.interfaces.IButtonInfo) 
            {
                addListItem("DEVICE_SETTING.BUTTON_INFO", core.settings.SettingsMapper.col_buttonInfo, (setting as core.settings.interfaces.IButtonInfo).buttonInfo, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IButtonTone) 
            {
                addListItem("DEVICE_SETTING.BUTTON_TONE", core.settings.SettingsMapper.col_buttonTone, (setting as core.settings.interfaces.IButtonTone).buttonTone, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IAlarmMode && setting is core.settings.interfaces.IAlarm) 
            {
                this.alarmItem = addListItem("DEVICE_SETTING.ALARM_MODE", core.settings.SettingsMapper.col_alarmMode, (setting as core.settings.interfaces.IAlarmMode).alarmMode, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.AlarmModeDataProvider.DATA_PROVIDER);
                this.alarmTimeItem = addListItem("DEVICE_SETTING.ALARM_TIME", core.settings.SettingsMapper.col_alarm, (setting as core.settings.interfaces.IAlarm).alarm, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME, null, backend.utils.DataUtils.dateTimeFormatter, true, utils.LanguageManager.getString("UNIT_CLOCK"));
                this.validateAlarmTimeItem();
            }
            if (setting is core.settings.interfaces.IZoneAlarm) 
            {
                addListItem("DEVICE_SETTING.ZONE_ALARM", core.settings.SettingsMapper.col_zoneAlarm, (setting as core.settings.interfaces.IZoneAlarm).zoneAlarm, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IPhaseAlarm) 
            {
                addListItem("DEVICE_SETTING.PHASE_ALARM", core.settings.SettingsMapper.col_phaseAlarm, (setting as core.settings.interfaces.IPhaseAlarm).phaseAlarm, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IKeyLock) 
            {
                addListItem("DEVICE_SETTING.KEY_LOCK", core.settings.SettingsMapper.col_keyLock, (setting as core.settings.interfaces.IKeyLock).keyLock, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.ICountdown) 
            {
                this.countdownItem = addListItem("DEVICE_SETTING.COUNTDOWN", core.settings.SettingsMapper.col_countdownOn, (setting as core.settings.interfaces.ICountdown).countdownOn, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
                this.countdownTimeItem = addListItem("DEVICE_SETTING.COUNTDOWN_TIME", core.settings.SettingsMapper.col_countdown, (setting as core.settings.interfaces.ICountdown).countdown, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME, null, backend.utils.DataUtils.countdownFormatter, false, utils.LanguageManager.getString("UNIT_HOUR"));
                this.validateCountdownTimeItem();
            }
            if (setting is core.settings.interfaces.IMyName) 
            {
                loc2 = addListItem("DEVICE_SETTING.MY_NAME", core.settings.SettingsMapper.col_myName, (setting as core.settings.interfaces.IMyName).myName, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD);
                loc2.maxChars = (setting as core.settings.interfaces.IMyName).myNameMaxLength;
            }
            if (setting is core.settings.interfaces.IAutoPause) 
            {
                addListItem("DEVICE_SETTING.AUTO_PAUSE", core.settings.SettingsMapper.col_autoPause, (setting as core.settings.interfaces.IAutoPause).autoPause, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IAutoScan) 
            {
                addListItem("DEVICE_SETTING.AUTO_SCAN", core.settings.SettingsMapper.col_scanFlagOn, (setting as core.settings.interfaces.IAutoScan).scanFlagOn, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.ISamplingRate) 
            {
                addListItem("DEVICE_SETTING.SAMPLING_RATE", core.settings.SettingsMapper.col_samplingRate, (setting as core.settings.interfaces.ISamplingRate).samplingRate, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.SamplingRateDataProvider.getDataProviderByUnit(setting.unitType));
            }
            if (setting is core.settings.interfaces.ISystemTone) 
            {
                addListItem("DEVICE_SETTING.SYSTEM_TONE", core.settings.SettingsMapper.col_systemTone, (setting as core.settings.interfaces.ISystemTone).systemTone, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IBacklightTime) 
            {
                addListItem("DEVICE_SETTING.BACKLIGHT_TIME", core.settings.SettingsMapper.col_backlightTime, (setting as core.settings.interfaces.IBacklightTime).backlightTime, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.BacklightTimeDataProvider.getDataProviderByUnit(setting.unitType));
            }
            if (setting is core.settings.interfaces.IBacklightLevel) 
            {
                addListItem("DEVICE_SETTING.BACKLIGHT_LEVEL", core.settings.SettingsMapper.col_backlightLevel, (setting as core.settings.interfaces.IBacklightLevel).backlightLevel, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.BacklightLevelDataProvider.generateDataProvider(setting as core.settings.interfaces.IBacklightLevel));
            }
            if (setting is core.settings.interfaces.IGPSStatus) 
            {
                addListItem("DEVICE_SETTING.GPS_STATUS", core.settings.SettingsMapper.col_gpsStatus, (setting as core.settings.interfaces.IGPSStatus).gpsStatus, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IGPSFormat) 
            {
                addListItem("DEVICE_SETTING.GPS_FORMAT", core.settings.SettingsMapper.col_gpsFormat, (setting as core.settings.interfaces.IGPSFormat).gpsFormat, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.GPSFormatDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IOffTrackAlarm) 
            {
                addListItem("DEVICE_SETTING.OFF_TRACK_ALARM", core.settings.SettingsMapper.col_offTrackAlarm, (setting as core.settings.interfaces.IOffTrackAlarm).offTrackAlarm, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.TrackDistanceDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.ITrackDirection) 
            {
                addListItem("SETTING_TRACK_DIRECTION", core.settings.SettingsMapper.col_trackDirection, (setting as core.settings.interfaces.ITrackDirection).trackDirection, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.TrackDirectionDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IStravaSegmentsEnabled) 
            {
                addListItem("SETTING_STRAVA_SEGMENTS_ENABLED", core.settings.SettingsMapper.col_stravaSegmentsEnabled, (setting as core.settings.interfaces.IStravaSegmentsEnabled).stravaSegmentsEnabled, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IWayPointAlarm) 
            {
                addListItem("DEVICE_SETTING.WAYPOINT_ALARM", core.settings.SettingsMapper.col_waypointAlarm, (setting as core.settings.interfaces.IWayPointAlarm).waypointAlarm, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.TrackDistanceDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IAutoZoomTrack) 
            {
                addListItem("DEVICE_SETTING.AUTO_ZOOM_TRACK", core.settings.SettingsMapper.col_autoZoomTrack, (setting as core.settings.interfaces.IAutoZoomTrack).autoZoomTrack, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IAutoOffTime) 
            {
                addListItem("DEVICE_SETTING.AUTO_OFF_TIME", core.settings.SettingsMapper.col_autoOffTime, (setting as core.settings.interfaces.IAutoOffTime).autoOffTime, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.AutoOffTimeDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IHeartrateSensor) 
            {
                addListItem("DEVICE_SETTING.HEARTRATE_SENSOR", core.settings.SettingsMapper.col_heartrateSensorActive, (setting as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.ICadenceSensor) 
            {
                addListItem("DEVICE_SETTING.CADENCE_SENSOR", core.settings.SettingsMapper.col_cadenceSensorActive, (setting as core.settings.interfaces.ICadenceSensor).cadenceSensorActive, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IPowerSaveMode) 
            {
                addListItem("DEVICE_SETTING.POWER_SAVE_MODE", core.settings.SettingsMapper.col_powerSaveModeActive, (setting as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.IBacklight) 
            {
                this.backlight = addListItem("DEVICE_SETTING.BACKLIGHT", core.settings.SettingsMapper.col_backlightActive, (setting as core.settings.interfaces.IBacklight).backlightActive, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
                if (setting is core.settings.interfaces.IBacklightTimeOn) 
                {
                    this.backlightTimeOn = addListItem("DEVICE_SETTING.BACKLIGHT_TIME_ON", core.settings.SettingsMapper.col_backlightTimeOn, (setting as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME, null, backend.utils.DataUtils.dateTimeFormatter, true, utils.LanguageManager.getString("UNIT_CLOCK"));
                }
                if (setting is core.settings.interfaces.IBacklightTimeOff) 
                {
                    this.backlightTimeOff = addListItem("DEVICE_SETTING.BACKLIGHT_TIME_OFF", core.settings.SettingsMapper.col_backlightTimeOff, (setting as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME, null, backend.utils.DataUtils.dateTimeFormatter, true, utils.LanguageManager.getString("UNIT_CLOCK"));
                }
                this.validateBacklight();
            }
            return;
        }

        internal function validateAlarmTimeItem():void
        {
            this.alarmTimeItem.editable = !((setting as core.settings.interfaces.IAlarmMode).alarmMode == core.general.AlarmMode.OFF);
            validateEditableElement(this.alarmItem, this.alarmTimeItem);
            return;
        }

        internal function validateCountdownTimeItem():void
        {
            this.countdownTimeItem.editable = (setting as core.settings.interfaces.ICountdown).countdownOn;
            validateEditableElement(this.countdownItem, this.countdownTimeItem);
            return;
        }

        internal function validateBacklight():void
        {
            var loc1:*;
            this.backlightTimeOff.editable = loc1 = (setting as core.settings.interfaces.IBacklight).backlightActive;
            this.backlightTimeOn.editable = loc1;
            if (this.backlightTimeOn) 
            {
                this.backlightTimeOn.validateSizesAndPositions();
            }
            if (this.backlightTimeOff) 
            {
                this.backlightTimeOff.validateSizesAndPositions();
            }
            return;
        }

        protected override function onSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            super.onSettingsChanged(arg1, arg2);
            var loc1:*=arg1.saveToDbUseUpdateObject.updateField;
            switch (loc1) 
            {
                case core.settings.SettingsMapper.col_alarmMode:
                {
                    this.validateAlarmTimeItem();
                    break;
                }
                case core.settings.SettingsMapper.col_countdownOn:
                {
                    this.validateCountdownTimeItem();
                    break;
                }
                case core.settings.SettingsMapper.col_backlightActive:
                {
                    this.validateBacklight();
                    break;
                }
                case core.settings.SettingsMapper.col_backlightTimeOn:
                {
                    this.validateBacklight();
                    break;
                }
            }
            return;
        }

        internal function _DeviceSettingDevice_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        public function ___DeviceSettingDevice_SettingsScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.removedFromStageHandler(arg1);
            return;
        }

        internal function _DeviceSettingDevice_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_DEVICE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingDevice._watcherSetupUtil = arg1;
            return;
        }

        internal var alarmItem:frontend.components.menuList.MenuListItem;

        internal var alarmTimeItem:frontend.components.menuList.MenuListItem;

        internal var backlight:frontend.components.menuList.MenuListItem;

        internal var backlightTimeOff:frontend.components.menuList.MenuListItem;

        internal var backlightTimeOn:frontend.components.menuList.MenuListItem;

        internal var clock:frontend.components.menuList.MenuListItem;

        internal var clockUpdateDelay:uint=1000;

        internal var clockUpdateTimeout:uint=0;

        internal var countdownItem:frontend.components.menuList.MenuListItem;

        internal var countdownTimeItem:frontend.components.menuList.MenuListItem;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class DeviceSettingFavA
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
    
    public class DeviceSettingFavA extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingFavA()
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
            bindings = this._DeviceSettingFavA_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingFavAWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingFavA[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingFavA_Label1_c()];
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
            if (setting is core.settings.interfaces.IFavoriteTrip1) 
            {
                loc4 = (setting as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1;
                loc3 = loc4.length;
                addHeadline(utils.LanguageManager.getString("SETTINGS_FAVORITES_TRIP_VIEW"));
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    addFavListItem((loc2 + 1).toString(), "favoritesTrip1_" + loc2, loc4[loc2], loc1);
                    ++loc2;
                }
            }
            if (setting is core.settings.interfaces.IFavoritesTrack) 
            {
                loc4 = Vector.<String>((setting as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0].toString().split(","));
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
                    addFavListItem(loc5 + loc6, "favoritesTrack1_" + loc5 + "_" + loc6, loc4[loc2], loc1);
                    ++loc2;
                }
            }
            if (setting is core.settings.interfaces.IFavoritesAltitude) 
            {
                loc4 = Vector.<String>((setting as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0].toString().split(","));
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
                    addFavListItem(loc5 + loc6, "favoritesAltitude1_" + loc5 + "_" + loc6, loc4[loc2], loc1);
                    ++loc2;
                }
            }
            if (setting is core.settings.interfaces.IFavoritesLap) 
            {
                loc4 = Vector.<String>((setting as core.settings.interfaces.IFavoritesLap).favoritesLap[0].toString().split(","));
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
                    addFavListItem(loc5 + loc6, "favoritesLap1_" + loc5 + "_" + loc6, loc4[loc2], loc1);
                    ++loc2;
                }
            }
            if (setting is core.settings.interfaces.IFavoritesCustom && setting is core.settings.SettingsROX100 && core.units.UnitROX100.getSoftwareRevisionNumber(setting.unit.softwareRevision) >= 1403271) 
            {
                addHeadline(utils.LanguageManager.getString("SETTINGS_FAVORITES_CUSTOM_VIEW"));
                this.customFavCountItem = addFavListItem(utils.LanguageManager.getString("SETTINGS_FAVORITES_CUSTOM_PAGECOUNT_LABEL"), core.settings.SettingsMapper.col_favoritesCustomA_PageCount, (setting as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[0], backend.utils.dataprovider.FavoritesRox100DataProvider.DATA_PROVIDER_PAGE_COUNT);
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
            var loc2:*=(setting as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[0];
            var loc3:*=6;
            var loc4:*=Vector.<String>((setting as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0].toString().split(","));
            loc1 = 0;
            while (loc1 < loc3) 
            {
                loc5 = (loc1 + 1).toString();
                loc6 = "A";
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
                case core.settings.SettingsMapper.col_favoritesCustomA_PageCount:
                {
                    this.validateCustomPagecountItems();
                    break;
                }
            }
            return;
        }

        internal function _DeviceSettingFavA_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        internal function _DeviceSettingFavA_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_FAVORITES_A");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingFavA._watcherSetupUtil = arg1;
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


//  class DeviceSettingFavB
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


//  class DeviceSettingFuelConsumption
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


//  class DeviceSettingRCMoveFavorites
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


//  class DeviceSettingRCMoveTrainingFree
package frontend.screen.mydevices.settings 
{
    import backend.utils.*;
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
    
    public class DeviceSettingRCMoveTrainingFree extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingRCMoveTrainingFree()
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
            bindings = this._DeviceSettingRCMoveTrainingFree_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingRCMoveTrainingFreeWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingRCMoveTrainingFree[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingRCMoveTrainingFree_Label1_c()];
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
            addListItem("SETTINGS_FAVORITES_HEARTRATE_TARGET_ZONE", core.settings.SettingsMapper.col_freeTrainingTargetZone, (setting as core.settings.interfaces.ITrainingFree).freeTrainingTargetZone, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.TrainingZoneDataProvider.DATA_PROVIDER_RCMOVE);
            this.validateFitZoneItem();
            this.validateFatZoneItem();
            this.validateOwn1ZoneItem();
            this.validateOwn2ZoneItem();
            this.validateOwn3ZoneItem();
            return;
        }

        protected override function onSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            if (arg1 == this.own1 || arg1 == this.own2 || arg1 == this.own3) 
            {
                setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue.start;
                setting[arg1.saveToDbUseUpdateObject.updateField2] = arg2.rawValue.end;
            }
            else 
            {
                super.onSettingsChanged(arg1, arg2);
            }
            return;
        }

        internal function validateFitZoneItem():void
        {
            var loc1:*=new Object();
            loc1.start = utils.Calculations.calculateFitStartValue(setting);
            loc1.end = utils.Calculations.calculateFitEndValue(setting);
            var loc2:*=-1;
            if (this.fitZone) 
            {
                loc2 = dataProvider.getItemIndex(this.fitZone);
                dataProvider.removeItemAt(loc2);
            }
            this.fitZone = addListItemZoneInput("DEVICE_SETTING.FIT_ZONE", "", "", loc1, 40, 240, 1, backend.utils.DataUtils.heartrateFormatter, null, false, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validateFatZoneItem():void
        {
            var loc1:*=new Object();
            loc1.start = utils.Calculations.calculateFatStartValue(setting);
            loc1.end = utils.Calculations.calculateFatEndValue(setting);
            var loc2:*=-1;
            if (this.fatZone) 
            {
                loc2 = dataProvider.getItemIndex(this.fatZone);
                dataProvider.removeItemAt(loc2);
            }
            this.fatZone = addListItemZoneInput("DEVICE_SETTING.FAT_ZONE", "", "", loc1, 40, 240, 1, backend.utils.DataUtils.heartrateFormatter, null, false, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validateOwn1ZoneItem():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimit;
            loc1.end = (setting as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimit;
            var loc2:*=-1;
            if (this.own1) 
            {
                loc2 = dataProvider.getItemIndex(this.own1);
                dataProvider.removeItemAt(loc2);
            }
            this.own1 = addListItemZoneInput("DEVICE_SETTING.OWN_ZONE_1", "freeOwnZone1LowerLimit", "freeOwnZone1UpperLimit", loc1, (setting as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimitMin, (setting as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimitMax, 1, backend.utils.DataUtils.heartrateFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validateOwn2ZoneItem():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimit;
            loc1.end = (setting as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimit;
            var loc2:*=-1;
            if (this.own2) 
            {
                loc2 = dataProvider.getItemIndex(this.own2);
                dataProvider.removeItemAt(loc2);
            }
            this.own2 = addListItemZoneInput("DEVICE_SETTING.OWN_ZONE_2", "freeOwnZone2LowerLimit", "freeOwnZone2UpperLimit", loc1, (setting as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimitMin, (setting as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimitMax, 1, backend.utils.DataUtils.heartrateFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validateOwn3ZoneItem():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimit;
            loc1.end = (setting as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimit;
            var loc2:*=-1;
            if (this.own3) 
            {
                loc2 = dataProvider.getItemIndex(this.own3);
                dataProvider.removeItemAt(loc2);
            }
            this.own3 = addListItemZoneInput("DEVICE_SETTING.OWN_ZONE_3", "freeOwnZone3LowerLimit", "freeOwnZone3UpperLimit", loc1, (setting as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimitMin, (setting as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimitMax, 1, backend.utils.DataUtils.heartrateFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function _DeviceSettingRCMoveTrainingFree_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        internal function _DeviceSettingRCMoveTrainingFree_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_RC_MOVE_TRAINING_FREE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingRCMoveTrainingFree._watcherSetupUtil = arg1;
            return;
        }

        internal var fatZone:frontend.components.menuList.MenuListItem;

        internal var fitZone:frontend.components.menuList.MenuListItem;

        internal var own1:frontend.components.menuList.MenuListItem;

        internal var own2:frontend.components.menuList.MenuListItem;

        internal var own3:frontend.components.menuList.MenuListItem;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class DeviceSettingRCMoveTrainingInterval
package frontend.screen.mydevices.settings 
{
    import backend.utils.*;
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
    
    public class DeviceSettingRCMoveTrainingInterval extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingRCMoveTrainingInterval()
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
            bindings = this._DeviceSettingRCMoveTrainingInterval_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingRCMoveTrainingIntervalWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingRCMoveTrainingInterval[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingRCMoveTrainingInterval_Label1_c()];
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
            addListItem("SETTINGS_DETAIL_TRAINING_INTERVAL_WARM_UP", core.settings.SettingsMapper.col_intervalWarmUpTime, (setting as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTime, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME, null, backend.utils.DataUtils.timeFormatter_MM_SS, false, utils.LanguageManager.getString("UNIT_MINUTES"));
            this.addWarmUpHR();
            addListItem("SETTINGS_DETAIL_TRAINING_INTERVAL_INTERVAL", core.settings.SettingsMapper.col_intervalTime, (setting as core.settings.interfaces.ITrainingInterval).intervalTime, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME, null, backend.utils.DataUtils.timeFormatter_MM_SS, false, utils.LanguageManager.getString("UNIT_MINUTES"));
            this.addIntervalHR();
            addListItem("SETTINGS_DETAIL_TRAINING_INTERVAL_RECOVERY", core.settings.SettingsMapper.col_intervalRecoveryTime, (setting as core.settings.interfaces.ITrainingInterval).intervalRecoveryTime, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME, null, backend.utils.DataUtils.timeFormatter_MM_SS, false, utils.LanguageManager.getString("UNIT_MINUTES"));
            addListItem("SETTINGS_DETAIL_TRAINING_INTERVAL_COOL_DOWN", core.settings.SettingsMapper.col_intervalCoolDownTime, (setting as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTime, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME, null, backend.utils.DataUtils.timeFormatter_MM_SS, false, utils.LanguageManager.getString("UNIT_MINUTES"));
            this.addCooldownHR();
            return;
        }

        internal function addWarmUpHR():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneLowerLimit;
            loc1.end = (setting as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneUpperLimit;
            addListItemZoneInput("SETTINGS_DETAIL_TRAINING_INTERVAL_WARM_UP_HR", core.settings.SettingsMapper.col_intervalWarmUpTargetZoneLowerLimit, core.settings.SettingsMapper.col_intervalWarmUpTargetZoneUpperLimit, loc1, 30, 240, 1, backend.utils.DataUtils.heartrateFormatter, null, true, -1, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function addIntervalHR():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.ITrainingInterval).intervalTargetZoneLowerLimit;
            loc1.end = (setting as core.settings.interfaces.ITrainingInterval).intervalTargetZoneUpperLimit;
            addListItemZoneInput("SETTINGS_DETAIL_TRAINING_INTERVAL_INTERVAL_HR", core.settings.SettingsMapper.col_intervalTargetZoneLowerLimit, core.settings.SettingsMapper.col_intervalTargetZoneUpperLimit, loc1, 30, 240, 1, backend.utils.DataUtils.heartrateFormatter, null, true, -1, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function addCooldownHR():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneLowerLimit;
            loc1.end = (setting as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneUpperLimit;
            addListItemZoneInput("SETTINGS_DETAIL_TRAINING_INTERVAL_COOL_DOWN_HR", core.settings.SettingsMapper.col_intervalCoolDownTargetZoneLowerLimit, core.settings.SettingsMapper.col_intervalCoolDownTargetZoneUpperLimit, loc1, 30, 240, 1, backend.utils.DataUtils.heartrateFormatter, null, true, -1, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function _DeviceSettingRCMoveTrainingInterval_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        internal function _DeviceSettingRCMoveTrainingInterval_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_RC_MOVE_TRAINING_INTERVAL");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingRCMoveTrainingInterval._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class DeviceSettingUnit
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


//  class DeviceSettingUser
package frontend.screen.mydevices.settings 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.units.interfaces.*;
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
    
    public class DeviceSettingUser extends frontend.screen.mydevices.settings.SettingsScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingUser()
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
            bindings = this._DeviceSettingUser_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingUserWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingUser[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._DeviceSettingUser_Label1_c()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function validateThreeZones1():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IThreeZones).startZone1;
            loc1.end = (setting as core.settings.interfaces.IThreeZones).startZone2;
            var loc2:*=-1;
            if (this.threeZone1) 
            {
                loc2 = dataProvider.getItemIndex(this.threeZone1);
                dataProvider.removeItemAt(loc2);
            }
            this.threeZone1 = addListItemZoneInput("DEVICE_SETTING.HR_ZONE_1", core.settings.SettingsMapper.col_startZone1, core.settings.SettingsMapper.col_startZone2, loc1, 40, ((setting as core.settings.interfaces.IThreeZones).startZone3 - 1), 5, backend.utils.DataUtils.heartrateFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validateThreeZones2():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IThreeZones).startZone2;
            loc1.end = (setting as core.settings.interfaces.IThreeZones).startZone3;
            var loc2:*=-1;
            if (this.threeZone2) 
            {
                loc2 = dataProvider.getItemIndex(this.threeZone2);
                dataProvider.removeItemAt(loc2);
            }
            this.threeZone2 = addListItemZoneInput("DEVICE_SETTING.HR_ZONE_2", core.settings.SettingsMapper.col_startZone2, core.settings.SettingsMapper.col_startZone3, loc1, (setting as core.settings.interfaces.IThreeZones).startZone1 + 1, ((setting as core.settings.interfaces.IThreeZones).endZone3 - 1), 5, backend.utils.DataUtils.heartrateFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validateThreeZones3():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IThreeZones).startZone3;
            loc1.end = (setting as core.settings.interfaces.IThreeZones).endZone3;
            var loc2:*=-1;
            if (this.threeZone3) 
            {
                loc2 = dataProvider.getItemIndex(this.threeZone3);
                dataProvider.removeItemAt(loc2);
            }
            this.threeZone3 = addListItemZoneInput("DEVICE_SETTING.HR_ZONE_3", core.settings.SettingsMapper.col_startZone3, core.settings.SettingsMapper.col_endZone3, loc1, (setting as core.settings.interfaces.IThreeZones).startZone2 + 1, 240, 5, backend.utils.DataUtils.heartrateFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validateIntensityZones1():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
            loc1.end = (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
            var loc2:*=-1;
            if (this.intensityZone1) 
            {
                loc2 = dataProvider.getItemIndex(this.intensityZone1);
                dataProvider.removeItemAt(loc2);
            }
            this.intensityZone1 = addListItemZoneInput("DEVICE_SETTING.INTENSITY_ZONE_1", "intensityZone1PercentageStart", "intensityZone2PercentageStart", loc1, 20, ((setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart - 1), 1, backend.utils.DataUtils.intensityZonePercentageFormatter, null, true, loc2, backend.utils.DataUtils.unitStringPercent);
            return;
        }

        internal function validateIntensityZones2():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
            loc1.end = (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
            var loc2:*=-1;
            if (this.intensityZone2) 
            {
                loc2 = dataProvider.getItemIndex(this.intensityZone2);
                dataProvider.removeItemAt(loc2);
            }
            this.intensityZone2 = addListItemZoneInput("DEVICE_SETTING.INTENSITY_ZONE_2", "intensityZone2PercentageStart", "intensityZone3PercentageStart", loc1, (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart + 1, ((setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart - 1), 1, backend.utils.DataUtils.intensityZonePercentageFormatter, null, true, loc2, backend.utils.DataUtils.unitStringPercent);
            return;
        }

        internal function validateIntensityZones3():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
            loc1.end = (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
            var loc2:*=-1;
            if (this.intensityZone3) 
            {
                loc2 = dataProvider.getItemIndex(this.intensityZone3);
                dataProvider.removeItemAt(loc2);
            }
            this.intensityZone3 = addListItemZoneInput("DEVICE_SETTING.INTENSITY_ZONE_3", "intensityZone3PercentageStart", "intensityZone4PercentageStart", loc1, (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart + 1, ((setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd - 1), 1, backend.utils.DataUtils.intensityZonePercentageFormatter, null, true, loc2, backend.utils.DataUtils.unitStringPercent);
            return;
        }

        internal function validateIntensityZones4():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
            loc1.end = (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd;
            var loc2:*=-1;
            if (this.intensityZone4) 
            {
                loc2 = dataProvider.getItemIndex(this.intensityZone4);
                dataProvider.removeItemAt(loc2);
            }
            this.intensityZone4 = addListItemZoneInput("DEVICE_SETTING.INTENSITY_ZONE_4", "intensityZone4PercentageStart", "intensityZone4PercentageEnd", loc1, (setting as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart + 1, 100, 1, backend.utils.DataUtils.intensityZonePercentageFormatter, null, true, loc2, backend.utils.DataUtils.unitStringPercent);
            return;
        }

        internal function validatePowerTargetZone():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimit;
            loc1.end = (setting as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimit;
            var loc2:*=-1;
            if (this.powerTargetZone) 
            {
                loc2 = dataProvider.getItemIndex(this.powerTargetZone);
                dataProvider.removeItemAt(loc2);
            }
            this.powerTargetZone = addListItemZoneInput("DEVICE_SETTING.POWER_TARGET_ZONE_INDIVIDUAL", core.settings.SettingsMapper.col_powerTargetZoneLowerLimit, core.settings.SettingsMapper.col_powerTargetZoneUpperLimit, loc1, (setting as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimitMin, (setting as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimitMax, 1, backend.utils.DataUtils.powerFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validatePowerIntensityZones1():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start;
            loc1.end = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start;
            var loc2:*=-1;
            if (this.powerIntensityZone1) 
            {
                loc2 = dataProvider.getItemIndex(this.powerIntensityZone1);
                dataProvider.removeItemAt(loc2);
            }
            this.powerIntensityZone1 = addListItemZoneInput("DEVICE_SETTING.POWER_INTENSITY_ZONE_1", core.settings.SettingsMapper.col_powerIntensityZone1Start, core.settings.SettingsMapper.col_powerIntensityZone2Start, loc1, 0, ((setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start - 1), 1, backend.utils.DataUtils.powerFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validatePowerIntensityZones2():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start;
            loc1.end = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start;
            var loc2:*=-1;
            if (this.powerIntensityZone2) 
            {
                loc2 = dataProvider.getItemIndex(this.powerIntensityZone2);
                dataProvider.removeItemAt(loc2);
            }
            this.powerIntensityZone2 = addListItemZoneInput("DEVICE_SETTING.POWER_INTENSITY_ZONE_2", core.settings.SettingsMapper.col_powerIntensityZone2Start, core.settings.SettingsMapper.col_powerIntensityZone3Start, loc1, (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start + 1, ((setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start - 1), 1, backend.utils.DataUtils.powerFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validatePowerIntensityZones3():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start;
            loc1.end = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start;
            var loc2:*=-1;
            if (this.powerIntensityZone3) 
            {
                loc2 = dataProvider.getItemIndex(this.powerIntensityZone3);
                dataProvider.removeItemAt(loc2);
            }
            this.powerIntensityZone3 = addListItemZoneInput("DEVICE_SETTING.POWER_INTENSITY_ZONE_3", core.settings.SettingsMapper.col_powerIntensityZone3Start, core.settings.SettingsMapper.col_powerIntensityZone4Start, loc1, (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start + 1, ((setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start - 1), 1, backend.utils.DataUtils.powerFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validatePowerIntensityZones4():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start;
            loc1.end = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start;
            var loc2:*=-1;
            if (this.powerIntensityZone4) 
            {
                loc2 = dataProvider.getItemIndex(this.powerIntensityZone4);
                dataProvider.removeItemAt(loc2);
            }
            this.powerIntensityZone4 = addListItemZoneInput("DEVICE_SETTING.POWER_INTENSITY_ZONE_4", core.settings.SettingsMapper.col_powerIntensityZone4Start, core.settings.SettingsMapper.col_powerIntensityZone5Start, loc1, (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start + 1, ((setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start - 1), 1, backend.utils.DataUtils.powerFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validatePowerIntensityZones5():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start;
            loc1.end = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start;
            var loc2:*=-1;
            if (this.powerIntensityZone5) 
            {
                loc2 = dataProvider.getItemIndex(this.powerIntensityZone5);
                dataProvider.removeItemAt(loc2);
            }
            this.powerIntensityZone5 = addListItemZoneInput("DEVICE_SETTING.POWER_INTENSITY_ZONE_5", core.settings.SettingsMapper.col_powerIntensityZone5Start, core.settings.SettingsMapper.col_powerIntensityZone6Start, loc1, (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start + 1, ((setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start - 1), 1, backend.utils.DataUtils.powerFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validatePowerIntensityZones6():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start;
            loc1.end = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start;
            var loc2:*=-1;
            if (this.powerIntensityZone6) 
            {
                loc2 = dataProvider.getItemIndex(this.powerIntensityZone6);
                dataProvider.removeItemAt(loc2);
            }
            this.powerIntensityZone6 = addListItemZoneInput("DEVICE_SETTING.POWER_INTENSITY_ZONE_6", core.settings.SettingsMapper.col_powerIntensityZone6Start, core.settings.SettingsMapper.col_powerIntensityZone7Start, loc1, (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start + 1, ((setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End - 1), 1, backend.utils.DataUtils.powerFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validatePowerIntensityZones7():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start;
            loc1.end = (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End;
            var loc2:*=-1;
            if (this.powerIntensityZone7) 
            {
                loc2 = dataProvider.getItemIndex(this.powerIntensityZone7);
                dataProvider.removeItemAt(loc2);
            }
            this.powerIntensityZone7 = addListItemZoneInput("DEVICE_SETTING.POWER_INTENSITY_ZONE_7", core.settings.SettingsMapper.col_powerIntensityZone7Start, core.settings.SettingsMapper.col_powerIntensityZone7End, loc1, (setting as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start + 1, 2000, 1, backend.utils.DataUtils.powerFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function _DeviceSettingUser_Label1_c():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            return loc1;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingUser._watcherSetupUtil = arg1;
            return;
        }

        internal function onCalcThreeZones():void
        {
            utils.Calculations.calculateThreeZonesValues(setting);
            this.validateThreeZones1();
            this.validateThreeZones2();
            this.validateThreeZones3();
            return;
        }

        protected override function validateProperties():void
        {
            var loc1:*=null;
            dataProvider.removeAll();
            if (setting is core.settings.interfaces.IGender) 
            {
                addListItem("DEVICE_SETTING.GENDER", core.settings.SettingsMapper.col_gender, (setting as core.settings.interfaces.IGender).gender, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.GenderDataProvider.DATA_PROVIDER);
            }
            if (setting is core.settings.interfaces.IBirthDate) 
            {
                addListItemDateInput("DEVICE_SETTING.BIRTHDATE", core.settings.SettingsMapper.col_birthDate, (setting as core.settings.interfaces.IBirthDate).birthDate, (setting as core.settings.interfaces.IBirthDate).birthDateMin, (setting as core.settings.interfaces.IBirthDate).birthDateMax, backend.utils.DataUtils.dateFormatter, true);
            }
            if (setting is core.settings.interfaces.IYearOfBirth) 
            {
                addListItemNumberInput("DEVICE_SETTING.YEAR_OF_BIRTH", core.settings.SettingsMapper.col_yearOfBirth, (setting as core.settings.interfaces.IYearOfBirth).yearOfBirth, (setting as core.settings.interfaces.IYearOfBirth).yearOfBirthMin, (setting as core.settings.interfaces.IYearOfBirth).yearOfBirthMax);
            }
            if (setting is core.settings.interfaces.IAge) 
            {
                addListItemNumberInput("DEVICE_SETTING.AGE", core.settings.SettingsMapper.col_age, (setting as core.settings.interfaces.IAge).age, (setting as core.settings.interfaces.IAge).ageMin, (setting as core.settings.interfaces.IAge).ageMax);
            }
            if (setting is core.settings.interfaces.IBodyWeight) 
            {
                addListItemNumberInput("DEVICE_SETTING.BODY_WEIGHT", core.settings.SettingsMapper.col_bodyWeight, (setting as core.settings.interfaces.IBodyWeight).bodyWeight, (setting as core.settings.interfaces.IBodyWeight).bodyWeightMin, (setting as core.settings.interfaces.IBodyWeight).bodyWeightMax, backend.utils.DataUtils.weightFormatter, backend.utils.DataUtils.weightConverter, backend.utils.DataUtils.unitStringWeight);
            }
            if (setting is core.settings.interfaces.IBodyHeight) 
            {
                addListItemNumberInput("DEVICE_SETTING.BODY_HEIGHT", core.settings.SettingsMapper.col_bodyHeight, (setting as core.settings.interfaces.IBodyHeight).bodyHeight, (setting as core.settings.interfaces.IBodyHeight).bodyHeightMin, (setting as core.settings.interfaces.IBodyHeight).bodyHeightMax, backend.utils.DataUtils.bodySizeFormatter, backend.utils.DataUtils.bodySizeConverter, backend.utils.DataUtils.unitStringBodySize);
            }
            if (setting is core.settings.interfaces.IShoulderWidth) 
            {
                addListItemNumberInput("DEVICE_SETTING.SHOULDER_WIDTH", core.settings.SettingsMapper.col_shoulderWidth, (setting as core.settings.interfaces.IShoulderWidth).shoulderWidth, (setting as core.settings.interfaces.IShoulderWidth).shoulderWidthMin, (setting as core.settings.interfaces.IShoulderWidth).shoulderWidthMax, backend.utils.DataUtils.bodySizeFormatter, backend.utils.DataUtils.bodySizeConverter, backend.utils.DataUtils.unitStringBodySize);
            }
            if (setting is core.settings.interfaces.IHRmax) 
            {
                addListItemNumberInput("DEVICE_SETTING.HR_MAX", core.settings.SettingsMapper.col_hrMax, (setting as core.settings.interfaces.IHRmax).hrMax, (setting as core.settings.interfaces.IHRmax).hrMaxMin, (setting as core.settings.interfaces.IHRmax).hrMaxMax, backend.utils.DataUtils.heartrateFormatter, null, backend.utils.DataUtils.unitStringHeartrate);
            }
            if (setting is core.settings.interfaces.ITrainingZone) 
            {
                addHeadline(utils.LanguageManager.getString("DEVICE_SETTING.HR_TRAINING_ZONE"));
                this.validateFitZoneItem();
                this.validateFatZoneItem();
                this.validateOwnZoneItem();
                addListItem("DEVICE_SETTING.ACTIVE_TRAINING_ZONE", core.settings.SettingsMapper.col_trainingZone, (setting as core.settings.interfaces.ITrainingZone).trainingZone, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER, backend.utils.dataprovider.TrainingZoneDataProvider.DATA_PROVIDER_HEARTRATE_LIMITS);
            }
            if (setting is core.settings.interfaces.ICalibration) 
            {
                addListItem("DEVICE_SETTING.CALIBRATION", core.settings.SettingsMapper.col_calibration, (setting as core.settings.interfaces.ICalibration).calibration, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            }
            if (setting is core.settings.interfaces.ICorrectionFactor) 
            {
                addListItemNumberInput("DEVICE_SETTING.CORRECTION_FACTOR", core.settings.SettingsMapper.col_correctionFactor, (setting as core.settings.interfaces.ICorrectionFactor).correctionFactor, (setting as core.settings.interfaces.ICorrectionFactor).correctionFactorMin, (setting as core.settings.interfaces.ICorrectionFactor).correctionFactorMax, backend.utils.DataUtils.heartrateFormatter);
            }
            if (setting is core.settings.interfaces.IThreeZones) 
            {
                addHeadline(utils.LanguageManager.getString("DEVICE_SETTING.HR_ZONES"));
                this.validateThreeZones1();
                this.validateThreeZones2();
                this.validateThreeZones3();
                loc1 = new frontend.components.menuList.MenuListItem();
                loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_BUTTON;
                loc1.functionButtonLabel = "DEVICE_SETTING.CALCULATE_THREE_ZONES";
                loc1.functionButtonCallback = this.onCalcThreeZones;
                loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc1.useConfigCache = false;
                loc1.useLocalesForText = true;
                dataProvider.addItem(loc1);
            }
            if (setting is core.units.interfaces.IIntensityZonesPercentage) 
            {
                addHeadline(utils.LanguageManager.getString("DEVICE_SETTING.INTENSITY_ZONES"));
                this.validateIntensityZones1();
                this.validateIntensityZones2();
                this.validateIntensityZones3();
                this.validateIntensityZones4();
            }
            if (setting is core.settings.interfaces.IPowerTargetZone) 
            {
                addHeadline(utils.LanguageManager.getString("DEVICE_SETTING.POWER_TARGET_ZONE"));
                addListItem("DEVICE_SETTING.POWER_TARGET_ZONE_STATUS", core.settings.SettingsMapper.col_powerTargetZoneEnabled, (setting as core.settings.interfaces.IPowerTargetZone).powerTargetZoneEnabled, frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
                this.validatePowerTargetZone();
            }
            if (setting is core.settings.interfaces.IPowerIntensityZone) 
            {
                addHeadline(utils.LanguageManager.getString("DEVICE_SETTING.POWER_ZONES"));
                this.validatePowerIntensityZones1();
                this.validatePowerIntensityZones2();
                this.validatePowerIntensityZones3();
                this.validatePowerIntensityZones4();
                this.validatePowerIntensityZones5();
                this.validatePowerIntensityZones6();
                this.validatePowerIntensityZones7();
            }
            return;
        }

        protected override function onSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            if (arg1 != this.ownZone) 
            {
                if (arg1 == this.threeZone1 || arg1 == this.threeZone2 || arg1 == this.threeZone3) 
                {
                    setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue.start;
                    setting[arg1.saveToDbUseUpdateObject.updateField2] = arg2.rawValue.end;
                    this.validateThreeZones1();
                    this.validateThreeZones2();
                    this.validateThreeZones3();
                }
                else if (arg1 == this.intensityZone1 || arg1 == this.intensityZone2 || arg1 == this.intensityZone3 || arg1 == this.intensityZone4) 
                {
                    setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue.start;
                    setting[arg1.saveToDbUseUpdateObject.updateField2] = arg2.rawValue.end;
                    this.validateIntensityZones1();
                    this.validateIntensityZones2();
                    this.validateIntensityZones3();
                    this.validateIntensityZones4();
                }
                else if (arg1 == this.powerIntensityZone1 || arg1 == this.powerIntensityZone2 || arg1 == this.powerIntensityZone3 || arg1 == this.powerIntensityZone4 || arg1 == this.powerIntensityZone5 || arg1 == this.powerIntensityZone6 || arg1 == this.powerIntensityZone7) 
                {
                    setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue.start;
                    setting[arg1.saveToDbUseUpdateObject.updateField2] = arg2.rawValue.end;
                    this.validatePowerIntensityZones1();
                    this.validatePowerIntensityZones2();
                    this.validatePowerIntensityZones3();
                    this.validatePowerIntensityZones4();
                    this.validatePowerIntensityZones5();
                    this.validatePowerIntensityZones6();
                    this.validatePowerIntensityZones7();
                }
                else if (arg1.saveToDbUseUpdateObject) 
                {
                    setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
                    var loc1:*=arg1.saveToDbUseUpdateObject.updateField;
                    switch (loc1) 
                    {
                        case core.settings.SettingsMapper.col_hrMax:
                        {
                            if (setting is core.settings.interfaces.ITrainingZone) 
                            {
                                this.validateFitZoneItem();
                                this.validateFatZoneItem();
                                this.validateOwnZoneItem();
                            }
                            break;
                        }
                    }
                }
            }
            else 
            {
                setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue.start;
                setting[arg1.saveToDbUseUpdateObject.updateField2] = arg2.rawValue.end;
            }
            return;
        }

        internal function validateFitZoneItem():void
        {
            var loc1:*=new Object();
            loc1.start = utils.Calculations.calculateFitStartValue(setting);
            loc1.end = utils.Calculations.calculateFitEndValue(setting);
            var loc2:*=-1;
            if (this.fitZone) 
            {
                loc2 = dataProvider.getItemIndex(this.fitZone);
                dataProvider.removeItemAt(loc2);
            }
            this.fitZone = addListItemZoneInput("DEVICE_SETTING.FIT_ZONE", "", "", loc1, (setting as core.settings.interfaces.IHeartrateLimits).lowerLimitMin, (setting as core.settings.interfaces.IHeartrateLimits).upperLimitMax, 1, backend.utils.DataUtils.heartrateFormatter, null, false, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validateFatZoneItem():void
        {
            var loc1:*=new Object();
            loc1.start = utils.Calculations.calculateFatStartValue(setting);
            loc1.end = utils.Calculations.calculateFatEndValue(setting);
            var loc2:*=-1;
            if (this.fatZone) 
            {
                loc2 = dataProvider.getItemIndex(this.fatZone);
                dataProvider.removeItemAt(loc2);
            }
            this.fatZone = addListItemZoneInput("DEVICE_SETTING.FAT_ZONE", "", "", loc1, (setting as core.settings.interfaces.IHeartrateLimits).lowerLimitMin, (setting as core.settings.interfaces.IHeartrateLimits).upperLimitMax, 1, backend.utils.DataUtils.heartrateFormatter, null, false, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function validateOwnZoneItem():void
        {
            var loc1:*=new Object();
            loc1.start = (setting as core.settings.interfaces.IHeartrateLimits).lowerLimit;
            loc1.end = (setting as core.settings.interfaces.IHeartrateLimits).upperLimit;
            var loc2:*=-1;
            if (this.ownZone) 
            {
                loc2 = dataProvider.getItemIndex(this.ownZone);
                dataProvider.removeItemAt(loc2);
            }
            this.ownZone = addListItemZoneInput("DEVICE_SETTING.OWN_ZONE", core.settings.SettingsMapper.col_lowerLimit, core.settings.SettingsMapper.col_upperLimit, loc1, (setting as core.settings.interfaces.IHeartrateLimits).lowerLimitMin, (setting as core.settings.interfaces.IHeartrateLimits).upperLimitMax, 1, backend.utils.DataUtils.heartrateFormatter, null, true, loc2, backend.utils.DataUtils.unitStringHeartrate);
            return;
        }

        internal function _DeviceSettingUser_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICE_SETTING_USER");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        internal var fatZone:frontend.components.menuList.MenuListItem;

        internal var fitZone:frontend.components.menuList.MenuListItem;

        internal var intensityZone1:frontend.components.menuList.MenuListItem;

        internal var intensityZone2:frontend.components.menuList.MenuListItem;

        internal var intensityZone3:frontend.components.menuList.MenuListItem;

        internal var ownZone:frontend.components.menuList.MenuListItem;

        internal var powerIntensityZone1:frontend.components.menuList.MenuListItem;

        internal var powerIntensityZone2:frontend.components.menuList.MenuListItem;

        internal var powerIntensityZone3:frontend.components.menuList.MenuListItem;

        internal var powerIntensityZone4:frontend.components.menuList.MenuListItem;

        internal var powerIntensityZone5:frontend.components.menuList.MenuListItem;

        internal var powerIntensityZone6:frontend.components.menuList.MenuListItem;

        internal var powerIntensityZone7:frontend.components.menuList.MenuListItem;

        internal var powerTargetZone:frontend.components.menuList.MenuListItem;

        internal var threeZone1:frontend.components.menuList.MenuListItem;

        internal var threeZone2:frontend.components.menuList.MenuListItem;

        internal var intensityZone4:frontend.components.menuList.MenuListItem;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var threeZone3:frontend.components.menuList.MenuListItem;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class DeviceSettingView
package frontend.screen.mydevices.settings 
{
    import backend.utils.dbUtils.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.events.*;
    import feathers.layout.*;
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
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.popup.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class DeviceSettingView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSettingView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._altitudeInterfaces = [];
            this._bicyclesInterfaces = [];
            this._deviceInterfaces = [];
            this._favASettingInterfaces = [];
            this._favBSettingInterfaces = [];
            this._fuelConsumption = [];
            this._userInterfaces = [];
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._DeviceSettingView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_settings_DeviceSettingViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSettingView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._DeviceSettingView_CustomVScrollContainer1_i(), this._DeviceSettingView_Footer1_i()];
            this.addEventListener("addedToStage", this.___DeviceSettingView_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___DeviceSettingView_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().removeBackFunction(this.backButtonFunction);
            return;
        }

        internal function backButtonFunction():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS, {"unit":this.unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.deletePopUp = new frontend.components.popup.DeletePopUp();
            this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_SETTINGS_TITLE");
            this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_SETTINGS_TEXT");
            this.deletePopUp.cancelCallback = this.onPopUpClose;
            this.deletePopUp.deleteCallback = this.onPopUpDelete;
            frontend.components.popup.PopUpBase.showModalPopUp(this.deletePopUp, true, true);
            return;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onInit():void
        {
            this.validateCategoryInterfaces();
            return;
        }

        internal function validateCategoryInterfaces():void
        {
            this._deviceInterfaces = [core.settings.interfaces.ILanguage, core.settings.interfaces.IClock, core.settings.interfaces.IVolume, core.settings.interfaces.IDate, core.settings.interfaces.ITimeZone, core.settings.interfaces.ISummerTime, core.settings.interfaces.IContrast, core.settings.interfaces.IButtonInfo, core.settings.interfaces.IButtonTone, [core.settings.interfaces.IAlarmMode, core.settings.interfaces.IAlarm], core.settings.interfaces.IZoneAlarm, core.settings.interfaces.IPhaseAlarm, core.settings.interfaces.IKeyLock, core.settings.interfaces.ICountdown, core.settings.interfaces.IMyName, core.settings.interfaces.IAutoPause, core.settings.interfaces.IAutoScan, core.settings.interfaces.ISamplingRate, core.settings.interfaces.ISystemTone, core.settings.interfaces.IBacklightTime, core.settings.interfaces.IBacklightLevel, core.settings.interfaces.IGPSStatus, core.settings.interfaces.IGPSFormat, core.settings.interfaces.IOffTrackAlarm, core.settings.interfaces.IWayPointAlarm, core.settings.interfaces.IAutoZoomTrack, core.settings.interfaces.IAutoOffTime];
            this._bicyclesInterfaces = [core.settings.interfaces.IWheelSize1, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IWheelSize3];
            this._altitudeInterfaces = [core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IHomeAltitude3, core.settings.interfaces.IActualAltitude, core.settings.interfaces.ISeaLevel];
            this._userInterfaces = [core.settings.interfaces.IGender, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IBirthDate, core.settings.interfaces.IYearOfBirth, core.settings.interfaces.IHRmax, core.settings.interfaces.IThreeZones, core.settings.interfaces.IAge, core.settings.interfaces.IHeartrateLimits];
            this._favASettingInterfaces = [core.settings.interfaces.IFavoritesAltitude, core.settings.interfaces.IFavoritesLap, core.settings.interfaces.IFavoritesTrack, core.settings.interfaces.IFavoriteTrip1];
            this._favBSettingInterfaces = [core.settings.interfaces.IFavoritesAltitude, core.settings.interfaces.IFavoritesLap, core.settings.interfaces.IFavoritesTrack, core.settings.interfaces.IFavoriteTrip2];
            this._fuelConsumption = [core.settings.interfaces.IFuelConsumption];
            return;
        }

        internal function onPopUpDelete():void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.settings.SettingsMapper.prepareDelete(this.settings.GUID), this.onDeleteSettingsComplete, this.onDeleteSettingsError, Workers.worker_DatabaseWorker);
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onNameChanged(arg1:Object):void
        {
            var loc1:*;
            this.settings.name = loc1 = arg1 as String;
            title = loc1;
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        protected override function validateProperties():void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            this.menuList.removeChildren();
            title = this.settings.name;
            var loc1:*=new frontend.components.menuList.MenuListHeadline();
            loc1.useLocalesForText = false;
            loc1.text = this.settings.unit.externalName;
            this.menuList.addChild(loc1);
            this._saveNameObj = new frontend.components.menuList.MenuListDbObject();
            this._saveNameObj.keyField = "GUID";
            this._saveNameObj.keyValue = this.settings.GUID;
            this._saveNameObj.updateField = core.settings.SettingsMapper.col_name;
            this._saveNameObj.table = core.settings.SettingsMapper.table_name;
            this._saveNameObj.updateModificationDate = true;
            this._saveNameObj.completeCallback = this.onNameChanged;
            var loc2:*=new frontend.components.menuList.MenuListItem();
            loc2.defaultValue = this.settings.name;
            loc2.editable = true;
            loc2.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc2.saveToDbUseUpdate = true;
            loc2.saveToDbUseUpdateObject = this._saveNameObj;
            loc2.text = "DEVICE_SETTING.NAME";
            loc2.title = "DEVICE_SETTING.NAME";
            loc2.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
            loc2.useConfigCache = false;
            loc2.useLocalesForText = true;
            loc2.useLocalesForTitle = true;
            this.menuList.addChild(loc2);
            if (this.hasAnyInterface(this._deviceInterfaces)) 
            {
                loc4 = new frontend.components.menuList.MenuListItem();
                loc4.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc4.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_DEVICE;
                loc4.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc4.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc4.text = "DEVICE_SETTING_DEVICE";
                this.menuList.addChild(loc4);
            }
            var loc3:*=new frontend.components.menuList.MenuListItem();
            loc3.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
            loc3.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_UNIT;
            loc3.destinationObject = {"setting":this.settings, "unit":this.unit};
            loc3.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc3.text = "DEVICE_SETTING_UNIT";
            this.menuList.addChild(loc3);
            if (this.hasAnyInterface(this._bicyclesInterfaces)) 
            {
                loc5 = new frontend.components.menuList.MenuListItem();
                loc5.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc5.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_BYCICLES;
                loc5.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc5.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc5.text = "DEVICE_SETTING_BYCICLES";
                this.menuList.addChild(loc5);
            }
            if (this.hasAnyInterface(this._altitudeInterfaces)) 
            {
                loc6 = new frontend.components.menuList.MenuListItem();
                loc6.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc6.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_ALTITUDE;
                loc6.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc6.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc6.text = "DEVICE_SETTING_ALTITUDE";
                this.menuList.addChild(loc6);
            }
            if (this.hasAnyInterface(this._userInterfaces)) 
            {
                loc7 = new frontend.components.menuList.MenuListItem();
                loc7.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc7.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_USER;
                loc7.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc7.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc7.text = "DEVICE_SETTING_USER";
                this.menuList.addChild(loc7);
            }
            if (this.settings is core.settings.SettingsPC2814) 
            {
                loc8 = new frontend.components.menuList.MenuListItem();
                loc8.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc8.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_RC_MOVE_FAVORITES;
                loc8.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc8.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc8.text = "DEVICE_SETTING_RC_MOVE_FAVORITES";
                this.menuList.addChild(loc8);
                loc9 = new frontend.components.menuList.MenuListItem();
                loc9.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc9.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_RC_MOVE_TRAINING_FREE;
                loc9.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc9.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc9.text = "DEVICE_SETTING_RC_MOVE_TRAINING_FREE";
                this.menuList.addChild(loc9);
                loc10 = new frontend.components.menuList.MenuListItem();
                loc10.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc10.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_RC_MOVE_TRAINING_INTERVAL;
                loc10.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc10.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc10.text = "DEVICE_SETTING_RC_MOVE_TRAINING_INTERVAL";
                this.menuList.addChild(loc10);
                return;
            }
            if (this.hasAnyInterface(this._favASettingInterfaces)) 
            {
                loc11 = new frontend.components.menuList.MenuListItem();
                loc11.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc11.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_FAVORITES_A;
                loc11.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc11.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc11.text = "DEVICE_SETTING_FAVORITES_A";
                this.menuList.addChild(loc11);
            }
            if (this.hasAnyInterface(this._favBSettingInterfaces)) 
            {
                loc12 = new frontend.components.menuList.MenuListItem();
                loc12.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc12.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_FAVORITES_B;
                loc12.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc12.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc12.text = "DEVICE_SETTING_FAVORITES_B";
                this.menuList.addChild(loc12);
            }
            if (this.hasAnyInterface(this._fuelConsumption)) 
            {
                loc13 = new frontend.components.menuList.MenuListItem();
                loc13.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                loc13.destination = handler.ViewHandler.VIEW_DEVICE_SETTING_FUEL_CONSUMPTION;
                loc13.destinationObject = {"setting":this.settings, "unit":this.unit};
                loc13.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
                loc13.text = "DEVICE_SETTING_FUEL_CONSUMPTION";
                this.menuList.addChild(loc13);
            }
            return;
        }

        internal function hasAnyInterface(arg1:Array):Boolean
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc1:*=false;
            var loc3:*=arg1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (arg1[loc2] is Array) 
                {
                    loc4 = arg1[loc2] as Array;
                    loc6 = (arg1[loc2] as Array).length;
                    loc5 = 0;
                    while (loc5 < loc6) 
                    {
                        loc1 = this.settings is loc4[loc5];
                        if (!loc1) 
                        {
                            break;
                        }
                        ++loc5;
                    }
                }
                else 
                {
                    loc1 = this.settings is arg1[loc2];
                }
                if (loc1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        internal function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS_TRANSFER, {"unit":this.unit, "settings":this.settings, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected function onAddetToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addBackFunction(this.backButtonFunction);
            return;
        }

        internal function onDeleteSettingsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function onDeleteSettingsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteSettingsError");
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function _DeviceSettingView_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.layout = this._DeviceSettingView_AnchorLayout1_c();
            loc1.mxmlContent = [this._DeviceSettingView_MenuList1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _DeviceSettingView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _DeviceSettingView_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "menuList";
            this.menuList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "menuList", this.menuList);
            return loc1;
        }

        internal function _DeviceSettingView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._DeviceSettingView_IconButton1_i(), this._DeviceSettingView_IconButton2_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _DeviceSettingView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSettingView_IconButton1";
            this._DeviceSettingView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSettingView_IconButton1", this._DeviceSettingView_IconButton1);
            return loc1;
        }

        internal function _DeviceSettingView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSettingView_IconButton2";
            this._DeviceSettingView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSettingView_IconButton2", this._DeviceSettingView_IconButton2);
            return loc1;
        }

        public function ___DeviceSettingView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddetToStage(arg1);
            return;
        }

        public function ___DeviceSettingView_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _DeviceSettingView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0);
            }, null, "menuList.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "menuList.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uploadicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSettingView_IconButton1.image")
            result[5] = new feathers.binding.Binding(this, function ():Function
            {
                return toDevice_handler;
            }, null, "_DeviceSettingView_IconButton1.touchHandler")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.trashicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSettingView_IconButton2.image")
            result[7] = new feathers.binding.Binding(this, function ():Function
            {
                return touchHandler;
            }, null, "_DeviceSettingView_IconButton2.touchHandler")
            return result;
        }

        public function set scroller(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._402164678scroller;
            if (loc1 !== arg1) 
            {
                this._402164678scroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scroller", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get menuList():frontend.components.menuList.MenuList
        {
            return this._604015971menuList;
        }

        public function set menuList(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._604015971menuList;
            if (loc1 !== arg1) 
            {
                this._604015971menuList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "menuList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scroller():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._402164678scroller;
        }

        public function get settings():core.settings.Settings
        {
            return this._1434631203settings;
        }

        public function set settings(arg1:core.settings.Settings):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1434631203settings;
            if (loc1 !== arg1) 
            {
                this._1434631203settings = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "settings", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _saveNameObj():frontend.components.menuList.MenuListDbObject
        {
            return this._1790552176_saveNameObj;
        }

        internal function set _saveNameObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1790552176_saveNameObj;
            if (loc1 !== arg1) 
            {
                this._1790552176_saveNameObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveNameObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSettingView._watcherSetupUtil = arg1;
            return;
        }

        internal static const padding:Number=20 * SIGMALink.scaleFactor;

        internal var _bicyclesInterfaces:Array;

        internal var _deviceInterfaces:Array;

        internal var _favASettingInterfaces:Array;

        internal var _favBSettingInterfaces:Array;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal var _fuelConsumption:Array;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _1790552176_saveNameObj:frontend.components.menuList.MenuListDbObject;

        internal var _userInterfaces:Array;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        public var unit:core.units.Unit;

        public var _DeviceSettingView_IconButton1:frontend.components.button.IconButton;

        mx_internal var _bindingsByDestination:Object;

        public var _DeviceSettingView_IconButton2:frontend.components.button.IconButton;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _604015971menuList:frontend.components.menuList.MenuList;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _1434631203settings:core.settings.Settings;

        internal var _altitudeInterfaces:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class MenuItemListRenderer
package frontend.screen.mydevices.settings 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    
    public class MenuItemListRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function MenuItemListRenderer()
        {
            super();
            height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        protected override function commitData():void
        {
            var loc1:*=null;
            super.commitData();
            if (!data) 
            {
                return;
            }
            if (data is feathers.controls.Label) 
            {
                (data as feathers.controls.Label).layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
                this._group.removeChildren();
                this._group.addChild(data as feathers.controls.Label);
                this._group.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }
            else 
            {
                loc1 = data as frontend.components.menuList.MenuListItem;
                this._group.removeChildren();
                this._group.addChild(loc1);
                this._group.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
                height = loc1.visible ? frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT : 0;
            }
            return;
        }

        internal var _bottomLine:starling.display.Quad;

        internal var _group:feathers.controls.LayoutGroup;
    }
}


//  class SettingsScreen
package frontend.screen.mydevices.settings 
{
    import __AS3__.vec.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.units.*;
    import feathers.data.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.mydevices.list.*;
    import handler.*;
    import service.cloud.*;
    import starling.events.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class SettingsScreen extends frontend.screen.mydevices.list.MenuItemListScreen
    {
        public function SettingsScreen()
        {
            super();
            allowCaching = false;
            savePropertiesForBackNavigation = true;
            return;
        }

        protected override function addListItem(arg1:String, arg2:String, arg3:Object, arg4:String, arg5:feathers.data.ListCollection=null, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItem(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            loc1.saveCompleteCallback = this.onSettingsChanged;
            return loc1;
        }

        protected override function addFavListItem(arg1:String, arg2:String, arg3:Object, arg4:feathers.data.ListCollection):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addFavListItem(arg1, arg2, arg3, arg4);
            loc1.saveCompleteCallback = this.onFavSettingsChanged;
            return loc1;
        }

        protected override function addListItemNumberInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:utils.converter.IConverter=null, arg8:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemNumberInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            loc1.saveCompleteCallback = this.onSettingsChanged;
            return loc1;
        }

        protected override function addListItemDateInput(arg1:String, arg2:String, arg3:Object, arg4:Number=NaN, arg5:Number=NaN, arg6:utils.interfaces.ICustomFormatterBase=null, arg7:Boolean=false):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemDateInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            loc1.saveCompleteCallback = this.onSettingsChanged;
            return loc1;
        }

        protected override function addListItemZoneInput(arg1:String, arg2:String, arg3:String, arg4:Object, arg5:Number, arg6:Number, arg7:Number, arg8:utils.interfaces.ICustomFormatterBase, arg9:utils.converter.IConverter, arg10:Boolean, arg11:int, arg12:String=""):frontend.components.menuList.MenuListItem
        {
            var loc1:*=super.addListItemZoneInput(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
            if (arg10) 
            {
                loc1.saveCompleteCallback = this.onSettingsChanged;
            }
            return loc1;
        }

        protected override function getDBObject(arg1:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=super.getDBObject(arg1);
            loc1.keyField = core.settings.SettingsMapper.col_GUID;
            loc1.keyValue = this.setting.GUID;
            loc1.table = core.settings.SettingsMapper.table_name;
            return loc1;
        }

        protected override function getMultiDBObject(arg1:String, arg2:String):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=super.getMultiDBObject(arg1, arg2);
            loc1.keyField = core.settings.SettingsMapper.col_GUID;
            loc1.keyValue = this.setting.GUID;
            loc1.table = core.settings.SettingsMapper.table_name;
            return loc1;
        }

        protected function onSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.setting[arg1.saveToDbUseUpdateObject.updateField] = arg2.rawValue;
            var loc1:*=dataProvider.getItemIndex(arg1);
            dataProvider.updateItemAt(loc1);
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        protected function onFavSettingsChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=arg1.saveToDbUseUpdateObject.updateField;
            if (hasString(loc5, "favoritesTrip1_", "favoritesTrip2_")) 
            {
                loc1 = loc5.split("_");
                if (hasString(loc5, "favoritesTrip1_")) 
                {
                    (this.setting as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1[loc1[1]] = arg2.rawValue.toString();
                }
                else 
                {
                    (this.setting as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2[loc1[1]] = arg2.rawValue.toString();
                }
            }
            else if (hasString(loc5, "favoritesTrack1_", "favoritesTrack2_")) 
            {
                loc1 = arg1.saveToDbUseUpdateObject.updateField.split("_");
                loc2 = (parseInt(loc1[1]) - 1);
                loc4 = loc1[2] != "A" ? 1 : 0;
                loc3 = hasString(loc5, "favoritesTrack1_") ? 0 : 1;
                (this.setting as core.settings.interfaces.IFavoritesTrack).favoritesTrack[loc3][loc2][loc4] = arg2.rawValue.toString();
            }
            else if (hasString(loc5, "favoritesAltitude1_", "favoritesAltitude2_")) 
            {
                loc1 = arg1.saveToDbUseUpdateObject.updateField.split("_");
                loc2 = (parseInt(loc1[1]) - 1);
                loc4 = loc1[2] != "A" ? 1 : 0;
                loc3 = hasString(loc5, "favoritesAltitude1_") ? 0 : 1;
                (this.setting as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[loc3][loc2][loc4] = arg2.rawValue.toString();
            }
            else if (hasString(loc5, "favoritesLap1_", "favoritesLap2_")) 
            {
                loc1 = arg1.saveToDbUseUpdateObject.updateField.split("_");
                loc2 = (parseInt(loc1[1]) - 1);
                loc4 = loc1[2] != "A" ? 1 : 0;
                loc3 = hasString(loc5, "favoritesLap1_") ? 0 : 1;
                (this.setting as core.settings.interfaces.IFavoritesLap).favoritesLap[loc3][loc2][loc4] = arg2.rawValue.toString();
            }
            else if (hasString(loc5, "favoritesCustomA_PageCount", "favoritesCustomB_PageCount")) 
            {
                loc3 = hasString(loc5, "favoritesCustomA_PageCount") ? 0 : 1;
                (this.setting as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[loc3] = parseInt(arg2.rawValue.toString());
            }
            else if (hasString(loc5, "favoritesCustom")) 
            {
                loc1 = arg1.saveToDbUseUpdateObject.updateField.split("favoritesCustom");
                loc1 = (loc1[1] as String).split("_");
                loc2 = (parseInt(loc1[0]) - 1);
                loc3 = loc1[1] != "A" ? 1 : 0;
                (this.setting as core.settings.interfaces.IFavoritesCustom).favoritesCustom[loc3][loc2] = arg2.rawValue.toString();
            }
            var loc6:*=dataProvider.getItemIndex(arg1);
            dataProvider.updateItemAt(loc6);
            return;
        }

        protected override function createFooterButtons():void
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.image = frontend.Textures.uploadicon;
            loc1.touchHandler = this.toDevice_handler;
            var loc2:*=new Vector.<frontend.components.button.IconButton>();
            loc2.push(loc1);
            footer.setButtonGroup(loc2);
            return;
        }

        protected function toDevice_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS_TRANSFER, {"unit":this.unit, "settings":this.setting, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        public var setting:core.settings.Settings;

        public var unit:core.units.Unit;
    }
}


