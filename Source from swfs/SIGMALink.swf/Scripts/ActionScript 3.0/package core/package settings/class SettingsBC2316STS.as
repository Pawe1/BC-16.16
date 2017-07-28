//class SettingsBC2316STS
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC2316STS extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IDate, core.settings.interfaces.ILanguage, core.settings.interfaces.IService, core.settings.interfaces.IWheelSize2Mode, core.settings.interfaces.ITireSize2, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.IActualAltitude, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IContrast, core.settings.interfaces.IDateFormat, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IClockMode, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IMyName, core.settings.interfaces.IPowerSaveMode, core.settings.interfaces.ICadenceSensor, core.settings.interfaces.IHeartrateSensor, core.settings.interfaces.INfc, core.settings.interfaces.IWeightUnit, core.settings.interfaces.IBodyHeightUnit, core.settings.interfaces.IBikeType1, core.settings.interfaces.IBikeWeight1, core.settings.interfaces.IBikeType2, core.settings.interfaces.IBikeWeight2, core.settings.interfaces.IBirthDate, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyHeight, core.settings.interfaces.IShoulderWidth, core.settings.interfaces.IGender, core.settings.interfaces.IHRmax, core.settings.interfaces.IHeartrateLimits, core.units.interfaces.IIntensityZonesPercentage, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IHRMaxOption, core.settings.interfaces.ISamplingRate
    {
        public function SettingsBC2316STS(arg1:flash.events.IEventDispatcher=null)
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            _birthDate = new Date(1983, 0, 1);
            _tireSize2 = core.general.TireSize.S_16INCH;
            _wheelSize2Mode = core.general.WheelSizeSelectionMode.TIRE;
            super(arg1);
            return;
        }

        public function get shoulderWidthMin():Number
        {
            if (bodyHeightUnit == "kilometer") 
            {
                return 40;
            }
            return 38;
        }

        public function get actualAltitude():int
        {
            return _actualAltitude;
        }

        public function set actualAltitude(arg1:int):void
        {
            if (arg1 != _actualAltitude) 
            {
                _actualAltitude = arg1;
                dispatchEvent(new flash.events.Event("actualAltitudeChange"));
            }
            return;
        }

        public function get actualAltitudeMax():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 5181295;
        }

        public function get actualAltitudeMin():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        public function get altitudeReference():String
        {
            return _altitudeReference;
        }

        public function set altitudeReference(arg1:String):void
        {
            if (_altitudeReference !== arg1) 
            {
                _altitudeReference = arg1;
                dispatchEvent(new flash.events.Event("altitudeReferenceChange"));
            }
            return;
        }

        public function set temperatureUnit(arg1:String):void
        {
            if (arg1 != _temperatureUnit) 
            {
                _temperatureUnit = arg1;
                dispatchEvent(new flash.events.Event("temperatureUnitChange"));
            }
            return;
        }

        public function get altitudeUnit():String
        {
            return _altitudeUnit;
        }

        public function set altitudeUnit(arg1:String):void
        {
            if (arg1 != _altitudeUnit) 
            {
                _altitudeUnit = arg1;
                dispatchEvent(new flash.events.Event("altitudeUnitChange"));
            }
            return;
        }

        public function get tireSize2():core.general.TireSize
        {
            return _tireSize2;
        }

        public function get bikeType1():String
        {
            return _bikeType1;
        }

        public function set bikeType1(arg1:String):void
        {
            if (arg1 != _bikeType1) 
            {
                _bikeType1 = arg1;
                dispatchEvent(new flash.events.Event("bikeType1Change"));
            }
            return;
        }

        public function set tireSize2(arg1:core.general.TireSize):void
        {
            _tireSize2 = arg1;
            if (arg1 && core.general.WheelSizeSelectionMode.TIRE.equals(wheelSize2Mode)) 
            {
                wheelSize2 = parseInt(arg1.data);
            }
            return;
        }

        public function get bikeType2():String
        {
            return _bikeType2;
        }

        public function set bikeType2(arg1:String):void
        {
            if (arg1 != _bikeType2) 
            {
                _bikeType2 = arg1;
                dispatchEvent(new flash.events.Event("bikeType2Change"));
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

        public function get bikeWeight1():int
        {
            return _bikeWeight1;
        }

        public function set bikeWeight1(arg1:int):void
        {
            if (arg1 != _bikeWeight1) 
            {
                _bikeWeight1 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight1Change"));
            }
            return;
        }

        public function get bikeWeight1Max():int
        {
            if (weightUnit == "kg") 
            {
                return 50000;
            }
            return 45359;
        }

        public function get bikeWeight1Min():int
        {
            if (weightUnit == "kg") 
            {
                return 1000;
            }
            return 1361;
        }

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        public function get bikeWeight2():int
        {
            return _bikeWeight2;
        }

        public function set bikeWeight2(arg1:int):void
        {
            if (arg1 != _bikeWeight2) 
            {
                _bikeWeight2 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight2Change"));
            }
            return;
        }

        public function get bikeWeight2Max():int
        {
            return bikeWeight1Max;
        }

        public function get bikeWeight2Min():int
        {
            return bikeWeight1Min;
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

        public function get upperLimitMax():int
        {
            return 240;
        }

        public function get bodyHeight():Number
        {
            return _bodyHeight;
        }

        public function set bodyHeight(arg1:Number):void
        {
            if (arg1 != _bodyHeight) 
            {
                _bodyHeight = arg1;
                dispatchEvent(new flash.events.Event("bodyHeightChange"));
            }
            return;
        }

        public function get bodyHeightMax():Number
        {
            if (weightUnit == "kg") 
            {
                return 250;
            }
            return 254;
        }

        public function get bodyHeightMin():Number
        {
            if (weightUnit == "kg") 
            {
                return 100;
            }
            return 102;
        }

        public function get upperLimitMin():int
        {
            return lowerLimit + 1;
        }

        public function get bodyHeightUnit():String
        {
            return _bodyHeightUnit;
        }

        public function set bodyHeightUnit(arg1:String):void
        {
            _bodyHeightUnit = arg1;
            return;
        }

        public function get weightUnit():String
        {
            return _weightUnit;
        }

        public function get bodyWeight():int
        {
            return _bodyWeight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _bodyWeight) 
            {
                _bodyWeight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            if (weightUnit == "kg") 
            {
                return 200000;
            }
            return 181437;
        }

        public function get bodyWeightMin():int
        {
            if (weightUnit == "kg") 
            {
                return 20000;
            }
            return 18144;
        }

        public function set weightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function get cadenceSensorActive():Boolean
        {
            return _cadenceSensorActive;
        }

        public function set cadenceSensorActive(arg1:Boolean):void
        {
            if (arg1 != _cadenceSensorActive) 
            {
                _cadenceSensorActive = arg1;
                dispatchEvent(new flash.events.Event("cadenceSensorActiveChange"));
            }
            return;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
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

        public function set wheelSize2(arg1:int):void
        {
            if (_wheelSize2 !== arg1) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
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
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
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

        public function get wheelSize2Min():int
        {
            return 500;
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

        public function set hrMaxOption(arg1:String):void
        {
            if (arg1 != _hrMaxOption) 
            {
                _hrMaxOption = arg1;
                dispatchEvent(new flash.events.Event("hrMaxOptionChange"));
            }
            return;
        }

        public function get heartrateSensorActive():Boolean
        {
            return _heartrateSensorActive;
        }

        public function set heartrateSensorActive(arg1:Boolean):void
        {
            if (arg1 != _heartrateSensorActive) 
            {
                _heartrateSensorActive = arg1;
                dispatchEvent(new flash.events.Event("heartrateSensorActiveChange"));
            }
            return;
        }

        public function get wheelSize2Mode():core.general.WheelSizeSelectionMode
        {
            return _wheelSize2Mode;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude1Change"));
            }
            return;
        }

        public function get homeAltitude1Max():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get homeAltitude1Min():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function set wheelSize2Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _wheelSize2Mode = arg1;
            return;
        }

        public function get homeAltitude2():int
        {
            return _homeAltitude2;
        }

        public function set homeAltitude2(arg1:int):void
        {
            if (arg1 != _homeAltitude2) 
            {
                _homeAltitude2 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude2Change"));
            }
            return;
        }

        public function get homeAltitude2Max():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get homeAltitude2Min():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
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
            return 40;
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

        public function get hrMaxOption():String
        {
            return _hrMaxOption;
        }

        public function get trainingZone():String
        {
            return _trainingZone;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1PercentageStart;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone1PercentageStart) 
            {
                _intensityZone1PercentageStart = arg1;
                dispatchEvent(new flash.events.Event("intensityZone1PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2PercentageStart;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone2PercentageStart) 
            {
                _intensityZone2PercentageStart = arg1;
                dispatchEvent(new flash.events.Event("intensityZone2PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3PercentageStart;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone3PercentageStart) 
            {
                _intensityZone3PercentageStart = arg1;
                dispatchEvent(new flash.events.Event("intensityZone3PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4PercentageEnd;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            if (arg1 != _intensityZone4PercentageEnd) 
            {
                _intensityZone4PercentageEnd = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageEndChange"));
            }
            return;
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4PercentageStart;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone4PercentageStart) 
            {
                _intensityZone4PercentageStart = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageStartChange"));
            }
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 20;
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
            return (upperLimit - 1);
        }

        public function get lowerLimitMin():int
        {
            return 40;
        }

        public function get myName():String
        {
            return _myName;
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

        public function get myNameMaxLength():uint
        {
            return 9;
        }

        public function get nfcActive():Boolean
        {
            return _nfcActive;
        }

        public function set nfcActive(arg1:Boolean):void
        {
            _nfcActive = arg1;
            return;
        }

        public function get powerSaveModeActive():Boolean
        {
            return _powerSaveModeActive;
        }

        public function set powerSaveModeActive(arg1:Boolean):void
        {
            if (arg1 != _powerSaveModeActive) 
            {
                _powerSaveModeActive = arg1;
                dispatchEvent(new flash.events.Event("powerSaveModeActiveChange"));
            }
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
            }
            return;
        }

        public function get seaLevel():Number
        {
            return _seaLevel;
        }

        public function set seaLevel(arg1:Number):void
        {
            if (arg1 != _seaLevel) 
            {
                _seaLevel = arg1;
                dispatchEvent(new flash.events.Event("seaLevelChange"));
            }
            return;
        }

        public function get seaLevelMax():Number
        {
            return 1050;
        }

        public function get seaLevelMin():Number
        {
            return 950;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get shoulderWidth():Number
        {
            return _shoulderWidth;
        }

        public function set shoulderWidth(arg1:Number):void
        {
            if (arg1 != _shoulderWidth) 
            {
                _shoulderWidth = arg1;
                dispatchEvent(new flash.events.Event("shoulderWidthChange"));
            }
            return;
        }

        public function get shoulderWidthMax():Number
        {
            if (bodyHeightUnit == "kilometer") 
            {
                return 80;
            }
            return 76;
        }

        internal const _myNameMaxLength:uint=9;

        internal var _actualAltitude:int=250000;

        internal var _altitudeReference:String;

        internal var _altitudeUnit:String="meter";

        internal var _bikeType1:String="raceDrop";

        internal var _bikeType2:String="raceDrop";

        internal var _bikeWeight1:int=8000;

        internal var _bikeWeight2:int=8000;

        internal var _birthDate:Date;

        internal var _bodyHeight:Number=180;

        internal var _bodyHeightUnit:String="";

        internal var _bodyWeight:int=70000;

        internal var _cadenceSensorActive:Boolean=false;

        internal var _clockMode:String="24";

        internal var _contrast:int=2;

        internal var _dateFormat:String="eu";

        internal var _gender:String="male";

        internal var _homeAltitude1:int=100000;

        internal var _homeAltitude2:int=100000;

        internal var _hrMax:int=193;

        internal var _hrMaxOption:String="calculated";

        internal var _tireSize2:core.general.TireSize;

        internal var _lowerLimit:int=105;

        internal var _trainingZone:String="fitZone";

        internal var _heartrateSensorActive:Boolean=false;

        internal var _nfcActive:Boolean=true;

        internal var _upperLimit:int=155;

        internal var _serviceInterval:int=750;

        internal var _intensityZone2PercentageStart:Number=70;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _serviceStatusOn:Boolean=false;

        internal var _weightUnit:String="kg";

        internal var _powerSaveModeActive:Boolean=false;

        internal var _intensityZone3PercentageStart:Number=80;

        internal var _wheelSize2:int=1253;

        internal var _shoulderWidth:Number=44;

        internal var _language:String="en";

        internal var _samplingRate:Number=5;

        internal var _myName:String="BC 23.16 STS";

        internal var _wheelSize2Mode:core.general.WheelSizeSelectionMode;

        internal var _intensityZone1PercentageStart:Number=60;

        internal var _temperatureUnit:String="";

        internal var _zoneAlarm:Boolean=false;

        internal var _seaLevel:Number=1009;

        internal var _intensityZone4PercentageStart:Number=90;
    }
}


