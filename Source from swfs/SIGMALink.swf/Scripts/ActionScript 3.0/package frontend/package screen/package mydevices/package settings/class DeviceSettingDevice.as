//class DeviceSettingDevice
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


