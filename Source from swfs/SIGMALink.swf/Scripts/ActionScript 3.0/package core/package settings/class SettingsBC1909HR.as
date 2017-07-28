//class SettingsBC1909HR
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1909HR extends core.settings.SettingsTopline2009 implements core.settings.interfaces.ILanguage, core.settings.interfaces.IHeartrateLimits, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IHRmax, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IAge, core.settings.interfaces.IGender, core.settings.interfaces.IService, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IContrast
    {
        public function SettingsBC1909HR()
        {
            super();
            wheelSize1 = 2155;
            speedUnit = "kmh";
            hrMax = 191;
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

        public function get upperLimitMax():int
        {
            return 240;
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

        public function get upperLimitMin():int
        {
            return lowerLimit + 5;
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

        public function get wheelSize2():int
        {
            return _wheelSize2;
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

        public override function toString():String
        {
            return "[SettingsBC1909HR extends SettingsTopline ...]";
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

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        internal var _age:int=30;

        internal var _contrast:int=2;

        internal var _gender:String="male";

        internal var _hrMax:int=40;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String;

        internal var _serviceStatusOn:Boolean=false;

        internal var _lowerLimit:int=107;

        internal var _wheelSize2:int=2000;

        internal var _upperLimit:int=136;

        internal var _serviceInterval:int=750;

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";

        internal var _trainingZone:String="N/A";
    }
}


