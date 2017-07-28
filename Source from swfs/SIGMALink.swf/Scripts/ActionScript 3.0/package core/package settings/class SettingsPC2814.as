//class SettingsPC2814
package core.settings 
{
    import __AS3__.vec.*;
    import core.settings.interfaces.*;
    import core.training.type.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SettingsPC2814 extends core.settings.SettingsPulseComputer implements core.settings.interfaces.IDate, core.settings.interfaces.ILanguage, core.settings.interfaces.IDateFormat, core.settings.interfaces.IGender, core.settings.interfaces.IHRmax, core.settings.interfaces.ISamplingRate, core.settings.interfaces.IButtonTone, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.ILowBatDetectLevel, core.units.interfaces.IIntensityZonesPercentage, core.settings.interfaces.IBirthDate, core.settings.interfaces.IAlarm, core.settings.interfaces.IAlarmMode, core.settings.interfaces.IFavoriteTrip1, core.settings.interfaces.IFavoriteTrip2, core.settings.interfaces.ITrainingFree, core.settings.interfaces.ITrainingIntervalWarmUp, core.settings.interfaces.ITrainingInterval, core.settings.interfaces.ITrainingIntervalCoolDown, core.settings.interfaces.IMyName, core.settings.interfaces.IKeyLock, core.settings.interfaces.IPhaseAlarm
    {
        public function SettingsPC2814(arg1:flash.events.IEventDispatcher=null)
        {
            _alarm = new Date(2014, 0, 1);
            _birthDate = new Date(1980, 0, 1);
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>(9);
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>(9);
            _intervalRecoveryMode = core.training.type.PhaseControl.TIME;
            super(arg1);
            bodyWeight = 75000;
            favoritesTrip1[0] = "2";
            favoritesTrip2[0] = "1";
            favoritesTrip1[1] = "6";
            favoritesTrip2[1] = "7";
            favoritesTrip1[2] = "8";
            favoritesTrip2[2] = "9";
            favoritesTrip1[3] = "5";
            favoritesTrip2[3] = "2";
            favoritesTrip1[4] = "3";
            favoritesTrip2[4] = "0";
            favoritesTrip1[5] = "4";
            favoritesTrip2[5] = "0";
            favoritesTrip1[6] = "0";
            favoritesTrip2[6] = "0";
            favoritesTrip1[7] = "0";
            favoritesTrip2[7] = "0";
            favoritesTrip1[8] = "0";
            favoritesTrip2[8] = "0";
            return;
        }

        public function set intervalWarmUpTime(arg1:int):void
        {
            if (arg1 != _intervalWarmUpTime) 
            {
                _intervalWarmUpTime = arg1;
                dispatchEvent(new flash.events.Event("intervalWarmUpTimeChange"));
            }
            return;
        }

        public function get alarm():Date
        {
            return _alarm;
        }

        public function set alarm(arg1:Date):void
        {
            if (arg1 != _alarm) 
            {
                _alarm = arg1;
                dispatchEvent(new flash.events.Event("alarmChange"));
            }
            return;
        }

        public function get keyLock():Boolean
        {
            return _keyLock;
        }

        public function get alarmMode():String
        {
            return _alarmMode;
        }

        public function set alarmMode(arg1:String):void
        {
            if (arg1 != _alarmMode) 
            {
                _alarmMode = arg1;
                dispatchEvent(new flash.events.Event("alarmModeChange"));
            }
            return;
        }

        public function set keyLock(arg1:Boolean):void
        {
            if (arg1 != _keyLock) 
            {
                _keyLock = arg1;
                dispatchEvent(new flash.events.Event("keyLockChange"));
            }
            return;
        }

        public function get birthDate():Date
        {
            return _birthDate;
        }

        public function set birthDate(arg1:Date):void
        {
            if (arg1 != _birthDate) 
            {
                _birthDate = arg1;
                dispatchEvent(new flash.events.Event("birthDateChange"));
            }
            return;
        }

        public function get birthDateMax():Number
        {
            return new Date(NOW.fullYear - 6, NOW.month, NOW.date).time;
        }

        public function get birthDateMin():Number
        {
            return new Date(1900, 0, 1).time;
        }

        public function get language():String
        {
            return _language;
        }

        public function get buttonTone():Boolean
        {
            return _buttonTone;
        }

        public function set buttonTone(arg1:Boolean):void
        {
            if (arg1 != _buttonTone) 
            {
                _buttonTone = arg1;
                dispatchEvent(new flash.events.Event("buttonToneChange"));
            }
            return;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public final function get favoritesTrip1():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip1;
        }

        public final function set favoritesTrip1(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip1 !== arg1) 
            {
                _favoritesTrip1 = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrip1Change"));
            }
            return;
        }

        public function get favoritesTrip1Size():int
        {
            return 9;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public final function get favoritesTrip2():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip2;
        }

        public final function set favoritesTrip2(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip2 !== arg1) 
            {
                _favoritesTrip2 = arg1;
                dispatchEvent(new flash.events.Event("favorites2Change"));
            }
            return;
        }

        public function get favoritesTrip2Size():int
        {
            return 9;
        }

        public function get myName():String
        {
            return _myName;
        }

        public function get freeOwnZone1LowerLimit():int
        {
            return _freeOwnZone1LowerLimit;
        }

        public function set freeOwnZone1LowerLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone1LowerLimit) 
            {
                _freeOwnZone1LowerLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone1LowerLimitChange"));
            }
            return;
        }

        public function get freeOwnZone1LowerLimitDefault():int
        {
            return 110;
        }

        public function get freeOwnZone1LowerLimitMax():int
        {
            return (Math.min(240, freeOwnZone1UpperLimit) - 1);
        }

        public function get freeOwnZone1LowerLimitMin():int
        {
            return 30;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function get freeOwnZone1UpperLimit():int
        {
            return _freeOwnZone1UpperLimit;
        }

        public function set freeOwnZone1UpperLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone1UpperLimit) 
            {
                _freeOwnZone1UpperLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone1UpperLimitChange"));
            }
            return;
        }

        public function get freeOwnZone1UpperLimitDefault():int
        {
            return 155;
        }

        public function get freeOwnZone1UpperLimitMax():int
        {
            return 240;
        }

        public function get freeOwnZone1UpperLimitMin():int
        {
            return Math.max(30, freeOwnZone1LowerLimit) + 1;
        }

        public function get myNameMaxLength():uint
        {
            return 10;
        }

        public function get freeOwnZone2LowerLimit():int
        {
            return _freeOwnZone2LowerLimit;
        }

        public function set freeOwnZone2LowerLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone2LowerLimit) 
            {
                _freeOwnZone2LowerLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone2LowerLimitChange"));
            }
            return;
        }

        public function get freeOwnZone2LowerLimitDefault():int
        {
            return 120;
        }

        public function get freeOwnZone2LowerLimitMax():int
        {
            return (Math.min(240, freeOwnZone2UpperLimit) - 1);
        }

        public function get freeOwnZone2LowerLimitMin():int
        {
            return 30;
        }

        public function get phaseAlarm():Boolean
        {
            return _phaseAlarm;
        }

        public function get freeOwnZone2UpperLimit():int
        {
            return _freeOwnZone2UpperLimit;
        }

        public function set freeOwnZone2UpperLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone2UpperLimit) 
            {
                _freeOwnZone2UpperLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone2UpperLimitChange"));
            }
            return;
        }

        public function get freeOwnZone2UpperLimitDefault():int
        {
            return 165;
        }

        public function get freeOwnZone2UpperLimitMax():int
        {
            return 240;
        }

        public function get freeOwnZone2UpperLimitMin():int
        {
            return Math.max(30, freeOwnZone2LowerLimit) + 1;
        }

        public function set phaseAlarm(arg1:Boolean):void
        {
            if (arg1 != _phaseAlarm) 
            {
                _phaseAlarm = arg1;
                dispatchEvent(new flash.events.Event("phaseAlarmChange"));
            }
            return;
        }

        public function get freeOwnZone3LowerLimit():int
        {
            return _freeOwnZone3LowerLimit;
        }

        public function set freeOwnZone3LowerLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone3LowerLimit) 
            {
                _freeOwnZone3LowerLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone3LowerLimitChange"));
            }
            return;
        }

        public function get freeOwnZone3LowerLimitDefault():int
        {
            return 130;
        }

        public function get freeOwnZone3LowerLimitMax():int
        {
            return (Math.min(240, freeOwnZone3UpperLimit) - 1);
        }

        public function get freeOwnZone3LowerLimitMin():int
        {
            return 30;
        }

        public function get samplingRate():Number
        {
            return _samplingRate;
        }

        public function get freeOwnZone3UpperLimit():int
        {
            return _freeOwnZone3UpperLimit;
        }

        public function set freeOwnZone3UpperLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone3UpperLimit) 
            {
                _freeOwnZone3UpperLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone3UpperLimitChange"));
            }
            return;
        }

        public function get freeOwnZone3UpperLimitDefault():int
        {
            return 175;
        }

        public function get freeOwnZone3UpperLimitMax():int
        {
            return 240;
        }

        public function get freeOwnZone3UpperLimitMin():int
        {
            return Math.max(30, freeOwnZone3LowerLimit) + 1;
        }

        public function set samplingRate(arg1:Number):void
        {
            if (arg1 != _samplingRate) 
            {
                _samplingRate = arg1;
                dispatchEvent(new flash.events.Event("samplingRateChange"));
            }
            return;
        }

        public function get freeTrainingTargetZone():String
        {
            return _freeTrainingTargetZone;
        }

        public function set freeTrainingTargetZone(arg1:String):void
        {
            if (arg1 != _freeTrainingTargetZone) 
            {
                _freeTrainingTargetZone = arg1;
                dispatchEvent(new flash.events.Event("freeTrainingTargetZone"));
            }
            return;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone1) 
            {
                _intensityZone1 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone1PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone2) 
            {
                _intensityZone2 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone2PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone3) 
            {
                _intensityZone3 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone3PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4End;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            if (arg1 != _intensityZone4End) 
            {
                _intensityZone4End = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageEndChange"));
            }
            return;
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone4) 
            {
                _intensityZone4 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageStartChange"));
            }
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 30;
        }

        public override function toString():String
        {
            return "[SettingsPC2813 extends SettingsPulseComputer]";
        }

        public function get intervalCoolDownTargetZoneLowerLimit():int
        {
            return _intervalCoolDownTargetZoneLowerLimit;
        }

        public function set intervalCoolDownTargetZoneLowerLimit(arg1:int):void
        {
            if (arg1 != _intervalCoolDownTargetZoneLowerLimit) 
            {
                _intervalCoolDownTargetZoneLowerLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalCoolDownTargetZoneLowerLimitChange"));
            }
            return;
        }

        public function get intervalCoolDownTargetZoneLowerLimitMax():int
        {
            return (Math.min(240, intervalCoolDownTargetZoneUpperLimit) - 1);
        }

        public function get intervalCoolDownTargetZoneLowerLimitMin():int
        {
            return 30;
        }

        public function get intervalCoolDownTargetZoneUpperLimit():int
        {
            return _intervalCoolDownTargetZoneUpperLimit;
        }

        public function set intervalCoolDownTargetZoneUpperLimit(arg1:int):void
        {
            if (arg1 != _intervalCoolDownTargetZoneUpperLimit) 
            {
                _intervalCoolDownTargetZoneUpperLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalCoolDownTargetZoneUpperLimitChange"));
            }
            return;
        }

        public function get intervalCoolDownTargetZoneUpperLimitMax():int
        {
            return 240;
        }

        public function get intervalCoolDownTargetZoneUpperLimitMin():int
        {
            return Math.max(30, intervalCoolDownTargetZoneLowerLimit) + 1;
        }

        public function get intervalCoolDownTime():int
        {
            return _intervalCoolDownTime;
        }

        public function set intervalCoolDownTime(arg1:int):void
        {
            if (arg1 != _intervalCoolDownTime) 
            {
                _intervalCoolDownTime = arg1;
                dispatchEvent(new flash.events.Event("intervalCoolDownTimeChange"));
            }
            return;
        }

        public function get intervalRecoveryHR():int
        {
            return _intervalRecoveryHR;
        }

        public function set intervalRecoveryHR(arg1:int):void
        {
            if (arg1 != _intervalRecoveryHR) 
            {
                _intervalRecoveryHR = arg1;
                dispatchEvent(new flash.events.Event("intervalRecoveryHRChange"));
            }
            return;
        }

        public function get intervalRecoveryMode():core.training.type.PhaseControl
        {
            return _intervalRecoveryMode;
        }

        public function set intervalRecoveryMode(arg1:core.training.type.PhaseControl):void
        {
            if (arg1 != _intervalRecoveryMode) 
            {
                _intervalRecoveryMode = arg1;
                dispatchEvent(new flash.events.Event("intervalRecoveryModeChange"));
            }
            return;
        }

        public function get intervalRecoveryTime():int
        {
            return _intervalRecoveryTime;
        }

        public function set intervalRecoveryTime(arg1:int):void
        {
            if (arg1 != _intervalRecoveryTime) 
            {
                _intervalRecoveryTime = arg1;
                dispatchEvent(new flash.events.Event("intervalRecoveryTimeChange"));
            }
            return;
        }

        public function get intervalTargetZoneLowerLimit():int
        {
            return _intervalTargetZoneLowerLimit;
        }

        public function set intervalTargetZoneLowerLimit(arg1:int):void
        {
            if (arg1 != _intervalTargetZoneLowerLimit) 
            {
                _intervalTargetZoneLowerLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalTargetZoneLowerLimitChange"));
            }
            return;
        }

        public function get intervalTargetZoneLowerLimitMax():int
        {
            return (Math.min(240, intervalTargetZoneUpperLimit) - 1);
        }

        public function get intervalTargetZoneLowerLimitMin():int
        {
            return 30;
        }

        public function get intervalTargetZoneUpperLimit():int
        {
            return _intervalTargetZoneUpperLimit;
        }

        public function set intervalTargetZoneUpperLimit(arg1:int):void
        {
            if (arg1 != _intervalTargetZoneUpperLimit) 
            {
                _intervalTargetZoneUpperLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalTargetZoneUpperLimitChange"));
            }
            return;
        }

        public function get intervalTargetZoneUpperLimitMax():int
        {
            return 240;
        }

        public function get intervalTargetZoneUpperLimitMin():int
        {
            return Math.max(30, intervalTargetZoneLowerLimit) + 1;
        }

        public function get intervalTime():int
        {
            return _intervalTime;
        }

        public function set intervalTime(arg1:int):void
        {
            if (arg1 != _intervalTime) 
            {
                _intervalTime = arg1;
                dispatchEvent(new flash.events.Event("intervalTimeChange"));
            }
            return;
        }

        public function get intervalWarmUpTargetZoneLowerLimit():int
        {
            return _intervalWarmUpTargetZoneLowerLimit;
        }

        public function set intervalWarmUpTargetZoneLowerLimit(arg1:int):void
        {
            if (arg1 != _intervalWarmUpTargetZoneLowerLimit) 
            {
                _intervalWarmUpTargetZoneLowerLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalWarmUpTargetZoneLowerLimitChange"));
            }
            return;
        }

        public function get intervalWarmUpTargetZoneLowerLimitMax():int
        {
            return (Math.min(240, intervalWarmUpTargetZoneUpperLimit) - 1);
        }

        public function get intervalWarmUpTargetZoneLowerLimitMin():int
        {
            return 30;
        }

        public function get intervalWarmUpTargetZoneUpperLimit():int
        {
            return _intervalWarmUpTargetZoneUpperLimit;
        }

        public function set intervalWarmUpTargetZoneUpperLimit(arg1:int):void
        {
            if (arg1 != _intervalWarmUpTargetZoneUpperLimit) 
            {
                _intervalWarmUpTargetZoneUpperLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalWarmUpTargetZoneUpperLimitChange"));
            }
            return;
        }

        public function get intervalWarmUpTargetZoneUpperLimitMax():int
        {
            return 240;
        }

        public function get intervalWarmUpTargetZoneUpperLimitMin():int
        {
            return Math.max(30, intervalWarmUpTargetZoneLowerLimit) + 1;
        }

        public function get intervalWarmUpTime():int
        {
            return _intervalWarmUpTime;
        }

        internal const _myNameMaxLength:uint=10;

        internal static const NOW:Date=new Date();

        public static const FREE_OWN_ZONE_2_UPPER_LIMIT_DEFAULT:int=165;

        public static const FREE_OWN_ZONE_1_LOWER_LIMIT_DEFAULT:int=110;

        public static const FREE_OWN_ZONE_1_UPPER_LIMIT_DEFAULT:int=155;

        public static const FREE_OWN_ZONE_2_LOWER_LIMIT_DEFAULT:int=120;

        public static const FREE_OWN_ZONE_3_LOWER_LIMIT_DEFAULT:int=130;

        public static const FREE_OWN_ZONE_3_UPPER_LIMIT_DEFAULT:int=175;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        internal static const FAVORIT_TRIP_SIZE:int=9;

        internal var _freeOwnZone2UpperLimit:int=165;

        internal var _freeOwnZone3LowerLimit:int=130;

        internal var _freeOwnZone3UpperLimit:int=175;

        internal var _freeTrainingTargetZone:String="fitZone";

        internal var _gender:String="male";

        internal var _hrMax:int=190;

        internal var _intervalCoolDownTargetZoneLowerLimit:int=90;

        internal var _intervalWarmUpTargetZoneUpperLimit:int=130;

        internal var _lowBatDetectLevel:String;

        internal var _intervalCoolDownTargetZoneUpperLimit:int=120;

        internal var _intervalTime:int=60;

        internal var _myName:String="RC MOVE";

        internal var _intervalRecoveryTime:int=60;

        internal var _intervalCoolDownTime:int=300;

        internal var _intervalWarmUpTime:int=600;

        internal var _phaseAlarm:Boolean=true;

        internal var _intervalWarmUpTargetZoneLowerLimit:int=100;

        internal var _intervalTargetZoneUpperLimit:int=150;

        internal var _alarm:Date;

        internal var _keyLock:Boolean=false;

        internal var _intervalRecoveryMode:core.training.type.PhaseControl;

        internal var _zoneAlarm:Boolean=true;

        internal var _intervalTargetZoneLowerLimit:int=130;

        internal var _language:String="en";

        internal var _intensityZone1:Number=60;

        internal var _intensityZone2:Number=70;

        internal var _intensityZone3:Number=80;

        internal var _alarmMode:String="off";

        internal var _intensityZone4End:Number=100;

        internal var _intervalRecoveryHR:int=100;

        internal var _birthDate:Date;

        internal var _buttonTone:Boolean=true;

        internal var _dateFormat:String="eu";

        internal var _intensityZone4:Number=90;

        internal var _favoritesTrip1:__AS3__.vec.Vector.<String>;

        internal var _favoritesTrip2:__AS3__.vec.Vector.<String>;

        internal var _freeOwnZone1LowerLimit:int=110;

        internal var _freeOwnZone1UpperLimit:int=155;

        internal var _freeOwnZone2LowerLimit:int=120;

        internal var _samplingRate:Number=0;
    }
}


