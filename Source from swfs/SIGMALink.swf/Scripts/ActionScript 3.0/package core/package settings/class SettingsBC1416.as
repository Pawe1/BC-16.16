//class SettingsBC1416
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1416 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IDate, core.settings.interfaces.ILanguage, core.settings.interfaces.IService, core.settings.interfaces.IWheelSize2Mode, core.settings.interfaces.ITireSize2, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.IActualAltitude, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IContrast, core.settings.interfaces.IDateFormat, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IClockMode, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IMyName, core.settings.interfaces.IPowerSaveMode, core.settings.interfaces.INfc
    {
        public function SettingsBC1416(arg1:flash.events.IEventDispatcher=null)
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            _tireSize2 = core.general.TireSize.S_16INCH;
            _wheelSize2Mode = core.general.WheelSizeSelectionMode.TIRE;
            super(arg1);
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

        public function get tireSize2():core.general.TireSize
        {
            return _tireSize2;
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

        public function get contrastMax():int
        {
            return 3;
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

        public function set tireSize2(arg1:core.general.TireSize):void
        {
            _tireSize2 = arg1;
            if (arg1 && core.general.WheelSizeSelectionMode.TIRE.equals(wheelSize2Mode)) 
            {
                wheelSize2 = parseInt(arg1.data);
            }
            return;
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

        public function set wheelSize2(arg1:int):void
        {
            if (_wheelSize2 !== arg1) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
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

        public function get wheelSize2Mode():core.general.WheelSizeSelectionMode
        {
            return _wheelSize2Mode;
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

        public function set wheelSize2Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _wheelSize2Mode = arg1;
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

        public function get powerSaveModeActive():Boolean
        {
            return _powerSaveModeActive;
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

        public function set powerSaveModeActive(arg1:Boolean):void
        {
            if (arg1 != _powerSaveModeActive) 
            {
                _powerSaveModeActive = arg1;
                dispatchEvent(new flash.events.Event("powerSaveModeActiveChange"));
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

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        internal const _myNameMaxLength:uint=9;

        internal var _actualAltitude:int=250000;

        internal var _altitudeReference:String;

        internal var _clockMode:String="24";

        internal var _contrast:int=2;

        internal var _altitudeUnit:String="meter";

        internal var _dateFormat:String="eu";

        internal var _homeAltitude1:int=100000;

        internal var _homeAltitude2:int=100000;

        internal var _language:String="en";

        internal var _tireSize2:core.general.TireSize;

        internal var _seaLevel:Number=1009;

        internal var _nfcActive:Boolean=true;

        internal var _wheelSize2:int=1253;

        internal var _serviceStatusOn:Boolean=false;

        internal var _powerSaveModeActive:Boolean=false;

        internal var _myName:String="BC 14.16";

        internal var _temperatureUnit:String="";

        internal var _wheelSize2Mode:core.general.WheelSizeSelectionMode;

        internal var _serviceInterval:int=750;
    }
}


