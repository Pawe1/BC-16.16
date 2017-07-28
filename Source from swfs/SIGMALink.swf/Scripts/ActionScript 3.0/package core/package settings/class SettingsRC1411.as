//class SettingsRC1411
package core.settings 
{
    import core.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsRC1411 extends core.settings.SettingsRunningComputer implements core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.ICorrectionFactor, core.settings.interfaces.IYearOfBirth, core.settings.interfaces.IHRmax, core.settings.interfaces.IHeartrateLimits, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IBodyWeight, core.settings.interfaces.ILanguage, core.settings.interfaces.IContrast, core.settings.interfaces.ICalibration, core.settings.interfaces.IDateFormat, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IGender, core.settings.interfaces.IClockMode, core.settings.interfaces.IButtonTone, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.ISamplingRate, core.settings.interfaces.IDate
    {
        public function SettingsRC1411(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            totalsSeperatedOnUnit = true;
            speedUnit = "kmh";
            return;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            if (core.MeasurementConfig.weightFormat == "kg") 
            {
                return 199000;
            }
            return 180983;
        }

        public function get bodyWeightMin():int
        {
            if (core.MeasurementConfig.weightFormat == "kg") 
            {
                return 20000;
            }
            return 18144;
        }

        public function get bodyWeightUnit():String
        {
            return _weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function set trainingZone(arg1:String):void
        {
            if (arg1 != _trainingZone) 
            {
                _trainingZone = arg1;
                dispatchEvent(new flash.events.Event("trainingZoneChange"));
            }
            return;
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

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        public function get calibration():Boolean
        {
            return _calibration;
        }

        public function set calibration(arg1:Boolean):void
        {
            if (arg1 != _calibration) 
            {
                _calibration = arg1;
                dispatchEvent(new flash.events.Event("calibrationChange"));
            }
            return;
        }

        public function set upperLimit(arg1:int):void
        {
            if (arg1 != _upperLimit) 
            {
                _upperLimit = arg1;
                dispatchEvent(new flash.events.Event("upperLimitChange"));
            }
            return;
        }

        public function get calibrationDone():Boolean
        {
            return _calibrationDone;
        }

        public function set calibrationDone(arg1:Boolean):void
        {
            if (arg1 != _calibrationDone) 
            {
                _calibrationDone = arg1;
                dispatchEvent(new flash.events.Event("calibrationDoneChange"));
            }
            return;
        }

        public function get upperLimitMax():int
        {
            return 240;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function get upperLimitMin():int
        {
            return lowerLimit + 5;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 5;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get yearOfBirth():int
        {
            return _yearOfBirth;
        }

        public function get correctionFactor():int
        {
            return _correctionFactor;
        }

        public function set correctionFactor(arg1:int):void
        {
            if (arg1 != _correctionFactor) 
            {
                _correctionFactor = arg1;
                dispatchEvent(new flash.events.Event("correctionFactorChange"));
            }
            return;
        }

        public function get correctionFactorMax():int
        {
            return 1500;
        }

        public function get correctionFactorMin():int
        {
            return 500;
        }

        public function set yearOfBirth(arg1:int):void
        {
            if (arg1 != _yearOfBirth) 
            {
                _yearOfBirth = arg1;
                dispatchEvent(new flash.events.Event("yearOfBirthChange"));
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

        public function get yearOfBirthMax():int
        {
            return YEAR_OF_BIRTH_MAX;
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

        public function get yearOfBirthMin():int
        {
            return 1900;
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

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get language():String
        {
            return _language;
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

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
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

        public override function toString():String
        {
            return "[SettingsRC1411...]";
        }

        public function get lowerLimit():int
        {
            return _lowerLimit;
        }

        public function set lowerLimit(arg1:int):void
        {
            if (arg1 != _lowerLimit) 
            {
                _lowerLimit = arg1;
                dispatchEvent(new flash.events.Event("lowerLimitChange"));
            }
            return;
        }

        public function get lowerLimitMax():int
        {
            return upperLimit - 5;
        }

        public function get lowerLimitMin():int
        {
            return 40;
        }

        public function get needUpdateSettingInfo():Boolean
        {
            return _needUpdateSettingInfo;
        }

        public function set needUpdateSettingInfo(arg1:Boolean):void
        {
            _needUpdateSettingInfo = arg1;
            return;
        }

        public function get samplingRate():Number
        {
            return _samplingRate;
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

        public function get trainingZone():String
        {
            return _trainingZone;
        }

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        public static const TOTAL_CALORIES_MAX:int=99999;

        public static const TOTAL_DISTANCE_MAX_KM:int=99999000;

        public static const TOTAL_DISTANCE_MAX_MI:Number=160932790.656;

        public static const TOTAL_CALORIES_MIN:int=0;

        public static const TOTAL_DISTANCE_MIN:int=0;

        public static const TOTAL_TIME_HOURS_MAX:int=999;

        public static const TOTAL_TIME_HOURS_MIN:int=0;

        public static const TOTAL_TIME_MAX:int=359999900;

        public static const TOTAL_TIME_MINUTES_MAX:int=59;

        public static const TOTAL_TIME_MINUTES_MIN:int=0;

        public static const TOTAL_TIME_SECONDS_MAX:int=59;

        public static const TOTAL_TIME_SECONDS_MIN:int=0;

        public static const WEIGHTLB_MIN_IN_KG:int=18144;

        public static const WEIGHT_KG_MAX:int=199000;

        public static const WEIGHT_KG_MIN:int=20000;

        public static const CORRECTION_FACTOR_MAX:int=1500;

        public static const YEAR_OF_BIRTH_MAX:int=new Date().fullYear - 6;

        public static const YEAR_OF_BIRTH_MIN:int=1900;

        public static const CONTRAST_MAX:int=5;

        public static const CONTRAST_MIN:int=1;

        public static const WEIGHTLB_MAX_IN_KG:int=180983;

        public static const CORRECTION_FACTOR_MIN:int=500;

        internal var _buttonTone:Boolean=true;

        internal var _calibration:Boolean;

        internal var _calibrationDone:Boolean;

        internal var _clockMode:String="24";

        internal var _contrast:int=3;

        internal var _dateFormat:String="eu";

        internal var _gender:String="male";

        internal var _hrMax:int=191;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String;

        internal var _lowerLimit:int=105;

        internal var _samplingRate:Number=5;

        internal var _upperLimit:int=155;

        internal var _zoneAlarm:Boolean=true;

        internal var _yearOfBirth:int;

        internal var _trainingZone:String="fitZone";

        internal var _weightUnit:String="kg";

        internal var _needUpdateSettingInfo:Boolean=false;

        internal var _correctionFactor:int=1000;

        internal var _weight:int=75000;
    }
}


