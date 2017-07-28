//class SettingsROX70
package core.settings 
{
    import core.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX70 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IDate, core.settings.interfaces.IDistanceUnit, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IDateFormat, core.settings.interfaces.IClockMode, core.settings.interfaces.ILanguage, core.settings.interfaces.ITimeZone, core.settings.interfaces.ISummerTime, core.settings.interfaces.IMyName, core.settings.interfaces.IButtonTone, core.settings.interfaces.ISystemTone, core.settings.interfaces.IContrast, core.settings.interfaces.IBacklightTime, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IHomeAltitude3, core.settings.interfaces.IGPSFormat, core.settings.interfaces.IOffTrackAlarm, core.settings.interfaces.ITrackDirection, core.settings.interfaces.IWayPointAlarm, core.settings.interfaces.IAutoOffTime, core.settings.interfaces.IBacklightLevel, core.settings.interfaces.IGender
    {
        public function SettingsROX70(arg1:flash.events.IEventDispatcher=null)
        {
            _autoOffTime = core.general.AutoOffTimeUnit.FIVE_MINUTES;
            super(arg1);
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

        public function get systemTone():Boolean
        {
            return _systemTone;
        }

        public function get autoOffTime():core.general.AutoOffTimeUnit
        {
            return _autoOffTime;
        }

        public function set autoOffTime(arg1:core.general.AutoOffTimeUnit):void
        {
            _autoOffTime = arg1;
            return;
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

        public function get backlightLevel():uint
        {
            return _backlightLevel;
        }

        public function set backlightLevel(arg1:uint):void
        {
            _backlightLevel = arg1;
            return;
        }

        public function get backlightLevelMax():int
        {
            return 3;
        }

        public function get backlightLevelMin():int
        {
            return 1;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        public function get backlightTime():Number
        {
            return _backlightTime;
        }

        public function set backlightTime(arg1:Number):void
        {
            if (arg1 != _backlightTime) 
            {
                _backlightTime = arg1;
                dispatchEvent(new flash.events.Event("backlightTimeChange"));
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

        public function get timeZone():int
        {
            return _timeZone;
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

        public function set timeZone(arg1:int):void
        {
            if (arg1 != _timeZone) 
            {
                _timeZone = arg1;
                dispatchEvent(new flash.events.Event("timeZoneChange"));
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
            return 10;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get trackDirection():String
        {
            return _trackDirection;
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

        public function set trackDirection(arg1:String):void
        {
            _trackDirection = arg1;
            return;
        }

        public function get distanceUnit():String
        {
            return _distanceUnit;
        }

        public function set distanceUnit(arg1:String):void
        {
            if (arg1 != _distanceUnit) 
            {
                _distanceUnit = arg1;
                dispatchEvent(new flash.events.Event("distanceUnitChange"));
            }
            return;
        }

        public function get waypointAlarm():Number
        {
            return _waypointAlarm;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            _gender = arg1;
            return;
        }

        public function set waypointAlarm(arg1:Number):void
        {
            if (arg1 != _waypointAlarm) 
            {
                _waypointAlarm = arg1;
                dispatchEvent(new flash.events.Event("waypointAlarmChange"));
            }
            return;
        }

        public function get gpsFormat():String
        {
            return _gpsFormat;
        }

        public function set gpsFormat(arg1:String):void
        {
            if (arg1 != _gpsFormat) 
            {
                _gpsFormat = arg1;
                dispatchEvent(new flash.events.Event("gpsFormatChange"));
            }
            return;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-settingsROX100Id " + settingsROX70Id;
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

        public override function toString():String
        {
            return "[SettingsROX100 extends SettingsBikeComputer]";
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

        public function get homeAltitude3():int
        {
            return _homeAltitude3;
        }

        public function set homeAltitude3(arg1:int):void
        {
            if (arg1 != _homeAltitude3) 
            {
                _homeAltitude3 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude3Change"));
            }
            return;
        }

        public function get homeAltitude3Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude3Min():int
        {
            return homeAltitude1Min;
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
            return 12;
        }

        public function get offTrackAlarm():Number
        {
            return _offTrackAlarm;
        }

        public function set offTrackAlarm(arg1:Number):void
        {
            if (arg1 != _offTrackAlarm) 
            {
                _offTrackAlarm = arg1;
                dispatchEvent(new flash.events.Event("offTrackAlarmChange"));
            }
            return;
        }

        public function get settingsROX70Id():int
        {
            return _settingsROX70Id;
        }

        public function set settingsROX70Id(arg1:int):void
        {
            _settingsROX70Id = arg1;
            return;
        }

        public function get summerTime():Boolean
        {
            return _summerTime;
        }

        internal static const NOW:Date=new Date();

        internal const _myNameMaxLength:uint=12;

        public static const CONTRAST_MAX:int=10;

        public static const CONTRAST_MIN:int=1;

        public static const HOME_ALTITUDE_FT_MAX_IN_MM:int=5181295;

        public static const HOME_ALTITUDE_FT_MIN_IN_MM:int=-304495;

        public static const HOME_ALTITUDE_M_MAX_IN_MM:int=4999000;

        public static const HOME_ALTITUDE_M_MIN_IN_MM:int=-9990000;

        internal var _altitudeUnit:String="meter";

        internal var _autoOffTime:core.general.AutoOffTimeUnit;

        internal var _backlightLevel:uint=3;

        internal var _backlightTime:Number=1;

        internal var _buttonTone:Boolean=true;

        internal var _clockMode:String="24";

        internal var _contrast:int=6;

        internal var _dateFormat:String="eu";

        internal var _distanceUnit:String="kilometer";

        internal var _gender:String="male";

        internal var _gpsFormat:String="hddd°mm,mmm";

        internal var _homeAltitude1:int=100000;

        internal var _homeAltitude2:int=200000;

        internal var _myName:String="ROX 7.0 GPS";

        internal var _timeZone:int=104;

        internal var _summerTime:Boolean=true;

        internal var _offTrackAlarm:Number=2;

        internal var _trackDirection:String="drivingDirection";

        internal var _homeAltitude3:int=300000;

        internal var _systemTone:Boolean=true;

        internal var _language:String="en";

        internal var _settingsROX70Id:int;

        internal var _temperatureUnit:String="celsius";

        internal var _waypointAlarm:Number=2;
    }
}


