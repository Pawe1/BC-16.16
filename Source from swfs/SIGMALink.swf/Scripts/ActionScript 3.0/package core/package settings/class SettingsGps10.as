//class SettingsGps10
package core.settings 
{
    import core.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsGps10 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IClockMode, core.settings.interfaces.ILanguage, core.settings.interfaces.IAutoPause, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IContrast, core.settings.interfaces.IDateFormat, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.INfc, core.settings.interfaces.ISystemTone, core.settings.interfaces.IActualAltitude, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IMyName, core.settings.interfaces.IAutoLapBasedOnDistance, core.settings.interfaces.ITimeZone, core.settings.interfaces.ISummerTime
    {
        public function SettingsGps10(arg1:flash.events.IEventDispatcher=null)
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            super(arg1);
            return;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
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

        public function set systemTone(arg1:Boolean):void
        {
            if (arg1 != _systemTone) 
            {
                _systemTone = arg1;
                dispatchEvent(new flash.events.Event("systemToneChange"));
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

        public function get systemTone():Boolean
        {
            return _systemTone;
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

        public function set summerTime(arg1:Boolean):void
        {
            if (arg1 != _summerTime) 
            {
                _summerTime = arg1;
                dispatchEvent(new flash.events.Event("summerTimeChange"));
            }
            return;
        }

        public function get autoLapDistance():uint
        {
            return _autoLapDistance;
        }

        public function set autoLapDistance(arg1:uint):void
        {
            if (arg1 > autoLapDistanceMax) 
            {
                arg1 = autoLapDistanceMax;
            }
            if (arg1 < autoLapDistanceMin) 
            {
                arg1 = autoLapDistanceMin;
            }
            _autoLapDistance = arg1;
            return;
        }

        public function get autoLapDistanceMax():uint
        {
            var loc1:*=core.MeasurementConfig.distanceFormat;
            while ("kilometer" === loc1) 
            {
                return 99900000;
            }
        }

        public function get autoLapDistanceMin():uint
        {
            var loc1:*=core.MeasurementConfig.distanceFormat;
            while ("kilometer" === loc1) 
            {
                return 100000;
            }
        }

        public function get seaLevelMin():Number
        {
            return 900;
        }

        public function get autoPause():Boolean
        {
            return _autoPause;
        }

        public function set autoPause(arg1:Boolean):void
        {
            if (arg1 != _autoPause) 
            {
                _autoPause = arg1;
                dispatchEvent(new flash.events.Event("autoPauseChange"));
            }
            return;
        }

        public function get seaLevelMax():Number
        {
            return 1050;
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

        public function set seaLevel(arg1:Number):void
        {
            if (arg1 != _seaLevel) 
            {
                _seaLevel = arg1;
                dispatchEvent(new flash.events.Event("seaLevelChange"));
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

        public function get seaLevel():Number
        {
            return _seaLevel;
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

        public function set nfcActive(arg1:Boolean):void
        {
            _nfcActive = arg1;
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

        public function get homeAltitude1Max():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 5181295;
        }

        public function get homeAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -9990000;
            }
            return -304495;
        }

        public function get summerTime():Boolean
        {
            return _summerTime;
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
            return homeAltitude1Max;
        }

        public function get homeAltitude2Min():int
        {
            return homeAltitude1Min;
        }

        public function get nfcActive():Boolean
        {
            return _nfcActive;
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

        public function get myNameMaxLength():uint
        {
            return 9;
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

        public function set temperatureUnit(arg1:String):void
        {
            if (arg1 != _temperatureUnit) 
            {
                _temperatureUnit = arg1;
                dispatchEvent(new flash.events.Event("temperatureUnitChange"));
            }
            return;
        }

        public function get timeZone():int
        {
            return _timeZone;
        }

        public function set timeZone(arg1:int):void
        {
            if (arg1 != _timeZone) 
            {
                _timeZone = arg1;
                dispatchEvent(new flash.events.Event("timeZoneChange"));
            }
            return;
        }

        internal const _myNameMaxLength:uint=9;

        public static const ACT_ALTIFT_MAX:int=5181295;

        public static const ACT_ALTIFT_MIN:int=-304495;

        public static const ACT_ALTIM_MAX:int=4999000;

        public static const ACT_ALTIM_MIN:int=-999000;

        public static const CALORIES_MAX:int=99999;

        public static const CALORIES_MIN:int=0;

        public static const CONTRAST_MAX:int=3;

        public static const CONTRAST_MIN:int=1;

        public static const DISTANCE1_MAX_KM:int=99999000;

        public static const DISTANCE2_MAX_KM:int=99999000;

        public static const DISTANCE1_MAX_MI:Number=160932790.656;

        public static const DISTANCE2_MAX_MI:Number=160932790.656;

        public static const DISTANCE1_MIN:Number=0;

        public static const HOME_ALTITUDE_FT_MAX_IN_MM:int=5181295;

        public static const HOME_ALTITUDE_FT_MIN_IN_MM:int=-304495;

        public static const HOME_ALTITUDE_M_MAX_IN_MM:int=4999000;

        public static const HOME_ALTITUDE_M_MIN_IN_MM:int=-9990000;

        public static const SEA_LEVEL_MAX:int=1050;

        public static const SEA_LEVEL_MIN:int=900;

        public static const TOTALTIMEBIKE1_MAX:uint=3599999900;

        public static const TOTAL_ALTI_1_MAX_M:int=99999000;

        public static const TOTAL_ALTI_1_MIN:int=0;

        internal static const AUTOLAP_DISTANCE_MAX_KM:uint=99900000;

        internal static const AUTOLAP_DISTANCE_MAX_MILE:uint=99900000;

        internal static const AUTOLAP_DISTANCE_MIN_KM:uint=100000;

        internal static const AUTOLAP_DISTANCE_MIN_MILE:uint=100000;

        internal var _autoLapDistance:uint;

        internal var _systemTone:Boolean=false;

        internal var _altitudeUnit:String="meter";

        internal var _altitudeReference:String;

        internal var _temperatureUnit:String="";

        internal var _actualAltitude:int=250000;

        internal var _myName:String="Pure GPS";

        internal var _timeZone:int=104;

        internal var _nfcActive:Boolean=true;

        internal var _language:String="en";

        internal var _homeAltitude1:int=100;

        internal var _seaLevel:Number=1013;

        internal var _dateFormat:String="eu";

        internal var _contrast:int=2;

        internal var _clockMode:String="24";

        internal var _autoPause:Boolean=true;

        internal var _summerTime:Boolean=true;

        internal var _homeAltitude2:int=200;
    }
}


