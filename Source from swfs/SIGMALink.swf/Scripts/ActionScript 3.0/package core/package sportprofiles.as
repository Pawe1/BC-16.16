//package sportprofiles
//  class FavFunctionList
package core.sportprofiles 
{
    import __AS3__.vec.*;
    import flash.events.*;
    
    public class FavFunctionList extends flash.events.EventDispatcher
    {
        public function FavFunctionList()
        {
            favFunctionList = new __AS3__.vec.Vector.<core.sportprofiles.FavFunctionlistItem>();
            super();
            return;
        }

        public function changeFavFunction(arg1:core.sportprofiles.FavFunctionlistItem):void
        {
            var loc1:*=0;
            var loc2:*=false;
            while (loc1 < favFunctionList.length) 
            {
                if (favFunctionList[loc1].position == arg1.position) 
                {
                    loc2 = !(favFunctionList[loc1] == arg1);
                    favFunctionList[loc1] = arg1;
                    if (loc2) 
                    {
                        dispatchEvent(new flash.events.Event("EVENT_FAVFUNCTIONLIST_CHANGED"));
                    }
                    return;
                }
                ++loc1;
            }
            favFunctionList.push(arg1);
            dispatchEvent(new flash.events.Event("EVENT_FAVFUNCTIONLIST_CHANGED"));
            return;
        }

        public function resetFavFunctions():void
        {
            favFunctionList = new __AS3__.vec.Vector.<core.sportprofiles.FavFunctionlistItem>();
            dispatchEvent(new flash.events.Event("EVENT_FAVFUNCTIONLIST_RESETTED"));
            return;
        }

        public function getFavFunctionlistItem(arg1:*):core.sportprofiles.FavFunctionlistItem
        {
            if (favFunctionList.hasOwnProperty(arg1)) 
            {
                return favFunctionList[arg1];
            }
            return null;
        }

        public function toArray():Array
        {
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < favFunctionList.length) 
            {
                loc1.push(favFunctionList[loc2]);
                ++loc2;
            }
            return loc1;
        }

        public function toObject():Object
        {
            var loc2:*={};
            var loc1:*=0;
            loc2["list"] = {};
            loc2["tid"] = templateId;
            loc2["active"] = active;
            while (loc1 < favFunctionList.length) 
            {
                loc2["list"][favFunctionList[loc1].position] = favFunctionList[loc1].favFuncId;
                ++loc1;
            }
            return loc2;
        }

        public function toJson():String
        {
            var loc1:*=JSON.stringify(toObject());
            return loc1;
        }

        public function fromJson(arg1:String):core.sportprofiles.FavFunctionList
        {
            var loc3:*=null;
            var loc1:*=null;
            if (arg1) 
            {
                loc3 = JSON.parse(arg1);
            }
            if (loc3) 
            {
                if (loc3.hasOwnProperty("list")) 
                {
                    var loc5:*=0;
                    var loc4:*=loc3.list;
                    for (var loc2:* in loc4) 
                    {
                        loc1 = new core.sportprofiles.FavFunctionlistItem(loc3.list[loc2], parseInt(loc2));
                        changeFavFunction(loc1);
                    }
                }
                if (loc3.hasOwnProperty("tid")) 
                {
                    templateId = loc3.tid as uint;
                }
                if (loc3.hasOwnProperty("active")) 
                {
                    active = loc3.active as Boolean;
                }
            }
            return this;
        }

        public static const EVENT_FAVFUNCTIONLIST_CHANGED:String="EVENT_FAVFUNCTIONLIST_CHANGED";

        public static const EVENT_FAVFUNCTIONLIST_RESETTED:String="EVENT_FAVFUNCTIONLIST_RESETTED";

        public static const NAME_ACTIVE:String="active";

        public static const NAME_LIST:String="list";

        public static const NAME_TEMPLATEID:String="tid";

        public var active:Boolean;

        public var templateId:uint;

        internal var favFunctionList:__AS3__.vec.Vector.<core.sportprofiles.FavFunctionlistItem>;
    }
}


//  class FavFunctionlistItem
package core.sportprofiles 
{
    public class FavFunctionlistItem extends Object
    {
        public function FavFunctionlistItem(arg1:uint, arg2:uint)
        {
            super();
            favFuncId = arg1;
            position = arg2;
            return;
        }

        public var favFuncId:uint;

        public var position:uint;
    }
}


//  class SportProfileROX110
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


//  class SportProfileROX70
package core.sportprofiles 
{
    import core.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SportProfileROX70 extends core.sportprofiles.Sportprofile implements core.settings.interfaces.IAutoPause, core.settings.interfaces.IAutoLap, core.settings.interfaces.IAutoLapBasedOnDistance, core.settings.interfaces.IAutoLapBasedOnTime, core.settings.interfaces.IAutoLapBasedOnCalories, core.settings.interfaces.IFavSets
    {
        public function SportProfileROX70(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            favSetMaxCount = 6;
            return;
        }

        public function set fav_set_5(arg1:String):void
        {
            _fav_set_5 = arg1;
            return;
        }

        public function get autoLap():uint
        {
            return _autoLap;
        }

        public function set autoLap(arg1:uint):void
        {
            _autoLap = arg1;
            return;
        }

        public function get fav_set_6():String
        {
            return _fav_set_6;
        }

        public function get autoLapBasedOn():uint
        {
            return _autoLapBasedOn;
        }

        public function set autoLapBasedOn(arg1:uint):void
        {
            _autoLapBasedOn = arg1;
            return;
        }

        public function set fav_set_6(arg1:String):void
        {
            _fav_set_6 = arg1;
            return;
        }

        public function get autoLapCalories():uint
        {
            return _autoLapCalories;
        }

        public function set autoLapCalories(arg1:uint):void
        {
            if (arg1 > autoLapCaloriesMax / 10) 
            {
                arg1 = autoLapCaloriesMax / 10;
            }
            if (arg1 < autoLapCaloriesMin / 10) 
            {
                arg1 = autoLapCaloriesMin / 10;
            }
            _autoLapCalories = arg1;
            return;
        }

        public function get autoLapCaloriesMax():uint
        {
            return 9999;
        }

        public function get autoLapCaloriesMin():uint
        {
            return 10;
        }

        public function get fav_set_7():String
        {
            return _fav_set_7;
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

        public function set fav_set_7(arg1:String):void
        {
            _fav_set_7 = arg1;
            return;
        }

        public function get autoLapTime():uint
        {
            return _autoLapTime;
        }

        public function set autoLapTime(arg1:uint):void
        {
            if (arg1 > autoLapTimeMax) 
            {
                arg1 = autoLapTimeMax;
            }
            if (arg1 < autoLapTimeMin) 
            {
                arg1 = autoLapTimeMin;
            }
            _autoLapTime = arg1;
            return;
        }

        public function get autoLapTimeMax():uint
        {
            return 3599900;
        }

        public function get autoLapTimeMin():uint
        {
            return 500;
        }

        public function get fav_set_8():String
        {
            return _fav_set_8;
        }

        public function get autoPause():Boolean
        {
            return _autoPause;
        }

        public function set autoPause(arg1:Boolean):void
        {
            _autoPause = arg1;
            return;
        }

        public function set fav_set_8(arg1:String):void
        {
            _fav_set_8 = arg1;
            return;
        }

        public function get bikeName():String
        {
            return _bikeName;
        }

        public function set bikeName(arg1:String):void
        {
            _bikeName = arg1;
            return;
        }

        public function get fav_set_9():String
        {
            return _fav_set_9;
        }

        public function get favSetMaxCount():uint
        {
            return _favSetMaxCount;
        }

        public function set favSetMaxCount(arg1:uint):void
        {
            _favSetMaxCount = arg1;
            return;
        }

        public function set fav_set_9(arg1:String):void
        {
            _fav_set_9 = arg1;
            return;
        }

        public function get fav_set_1():String
        {
            return _fav_set_1;
        }

        public function set fav_set_1(arg1:String):void
        {
            _fav_set_1 = arg1;
            return;
        }

        public override function toString():String
        {
            return "[SportProfileROX70]";
        }

        public function get fav_set_10():String
        {
            return _fav_set_10;
        }

        public function set fav_set_10(arg1:String):void
        {
            _fav_set_10 = arg1;
            return;
        }

        public function get fav_set_2():String
        {
            return _fav_set_2;
        }

        public function set fav_set_2(arg1:String):void
        {
            _fav_set_2 = arg1;
            return;
        }

        public function get fav_set_3():String
        {
            return _fav_set_3;
        }

        public function set fav_set_3(arg1:String):void
        {
            _fav_set_3 = arg1;
            return;
        }

        public function get fav_set_4():String
        {
            return _fav_set_4;
        }

        public function set fav_set_4(arg1:String):void
        {
            _fav_set_4 = arg1;
            return;
        }

        public function get fav_set_5():String
        {
            return _fav_set_5;
        }

        public static const FAV_SET_MAX_COUNT:uint=6;

        internal static const AUTOLAP_CALORIES_MAX:uint=9999;

        internal static const AUTOLAP_CALORIES_MIN:uint=10;

        internal static const AUTOLAP_DISTANCE_MAX_KM:uint=99900000;

        internal static const AUTOLAP_DISTANCE_MAX_MILE:uint=99900000;

        internal static const AUTOLAP_DISTANCE_MIN_KM:uint=100000;

        internal static const AUTOLAP_DISTANCE_MIN_MILE:uint=100000;

        internal static const AUTOLAP_TIME_MAX:uint=3599900;

        internal static const AUTOLAP_TIME_MIN:uint=500;

        internal var _autoLap:uint;

        internal var _autoLapBasedOn:uint;

        internal var _autoLapCalories:uint;

        internal var _autoLapDistance:uint;

        internal var _autoLapTime:uint;

        internal var _autoPause:Boolean;

        internal var _bikeName:String;

        internal var _favSetMaxCount:uint;

        internal var _fav_set_1:String;

        internal var _fav_set_10:String;

        internal var _fav_set_2:String;

        internal var _fav_set_8:String;

        internal var _fav_set_6:String;

        internal var _fav_set_3:String;

        internal var _fav_set_9:String;

        internal var _fav_set_5:String;

        internal var _fav_set_7:String;

        internal var _fav_set_4:String;
    }
}


//  class Sportprofile
package core.sportprofiles 
{
    import core.*;
    import core.general.interfaces.*;
    import core.sport.*;
    import core.units.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import helper.*;
    import init.*;
    import utils.*;
    import utils.interfaces.*;
    
    public class Sportprofile extends flash.events.EventDispatcher implements core.general.interfaces.ISynchronisable
    {
        public function Sportprofile(arg1:flash.events.IEventDispatcher=null)
        {
            super();
            return;
        }

        internal function changeFavSet(arg1:uint, arg2:String):void
        {
            if (this.hasOwnProperty("fav_set_" + arg1)) 
            {
                this["fav_set_" + arg1] = arg2;
            }
            return;
        }

        public function get GUID():String
        {
            return _GUID;
        }

        public function set GUID(arg1:String):void
        {
            _GUID = arg1;
            return;
        }

        public function changeFavFunctionList(arg1:uint, arg2:core.sportprofiles.FavFunctionList):void
        {
            if (arg1 == 1) 
            {
                arg2.active = true;
            }
            changeFavSet(arg1, arg2.toJson());
            return;
        }

        public function set isDeleted(arg1:Boolean):void
        {
            _isDeleted = arg1;
            return;
        }

        public function get dateOutputString():String
        {
            if (initFormatter) 
            {
                dateFormatter = initDateTimeFormatter();
                _dateOutputString = dateFormatter.format(modificationDate);
            }
            return _dateOutputString;
        }

        public function set dateOutputString(arg1:String):void
        {
            _dateOutputString = arg1;
            return;
        }

        public function changeLapFavSet(arg1:uint, arg2:String):void
        {
            if (this.hasOwnProperty("lap_fav_set_" + arg1)) 
            {
                this["lap_fav_set_" + arg1] = arg2;
            }
            return;
        }

        public function get isDeleted():Boolean
        {
            return _isDeleted;
        }

        public function changeAutoLapFavSet(arg1:uint, arg2:String):void
        {
            if (this.hasOwnProperty("auto_lap_fav_set_" + arg1)) 
            {
                this["auto_lap_fav_set_" + arg1] = arg2;
            }
            return;
        }

        public function getFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList
        {
            var loc1:*=null;
            if (this.hasOwnProperty("fav_set_" + arg1)) 
            {
                loc1 = new core.sportprofiles.FavFunctionList();
                loc1.fromJson(this["fav_set_" + arg1]);
                if (arg1 == 1) 
                {
                    loc1.active = true;
                }
                return loc1;
            }
            return null;
        }

        public function get modificationDate():Number
        {
            return _modificationDate;
        }

        public function set modificationDate(arg1:Number):void
        {
            _modificationDate = arg1;
            return;
        }

        public function getLapFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList
        {
            var loc1:*=null;
            if (this.hasOwnProperty("lap_fav_set_" + arg1)) 
            {
                loc1 = new core.sportprofiles.FavFunctionList();
                return loc1.fromJson(this["lap_fav_set_" + arg1]);
            }
            return null;
        }

        public function getAutoLapFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList
        {
            var loc1:*=null;
            if (this.hasOwnProperty("auto_lap_fav_set_" + arg1)) 
            {
                loc1 = new core.sportprofiles.FavFunctionList();
                return loc1.fromJson(this["auto_lap_fav_set_" + arg1]);
            }
            return null;
        }

        public override function toString():String
        {
            return "[Sportprofile implements ISynchronisable, IDatabase]";
        }

        public function get sport():core.sport.Sport
        {
            return _sport;
        }

        public function set sport(arg1:core.sport.Sport):void
        {
            _sport = arg1;
            if (_sport) 
            {
                _sportId = _sport.sportId;
            }
            return;
        }

        internal static function initDateTimeFormatter():utils.interfaces.ICustomDateTimeFormatter
        {
            var loc1:*=init.BackendInitializer.getInstance().createDateTimeFormatter();
            loc1.dateStyle = "short";
            loc1.timeStyle = "none";
            loc1.setStyle("locale", core.MeasurementConfig.dateFormat != "eu" ? "en_US" : "de_DE");
            return loc1;
        }

        public function get sportId():uint
        {
            return _sportId;
        }

        public function set sportId(arg1:uint):void
        {
            _sportId = arg1;
            return;
        }

        public final function set unit(arg1:core.units.Unit):void
        {
            if (_unit !== arg1) 
            {
                _unit = arg1;
                dispatchEvent(new flash.events.Event("unitChange"));
            }
            return;
        }

        public function get sportprofileId():int
        {
            return _sportprofileId;
        }

        public function set sportprofileId(arg1:int):void
        {
            if (arg1 != _sportprofileId) 
            {
                _sportprofileId = arg1;
                dispatchEvent(new flash.events.Event("currentIdChange"));
            }
            return;
        }

        public final function get unit():core.units.Unit
        {
            return _unit;
        }

        public function get unitGUID():String
        {
            return _unitGUID;
        }

        public function set unitGUID(arg1:String):void
        {
            _unitGUID = arg1;
            return;
        }

        public function clone():core.sportprofiles.Sportprofile
        {
            var loc2:*=flash.utils.getQualifiedClassName(this);
            flash.net.registerClassAlias(loc2, flash.utils.getDefinitionByName(loc2) as Class);
            var loc4:*=this.unit;
            var loc1:*=this.sport;
            this.unit = null;
            this.sport = null;
            var loc3:*=utils.BackendUtil.copy(this) as core.sportprofiles.Sportprofile;
            this.unit = loc4;
            this.sport = loc1;
            loc3.GUID = "";
            loc3.isDeleted = false;
            loc3.selected = false;
            loc3.sportprofileId = 0;
            loc3.unit = this.unit;
            loc3.sport = this.sport;
            return loc3;
        }

        public function copyFrom(arg1:Object):void
        {
            var loc2:*=helper.Object_helper.clone(arg1);
            var loc4:*=0;
            var loc3:*=loc2;
            for (var loc1:* in loc3) 
            {
                if (!this.hasOwnProperty(loc1)) 
                {
                    continue;
                }
                this[loc1] = loc2[loc1];
            }
            return;
        }

        internal var _GUID:String="";

        public var data:Array;

        internal var _isDeleted:Boolean=false;

        internal var _dateOutputString:String="--";

        internal var _modificationDate:Number=0;

        public var profileName:String;

        public var selected:Boolean;

        internal var _sport:core.sport.Sport;

        internal var _sportId:uint=0;

        internal var _sportprofileId:int;

        internal var _unitGUID:String="";

        public static var dateFormatter:utils.interfaces.ICustomDateTimeFormatter;

        public static var initFormatter:Boolean=true;

        internal var _unit:core.units.Unit;
    }
}


//  class SportprofileFactory
package core.sportprofiles 
{
    import core.general.*;
    
    public final class SportprofileFactory extends Object
    {
        public function SportprofileFactory()
        {
            super();
            return;
        }

        public static function createSportprofileFromUnitType(arg1:core.general.UnitType):core.sportprofiles.Sportprofile
        {
            var loc1:*=arg1;
            while (core.general.UnitType.ROX70 === loc1) 
            {
                return new core.sportprofiles.SportProfileROX70();
            }
        }
    }
}


//  class SportprofileFavFunctionObject
package core.sportprofiles 
{
    import utils.*;
    
    public class SportprofileFavFunctionObject extends Object
    {
        public function SportprofileFavFunctionObject(arg1:Array, arg2:uint, arg3:uint, arg4:uint=0, arg5:Array=null)
        {
            var loc2:*=0;
            allowedBoxFormats = [0];
            allowedViews = [];
            super();
            allowedViews = arg1;
            categoryId = arg2;
            functionId = arg3;
            sort = arg4;
            if (arg5 != null) 
            {
                allowedBoxFormats = [];
                loc2 = 0;
                var loc1:*=arg5.length;
                while (loc2 < loc1) 
                {
                    if (BOX_FORMATS.indexOf(arg5[loc2] >= 0)) 
                    {
                        allowedBoxFormats.push(arg5[loc2]);
                    }
                    ++loc2;
                }
            }
            return;
        }

        public function get functionLabel():String
        {
            return utils.LanguageManager.getString("SPORTPROFILE_FUNCTION_" + functionId);
        }

        public static const ALLOWED_BOX_FORMAT_ALL:uint=0;

        public static const ALLOWED_BOX_FORMAT_BIG:uint=10;

        public static const ALLOWED_BOX_FORMAT_SMALL:uint=20;

        public static const AUTO_LAP_VIEW:uint=3;

        public static const BOX_FORMATS:Array=[0, 10, 20];

        public static const LAP_VIEW:uint=2;

        public static const TRAINING_VIEW:uint=1;

        public var allowedBoxFormats:Array;

        public var allowedViews:Array;

        public var categoryId:uint;

        public var functionId:uint;

        internal var _functionLabel:String;

        public var selected:Boolean=false;

        public var sort:uint;
    }
}


//  class SportprofileFavFunctions
package core.sportprofiles 
{
    import __AS3__.vec.*;
    import utils.sort.*;
    
    public class SportprofileFavFunctions extends Object
    {
        public function SportprofileFavFunctions()
        {
            var loc1:*=0;
            _functions = new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>();
            _categories = new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionsCategory>();
            super();
            var loc2:*=0;
            sportprofile = currentSportprofile;
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 1, 1, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 1, 2, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 1, 3, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 1, 4, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 2, 5, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 2, 6, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 2, 8, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 2, 9, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 13, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 14, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 15, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 16, loc2++, [10]));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 17, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 18, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 19, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 20, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 21, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 22, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 23, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 24, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 25, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 26, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 27, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 28, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 29, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 30, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 31, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 32, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 33, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 37, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 38, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 39, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 40, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 42, loc2++, [10]));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 14, 7, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 57, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 58, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 59, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 60, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 61, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 62, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 63, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 64, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 65, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 66, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 67, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 68, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 69, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 70, loc2++));
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 71, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 72, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 73, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 74, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 75, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 76, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 77, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 78, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 79, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 80, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 81, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 82, loc2++));
            }
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 43, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 44, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 45, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 46, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 47, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 48, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 49, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 50, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 51, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 52, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 53, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 54, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 55, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 56, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 83, loc2++, [10]));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 96, loc2++, [10]));
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 84, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 85, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 86, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 87, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 88, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 89, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 90, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 91, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 92, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 93, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 94, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 95, loc2++));
            }
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 10, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 11, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 12, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 34, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 35, loc2++));
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 105, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 108, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 109, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 110, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 107, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 112, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 106, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 111, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 114, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 115, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 116, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 113, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 117, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 99, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 100, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 101, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 102, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 103, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 118, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 104, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 119, loc2++, [10]));
            }
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 120, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 122, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 123, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 124, loc2++, [10]));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 125, loc2++));
            }
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 126, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 127, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 128, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 129, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 130, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 131, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 133, loc2++, [10]));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 132, loc2++, [10]));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 134, loc2++, [10]));
            }
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 135, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 136, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 137, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 121, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 138, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 139, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 140, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 97, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 98, loc2++));
            }
            _categories.sort(sortCategories);
            loc1 = 0;
            while (loc1 < _categories.length) 
            {
                (_categories[loc1] as core.sportprofiles.SportprofileFavFunctionsCategory).functions.sort(sortFunctions);
                ++loc1;
            }
            _functions.sort(sortFunctions);
            return;
        }

        internal function addFunction(arg1:core.sportprofiles.SportprofileFavFunctionObject):void
        {
            getCategory(arg1.categoryId).addFunction(arg1);
            _functions.push(arg1);
            return;
        }

        public function get functions():__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>
        {
            return _functions;
        }

        public function getCategoryFunctions(arg1:uint):__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < _categories.length) 
            {
                if (_categories[loc1].categoryId == arg1) 
                {
                    return (_categories[loc1] as core.sportprofiles.SportprofileFavFunctionsCategory).functions;
                }
                ++loc1;
            }
            return new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>();
        }

        internal function getCategory(arg1:uint):core.sportprofiles.SportprofileFavFunctionsCategory
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < _categories.length) 
            {
                if (_categories[loc1].categoryId == arg1) 
                {
                    return _categories[loc1] as core.sportprofiles.SportprofileFavFunctionsCategory;
                }
                ++loc1;
            }
            var loc2:*=new core.sportprofiles.SportprofileFavFunctionsCategory(arg1);
            _catSortCounter = (_catSortCounter + 1);
            loc2.sort = _catSortCounter;
            _categories.push(loc2);
            return loc2;
        }

        public static function getInstance():core.sportprofiles.SportprofileFavFunctions
        {
            if (!_instance || !(_instance.sportprofile.unit.type == currentSportprofile.unit.type)) 
            {
                _instance = new SportprofileFavFunctions();
            }
            return _instance;
        }

        internal function sortCategories(arg1:core.sportprofiles.SportprofileFavFunctionsCategory, arg2:core.sportprofiles.SportprofileFavFunctionsCategory):Number
        {
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, "sort", false);
        }

        internal function sortFunctions(arg1:core.sportprofiles.SportprofileFavFunctionObject, arg2:core.sportprofiles.SportprofileFavFunctionObject):Number
        {
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, "sort", false);
        }

        public function getCategories():__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionsCategory>
        {
            return _categories;
        }

        public static const FUNC_TIME_EXCERCISE_TIME:uint=5;

        public static const FUNC_TIME_TRIP_TIME:uint=6;

        public static const FUNC_POWER_KJ:uint=113;

        public static const CATEGORY_ID_ALTITUDE:uint=4;

        public static const CATEGORY_ID_AUTOLAP:uint=7;

        public static const CATEGORY_ID_BICYCLE:uint=1;

        public static const CATEGORY_ID_CADENCE:uint=13;

        public static const CATEGORY_ID_CALORIES:uint=14;

        public static const CATEGORY_ID_CYCLINGDYNAMICS:uint=10;

        public static const CATEGORY_ID_GEARS:uint=11;

        public static const CATEGORY_ID_HEARTRATE:uint=12;

        public static const CATEGORY_ID_LAP:uint=8;

        public static const CATEGORY_ID_NAVIGATION:uint=6;

        public static const CATEGORY_ID_POWER:uint=9;

        public static const CATEGORY_ID_STATUS:uint=5;

        public static const CATEGORY_ID_TEMPERATURE:uint=3;

        public static const CATEGORY_ID_TIME:uint=2;

        public static const FUNC_ALTITUDE_ACTUAL_RISE_RATE:uint=15;

        public static const FUNC_ALTITUDE_ASCENT:uint=17;

        public static const FUNC_ALTITUDE_AVG_DECLINE_DOWNHILL:uint=32;

        public static const FUNC_ALTITUDE_AVG_INCLINE_UPHILL:uint=24;

        public static const FUNC_ALTITUDE_AVG_RISE_RATE_DOWNHILL:uint=30;

        public static const FUNC_ALTITUDE_AVG_RISE_RATE_UPHILL:uint=22;

        public static const FUNC_ALTITUDE_AVG_SPEED_DOWNHILL:uint=29;

        public static const FUNC_ALTITUDE_AVG_SPEED_UPHILL:uint=21;

        public static const FUNC_ALTITUDE_CURRENT_ALTITUDE:uint=13;

        public static const FUNC_ALTITUDE_DESCENT:uint=26;

        public static const FUNC_ALTITUDE_DISTACE_UPHILL:uint=19;

        public static const FUNC_ALTITUDE_DISTANCE_DOWNHILL:uint=27;

        public static const FUNC_ALTITUDE_INCLINE:uint=14;

        public static const FUNC_ALTITUDE_MAXIMUM_ALTITUDE:uint=18;

        public static const FUNC_ALTITUDE_MAX_DECLINE_DOWNHILL:uint=33;

        public static const FUNC_ALTITUDE_MAX_INCLINE_UPHILL:uint=25;

        public static const FUNC_ALTITUDE_MAX_RISE_RATE_DOWNHILL:uint=31;

        public static const FUNC_ALTITUDE_MAX_RISE_RATE_UPHILL:uint=23;

        public static const FUNC_ALTITUDE_PROFILE:uint=16;

        public static const FUNC_ALTITUDE_TIME_DOWNHILL:uint=28;

        public static const FUNC_ALTITUDE_TIME_UPHILL:uint=20;

        public static const FUNC_AUTOLAP_ALTITUDE_ASCENT_PER_LAP:uint=51;

        public static const FUNC_AUTOLAP_ALTITUDE_DESCENT_PER_LAP:uint=52;

        public static const FUNC_AUTOLAP_AL_PEDALING_INDEX:uint=95;

        public static const FUNC_AUTOLAP_AL_PEDALING_TIME:uint=94;

        public static const FUNC_AUTOLAP_AVG_ALTITUDE_PER_LAP:uint=49;

        public static const FUNC_AUTOLAP_AVG_BALANCE_LAP:uint=84;

        public static const FUNC_AUTOLAP_AVG_CAD:uint=90;

        public static const FUNC_AUTOLAP_AVG_HR:uint=92;

        public static const FUNC_AUTOLAP_AVG_INCLINE_PER_LAP_DOWNHILL:uint=54;

        public static const FUNC_AUTOLAP_AVG_INCLINE_PER_LAP_UPHILL:uint=53;

        public static const FUNC_AUTOLAP_AVG_SPEED_PER_LAP:uint=46;

        public static const FUNC_AUTOLAP_AVG_VAM_DOWNHILL_PER_LAP:uint=56;

        public static const FUNC_AUTOLAP_AVG_VAM_UPHILL_PER_LAP:uint=55;

        public static const FUNC_AUTOLAP_CALORIES_PER_LAP:uint=48;

        public static const FUNC_AUTOLAP_DISTANCE:uint=45;

        public static const FUNC_AUTOLAP_LAPLIST:uint=83;

        public static const FUNC_AUTOLAP_LAST_AUTOLAP_AVG_POWER:uint=86;

        public static const FUNC_AUTOLAP_LAST_AUTOLAP_NP:uint=89;

        public static const FUNC_AUTOLAP_LIST:uint=96;

        public static const FUNC_AUTOLAP_MAX_ALTITUDE_PER_LAP:uint=50;

        public static const FUNC_AUTOLAP_MAX_CAD:uint=91;

        public static const FUNC_AUTOLAP_MAX_HR:uint=93;

        public static const FUNC_AUTOLAP_MAX_POWER:uint=87;

        public static const FUNC_AUTOLAP_MAX_SPEED_PER_LAP:uint=47;

        public static const FUNC_AUTOLAP_NP:uint=88;

        public static const FUNC_AUTOLAP_NUMBER:uint=43;

        public static const FUNC_AUTOLAP_POWER_LAP:uint=85;

        public static const FUNC_AUTOLAP_TIME:uint=44;

        public static const FUNC_BICYCLE_AVERAGE_SPEED:uint=2;

        public static const FUNC_BICYCLE_CURRENT_SPEED:uint=1;

        public static const FUNC_BICYCLE_MAX_SPEED:uint=3;

        public static const FUNC_BICYCLE_TRIP_DISTANCE:uint=4;

        public static const FUNC_CADENCE_AVG_CAD:uint=136;

        public static const FUNC_CADENCE_AVG_EXPANSION:uint=138;

        public static const FUNC_CADENCE_AVG_EXPANSION_DOWNHILL:uint=140;

        public static const FUNC_CADENCE_AVG_EXPANSION_UPHILL:uint=139;

        public static const FUNC_CADENCE_CURRENT_CAD:uint=135;

        public static const FUNC_CADENCE_CURRENT_EXPANSION:uint=121;

        public static const FUNC_CADENCE_MAX_CAD:uint=137;

        public static const FUNC_CALORIES_CALORIES:uint=7;

        public static const FUNC_GEARS_DI2_BATTERY_LEVEL:uint=120;

        public static const FUNC_GEARS_DI2_FRONTGEAR:uint=122;

        public static const FUNC_GEARS_DI2_GEARS:uint=124;

        public static const FUNC_GEARS_DI2_GEAR_RATIO:uint=123;

        public static const FUNC_GEARS_DI2_GEAR_REAR:uint=125;

        public static const FUNC_HEARTRATE_AVG_HR:uint=127;

        public static const FUNC_HEARTRATE_AVG_HRMAX_PERCENT:uint=131;

        public static const FUNC_HEARTRATE_CURRENT_HR:uint=126;

        public static const FUNC_HEARTRATE_HRMAX_PERCENT:uint=130;

        public static const FUNC_HEARTRATE_HR_GRAPH:uint=134;

        public static const FUNC_HEARTRATE_INTENSITY_ZONE:uint=133;

        public static const FUNC_HEARTRATE_MAX_HR:uint=128;

        public static const FUNC_HEARTRATE_MIN_HR:uint=129;

        public static const FUNC_HEARTRATE_ZONE_BAR:uint=132;

        public static const FUNC_LAP_ALTITUDE_ASCENT_PER_LAP:uint=65;

        public static const FUNC_LAP_ALTITUDE_DESCENT_PER_LAP:uint=66;

        public static const FUNC_LAP_AVG_ALTITUDE_PER_LAP:uint=63;

        public static const FUNC_LAP_AVG_BALANCE:uint=71;

        public static const FUNC_LAP_AVG_CAD:uint=77;

        public static const FUNC_LAP_AVG_HR:uint=79;

        public static const FUNC_LAP_AVG_INCLINE_PER_LAP_DOWNHILL:uint=68;

        public static const FUNC_LAP_AVG_INCLINE_PER_LAP_UPHILL:uint=67;

        public static const FUNC_LAP_AVG_POWER:uint=72;

        public static const FUNC_LAP_AVG_SPEED_PER_LAP:uint=60;

        public static const FUNC_LAP_AVG_VAM_DOWNHILL_PER_LAP:uint=70;

        public static const FUNC_LAP_AVG_VAM_UPHILL_PER_LAP:uint=69;

        public static const FUNC_LAP_CALORIES_PER_LAP:uint=62;

        public static const FUNC_LAP_DISTANCE:uint=59;

        public static const FUNC_LAP_LAST_LAP_AVG_POWER:uint=73;

        public static const FUNC_LAP_LAST_LAP_NP:uint=76;

        public static const FUNC_LAP_MAX_ALTITUDE_PER_LAP:uint=64;

        public static const FUNC_LAP_MAX_CAD:uint=78;

        public static const FUNC_LAP_MAX_HR:uint=80;

        public static const FUNC_LAP_MAX_POWER:uint=74;

        public static const FUNC_LAP_MAX_SPEED_PER_LAP:uint=61;

        public static const FUNC_LAP_NP:uint=75;

        public static const FUNC_LAP_NUMBER:uint=57;

        public static const FUNC_LAP_PEDALING_INDEX:uint=82;

        public static const FUNC_LAP_PEDALING_TIME:uint=81;

        public static const FUNC_NAVIGATION_DIRECTION:uint=40;

        public static const FUNC_NAVIGATION_DISTANCE_TO_DESTINATION:uint=39;

        public static const FUNC_NAVIGATION_NAVIGATION:uint=41;

        public static const FUNC_NAVIGATION_TIME_OF_ARRIVAL:uint=38;

        public static const FUNC_NAVIGATION_TIME_TO_DESTINATION:uint=37;

        public static const FUNC_NAVIGATION_TRACK_VIEW:uint=42;

        public static const FUNC_PEDALING_INDEX:uint=98;

        public static const FUNC_PEDALING_TIME:uint=97;

        public static const FUNC_POWER_AVG_10_SEC:uint=109;

        public static const FUNC_POWER_AVG_30_SEC:uint=110;

        public static const FUNC_POWER_AVG_3_SEC:uint=108;

        public static const FUNC_POWER_AVG_POWER:uint=107;

        public static const FUNC_POWER_BALANCE:uint=99;

        public static const FUNC_POWER_BALANCE_10_SEC:uint=101;

        public static const FUNC_POWER_BALANCE_30_SEC:uint=102;

        public static const FUNC_POWER_BALANCE_3_SEC:uint=100;

        public static const FUNC_POWER_BALANCE_AVG:uint=103;

        public static const FUNC_POWER_CURRENT_POWER:uint=105;

        public static const FUNC_POWER_FTP_PERCENT:uint=106;

        public static const FUNC_POWER_IF:uint=111;

        public static const FUNC_LAP_TIME:uint=58;

        public static const FUNC_POWER_MAX:uint=112;

        public static const FUNC_POWER_NP:uint=114;

        public static const FUNC_POWER_PEDAL_SMOOTHNESS:uint=104;

        public static const FUNC_POWER_TARGET_ZONE:uint=119;

        public static const FUNC_POWER_TORQUE_EFFECTIVENESS:uint=118;

        public static const FUNC_POWER_TSS:uint=115;

        public static const FUNC_POWER_WATT_KG:uint=116;

        public static const FUNC_POWER_ZONES:uint=117;

        public static const FUNC_STATUS_BATTERY:uint=35;

        public static const FUNC_STATUS_CURRENT_TEMPERATURE:uint=10;

        public static const FUNC_STATUS_GPS_ACCURACY:uint=34;

        public static const FUNC_STATUS_GPS_POSITION:uint=36;

        public static const FUNC_STATUS_MAX_TEMP:uint=12;

        public static const FUNC_STATUS_MIN_TEMP:uint=11;

        public static const FUNC_TIME_CLOCK:uint=8;

        public static const FUNC_TIME_DATE:uint=9;

        internal var _functions:__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>;

        public var sportprofile:core.sportprofiles.Sportprofile;

        internal var _catSortCounter:uint=0;

        public static var currentSportprofile:core.sportprofiles.Sportprofile;

        internal static var _instance:core.sportprofiles.SportprofileFavFunctions;

        internal var _categories:__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionsCategory>;
    }
}


//  class SportprofileFavFunctionsCategory
package core.sportprofiles 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class SportprofileFavFunctionsCategory extends Object
    {
        public function SportprofileFavFunctionsCategory(arg1:*)
        {
            functions = new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>();
            super();
            categoryId = arg1;
            functions = new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>();
            return;
        }

        public function get categoryId():uint
        {
            return _categoryId;
        }

        public function set categoryId(arg1:uint):void
        {
            _categoryId = arg1;
            return;
        }

        public function get label():String
        {
            return utils.LanguageManager.getString("SPORTPROFILE_CATEGORY_" + _categoryId);
        }

        public function addFunction(arg1:core.sportprofiles.SportprofileFavFunctionObject):void
        {
            functions.push(arg1);
            return;
        }

        internal var _categoryId:uint;

        public var functions:__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>;

        internal var _label:String="";

        public var sort:uint=0;
    }
}


//  class SportprofileMapper
package core.sportprofiles 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import core.units.*;
    import core.units.interfaces.*;
    import database.*;
    import handler.*;
    import init.*;
    import utils.*;
    
    public class SportprofileMapper extends Object
    {
        public function SportprofileMapper()
        {
            super();
            return;
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.sportprofiles.Sportprofile):String
        {
            return "SELECT sportprofileId FROM Sportprofiles WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE Sportprofiles SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS UnitGUIDonSportprofile ON Sportprofiles (unitGUID)";
            return loc1;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (500 === loc2) 
            {
                DB_TABLE_500 = new database.DatabaseTable("Sportprofiles");
                DB_TABLE_500.addColumns([["sportprofileId", "INTEGER", false, true, true], ["GUID", "VARCHAR UNIQUE", false], ["unitGUID", "VARCHAR", false], ["modificationDate", "NUMERIC", true], ["isDeleted", "BOOL", true], ["sportId", "INTEGER", true], ["profileName", "VARCHAR", true], ["autoPause", "BOOLEAN", true], ["autoLap", "INTEGER", true], ["autoLapDistance", "INTEGER", true], ["autoLapCalories", "INTEGER", true], ["autoLapTime", "INTEGER", true], ["set_alert_basedon_distance", "VARCHAR", true], ["set_alert_basedon_time", "VARCHAR", true], ["set_alert_basedon_kcal", "VARCHAR", true], ["set_bike_name", "VARCHAR", true], ["set_bike_wheel_size", "INTEGER", true], ["set_bike_weight", "INTEGER", true], ["set_bike_type", "VARCHAR", true], ["set_avg_calc_power_inclzero", "VARCHAR", true], ["set_avg_calc_cad_inclzero", "VARCHAR", true], ["set_powerones_ftp", "VARCHAR", true], ["powerIntensityZone1Start", "INTEGER", true], ["powerIntensityZone2Start", "INTEGER", true], ["powerIntensityZone3Start", "INTEGER", true], ["powerIntensityZone4Start", "INTEGER", true], ["powerIntensityZone5Start", "INTEGER", true], ["powerIntensityZone6Start", "INTEGER", true], ["powerIntensityZone7Start", "INTEGER", true], ["powerIntensityZone7End", "INTEGER", true], ["intensityZone1", "NUMERIC", true], ["intensityZone2", "NUMERIC", true], ["intensityZone3", "NUMERIC", true], ["intensityZone4", "NUMERIC", true], ["intensityZone4End", "NUMERIC", true], ["gpsStatus", "BOOLEAN", true], ["fav_set_1", "VARCHAR", true], ["fav_set_2", "VARCHAR", true], ["fav_set_3", "VARCHAR", true], ["fav_set_4", "VARCHAR", true], ["fav_set_5", "VARCHAR", true], ["fav_set_6", "VARCHAR", true], ["fav_set_7", "VARCHAR", true], ["fav_set_8", "VARCHAR", true], ["fav_set_9", "VARCHAR", true], ["fav_set_10", "VARCHAR", true]]);
                loc1 = DB_TABLE_500;
            }
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Sportprofiles (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectSportprofiles(arg1:String, arg2:String="profileName", arg3:Boolean=false):String
        {
            return "SELECT * FROM Sportprofiles where unitGUID = \'" + arg1 + "\' and isDeleted = false ORDER BY " + arg2 + (arg3 ? " ASC" : " DESC");
        }

        public static function generateXML(arg1:core.sportprofiles.Sportprofile):XML
        {
            var loc1:*=new XML("<Sportprofile/>");
            loc1.sportId = arg1.sportId;
            loc1.GUID = arg1.GUID;
            loc1.unitGUID = arg1.unitGUID;
            loc1.unitType = arg1.unit.type.toString();
            loc1.profileName = arg1.profileName;
            loc1.modificationDate = arg1.modificationDate;
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                loc1.autoPause = (arg1 as core.settings.interfaces.IAutoPause).autoPause ? "true" : "false";
            }
            if (arg1 is core.settings.interfaces.IAutoLap) 
            {
                loc1.autoLap = (arg1 as core.settings.interfaces.IAutoLap).autoLap;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                loc1.autoLapBasedOnDistance = (arg1 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                loc1.autoLapBasedOnCalories = (arg1 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                loc1.autoLapBasedOnTime = (arg1 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime;
            }
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                loc1.wheelSize1 = (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                loc1.bikeWeight1 = (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1;
            }
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                loc1.bikeType1 = (arg1 as core.settings.interfaces.IBikeType1).bikeType1;
            }
            if (arg1 is core.settings.interfaces.IPowerFTP) 
            {
                loc1.thresholdPower = (arg1 as core.settings.interfaces.IPowerFTP).powerFTP;
            }
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc1.powerIntensityZone1Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start;
                loc1.powerIntensityZone2Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start;
                loc1.powerIntensityZone3Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start;
                loc1.powerIntensityZone4Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start;
                loc1.powerIntensityZone5Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start;
                loc1.powerIntensityZone6Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start;
                loc1.powerIntensityZone7Start = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start;
                loc1.powerIntensityZone7End = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc1.intensityZone1PercentageStart = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
                loc1.intensityZone2PercentageStart = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
                loc1.intensityZone3PercentageStart = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
                loc1.intensityZone4PercentageStart = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
                loc1.intensityZone4PercentageEnd = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd;
            }
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                loc1.gpsStatus = (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus ? "true" : "false";
            }
            if (arg1 is core.settings.interfaces.IFavSets) 
            {
                loc1.fav_set_1 = (arg1 as core.settings.interfaces.IFavSets).fav_set_1;
                loc1.fav_set_2 = (arg1 as core.settings.interfaces.IFavSets).fav_set_2;
                loc1.fav_set_3 = (arg1 as core.settings.interfaces.IFavSets).fav_set_3;
                loc1.fav_set_4 = (arg1 as core.settings.interfaces.IFavSets).fav_set_4;
                loc1.fav_set_5 = (arg1 as core.settings.interfaces.IFavSets).fav_set_5;
                loc1.fav_set_6 = (arg1 as core.settings.interfaces.IFavSets).fav_set_6;
                loc1.fav_set_7 = (arg1 as core.settings.interfaces.IFavSets).fav_set_7;
                loc1.fav_set_8 = (arg1 as core.settings.interfaces.IFavSets).fav_set_8;
                loc1.fav_set_9 = (arg1 as core.settings.interfaces.IFavSets).fav_set_9;
                loc1.fav_set_10 = (arg1 as core.settings.interfaces.IFavSets).fav_set_10;
            }
            if (arg1 is core.settings.interfaces.ILapFavSets) 
            {
                loc1.lap_fav_set_1 = (arg1 as core.settings.interfaces.ILapFavSets).lap_fav_set_1;
            }
            if (arg1 is core.settings.interfaces.IAutoLapFavSets) 
            {
                loc1.auto_lap_fav_set_1 = (arg1 as core.settings.interfaces.IAutoLapFavSets).auto_lap_fav_set_1;
            }
            if (arg1 is core.settings.interfaces.IAlarmDistance) 
            {
                loc1.alarmDistance = (arg1 as core.settings.interfaces.IAlarmDistance).alarmDistance ? "true" : "false";
                loc1.alarmDistanceBase = (arg1 as core.settings.interfaces.IAlarmDistance).alarmDistanceBase;
            }
            if (arg1 is core.settings.interfaces.IAlarmTime) 
            {
                loc1.alarmTime = (arg1 as core.settings.interfaces.IAlarmTime).alarmTime ? "true" : "false";
                loc1.alarmTimeBase = (arg1 as core.settings.interfaces.IAlarmTime).alarmTimeBase;
            }
            if (arg1 is core.settings.interfaces.IAlarmCalories) 
            {
                loc1.alarmCalories = (arg1 as core.settings.interfaces.IAlarmCalories).alarmCalories ? "true" : "false";
                loc1.alarmCaloriesBase = (arg1 as core.settings.interfaces.IAlarmCalories).alarmCaloriesBase;
            }
            if (arg1 is core.settings.interfaces.IAutoWheelsize) 
            {
                loc1.autoWheelsize = (arg1 as core.settings.interfaces.IAutoWheelsize).autoWheelsize ? "true" : "false";
            }
            if (arg1 is core.settings.interfaces.IAvgCadInclZero) 
            {
                loc1.avgCadInclZero = (arg1 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero;
            }
            if (arg1 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                loc1.avgPowerInclZero = (arg1 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero;
            }
            return loc1;
        }

        public static function fromXML(arg1:XML):core.sportprofiles.Sportprofile
        {
            var loc3:*=undefined;
            arg1.normalize();
            var loc2:*=arg1.name();
            if (loc2.localName != "Sportprofile") 
            {
                return null;
            }
            var loc1:*=core.general.UnitType.fromString(arg1.unitType);
            var loc4:*;
            (loc4 = core.sportprofiles.SportprofileFactory.createSportprofileFromUnitType(loc1)).sportId = arg1.sportId;
            loc4.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(loc4.sportId);
            loc4.GUID = arg1.GUID;
            loc4.unitGUID = arg1.unitGUID;
            loc4.unit = handler.AppDeviceHandlerCommon.deviceDicGUID[loc4.unitGUID];
            loc4.profileName = arg1.profileName;
            loc4.modificationDate = arg1.modificationDate;
            if (loc4 is core.settings.interfaces.IAutoPause) 
            {
                if ((loc3 = arg1.autoPause) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoPause).autoPause = loc3 != "true" ? false : true;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoLap) 
            {
                if ((loc3 = arg1.autoLap) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLap).autoLap = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                if ((loc3 = arg1.autoLapBasedOnDistance) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                if ((loc3 = arg1.autoLapBasedOnCalories) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                if ((loc3 = arg1.autoLapBasedOnTime) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IWheelSize1) 
            {
                if ((loc3 = arg1.wheelSize1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IWheelSize1).wheelSize1 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IBikeWeight1) 
            {
                if ((loc3 = arg1.bikeWeight1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IBikeType1) 
            {
                if ((loc3 = arg1.bikeType1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IBikeType1).bikeType1 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IPowerFTP) 
            {
                if ((loc3 = arg1.thresholdPower) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerFTP).powerFTP = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IPowerIntensityZone) 
            {
                if ((loc3 = arg1.powerIntensityZone1Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone2Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone3Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone4Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone5Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone6Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone7Start) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start = loc3;
                }
                if ((loc3 = arg1.powerIntensityZone7End) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End = loc3;
                }
            }
            if (loc4 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                if ((loc3 = arg1.intensityZone1PercentageStart) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart = loc3;
                }
                if ((loc3 = arg1.intensityZone2PercentageStart) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart = loc3;
                }
                if ((loc3 = arg1.intensityZone3PercentageStart) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart = loc3;
                }
                if ((loc3 = arg1.intensityZone4PercentageStart) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart = loc3;
                }
                if ((loc3 = arg1.intensityZone4PercentageEnd) != undefined) 
                {
                    (loc4 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IGPSStatus) 
            {
                if ((loc3 = arg1.gpsStatus) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IGPSStatus).gpsStatus = loc3 != "true" ? false : true;
                }
            }
            if (loc4 is core.settings.interfaces.IFavSets) 
            {
                if ((loc3 = arg1.fav_set_1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_1 = loc3;
                }
                if ((loc3 = arg1.fav_set_2) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_2 = loc3;
                }
                if ((loc3 = arg1.fav_set_3) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_3 = loc3;
                }
                if ((loc3 = arg1.fav_set_4) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_4 = loc3;
                }
                if ((loc3 = arg1.fav_set_5) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_5 = loc3;
                }
                if ((loc3 = arg1.fav_set_6) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_6 = loc3;
                }
                if ((loc3 = arg1.fav_set_7) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_7 = loc3;
                }
                if ((loc3 = arg1.fav_set_8) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_8 = loc3;
                }
                if ((loc3 = arg1.fav_set_9) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_9 = loc3;
                }
                if ((loc3 = arg1.fav_set_10) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IFavSets).fav_set_10 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.ILapFavSets) 
            {
                if ((loc3 = arg1.lap_fav_set_1) != undefined) 
                {
                    (loc4 as core.settings.interfaces.ILapFavSets).lap_fav_set_1 = loc3;
                }
                if ((loc3 = arg1.lap_fav_set_2) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoLapFavSets).auto_lap_fav_set_1 = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAlarmDistance) 
            {
                if ((loc3 = arg1.alarmDistance) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmDistance).alarmDistance = loc3 != "true" ? false : true;
                }
                if ((loc3 = arg1.alarmDistanceBase) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmDistance).alarmDistanceBase = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAlarmTime) 
            {
                if ((loc3 = arg1.alarmTime) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmTime).alarmTime = loc3 != "true" ? false : true;
                }
                if ((loc3 = arg1.alarmTimeBase) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmTime).alarmTimeBase = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAlarmCalories) 
            {
                if ((loc3 = arg1.alarmCalories) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmCalories).alarmCalories = loc3 != "true" ? false : true;
                }
                if ((loc3 = arg1.alarmCaloriesBase) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAlarmCalories).alarmCaloriesBase = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAutoWheelsize) 
            {
                if ((loc3 = arg1.autoWheelsize) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAutoWheelsize).autoWheelsize = loc3 != "true" ? false : true;
                }
            }
            if (loc4 is core.settings.interfaces.IAvgCadInclZero) 
            {
                if ((loc3 = arg1.avgCadInclZero) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero = loc3;
                }
            }
            if (loc4 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                if ((loc3 = arg1.avgPowerInclZero) != undefined) 
                {
                    (loc4 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero = loc3;
                }
            }
            return loc4;
        }

        public static function generateDBInsert(arg1:core.sportprofiles.Sportprofile, arg2:Array, arg3:Object):void
        {
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            var loc1:*=0;
            arg2.push("sportprofileId");
            ++loc1;
            arg3[loc1] = arg1.sportprofileId > 0 ? arg1.sportprofileId : null;
            arg2.push("GUID");
            ++loc1;
            arg3[loc1] = arg1.GUID;
            arg2.push("unitGUID");
            ++loc1;
            arg3[loc1] = arg1.unitGUID;
            arg2.push("modificationDate");
            ++loc1;
            arg3[loc1] = arg1.modificationDate;
            arg2.push("isDeleted");
            ++loc1;
            arg3[loc1] = arg1.isDeleted;
            arg2.push("sportId");
            ++loc1;
            arg3[loc1] = arg1.sportId;
            arg2.push("profileName");
            ++loc1;
            arg3[loc1] = arg1.profileName;
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                arg2.push("autoPause");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoPause).autoPause;
            }
            if (arg1 is core.settings.interfaces.IAutoLap) 
            {
                arg2.push("autoLap");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLap).autoLap;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                arg2.push("autoLapDistance");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                arg2.push("autoLapCalories");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories;
            }
            if (arg1 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                arg2.push("autoLapTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime;
            }
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                arg2.push("wheelSize1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                arg2.push("bikeWeight1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1;
            }
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                arg2.push("bikeType1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeType1).bikeType1;
            }
            if (arg1 is core.settings.interfaces.IPowerFTP) 
            {
                arg2.push("powerFTP");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerFTP).powerFTP;
            }
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                arg2.push("powerIntensityZone1Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start;
                arg2.push("powerIntensityZone2Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start;
                arg2.push("powerIntensityZone3Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start;
                arg2.push("powerIntensityZone4Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start;
                arg2.push("powerIntensityZone5Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start;
                arg2.push("powerIntensityZone6Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start;
                arg2.push("powerIntensityZone7Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start;
                arg2.push("powerIntensityZone7End");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone1");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
                arg2.push("intensityZone2");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
                arg2.push("intensityZone3");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
                arg2.push("intensityZone4");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
                arg2.push("intensityZone4End");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd;
            }
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                arg2.push("gpsStatus");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus;
            }
            if (arg1 is core.settings.interfaces.IFavSets) 
            {
                arg2.push("fav_set_1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_1;
                arg2.push("fav_set_2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_2;
                arg2.push("fav_set_3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_3;
                arg2.push("fav_set_4");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_4;
                arg2.push("fav_set_5");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_5;
                arg2.push("fav_set_6");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_6;
                arg2.push("fav_set_7");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_7;
                arg2.push("fav_set_8");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_8;
                arg2.push("fav_set_9");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_9;
                arg2.push("fav_set_10");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavSets).fav_set_10;
            }
            if (arg1 is core.settings.interfaces.ILapFavSets) 
            {
                arg2.push("lap_fav_set_1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ILapFavSets).lap_fav_set_1;
            }
            if (arg1 is core.settings.interfaces.IAutoLapFavSets) 
            {
                arg2.push("auto_lap_fav_set_1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoLapFavSets).auto_lap_fav_set_1;
            }
            if (arg1 is core.settings.interfaces.IAlarmDistance) 
            {
                arg2.push("alarmDistance");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmDistance).alarmDistance;
                arg2.push("alarmDistanceBase");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmDistance).alarmDistanceBase;
            }
            if (arg1 is core.settings.interfaces.IAlarmTime) 
            {
                arg2.push("alarmTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmTime).alarmTime;
                arg2.push("alarmTimeBase");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmTime).alarmTimeBase;
            }
            if (arg1 is core.settings.interfaces.IAlarmCalories) 
            {
                arg2.push("alarmCalories");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmCalories).alarmCalories;
                arg2.push("alarmCaloriesBase");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmCalories).alarmCaloriesBase;
            }
            if (arg1 is core.settings.interfaces.IAutoWheelsize) 
            {
                arg2.push("autoWheelsize");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoWheelsize).autoWheelsize;
            }
            if (arg1 is core.settings.interfaces.IAvgCadInclZero) 
            {
                arg2.push("avgCadInclZero");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero;
            }
            if (arg1 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                arg2.push("avgPowerInclZero");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero;
            }
            return;
        }

        public static function fromDB(arg1:Object, arg2:core.sportprofiles.Sportprofile, arg3:core.units.Unit=null):core.sportprofiles.Sportprofile
        {
            if (!arg2) 
            {
                if (arg3) 
                {
                    arg2 = core.sportprofiles.SportprofileFactory.createSportprofileFromUnitType(arg3.type);
                    arg2.unit = arg3;
                }
                else 
                {
                    arg2 = new core.sportprofiles.Sportprofile();
                }
            }
            arg2.sportprofileId = arg1["sportprofileId"];
            arg2.GUID = arg1["GUID"];
            arg2.unitGUID = arg1["unitGUID"];
            arg2.modificationDate = arg1["modificationDate"];
            arg2.isDeleted = arg1["isDeleted"];
            arg2.sportId = arg1["sportId"];
            arg2.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(arg2.sportId);
            arg2.profileName = arg1["profileName"];
            if (arg2 is core.settings.interfaces.IAutoPause) 
            {
                (arg2 as core.settings.interfaces.IAutoPause).autoPause = arg1["autoPause"];
            }
            if (arg2 is core.settings.interfaces.IAutoLap) 
            {
                (arg2 as core.settings.interfaces.IAutoLap).autoLap = arg1["autoLap"];
                (arg2 as core.settings.interfaces.IAutoLap).autoLapBasedOn = (arg2 as core.settings.interfaces.IAutoLap).autoLap > 0 ? ((arg2 as core.settings.interfaces.IAutoLap).autoLap - 1) : (arg2 as core.settings.interfaces.IAutoLap).autoLap;
            }
            if (arg2 is core.settings.interfaces.IAutoLapBasedOnDistance) 
            {
                (arg2 as core.settings.interfaces.IAutoLapBasedOnDistance).autoLapDistance = arg1["autoLapDistance"];
            }
            if (arg2 is core.settings.interfaces.IAutoLapBasedOnCalories) 
            {
                (arg2 as core.settings.interfaces.IAutoLapBasedOnCalories).autoLapCalories = arg1["autoLapCalories"];
            }
            if (arg2 is core.settings.interfaces.IAutoLapBasedOnTime) 
            {
                (arg2 as core.settings.interfaces.IAutoLapBasedOnTime).autoLapTime = arg1["autoLapTime"];
            }
            if (arg2 is core.settings.interfaces.IWheelSize1) 
            {
                (arg2 as core.settings.interfaces.IWheelSize1).wheelSize1 = arg1["wheelSize1"];
            }
            if (arg2 is core.settings.interfaces.IBikeWeight1) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = arg1["bikeWeight1"];
            }
            if (arg2 is core.settings.interfaces.IBikeType1) 
            {
                (arg2 as core.settings.interfaces.IBikeType1).bikeType1 = arg1["bikeType1"];
            }
            if (arg2 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start = arg1["powerIntensityZone1Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start = arg1["powerIntensityZone2Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start = arg1["powerIntensityZone3Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start = arg1["powerIntensityZone4Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start = arg1["powerIntensityZone5Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start = arg1["powerIntensityZone6Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start = arg1["powerIntensityZone7Start"];
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End = arg1["powerIntensityZone7End"];
            }
            if (arg2 is core.settings.interfaces.IPowerFTP) 
            {
                (arg2 as core.settings.interfaces.IPowerFTP).powerFTP = arg1["powerFTP"];
            }
            if (arg2 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart = arg1["intensityZone1"];
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart = arg1["intensityZone2"];
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart = arg1["intensityZone3"];
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart = arg1["intensityZone4"];
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd = arg1["intensityZone4End"];
            }
            if (arg2 is core.settings.interfaces.IGPSStatus) 
            {
                (arg2 as core.settings.interfaces.IGPSStatus).gpsStatus = arg1["gpsStatus"];
            }
            if (arg2 is core.settings.interfaces.IFavSets) 
            {
                (arg2 as core.settings.interfaces.IFavSets).fav_set_1 = arg1["fav_set_1"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_2 = arg1["fav_set_2"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_3 = arg1["fav_set_3"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_4 = arg1["fav_set_4"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_5 = arg1["fav_set_5"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_6 = arg1["fav_set_6"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_7 = arg1["fav_set_7"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_8 = arg1["fav_set_8"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_9 = arg1["fav_set_9"];
                (arg2 as core.settings.interfaces.IFavSets).fav_set_10 = arg1["fav_set_10"];
            }
            if (arg2 is core.settings.interfaces.ILapFavSets) 
            {
                (arg2 as core.settings.interfaces.ILapFavSets).lap_fav_set_1 = arg1["lap_fav_set_1"];
            }
            if (arg2 is core.settings.interfaces.IAutoLapFavSets) 
            {
                (arg2 as core.settings.interfaces.IAutoLapFavSets).auto_lap_fav_set_1 = arg1["auto_lap_fav_set_1"];
            }
            if (arg2 is core.settings.interfaces.IAlarmDistance) 
            {
                (arg2 as core.settings.interfaces.IAlarmDistance).alarmDistance = arg1["alarmDistance"];
                (arg2 as core.settings.interfaces.IAlarmDistance).alarmDistanceBase = arg1["alarmDistanceBase"];
            }
            if (arg2 is core.settings.interfaces.IAlarmTime) 
            {
                (arg2 as core.settings.interfaces.IAlarmTime).alarmTime = arg1["alarmTime"];
                (arg2 as core.settings.interfaces.IAlarmTime).alarmTimeBase = arg1["alarmTimeBase"];
            }
            if (arg2 is core.settings.interfaces.IAlarmCalories) 
            {
                (arg2 as core.settings.interfaces.IAlarmCalories).alarmCalories = arg1["alarmCalories"];
                (arg2 as core.settings.interfaces.IAlarmCalories).alarmCaloriesBase = arg1["alarmCaloriesBase"];
            }
            if (arg2 is core.settings.interfaces.IAutoWheelsize) 
            {
                (arg2 as core.settings.interfaces.IAutoWheelsize).autoWheelsize = arg1["autoWheelsize"];
            }
            if (arg2 is core.settings.interfaces.IAvgCadInclZero) 
            {
                (arg2 as core.settings.interfaces.IAvgCadInclZero).avgCadInclZero = arg1["avgCadInclZero"];
            }
            if (arg2 is core.settings.interfaces.IAvgPowerInclZero) 
            {
                (arg2 as core.settings.interfaces.IAvgPowerInclZero).avgPowerInclZero = arg1["avgPowerInclZero"];
            }
            return arg2;
        }

        public static function generateDBDelete(arg1:core.sportprofiles.Sportprofile):String
        {
            return "delete from Sportprofiles where Sportprofiles.GUID = " + arg1.GUID;
        }

        public static const col_alarmDistanceBase:String="alarmDistanceBase";

        public static const col_alarmTime:String="alarmTime";

        public static const col_alarmTimeBase:String="alarmTimeBase";

        public static const col_autoLap:String="autoLap";

        public static const col_autoLapBasedOn:String="autoLapBasedOn";

        public static const col_autoLapCalories:String="autoLapCalories";

        public static const col_autoLapDistance:String="autoLapDistance";

        public static const col_autoLapTime:String="autoLapTime";

        public static const col_autoPause:String="autoPause";

        public static const col_autoWheelsize:String="autoWheelsize";

        public static const col_auto_lap_fav_set_1:String="auto_lap_fav_set_1";

        public static const col_avgCadInclZero:String="avgCadInclZero";

        public static const col_avgPowerInclZero:String="avgPowerInclZero";

        public static const col_bikeType1:String="bikeType1";

        public static const col_bikeWeight1:String="bikeWeight1";

        public static const col_fav_set_1:String="fav_set_1";

        public static const col_fav_set_10:String="fav_set_10";

        public static const col_fav_set_2:String="fav_set_2";

        public static const col_fav_set_3:String="fav_set_3";

        public static const col_fav_set_4:String="fav_set_4";

        public static const col_fav_set_5:String="fav_set_5";

        public static const col_fav_set_6:String="fav_set_6";

        public static const col_fav_set_7:String="fav_set_7";

        public static const col_GUID:String="GUID";

        public static const col_fav_set_9:String="fav_set_9";

        public static const col_gpsStatus:String="gpsStatus";

        public static const col_intensityZone1:String="intensityZone1";

        public static const col_intensityZone2:String="intensityZone2";

        public static const col_intensityZone3:String="intensityZone3";

        public static const col_intensityZone4:String="intensityZone4";

        public static const col_intensityZone4End:String="intensityZone4End";

        public static const col_isDeleted:String="isDeleted";

        public static const col_lap_fav_set_1:String="lap_fav_set_1";

        public static const col_modificationDate:String="modificationDate";

        public static const col_powerFTP:String="powerFTP";

        public static const col_powerIntensityZone1Start:String="powerIntensityZone1Start";

        public static const col_powerIntensityZone2Start:String="powerIntensityZone2Start";

        public static const col_powerIntensityZone3Start:String="powerIntensityZone3Start";

        public static const col_powerIntensityZone4Start:String="powerIntensityZone4Start";

        public static const col_powerIntensityZone5Start:String="powerIntensityZone5Start";

        public static const col_powerIntensityZone6Start:String="powerIntensityZone6Start";

        public static const col_powerIntensityZone7End:String="powerIntensityZone7End";

        public static const col_profileName:String="profileName";

        public static const col_sportId:String="sportId";

        public static const col_sportprofileId:String="sportprofileId";

        public static const col_unitGUID:String="unitGUID";

        public static const col_wheelSize1:String="wheelSize1";

        public static const col_fav_set_8:String="fav_set_8";

        public static const ATTR_SQL_STATEMENT:String="sqlStatement";

        public static const ATTR_SQL_UPDATE_LINES:String="sqlUpdateLines";

        public static const INDEX_NAME:String="UnitGUIDonSportprofile";

        public static const TABLE_NAME:String="Sportprofiles";

        public static const col_alarmCalories:String="alarmCalories";

        public static const col_alarmCaloriesBase:String="alarmCaloriesBase";

        public static const col_alarmDistance:String="alarmDistance";

        public static const col_powerIntensityZone7Start:String="powerIntensityZone7Start";

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;
    }
}


