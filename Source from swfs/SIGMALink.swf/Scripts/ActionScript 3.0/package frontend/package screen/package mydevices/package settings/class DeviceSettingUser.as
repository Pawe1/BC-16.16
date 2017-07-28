//class DeviceSettingUser
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


