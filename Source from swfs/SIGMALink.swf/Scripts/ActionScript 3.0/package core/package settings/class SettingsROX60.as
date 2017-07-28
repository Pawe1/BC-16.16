//class SettingsROX60
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX60 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.IContrast, core.settings.interfaces.IWheelSize2, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IGender, core.settings.interfaces.IHRmax, core.units.interfaces.IIntensityZonesPercentage, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IHeartrateLimits, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IActualAltitude, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IAge, core.settings.interfaces.IDate, core.settings.interfaces.IDateFormat
    {
        public function SettingsROX60(arg1:flash.events.IEventDispatcher=null)
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            super(arg1);
            return;
        }

        public function get upperLimit():int
        {
            return _upperLimit;
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

        public function set upperLimit(arg1:int):void
        {
            if (arg1 != _upperLimit) 
            {
                _upperLimit = arg1;
                dispatchEvent(new flash.events.Event("upperLimitChange"));
            }
            return;
        }

        public function get age():int
        {
            return _age;
        }

        public function set age(arg1:int):void
        {
            if (arg1 != _age) 
            {
                _age = arg1;
                dispatchEvent(new flash.events.Event("AgeChange"));
            }
            return;
        }

        public function get ageMax():int
        {
            return 99;
        }

        public function get ageMin():int
        {
            return 10;
        }

        public function get upperLimitMax():int
        {
            return 240;
        }

        public function get altitudeReference():String
        {
            return _altitudeReference;
        }

        public function set altitudeReference(arg1:String):void
        {
            if (arg1 != _altitudeReference) 
            {
                _altitudeReference = arg1;
                dispatchEvent(new flash.events.Event("altitudeReferenceChange"));
            }
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
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
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

        public override function toString():String
        {
            return "[SettingsROX60 extends SettingsBikeComputer]";
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
            return 20;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
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
            return 900;
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

        public function get trainingZone():String
        {
            return _trainingZone;
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

        internal var _actualAltitude:int=257000;

        internal var _age:int=25;

        internal var _altitudeReference:String;

        internal var _contrast:int=2;

        internal var _dateFormat:String="eu";

        internal var _gender:String="male";

        internal var _homeAltitude1:int=300000;

        internal var _hrMax:int=193;

        internal var _lowBatDetectLevel:String="3.00V";

        internal var _serviceInterval:int=750;

        internal var _trainingZone:String="fitZone";

        internal var _wheelSize2:int=2000;

        internal var _lowerLimit:int=105;

        internal var _language:String="en";

        internal var _zoneAlarm:Boolean=false;

        internal var _seaLevel:Number=1013.2;

        internal var _upperLimit:int=155;

        internal var _intensityZone1:Number=60;

        internal var _intensityZone2:Number=70;

        internal var _intensityZone3:Number=80;

        internal var _intensityZone4:Number=90;

        internal var _intensityZone4End:Number=100;

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";

        internal var _serviceStatusOn:Boolean=true;
    }
}


