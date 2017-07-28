//class SettingsBC1616
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1616 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IDate, core.settings.interfaces.ILanguage, core.settings.interfaces.IService, core.settings.interfaces.IWheelSize2Mode, core.settings.interfaces.ITireSize2, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IContrast, core.settings.interfaces.IDateFormat, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IClockMode, core.settings.interfaces.IFuelConsumptionUnit, core.settings.interfaces.IETADistance, core.settings.interfaces.IMyName, core.settings.interfaces.IBacklight, core.settings.interfaces.IBacklightTimeOff, core.settings.interfaces.IBacklightTimeOn, core.settings.interfaces.IFuelConsumption, core.settings.interfaces.IPowerSaveMode, core.settings.interfaces.IETAArivalFlag, core.settings.interfaces.INfc
    {
        public function SettingsBC1616(arg1:flash.events.IEventDispatcher=null)
        {
            _tireSize2 = core.general.TireSize.S_16INCH;
            _wheelSize2Mode = core.general.WheelSizeSelectionMode.TIRE;
            super(arg1);
            return;
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

        public function get backlightActive():Boolean
        {
            return _backlightActive;
        }

        public function set backlightActive(arg1:Boolean):void
        {
            if (arg1 != _backlightActive) 
            {
                _backlightActive = arg1;
                dispatchEvent(new flash.events.Event("backlightActiveChange"));
            }
            return;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        public function get backlightTimeOff():Date
        {
            if (!_backlightTimeOff) 
            {
                _backlightTimeOff = new Date();
                _backlightTimeOff.setSeconds(64800);
            }
            return _backlightTimeOff;
        }

        public function set backlightTimeOff(arg1:Date):void
        {
            if (arg1 != _backlightTimeOff) 
            {
                _backlightTimeOff = arg1;
                dispatchEvent(new flash.events.Event("backlightTimeOffChange"));
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

        public function get backlightTimeOn():Date
        {
            if (!_backlightTimeOn) 
            {
                _backlightTimeOn = new Date();
                _backlightTimeOn.setSeconds(64800);
            }
            return _backlightTimeOn;
        }

        public function set backlightTimeOn(arg1:Date):void
        {
            if (arg1 != _backlightTimeOn) 
            {
                _backlightTimeOn = arg1;
                dispatchEvent(new flash.events.Event("backlightTimeOnChange"));
            }
            return;
        }

        public function get tireSize2():core.general.TireSize
        {
            return _tireSize2;
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

        public function set wheelSize2Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _wheelSize2Mode = arg1;
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

        public function set wheelSize2(arg1:int):void
        {
            if (_wheelSize2 !== arg1) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public function get etaArivalFlag():Boolean
        {
            return _etaArivalFlag;
        }

        public function set etaArivalFlag(arg1:Boolean):void
        {
            if (arg1 != _etaArivalFlag) 
            {
                _etaArivalFlag = arg1;
                dispatchEvent(new flash.events.Event("etaArivalFlagChange"));
            }
            return;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public function get etaDistance():Number
        {
            return _etaDistance;
        }

        public function set etaDistance(arg1:Number):void
        {
            if (arg1 != _etaDistance) 
            {
                _etaDistance = arg1;
                dispatchEvent(new flash.events.Event("etaDistanceChange"));
            }
            return;
        }

        public function get etaDistanceMax():Number
        {
            return 160935121;
        }

        public function get etaDistanceMin():Number
        {
            return 0;
        }

        public function get wheelSize2Min():int
        {
            return 500;
        }

        public function get fuelConsumption():Number
        {
            return _fuelConsumption;
        }

        public function set fuelConsumption(arg1:Number):void
        {
            if (arg1 != _fuelConsumption) 
            {
                _fuelConsumption = arg1;
                dispatchEvent(new flash.events.Event("fuelConsumptionChange"));
            }
            return;
        }

        public function get fuelConsumptionMax():Number
        {
            if (fuelConsumptionUnit == "l/100km") 
            {
                return 30;
            }
            return 23.52;
        }

        public function get fuelConsumptionMin():Number
        {
            if (fuelConsumptionUnit == "l/100km") 
            {
                return 1;
            }
            return 0.98;
        }

        public function get wheelSize2Mode():core.general.WheelSizeSelectionMode
        {
            return _wheelSize2Mode;
        }

        public function get fuelConsumptionUnit():String
        {
            return _fuelConsumptionUnit;
        }

        public function set fuelConsumptionUnit(arg1:String):void
        {
            if (arg1 != _fuelConsumptionUnit) 
            {
                _fuelConsumptionUnit = arg1;
                dispatchEvent(new flash.events.Event("fuelConsumptionUnitChange"));
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

        public function set tireSize2(arg1:core.general.TireSize):void
        {
            _tireSize2 = arg1;
            if (arg1 && core.general.WheelSizeSelectionMode.TIRE.equals(wheelSize2Mode)) 
            {
                wheelSize2 = parseInt(arg1.data);
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        internal const _myNameMaxLength:uint=9;

        internal var _backlightActive:Boolean=false;

        internal var _backlightTimeOff:Date;

        internal var _backlightTimeOn:Date;

        internal var _clockMode:String="24";

        internal var _contrast:int=2;

        internal var _dateFormat:String="eu";

        internal var _etaArivalFlag:Boolean=true;

        internal var _etaDistance:Number=100000;

        internal var _fuelConsumption:Number=8.5;

        internal var _fuelConsumptionUnit:String="l/100km";

        internal var _tireSize2:core.general.TireSize;

        internal var _powerSaveModeActive:Boolean=false;

        internal var _wheelSize2:int=1253;

        internal var _language:String="en";

        internal var _nfcActive:Boolean=true;

        internal var _temperatureUnit:String="";

        internal var _serviceInterval:int=750;

        internal var _wheelSize2Mode:core.general.WheelSizeSelectionMode;

        internal var _myName:String="BC 16.16";

        internal var _serviceStatusOn:Boolean=false;
    }
}


