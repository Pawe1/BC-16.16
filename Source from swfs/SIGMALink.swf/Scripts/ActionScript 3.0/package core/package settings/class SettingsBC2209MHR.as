//class SettingsBC2209MHR
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC2209MHR extends core.settings.SettingsTopline2009 implements core.settings.interfaces.ILanguage, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IAge, core.settings.interfaces.IGender, core.settings.interfaces.IActualAltitude, core.settings.interfaces.IService, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IContrast
    {
        public function SettingsBC2209MHR()
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            _referenceMark = core.general.AltitudeReference.SEA_LEVEL;
            super();
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
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

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
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
                dispatchEvent(new flash.events.Event("ageChange"));
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

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
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

        public function get wheelSize2():int
        {
            return _wheelSize2;
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

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
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

        public override function toString():String
        {
            return "[SettingsBC2209MHR extends SettingsBikeComputer ...]";
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
                dispatchEvent(new flash.events.Event("homeAltitudeChange"));
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

        public function get referenceMark():String
        {
            return _referenceMark;
        }

        public function set referenceMark(arg1:String):void
        {
            if (arg1 != _referenceMark) 
            {
                _referenceMark = arg1;
                dispatchEvent(new flash.events.Event("referenceMarkChange"));
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

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        internal var _actualAltitude:int=250000;

        internal var _age:int=27;

        internal var _altitudeReference:String;

        internal var _contrast:int=2;

        internal var _gender:String="male";

        internal var _homeAltitude1:int=100000;

        internal var _serviceStatusOn:Boolean=false;

        internal var _referenceMark:String;

        internal var _language:String="en";

        internal var _wheelSize2:int=2000;

        internal var _serviceInterval:int=750;

        internal var _lowBatDetectLevel:String="N/A";

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";

        internal var _seaLevel:Number=1009;
    }
}


