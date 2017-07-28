//class DeviceSettingRCMoveTrainingInterval
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


