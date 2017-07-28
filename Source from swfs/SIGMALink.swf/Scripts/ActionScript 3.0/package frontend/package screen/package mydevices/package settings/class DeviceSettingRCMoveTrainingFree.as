//class DeviceSettingRCMoveTrainingFree
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


