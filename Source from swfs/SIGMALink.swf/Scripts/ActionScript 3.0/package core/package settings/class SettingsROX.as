//class SettingsROX
package core.settings 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX extends core.settings.SettingsBikeComputer implements core.settings.interfaces.ILanguage, core.settings.interfaces.IThreeZones, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IGender, core.settings.interfaces.IDate, core.settings.interfaces.IFavoriteTrip1, core.settings.interfaces.IFavoriteTrip2, core.settings.interfaces.IBirthDate, core.settings.interfaces.IClockMode, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IHomeAltitude3, core.settings.interfaces.IHRmax, core.settings.interfaces.IVolume, core.settings.interfaces.IDateFormat, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.IButtonInfo, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IMyName, core.settings.interfaces.IShowTotals, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IContrast, core.settings.interfaces.IWheelSize1
    {
        public function SettingsROX(arg1:flash.events.IEventDispatcher=null, arg2:core.general.UnitType=null)
        {
            _birthDate = new Date(1981, 0, 1);
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>();
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>();
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>(10);
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>(10);
            if (core.general.UnitType.ROX90 != arg2) 
            {
                if (core.general.UnitType.ROX80 == arg2) 
                {
                    _myName = " ROX 8.0  ";
                    _favoritesTrip1[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                    _favoritesTrip1[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                    _favoritesTrip1[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                    _favoritesTrip1[3] = core.general.FavoritesROX2010.FAVORITES_GUI[3];
                    _favoritesTrip1[4] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                    _favoritesTrip1[5] = core.general.FavoritesROX2010.FAVORITES_GUI[16];
                    _favoritesTrip1[6] = core.general.FavoritesROX2010.FAVORITES_GUI[44];
                    _favoritesTrip1[7] = core.general.FavoritesROX2010.FAVORITES_GUI[43];
                    _favoritesTrip1[8] = core.general.FavoritesROX2010.FAVORITES_GUI[18];
                    _favoritesTrip1[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
                    _favoritesTrip2[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                    _favoritesTrip2[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                    _favoritesTrip2[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                    _favoritesTrip2[3] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                    _favoritesTrip2[4] = core.general.FavoritesROX2010.FAVORITES_GUI[22];
                    _favoritesTrip2[5] = core.general.FavoritesROX2010.FAVORITES_GUI[24];
                    _favoritesTrip2[6] = core.general.FavoritesROX2010.FAVORITES_GUI[27];
                    _favoritesTrip2[7] = core.general.FavoritesROX2010.FAVORITES_GUI[29];
                    _favoritesTrip2[8] = core.general.FavoritesROX2010.FAVORITES_GUI[23];
                    _favoritesTrip2[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
                }
            }
            else 
            {
                _myName = " ROX 9.0  ";
                _favoritesTrip1[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                _favoritesTrip1[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                _favoritesTrip1[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                _favoritesTrip1[3] = core.general.FavoritesROX2010.FAVORITES_GUI[3];
                _favoritesTrip1[4] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                _favoritesTrip1[5] = core.general.FavoritesROX2010.FAVORITES_GUI[16];
                _favoritesTrip1[6] = core.general.FavoritesROX2010.FAVORITES_GUI[44];
                _favoritesTrip1[7] = core.general.FavoritesROX2010.FAVORITES_GUI[43];
                _favoritesTrip1[8] = core.general.FavoritesROX2010.FAVORITES_GUI[18];
                _favoritesTrip1[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
                _favoritesTrip2[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                _favoritesTrip2[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                _favoritesTrip2[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                _favoritesTrip2[3] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                _favoritesTrip2[4] = core.general.FavoritesROX2010.FAVORITES_GUI[22];
                _favoritesTrip2[5] = core.general.FavoritesROX2010.FAVORITES_GUI[24];
                _favoritesTrip2[6] = core.general.FavoritesROX2010.FAVORITES_GUI[27];
                _favoritesTrip2[7] = core.general.FavoritesROX2010.FAVORITES_GUI[29];
                _favoritesTrip2[8] = core.general.FavoritesROX2010.FAVORITES_GUI[23];
                _favoritesTrip2[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
            }
            return;
        }

        public function get startZone1():int
        {
            return _startZone1;
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
            return 199000;
        }

        public function get bodyWeightMin():int
        {
            return 20000;
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

        public function set startZone1(arg1:int):void
        {
            if (arg1 != _startZone1) 
            {
                _startZone1 = arg1;
                dispatchEvent(new flash.events.Event("startZone1Change"));
            }
            return;
        }

        public function get buttonInfo():Boolean
        {
            return _buttonInfo;
        }

        public function set buttonInfo(arg1:Boolean):void
        {
            if (arg1 != _buttonInfo) 
            {
                _buttonInfo = arg1;
                dispatchEvent(new flash.events.Event("buttonInfoChange"));
            }
            return;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
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

        public function get startZone2():int
        {
            return _startZone2;
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
            return 15;
        }

        public function get contrastMin():int
        {
            return 0;
        }

        public function set startZone2(arg1:int):void
        {
            if (arg1 != _startZone2) 
            {
                _startZone2 = arg1;
                dispatchEvent(new flash.events.Event("startZone2Change"));
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

        public function get wheelSize2Min():int
        {
            return 1000;
        }

        public function get endZone3():int
        {
            return _endZone3;
        }

        public function set endZone3(arg1:int):void
        {
            if (arg1 != _endZone3) 
            {
                _endZone3 = arg1;
                dispatchEvent(new flash.events.Event("endZone3Change"));
            }
            return;
        }

        public function get startZone3():int
        {
            return _startZone3;
        }

        public function get favoritesTrip1():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip1;
        }

        public function set favoritesTrip1(arg1:__AS3__.vec.Vector.<String>):void
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
            return 10;
        }

        public function set startZone3(arg1:int):void
        {
            if (arg1 != _startZone3) 
            {
                _startZone3 = arg1;
                dispatchEvent(new flash.events.Event("startZone3Change"));
            }
            return;
        }

        public function get favoritesTrip2():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip2;
        }

        public function set favoritesTrip2(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip2 !== arg1) 
            {
                _favoritesTrip2 = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrip2Change"));
            }
            return;
        }

        public function get favoritesTrip2Size():int
        {
            return 10;
        }

        public override function toString():String
        {
            return "[SettingsROX extends SettingsBikeComputer implements ILanguage, IThreeZones, IWheelSize2, IWeight, IGender, IDate, IFavorite1, IFavorite2,...]";
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

        public function get volume():int
        {
            return _volume;
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
            return 4999000;
        }

        public function get homeAltitude1Min():int
        {
            return -999000;
        }

        public function set volume(arg1:int):void
        {
            if (arg1 != _volume) 
            {
                _volume = arg1;
                dispatchEvent(new flash.events.Event("volumeChange"));
            }
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
            return homeAltitude1Max;
        }

        public function get homeAltitude2Min():int
        {
            return homeAltitude1Min;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
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

        public function get wheelSize1():int
        {
            return _wheelSize1;
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

        public function set wheelSize1(arg1:int):void
        {
            if (_wheelSize1 !== arg1) 
            {
                _wheelSize1 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize1Change"));
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

        public function get wheelSize1Max():int
        {
            return 3999;
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

        public function get wheelSize1Min():int
        {
            return 1000;
        }

        public function get myName():String
        {
            if ("") 
            {
                if (core.general.UnitType.ROX8 == unitType || core.general.UnitType.ROX80 == unitType) 
                {
                    return " ROX 8.0  ";
                }
                if (core.general.UnitType.ROX9 == unitType || core.general.UnitType.ROX90 == unitType) 
                {
                    return " ROX 9.0  ";
                }
            }
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

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get myNameMaxLength():uint
        {
            return 10;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get showTotals():int
        {
            return _showTotals;
        }

        public function set showTotals(arg1:int):void
        {
            if (arg1 != _showTotals) 
            {
                _showTotals = arg1;
                dispatchEvent(new flash.events.Event("showTotalsChange"));
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

        public static const TOTALTIMEUPBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEUPBIKE2_SECONDS_MIN:int=0;

        public static const TOTALTRIPDISTDOWNBIKE1_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTDOWNBIKE1_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTDOWNBIKE1_MIN:int=0;

        public static const TOTALTRIPDISTDOWNBIKE2_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTDOWNBIKE2_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTDOWNBIKE2_MIN:int=0;

        public static const TOTALTRIPDISTUPBIKE1_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTUPBIKE1_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTUPBIKE1_MIN:int=0;

        public static const TOTALTRIPDISTUPBIKE2_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTUPBIKE2_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTUPBIKE2_MIN:int=0;

        public static const VOLUME_MAX:int=5;

        public static const VOLUME_MIN:int=1;

        internal const _myNameMaxLength:uint=10;

        public static const WEIGHTLB_MAX:int=399;

        public static const WEIGHTLB_MIN:int=40;

        public static const WEIGHT_G_MAX:int=199000;

        public static const WEIGHT_G_MIN:int=20000;

        public static const WHEEL_SBIKE1_MAX:int=3999;

        public static const WHEEL_SBIKE1_MIN:int=1000;

        internal static const FAVORIT_TRIP_SIZE:int=10;

        internal static const NOW:Date=new Date();

        internal static const WHEEL_SBIKE2_MAX:int=3999;

        internal static const WHEEL_SBIKE2_MIN:int=1000;

        public static const CHECKSUM3_MAX:int=65535;

        public static const CHECKSUM3_MIN:int=0;

        public static const CLOCK_MAX:int=86399;

        public static const CLOCK_MIN:int=0;

        public static const CONTRAST_MAX:int=15;

        public static const CONTRAST_MIN:int=0;

        public static const DATE_MAX:Date=new Date(2099, 11, 31);

        public static const DATE_MIN:Date=new Date(2006, 0, 1);

        public static const ENDPOWERZONE_MAX:int=240;

        public static const ENDPOWERZONE_MIN:int=40;

        public static const HOME_ALTITUDE_FT_MAX:Number=3.0479999997e+012;

        public static const HOME_ALTITUDE_FT_MIN:int=-304496;

        public static const HOME_ALTITUDE_M_MAX:int=4999000;

        public static const HOME_ALTITUDE_M_MIN:int=-999000;

        public static const MAXALTITUEBIKE1_FT_MAX:int=3047696;

        public static const MAXALTITUEBIKE1_FT_MIN:int=-304496;

        public static const MAXALTITUEBIKE1_M_MAX:int=4999000;

        public static const MAXALTITUEBIKE1_M_MIN:int=-999000;

        public static const MAXALTITUEBIKE2_FT_MAX:int=3047696;

        public static const MAXALTITUEBIKE2_FT_MIN:int=-304496;

        public static const MAXALTITUEBIKE2_M_MAX:int=4999000;

        public static const MAXALTITUEBIKE2_M_MIN:int=-999000;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        public static const STARTFITNESSZONE_MAX:int=240;

        public static const STARTFITNESSZONE_MIN:int=40;

        public static const STARTHEALTHZONE_MAX:int=240;

        public static const STARTHEALTHZONE_MIN:int=40;

        public static const STARTPOWERZONE_MAX:int=240;

        public static const STARTPOWERZONE_MIN:int=40;

        public static const TOTALCLIMBMETERBIKE1_MAX_FT:int=304799969;

        public static const TOTALCLIMBMETERBIKE1_MAX_M:int=999999000;

        public static const TOTALCLIMBMETERBIKE1_MIN:int=0;

        public static const TOTALCLIMBMETERBIKE2_MAX_FT:int=304799969;

        public static const TOTALCLIMBMETERBIKE2_MAX_M:int=999999000;

        public static const TOTALCLIMBMETERBIKE2_MIN:int=0;

        public static const TOTALDBIKE1_MAX_KM:Number=99999000;

        public static const TOTALDBIKE1_MAX_MI:Number=160932790.656;

        public static const TOTALDBIKE1_MIN:int=0;

        public static const TOTALDBIKE2_MAX_KM:Number=99999000;

        public static const TOTALDBIKE2_MAX_MI:Number=160932790.656;

        public static const TOTALDBIKE2_MIN:int=0;

        public static const TOTALDESCENTBIKE1_MAX_FT:int=304799969;

        public static const TOTALDESCENTBIKE1_MAX_M:int=999999000;

        public static const TOTALDESCENTBIKE1_MIN:int=0;

        public static const TOTALDESCENTBIKE2_MAX_FT:int=304799969;

        public static const TOTALDESCENTBIKE2_MAX_M:int=999999000;

        public static const TOTALDESCENTBIKE2_MIN:int=0;

        public static const TOTALKCALBIKE1_MAX:int=999999;

        public static const TOTALKCALBIKE1_MIN:int=0;

        public static const TOTALKCALBIKE2_MAX:int=999999;

        public static const TOTALKCALBIKE2_MIN:int=0;

        public static const TOTALTIMEBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE2_SECONDS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEDOWNBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEDOWNBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEDOWNBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE2_MAX:uint=3599999900;

        public static const TOTALTIMEDOWNBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE2_SECONDS_MIN:int=0;

        public static const TOTALTIMEUPBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEUPBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEUPBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEUPBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEUPBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEUPBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEUPBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEUPBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEUPBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEUPBIKE2_MAX:uint=3599999900;

        public static const TOTALTIMEUPBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEUPBIKE2_MINUTES_MIN:int=0;

        internal var _birthDate:Date;

        internal var _buttonInfo:Boolean=false;

        internal var _clockMode:String="24";

        internal var _contrast:int=10;

        internal var _dateFormat:String="eu";

        internal var _endZone3:int=194;

        internal var _favoritesTrip1:__AS3__.vec.Vector.<String>;

        internal var _favoritesTrip2:__AS3__.vec.Vector.<String>;

        internal var _gender:String="male";

        internal var _homeAltitude1:int=100000;

        internal var _homeAltitude2:int=200000;

        internal var _homeAltitude3:int=300000;

        internal var _hrMax:int=194;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String;

        internal var _myName:String="";

        internal var _showTotals:int;

        internal var _startZone1:int=107;

        internal var _startZone2:int=136;

        internal var _startZone3:int=155;

        internal var _volume:int=3;

        internal var _wheelSize1:int=2155;

        internal var _wheelSize2:int=2000;

        internal var _zoneAlarm:Boolean=true;

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";
    }
}


