//class DeviceSettingBycicles
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


