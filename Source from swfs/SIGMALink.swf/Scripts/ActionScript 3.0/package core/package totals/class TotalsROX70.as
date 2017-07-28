//class TotalsROX70
package core.totals 
{
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsROX70 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalCal1, core.totals.interfaces.ITotalDescent1, core.totals.interfaces.ITotalClimbMeter1, core.totals.interfaces.ITotalActivityCount1
    {
        public function TotalsROX70(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get totalTrainingTime1Max():uint
        {
            return 3599999900;
        }

        public function get totalActivityCount1():uint
        {
            return _totalActivityCount1;
        }

        public function set totalActivityCount1(arg1:uint):void
        {
            if (arg1 != _totalActivityCount1) 
            {
                _totalActivityCount1 = arg1;
                dispatchEvent(new flash.events.Event("totalActivityCount1Change"));
            }
            return;
        }

        public function get totalActivityCount1Max():uint
        {
            return 99999;
        }

        public function get totalActivityCount1Min():uint
        {
            return 0;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-totalTrainingTime1 " + totalTrainingTime1.toString();
        }

        public function get totalCal1():int
        {
            return _totalCal1;
        }

        public function set totalCal1(arg1:int):void
        {
            if (arg1 != _totalCal1) 
            {
                _totalCal1 = arg1;
                dispatchEvent(new flash.events.Event("totalCal1Change"));
            }
            return;
        }

        public function get totalCal1Max():int
        {
            return 999999;
        }

        public function get totalCal1Min():int
        {
            return 0;
        }

        public override function resetValues():void
        {
            super.resetValues();
            totalTrainingTime1 = 0;
            totalClimbMeter1 = 0;
            totalCal1 = 0;
            totalDescent1 = 0;
            return;
        }

        public function get totalClimbMeter1():int
        {
            return _totalClimbMeter1;
        }

        public function set totalClimbMeter1(arg1:int):void
        {
            if (arg1 != _totalClimbMeter1) 
            {
                _totalClimbMeter1 = arg1;
                dispatchEvent(new flash.events.Event("totalClimbMeter1Change"));
            }
            return;
        }

        public function get totalClimbMeter1Max():int
        {
            return 999999000;
        }

        public function get totalClimbMeter1Min():int
        {
            return 0;
        }

        public override function toString():String
        {
            return "[TotalsROX100 extends TotalsBikeComputer implements ITotalTrainingTime1, ITotalTrainingTime2,...]";
        }

        public function get totalDescent1():int
        {
            return _totalDescent1;
        }

        public function set totalDescent1(arg1:int):void
        {
            if (arg1 != _totalDescent1) 
            {
                _totalDescent1 = arg1;
                dispatchEvent(new flash.events.Event("totalDescent1Change"));
            }
            return;
        }

        public function get totalDescent1Max():int
        {
            return 999999000;
        }

        public function get totalDescent1Min():int
        {
            return 0;
        }

        public override function get totalDistance1Max():Number
        {
            return 99999000;
        }

        public override function get totalDistance1Min():Number
        {
            return 0;
        }

        public function get totalTrainingTime1():uint
        {
            return _totalTrainingTime1;
        }

        public function set totalTrainingTime1(arg1:uint):void
        {
            if (arg1 != _totalTrainingTime1) 
            {
                _totalTrainingTime1 = arg1;
                dispatchEvent(new flash.events.Event("totalTrainingTime1Change"));
            }
            return;
        }

        public static const MAX_ALTI_FT_MAX:int=16999000;

        public static const MAX_ALTI_FT_MIN:int=-999000;

        public static const MAX_ALTI_M_MAX:int=4999000;

        public static const MAX_ALTI_M_MIN:int=-999000;

        public static const TOTAL_ALTI_MAX:int=999999000;

        public static const TOTAL_ALTI_MIN:int=0;

        public static const TOTAL_ALTI_M_MAX:int=999999000;

        public static const TOTAL_ALTI_M_MIN:int=0;

        public static const TOTAL_KCAL_BIKE_MAX:int=999999;

        public static const TOTAL_KCAL_BIKE_MIN:int=0;

        public static const TOT_DIST_BIKE_M_MAX:int=99999000;

        public static const TOT_DIST_BIKE_M_MIN:int=0;

        public static const TOT_TIME_BIKE_MAX_HOURS:int=9999000;

        internal static const TOT_ACTIVITY_MAX:uint=99999;

        internal static const TOT_TIME_BIKE_MAX:uint=3599999900;

        internal var _totalActivityCount1:uint;

        internal var _totalCal1:int;

        internal var _totalClimbMeter1:int;

        internal var _totalDescent1:int;

        internal var _totalTrainingTime1:uint;
    }
}


