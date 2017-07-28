//class SportProfileROX110
package core.sportprofiles 
{
    import core.settings.interfaces.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SportProfileROX110 extends core.sportprofiles.SportProfileROX70 implements core.settings.interfaces.ILapFavSets, core.settings.interfaces.IAutoLapFavSets, core.settings.interfaces.IGPSStatus, core.settings.interfaces.IAlarmDistance, core.settings.interfaces.IAlarmTime, core.settings.interfaces.IAlarmCalories, core.settings.interfaces.IWheelSize1, core.settings.interfaces.IBikeWeight1, core.settings.interfaces.IBikeType1, core.settings.interfaces.IAvgCadInclZero, core.settings.interfaces.IAvgPowerInclZero, core.settings.interfaces.IPowerFTP, core.settings.interfaces.IPowerIntensityZone, core.units.interfaces.IIntensityZonesPercentage
    {
        public function SportProfileROX110(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            favSetMaxCount = 6;
            return;
        }

        public function set powerIntensityZone1Start(arg1:int):void
        {
            _powerIntensityZone1Start = arg1;
            return;
        }

        public function get alarmCalories():Boolean
        {
            return _alarmCalories;
        }

        public function set alarmCalories(arg1:Boolean):void
        {
            _alarmCalories = arg1;
            return;
        }

        public function get powerIntensityZone2Start():int
        {
            return _powerIntensityZone2Start;
        }

        public function get alarmCaloriesBase():Number
        {
            return _alarmCaloriesBase;
        }

        public function set alarmCaloriesBase(arg1:Number):void
        {
            _alarmCaloriesBase = arg1;
            return;
        }

        public function set powerIntensityZone2Start(arg1:int):void
        {
            _powerIntensityZone2Start = arg1;
            return;
        }

        public function get powerIntensityZone3Start():int
        {
            return _powerIntensityZone3Start;
        }

        public function set powerIntensityZone3Start(arg1:int):void
        {
            _powerIntensityZone3Start = arg1;
            return;
        }

        public function get alarmDistance():Boolean
        {
            return _alarmDistance;
        }

        public function set alarmDistance(arg1:Boolean):void
        {
            _alarmDistance = arg1;
            return;
        }

        public function get powerIntensityZone4Start():int
        {
            return _powerIntensityZone4Start;
        }

        public function get alarmDistanceBase():Number
        {
            return _alarmDistanceBase;
        }

        public function set alarmDistanceBase(arg1:Number):void
        {
            _alarmDistanceBase = arg1;
            return;
        }

        public function set powerIntensityZone4Start(arg1:int):void
        {
            _powerIntensityZone4Start = arg1;
            return;
        }

        public function get powerIntensityZone5Start():int
        {
            return _powerIntensityZone5Start;
        }

        public function set powerIntensityZone5Start(arg1:int):void
        {
            _powerIntensityZone5Start = arg1;
            return;
        }

        public function get alarmTime():Boolean
        {
            return _alarmTime;
        }

        public function set alarmTime(arg1:Boolean):void
        {
            _alarmTime = arg1;
            return;
        }

        public function get powerIntensityZone6Start():int
        {
            return _powerIntensityZone6Start;
        }

        public function get alarmTimeBase():Number
        {
            return _alarmTimeBase;
        }

        public function set alarmTimeBase(arg1:Number):void
        {
            _alarmTimeBase = arg1;
            return;
        }

        public function set powerIntensityZone6Start(arg1:int):void
        {
            _powerIntensityZone6Start = arg1;
            return;
        }

        public function get powerIntensityZone7End():int
        {
            return _powerIntensityZone7End;
        }

        public function set powerIntensityZone7End(arg1:int):void
        {
            _powerIntensityZone7End = arg1;
            return;
        }

        public function get auto_lap_fav_set_1():String
        {
            return _auto_lap_fav_set_1;
        }

        public function set auto_lap_fav_set_1(arg1:String):void
        {
            _auto_lap_fav_set_1 = arg1;
            return;
        }

        public function get powerIntensityZone7Start():int
        {
            return _powerIntensityZone7Start;
        }

        public function get avgCadInclZero():Boolean
        {
            return _avgCadInclZero;
        }

        public function set avgCadInclZero(arg1:Boolean):void
        {
            _avgCadInclZero = arg1;
            return;
        }

        public function set powerIntensityZone7Start(arg1:int):void
        {
            _powerIntensityZone7Start = arg1;
            return;
        }

        public function get avgPowerInclZero():Boolean
        {
            return _avgPowerInclZero;
        }

        public function set avgPowerInclZero(arg1:Boolean):void
        {
            _avgPowerInclZero = arg1;
            return;
        }

        public function get weightUnit():String
        {
            return _weightUnit;
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
            }
            return;
        }

        public function set weightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
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

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public function get gpsStatus():Boolean
        {
            return _gpsStatus;
        }

        public function set gpsStatus(arg1:Boolean):void
        {
            _gpsStatus = arg1;
            return;
        }

        public function set wheelSize1(arg1:int):void
        {
            if (_wheelSize1 !== arg1) 
            {
                _wheelSize1 = arg1;
            }
            return;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1PercentageStart;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            _intensityZone1PercentageStart = arg1;
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2PercentageStart;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            _intensityZone2PercentageStart = arg1;
            return;
        }

        public function get wheelSize1Min():int
        {
            return 500;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3PercentageStart;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            _intensityZone3PercentageStart = arg1;
            return;
        }

        public override function toString():String
        {
            return "[SportProfileROX110]";
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4PercentageEnd;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            _intensityZone4PercentageEnd = arg1;
            return;
        }

        public function get powerFTPMin():Number
        {
            return 1;
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4PercentageStart;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            _intensityZone4PercentageStart = arg1;
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 40;
        }

        public function get lapFavSetMaxCount():uint
        {
            return _lapFavSetMaxCount;
        }

        public function set lapFavSetMaxCount(arg1:uint):void
        {
            _lapFavSetMaxCount = arg1;
            return;
        }

        public function get lap_fav_set_1():String
        {
            return _lap_fav_set_1;
        }

        public function set lap_fav_set_1(arg1:String):void
        {
            _lap_fav_set_1 = arg1;
            return;
        }

        public function get powerFTP():Number
        {
            return _powerFTP;
        }

        public function set powerFTP(arg1:Number):void
        {
            _powerFTP = arg1;
            return;
        }

        public function get powerFTPMax():Number
        {
            return 2000;
        }

        public function get powerIntensityZone1Start():int
        {
            return _powerIntensityZone1Start;
        }

        public static const WHEEL_SBIKE1_MIN:int=500;

        public static const WEIGHTBIKE_KG_MAX_IN_G:int=50000;

        public static const INTENSITY_ZONE_PERCENTAGE_MIN:int=40;

        public static const POWER_FTP_MAX:int=2000;

        public static const POWER_FTP_MIN:int=1;

        public static const WEIGHTBIKE_KG_MIN_IN_G:int=1000;

        public static const WEIGHTBIKE_LB_MAX_IN_G:int=45359;

        public static const WEIGHTBIKE_LB_MIN_IN_G:int=1361;

        public static const WHEEL_SBIKE1_MAX:int=3999;

        internal var _alarmTimeBase:Number=0;

        public var alarmTimeBaseMax:Number=3599900;

        public var alarmTimeBaseMin:Number=500;

        internal var _auto_lap_fav_set_1:String;

        internal var _avgCadInclZero:Boolean=false;

        internal var _avgPowerInclZero:Boolean=false;

        internal var _bikeType1:String="raceDrop";

        internal var _bikeWeight1:int=8000;

        internal var _gpsStatus:Boolean;

        internal var _intensityZone1PercentageStart:Number=60;

        internal var _intensityZone2PercentageStart:Number=70;

        internal var _intensityZone3PercentageStart:Number=80;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _lapFavSetMaxCount:uint=2;

        internal var _powerIntensityZone4Start:int=228;

        internal var _powerIntensityZone7Start:int=378;

        internal var _lap_fav_set_1:String;

        internal var _powerIntensityZone2Start:int=141;

        internal var _weightUnit:String="kg";

        internal var _powerIntensityZone5Start:int=266;

        internal var _powerFTP:Number=250;

        internal var _alarmCalories:Boolean=false;

        internal var _intensityZone4PercentageStart:Number=90;

        internal var _powerIntensityZone6Start:int=303;

        internal var _powerIntensityZone3Start:int=191;

        internal var _alarmCaloriesBase:Number=0;

        internal var _powerIntensityZone7End:int=2000;

        public var alarmCaloriesBaseMax:Number=9999;

        public var alarmCaloriesBaseMin:Number=10;

        internal var _alarmDistance:Boolean=false;

        internal var _powerIntensityZone1Start:int=0;

        internal var _alarmDistanceBase:Number=0;

        public var alarmDistanceBaseMax:Number=99900;

        public var alarmDistanceBaseMin:Number=100;

        internal var _alarmTime:Boolean=false;

        internal var _wheelSize1:int=2155;
    }
}


