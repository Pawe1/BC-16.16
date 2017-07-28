//class SettingsROX100
package core.settings 
{
    import __AS3__.vec.*;
    import core.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX100 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IDate, core.settings.interfaces.IDistanceUnit, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IWeightUnit, core.settings.interfaces.IDateFormat, core.settings.interfaces.IClockMode, core.settings.interfaces.ILanguage, core.settings.interfaces.ISamplingRate, core.settings.interfaces.ITimeZone, core.settings.interfaces.ISummerTime, core.settings.interfaces.ICountdown, core.settings.interfaces.IMyName, core.settings.interfaces.IAutoPause, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.IButtonTone, core.settings.interfaces.ISystemTone, core.settings.interfaces.IContrast, core.settings.interfaces.IBacklightTime, core.settings.interfaces.IPowerMeterFormula, core.settings.interfaces.IBikeType1, core.settings.interfaces.IBikeType2, core.settings.interfaces.IBikeType3, core.settings.interfaces.IBikeWeight1, core.settings.interfaces.IBikeWeight2, core.settings.interfaces.IBikeWeight3, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IWheelSize3, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IHomeAltitude3, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IGender, core.settings.interfaces.IBirthDate, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IBodyHeight, core.settings.interfaces.IBodyHeightUnit, core.settings.interfaces.IShoulderWidth, core.settings.interfaces.IShoulderWidthUnit, core.settings.interfaces.IHRmax, core.units.interfaces.IIntensityZonesPercentage, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IHeartrateLimits, core.settings.interfaces.IPowerTargetZone, core.settings.interfaces.IGPSStatus, core.settings.interfaces.IGPSFormat, core.settings.interfaces.IOffTrackAlarm, core.settings.interfaces.IWayPointAlarm, core.settings.interfaces.IAutoZoomTrack, core.settings.interfaces.IFavoriteTrip1, core.settings.interfaces.IFavoriteTrip2, core.settings.interfaces.IFavoritesTrack, core.settings.interfaces.IFavoritesAltitude, core.settings.interfaces.IFavoritesLap, core.settings.interfaces.IFavoritesCustom, core.settings.interfaces.IPowerIntensityZone, core.settings.interfaces.IAutoOffTime, core.settings.interfaces.IWheelSize1
    {
        public function SettingsROX100(arg1:flash.events.IEventDispatcher=null)
        {
            _autoOffTime = core.general.AutoOffTimeUnit.FIVE_MINUTES;
            _birthDate = new Date(1983, 0, 1);
            _favoritesAltitude = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            _favoritesLap = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            _favoritesTrack = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>(10);
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>(10);
            super(arg1);
            favoritesTrack = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            favoritesTrack.splice(0, 2);
            favoritesTrack[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesTrack[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesTrack[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            favoritesAltitude.splice(0, 2);
            favoritesAltitude[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesAltitude[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesAltitude[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            favoritesLap.splice(0, 2);
            favoritesLap[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesLap[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesLap[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesTrack[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[0][0][0] = "1";
            _favoritesTrack[0][0][1] = "4";
            _favoritesTrack[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[0][1][0] = "54";
            _favoritesTrack[0][1][1] = "55";
            _favoritesTrack[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[0][2][0] = "52";
            _favoritesTrack[0][2][1] = "56";
            _favoritesTrack[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesTrack[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[1][0][0] = "1";
            _favoritesTrack[1][0][1] = "4";
            _favoritesTrack[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[1][1][0] = "10";
            _favoritesTrack[1][1][1] = "21";
            _favoritesTrack[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[1][2][0] = "52";
            _favoritesTrack[1][2][1] = "56";
            _favoritesAltitude[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesAltitude[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[0][0][0] = "1";
            _favoritesAltitude[0][0][1] = "4";
            _favoritesAltitude[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[0][1][0] = "32";
            _favoritesAltitude[0][1][1] = "31";
            _favoritesAltitude[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[0][2][0] = "52";
            _favoritesAltitude[0][2][1] = "36";
            _favoritesAltitude[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesAltitude[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[1][0][0] = "1";
            _favoritesAltitude[1][0][1] = "4";
            _favoritesAltitude[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[1][1][0] = "32";
            _favoritesAltitude[1][1][1] = "33";
            _favoritesAltitude[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[1][2][0] = "52";
            _favoritesAltitude[1][2][1] = "35";
            _favoritesLap[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesLap[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[0][0][0] = "2";
            _favoritesLap[0][0][1] = "1";
            _favoritesLap[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[0][1][0] = "8";
            _favoritesLap[0][1][1] = "0";
            _favoritesLap[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[0][2][0] = "4";
            _favoritesLap[0][2][1] = "6";
            _favoritesLap[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesLap[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[1][0][0] = "8";
            _favoritesLap[1][0][1] = "13";
            _favoritesLap[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[1][1][0] = "2";
            _favoritesLap[1][1][1] = "0";
            _favoritesLap[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[1][2][0] = "4";
            _favoritesLap[1][2][1] = "6";
            _favoritesTrip1[0] = "4";
            _favoritesTrip1[1] = "19";
            _favoritesTrip1[2] = "2";
            _favoritesTrip1[3] = "3";
            _favoritesTrip1[4] = "46";
            _favoritesTrip1[5] = "41";
            _favoritesTrip1[6] = "39";
            _favoritesTrip1[7] = "38";
            _favoritesTrip1[8] = "32";
            _favoritesTrip1[9] = "18";
            _favoritesTrip2[0] = "4";
            _favoritesTrip2[1] = "19";
            _favoritesTrip2[2] = "58";
            _favoritesTrip2[3] = "2";
            _favoritesTrip2[4] = "24";
            _favoritesTrip2[5] = "11";
            _favoritesTrip2[6] = "17";
            _favoritesTrip2[7] = "39";
            _favoritesTrip2[8] = "32";
            _favoritesTrip2[9] = "18";
            _favoritesCustom = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>();
            _favoritesCustom[0] = new __AS3__.vec.Vector.<String>(6, true);
            _favoritesCustom[0][0] = "1";
            _favoritesCustom[0][1] = "4";
            _favoritesCustom[0][2] = "7";
            _favoritesCustom[0][3] = "24";
            _favoritesCustom[0][4] = "10";
            _favoritesCustom[0][5] = "36";
            _favoritesCustom[1] = new __AS3__.vec.Vector.<String>(6, true);
            _favoritesCustom[1][0] = "1";
            _favoritesCustom[1][1] = "4";
            _favoritesCustom[1][2] = "7";
            _favoritesCustom[1][3] = "24";
            _favoritesCustom[1][4] = "10";
            _favoritesCustom[1][5] = "36";
            _customFavoritesPageCount = new __AS3__.vec.Vector.<int>(2, true);
            _customFavoritesPageCount[0] = 6;
            _customFavoritesPageCount[1] = 6;
            return;
        }

        public function get shoulderWidthMin():Number
        {
            if (distanceUnit == "kilometer") 
            {
                return 40;
            }
            return 38;
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

        public function get shoulderWidthUnit():String
        {
            return _shoulderWidthUnit;
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

        public function set shoulderWidthUnit(arg1:String):void
        {
            if (arg1 != _shoulderWidthUnit) 
            {
                if (_weightUnit) 
                {
                    _shoulderWidthUnit = convertWheightUnitToBodySizeUnit();
                }
                else 
                {
                    _shoulderWidthUnit = arg1;
                }
                dispatchEvent(new flash.events.Event("shoulderWidthUnitChange"));
            }
            return;
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

        public function get summerTime():Boolean
        {
            return _summerTime;
        }

        public function get autoZoomTrack():Boolean
        {
            return _autoZoomTrack;
        }

        public function set autoZoomTrack(arg1:Boolean):void
        {
            if (arg1 != _autoZoomTrack) 
            {
                _autoZoomTrack = arg1;
                dispatchEvent(new flash.events.Event("autoZoomTrackChange"));
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

        public function get systemTone():Boolean
        {
            return _systemTone;
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

        public function set systemTone(arg1:Boolean):void
        {
            if (arg1 != _systemTone) 
            {
                _systemTone = arg1;
                dispatchEvent(new flash.events.Event("systemToneChange"));
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

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        public function get bikeType3():String
        {
            return _bikeType3;
        }

        public function set bikeType3(arg1:String):void
        {
            if (arg1 != _bikeType3) 
            {
                _bikeType3 = arg1;
                dispatchEvent(new flash.events.Event("bikeType3Change"));
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

        public function get timeZone():int
        {
            return _timeZone;
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

        public function set timeZone(arg1:int):void
        {
            if (arg1 != _timeZone) 
            {
                _timeZone = arg1;
                dispatchEvent(new flash.events.Event("timeZoneChange"));
            }
            return;
        }

        public function get bikeWeight3():Number
        {
            return _bikeWeight3;
        }

        public function set bikeWeight3(arg1:Number):void
        {
            if (arg1 != _bikeWeight3) 
            {
                _bikeWeight3 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight3Change"));
            }
            return;
        }

        public function get bikeWeight3Max():int
        {
            return bikeWeight1Max;
        }

        public function get bikeWeight3Min():int
        {
            return bikeWeight1Min;
        }

        public function get trainingZone():String
        {
            return _trainingZone;
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

        public function set trainingZone(arg1:String):void
        {
            if (arg1 != _trainingZone) 
            {
                _trainingZone = arg1;
                dispatchEvent(new flash.events.Event("trainingZoneChange"));
            }
            return;
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
            if (bodyWeightUnit == "kg") 
            {
                return 250;
            }
            return 254;
        }

        public function get bodyHeightMin():Number
        {
            if (bodyWeightUnit == "kg") 
            {
                return 100;
            }
            return 102;
        }

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        public function get bodyHeightUnit():String
        {
            return _bodyHeightUnit;
        }

        public function set bodyHeightUnit(arg1:String):void
        {
            if (arg1 != _bodyHeightUnit) 
            {
                if (_weightUnit) 
                {
                    _bodyHeightUnit = convertWheightUnitToBodySizeUnit();
                }
                else 
                {
                    _bodyHeightUnit = arg1;
                }
                dispatchEvent(new flash.events.Event("bodyHeightUnitChange"));
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

        public function get bodyWeightMax():int
        {
            if (bodyWeightUnit == "kg") 
            {
                return 200000;
            }
            return 181437;
        }

        public function get bodyWeightMin():int
        {
            if (bodyWeightUnit == "kg") 
            {
                return 20000;
            }
            return 18144;
        }

        public function get bodyWeightUnit():String
        {
            return weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            weightUnit = arg1;
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
            return 4;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get waypointAlarm():Number
        {
            return _waypointAlarm;
        }

        public function get countdown():Number
        {
            return _countdown;
        }

        public function set countdown(arg1:Number):void
        {
            if (arg1 != _countdown) 
            {
                _countdown = arg1;
                dispatchEvent(new flash.events.Event("countdownChange"));
            }
            return;
        }

        public function get countdownMax():Number
        {
            return 3599999;
        }

        public function get countdownMin():Number
        {
            return 0;
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

        public function get countdownOn():Boolean
        {
            return _countdownOn;
        }

        public function set countdownOn(arg1:Boolean):void
        {
            if (arg1 != _countdownOn) 
            {
                _countdownOn = arg1;
                dispatchEvent(new flash.events.Event("countdownOnChange"));
            }
            return;
        }

        public function get weightUnit():String
        {
            return _weightUnit;
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

        public function set weightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                shoulderWidthUnit = "..will be calced";
                bodyHeightUnit = "..will be calced, too";
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
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

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public final function get favoritesAltitude():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>
        {
            return _favoritesAltitude;
        }

        public final function set favoritesAltitude(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void
        {
            if (_favoritesAltitude !== arg1) 
            {
                _favoritesAltitude = arg1;
                dispatchEvent(new flash.events.Event("favoritesAltitudeChange"));
            }
            return;
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

        public function get favoritesCustom():__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>
        {
            return _favoritesCustom;
        }

        public function set favoritesCustom(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>):void
        {
            _favoritesCustom = arg1;
            return;
        }

        public function get favoritesCustomPageCount():__AS3__.vec.Vector.<int>
        {
            return _customFavoritesPageCount;
        }

        public function set favoritesCustomPageCount(arg1:__AS3__.vec.Vector.<int>):void
        {
            _customFavoritesPageCount = arg1;
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public final function get favoritesLap():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>
        {
            return _favoritesLap;
        }

        public final function set favoritesLap(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void
        {
            if (_favoritesLap !== arg1) 
            {
                _favoritesLap = arg1;
                dispatchEvent(new flash.events.Event("favoritesLapChange"));
            }
            return;
        }

        public function get wheelSize1Min():int
        {
            return 500;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public final function get favoritesTrack():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>
        {
            return _favoritesTrack;
        }

        public final function set favoritesTrack(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void
        {
            if (_favoritesTrack !== arg1) 
            {
                _favoritesTrack = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrackChange"));
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

        public final function get favoritesTrip1():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip1;
        }

        public final function set favoritesTrip1(arg1:__AS3__.vec.Vector.<String>):void
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

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public final function get favoritesTrip2():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip2;
        }

        public final function set favoritesTrip2(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip2 !== arg1) 
            {
                _favoritesTrip2 = arg1;
                dispatchEvent(new flash.events.Event("favorites2Change"));
            }
            return;
        }

        public function get favoritesTrip2Size():int
        {
            return 10;
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

        public function get wheelSize3():int
        {
            return _wheelSize3;
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

        public function set wheelSize3(arg1:int):void
        {
            if (arg1 != _wheelSize3) 
            {
                _wheelSize3 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize3Change"));
            }
            return;
        }

        public function get gpsStatus():Boolean
        {
            return _gpsStatus;
        }

        public function set gpsStatus(arg1:Boolean):void
        {
            if (arg1 != _gpsStatus) 
            {
                _gpsStatus = arg1;
                dispatchEvent(new flash.events.Event("gpsStatusChange"));
            }
            return;
        }

        public function get wheelSize3Max():int
        {
            return 3999;
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

        public function get wheelSize3Min():int
        {
            return 500;
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

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
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

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-settingsROX100Id " + settingsROX100Id;
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
            return "[SettingsROX100 extends SettingsBikeComputer]";
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
            return 30;
        }

        internal function convertWheightUnitToBodySizeUnit():String
        {
            if (_weightUnit == "lb") 
            {
                return "inch";
            }
            return "centimeter";
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

        public function get powerIntensityZone1Start():int
        {
            return _powerZone1Start;
        }

        public function set powerIntensityZone1Start(arg1:int):void
        {
            _powerZone1Start = arg1;
            return;
        }

        public function get powerIntensityZone2Start():int
        {
            return _powerZone2Start;
        }

        public function set powerIntensityZone2Start(arg1:int):void
        {
            _powerZone2Start = arg1;
            return;
        }

        public function get powerIntensityZone3Start():int
        {
            return _powerZone3Start;
        }

        public function set powerIntensityZone3Start(arg1:int):void
        {
            _powerZone3Start = arg1;
            return;
        }

        public function get powerIntensityZone4Start():int
        {
            return _powerZone4Start;
        }

        public function set powerIntensityZone4Start(arg1:int):void
        {
            _powerZone4Start = arg1;
            return;
        }

        public function get powerIntensityZone5Start():int
        {
            return _powerZone5Start;
        }

        public function set powerIntensityZone5Start(arg1:int):void
        {
            _powerZone5Start = arg1;
            return;
        }

        public function get powerIntensityZone6Start():int
        {
            return _powerZone6Start;
        }

        public function set powerIntensityZone6Start(arg1:int):void
        {
            _powerZone6Start = arg1;
            return;
        }

        public function get powerIntensityZone7End():int
        {
            return _powerZone7End;
        }

        public function set powerIntensityZone7End(arg1:int):void
        {
            _powerZone7End = arg1;
            return;
        }

        public function get powerIntensityZone7Start():int
        {
            return _powerZone7Start;
        }

        public function set powerIntensityZone7Start(arg1:int):void
        {
            _powerZone7Start = arg1;
            return;
        }

        public function get powerMeterFormula():int
        {
            return _powerMeterFormula;
        }

        public function set powerMeterFormula(arg1:int):void
        {
            if (_powerMeterFormula !== arg1) 
            {
                _powerMeterFormula = arg1;
                dispatchEvent(new flash.events.Event("powerMeterFormulaChange"));
            }
            return;
        }

        public function get powerTargetZoneEnabled():Boolean
        {
            return _powerTargetZoneEnabled;
        }

        public function set powerTargetZoneEnabled(arg1:Boolean):void
        {
            if (arg1 != _powerTargetZoneEnabled) 
            {
                _powerTargetZoneEnabled = arg1;
                dispatchEvent(new flash.events.Event("powerTargetZoneEnabledChange"));
            }
            return;
        }

        public function get powerTargetZoneLowerLimit():int
        {
            return _powerTargetZoneLowerLimit;
        }

        public function set powerTargetZoneLowerLimit(arg1:int):void
        {
            if (arg1 != _powerTargetZoneLowerLimit) 
            {
                _powerTargetZoneLowerLimit = arg1;
                dispatchEvent(new flash.events.Event("powerTargetZoneLowerLimitChange"));
            }
            return;
        }

        public function get powerTargetZoneLowerLimitMax():int
        {
            return (2000 - 1);
        }

        public function get powerTargetZoneLowerLimitMin():int
        {
            return 0;
        }

        public function get powerTargetZoneUpperLimit():int
        {
            return _powerTargetZoneUpperLimit;
        }

        public function set powerTargetZoneUpperLimit(arg1:int):void
        {
            if (arg1 != _powerTargetZoneUpperLimit) 
            {
                _powerTargetZoneUpperLimit = arg1;
                dispatchEvent(new flash.events.Event("powerTargetZoneUpperLimitChange"));
            }
            return;
        }

        public function get powerTargetZoneUpperLimitMax():int
        {
            return 2000;
        }

        public function get powerTargetZoneUpperLimitMin():int
        {
            return 0 + 1;
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

        public function get settingsROX100Id():int
        {
            return _settingsROX100Id;
        }

        public function set settingsROX100Id(arg1:int):void
        {
            _settingsROX100Id = arg1;
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
            if (distanceUnit == "kilometer") 
            {
                return 80;
            }
            return 76;
        }

        public static const WEIGHTBIKE_KG_MIN_IN_G:int=1000;

        internal static const WHEEL_SBIKE3_MIN:int=500;

        internal const _myNameMaxLength:uint=12;

        public static const CONTRAST_MAX:int=4;

        public static const CONTRAST_MIN:int=1;

        public static const HOME_ALTITUDE_FT_MAX_IN_MM:int=5181295;

        public static const HOME_ALTITUDE_FT_MIN_IN_MM:int=-304495;

        public static const HOME_ALTITUDE_M_MAX_IN_MM:int=4999000;

        public static const HOME_ALTITUDE_M_MIN_IN_MM:int=-9990000;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        public static const POWER_TARGET_ZONE_MAX:int=2000;

        public static const POWER_TARGET_ZONE_MIN:int=0;

        public static const SEA_LEVEL_MAX:int=1050;

        public static const SEA_LEVEL_MIN:int=900;

        public static const SHOULDERWIDTH_CM_MAX:int=80;

        public static const SHOULDERWIDTH_CM_MIN:int=40;

        public static const SHOULDERWIDTH_INCH_MAX_IN_CM:int=76;

        public static const SHOULDERWIDTH_INCH_MIN_IN_CM:int=38;

        public static const USERSIZE_CM_MAX:int=250;

        public static const USERSIZE_CM_MIN:int=100;

        public static const USERSIZE_INCH_MAX_IN_CM:int=254;

        public static const USERSIZE_INCH_MIN_IN_CM:int=102;

        public static const WEIGHTBIKE_KG_MAX_IN_G:int=50000;

        public static const WEIGHTBIKE_LB_MAX_IN_G:int=45359;

        public static const WEIGHTBIKE_LB_MIN_IN_G:int=1361;

        public static const WEIGHT_KG_MAX_IN_G:int=200000;

        public static const WEIGHT_KG_MIN_IN_G:int=20000;

        public static const WEIGHT_LB_MAX_IN_G:int=181437;

        public static const WEIGHT_LB_MIN_IN_G:int=18144;

        public static const WHEEL_SBIKE1_MAX:int=3999;

        public static const WHEEL_SBIKE1_MIN:int=500;

        internal static const FAVORIT_TRIP_SIZE:int=10;

        internal static const NOW:Date=new Date();

        internal static const WHEEL_SBIKE2_MAX:int=3999;

        internal static const WHEEL_SBIKE2_MIN:int=500;

        internal static const WHEEL_SBIKE3_MAX:int=3999;

        internal var _myName:String="ROX 10.0";

        internal var _shoulderWidth:Number=44;

        internal var _temperatureUnit:String="";

        internal var _wheelSize1:int=2155;

        internal var _powerTargetZoneUpperLimit:int=250;

        internal var _seaLevel:Number=1013;

        internal var _timeZone:int=0;

        internal var _powerTargetZoneLowerLimit:int=150;

        internal var _wheelSize2:int=2155;

        internal var _offTrackAlarm:Number=2;

        internal var _trainingZone:String="fitZone";

        internal var _shoulderWidthUnit:String="centimeter";

        internal var _powerTargetZoneEnabled:Boolean=false;

        internal var _wheelSize3:int=2155;

        internal var _upperLimit:int=152;

        internal var _powerMeterFormula:int=1;

        internal var _summerTime:Boolean=false;

        internal var _settingsROX100Id:int;

        internal var _zoneAlarm:Boolean=true;

        internal var _buttonTone:Boolean=true;

        internal var _waypointAlarm:Number=2;

        internal var _customFavoritesPageCount:__AS3__.vec.Vector.<int>;

        internal var _intensityZone1:Number=60;

        internal var _intensityZone2:Number=70;

        internal var _intensityZone3:Number=80;

        internal var _intensityZone4:Number=90;

        internal var _intensityZone4End:Number=100;

        internal var _powerZone1Start:int=0;

        internal var _powerZone2Start:int=141;

        internal var _powerZone3Start:int=191;

        internal var _powerZone4Start:int=231;

        internal var _powerZone5Start:int=261;

        internal var _powerZone6Start:int=301;

        internal var _powerZone7End:int=2000;

        internal var _powerZone7Start:int=367;

        internal var _altitudeUnit:String="meter";

        internal var _systemTone:Boolean=false;

        internal var _autoOffTime:core.general.AutoOffTimeUnit;

        internal var _weightUnit:String="kg";

        internal var _autoPause:Boolean=true;

        internal var _autoZoomTrack:Boolean=false;

        internal var _backlightTime:Number=1;

        internal var _bikeType1:String="raceDrop";

        internal var _bikeType2:String="raceDrop";

        internal var _bikeType3:String="raceDrop";

        internal var _bikeWeight1:int=8000;

        internal var _bikeWeight2:int=8000;

        internal var _bikeWeight3:Number=8000;

        internal var _birthDate:Date;

        internal var _bodyHeight:Number=180;

        internal var _bodyHeightUnit:String="centimeter";

        internal var _clockMode:String="24";

        internal var _contrast:int=2;

        internal var _countdown:Number=0;

        internal var _countdownOn:Boolean=false;

        internal var _dateFormat:String="eu";

        internal var _distanceUnit:String="kilometer";

        internal var _favoritesAltitude:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        internal var _favoritesCustom:__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>;

        internal var _favoritesLap:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        internal var _samplingRate:Number=0;

        public var favoritesSelected:int=0;

        internal var _favoritesTrack:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        internal var _favoritesTrip1:__AS3__.vec.Vector.<String>;

        internal var _favoritesTrip2:__AS3__.vec.Vector.<String>;

        internal var _gender:String="male";

        internal var _gpsFormat:String="0";

        internal var _gpsStatus:Boolean=true;

        internal var _homeAltitude1:int=100;

        internal var _homeAltitude2:int=200;

        internal var _homeAltitude3:int=300;

        internal var _hrMax:int=191;

        internal var _language:String="en";

        internal var _lowerLimit:int=133;

        internal var _weight:int=70000;
    }
}


