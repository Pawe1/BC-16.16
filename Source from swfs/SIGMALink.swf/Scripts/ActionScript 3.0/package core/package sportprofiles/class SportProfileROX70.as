//class SportProfileROX70
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


