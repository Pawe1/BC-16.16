//class TotalsROX100
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsROX100 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalTrainingTime2, core.totals.interfaces.ITotalTrainingTime3, core.totals.interfaces.ITotalTripDistDown1, core.totals.interfaces.ITotalTripDistDown2, core.totals.interfaces.ITotalTripDistDown3, core.totals.interfaces.ITotalTripDistUp1, core.totals.interfaces.ITotalTripDistUp2, core.totals.interfaces.ITotalTripDistUp3, core.totals.interfaces.ITotalTimeDown1, core.totals.interfaces.ITotalTimeDown2, core.totals.interfaces.ITotalTimeDown3, core.totals.interfaces.ITotalTimeUp1, core.totals.interfaces.ITotalTimeUp2, core.totals.interfaces.ITotalTimeUp3, core.totals.interfaces.ITotalCal1, core.totals.interfaces.ITotalCal2, core.totals.interfaces.ITotalCal3, core.totals.interfaces.ITotalDescent1, core.totals.interfaces.ITotalDescent2, core.totals.interfaces.ITotalDescent3, core.totals.interfaces.ITotalDistance2, core.totals.interfaces.ITotalDistance3, core.totals.interfaces.ITotalClimbMeter1, core.totals.interfaces.ITotalClimbMeter2, core.totals.interfaces.ITotalClimbMeter3, core.totals.interfaces.IMaxAltitude1, core.totals.interfaces.IMaxAltitude2, core.totals.interfaces.IMaxAltitude3
    {
        public function TotalsROX100(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get totalTripDistDown3Min():Number
        {
            return 0;
        }

        public function get maxAltitude1():int
        {
            return _maxAltitude1;
        }

        public function set maxAltitude1(arg1:int):void
        {
            if (arg1 != _maxAltitude1) 
            {
                _maxAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("maxAltitude1Change"));
            }
            return;
        }

        public function get maxAltitude1Max():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 16999000;
        }

        public function get maxAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -999000;
            }
            return -999000;
        }

        public function get totalTripDistUp1():Number
        {
            return _totalTripDistUp1;
        }

        public function get maxAltitude2():int
        {
            return _maxAltitude2;
        }

        public function set maxAltitude2(arg1:int):void
        {
            if (arg1 != _maxAltitude2) 
            {
                _maxAltitude2 = arg1;
                dispatchEvent(new flash.events.Event("maxAltitude2Change"));
            }
            return;
        }

        public function get maxAltitude2Max():int
        {
            return maxAltitude1Max;
        }

        public function get maxAltitude2Min():int
        {
            return maxAltitude1Min;
        }

        public function set totalTripDistUp1(arg1:Number):void
        {
            if (arg1 != _totalTripDistUp1) 
            {
                _totalTripDistUp1 = arg1;
                dispatchEvent(new flash.events.Event("totalTripDistUp1Change"));
            }
            return;
        }

        public function get maxAltitude3():int
        {
            return _maxAltitude3;
        }

        public function set maxAltitude3(arg1:int):void
        {
            if (arg1 != _maxAltitude3) 
            {
                _maxAltitude3 = arg1;
                dispatchEvent(new flash.events.Event("maxAltitude3Change"));
            }
            return;
        }

        public function get maxAltitude3Max():int
        {
            return maxAltitude1Max;
        }

        public function get maxAltitude3Min():int
        {
            return maxAltitude1Min;
        }

        public function get totalTripDistUp1Max():Number
        {
            return 99999000;
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

        public function get totalTripDistUp1Min():Number
        {
            return 0;
        }

        public function get totalCal2():int
        {
            return _totalCal2;
        }

        public function set totalCal2(arg1:int):void
        {
            if (arg1 != _totalCal2) 
            {
                _totalCal2 = arg1;
                dispatchEvent(new flash.events.Event("totalCal2Change"));
            }
            return;
        }

        public function get totalCal2Max():int
        {
            return 999999;
        }

        public function get totalCal2Min():int
        {
            return 0;
        }

        public function get totalTripDistUp2():Number
        {
            return _totalTripDistUp2;
        }

        public function get totalCal3():int
        {
            return _totalCal3;
        }

        public function set totalCal3(arg1:int):void
        {
            if (arg1 != _totalCal3) 
            {
                _totalCal3 = arg1;
                dispatchEvent(new flash.events.Event("totalCal3Change"));
            }
            return;
        }

        public function get totalCal3Max():int
        {
            return 999999;
        }

        public function get totalCal3Min():int
        {
            return 0;
        }

        public function set totalTripDistUp2(arg1:Number):void
        {
            if (arg1 != _totalTripDistUp2) 
            {
                _totalTripDistUp2 = arg1;
                dispatchEvent(new flash.events.Event("totalTripDistUp2Change"));
            }
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

        public function get totalTripDistUp2Max():Number
        {
            return 99999000;
        }

        public function get totalClimbMeter2():int
        {
            return _totalClimbMeter2;
        }

        public function set totalClimbMeter2(arg1:int):void
        {
            if (arg1 != _totalClimbMeter2) 
            {
                _totalClimbMeter2 = arg1;
                dispatchEvent(new flash.events.Event("totalClimbMeter2Change"));
            }
            return;
        }

        public function get totalClimbMeter2Max():int
        {
            return 999999000;
        }

        public function get totalClimbMeter2Min():int
        {
            return 0;
        }

        public function get totalTripDistUp2Min():Number
        {
            return 0;
        }

        public function get totalClimbMeter3():int
        {
            return _totalClimbMeter3;
        }

        public function set totalClimbMeter3(arg1:int):void
        {
            if (arg1 != _totalClimbMeter3) 
            {
                _totalClimbMeter3 = arg1;
                dispatchEvent(new flash.events.Event("totalClimbMeter3Change"));
            }
            return;
        }

        public function get totalClimbMeter3Max():int
        {
            return 999999000;
        }

        public function get totalClimbMeter3Min():int
        {
            return 0;
        }

        public function get totalTripDistUp3():Number
        {
            return _totalTripDistUp3;
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

        public function set totalTripDistUp3(arg1:Number):void
        {
            if (arg1 != _totalTripDistUp3) 
            {
                _totalTripDistUp3 = arg1;
                dispatchEvent(new flash.events.Event("totalTripDistUp3Change"));
            }
            return;
        }

        public function get totalDescent2():int
        {
            return _totalDescent2;
        }

        public function set totalDescent2(arg1:int):void
        {
            if (arg1 != _totalDescent2) 
            {
                _totalDescent2 = arg1;
                dispatchEvent(new flash.events.Event("totalDescent2Change"));
            }
            return;
        }

        public function get totalDescent2Max():int
        {
            return 999999000;
        }

        public function get totalDescent2Min():int
        {
            return 0;
        }

        public function get totalTripDistUp3Max():Number
        {
            return 99999000;
        }

        public function get totalDescent3():int
        {
            return _totalDescent3;
        }

        public function set totalDescent3(arg1:int):void
        {
            if (arg1 != _totalDescent3) 
            {
                _totalDescent3 = arg1;
                dispatchEvent(new flash.events.Event("totalDescent3Change"));
            }
            return;
        }

        public function get totalDescent3Max():int
        {
            return 999999000;
        }

        public function get totalDescent3Min():int
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

        public function get totalTripDistUp3Min():Number
        {
            return 0;
        }

        public function get totalDistance2():Number
        {
            return _totalDistance2;
        }

        public function set totalDistance2(arg1:Number):void
        {
            if (arg1 != _totalDistance2) 
            {
                _totalDistance2 = arg1;
                dispatchEvent(new flash.events.Event("totalDistance2Change"));
            }
            return;
        }

        public function get totalDistance2Max():Number
        {
            return 99999000;
        }

        public function get totalDistance2Min():Number
        {
            return 0;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-totalTrainingTime1 " + totalTrainingTime1.toString();
        }

        public function get totalDistance3():Number
        {
            return _totalDistance3;
        }

        public function set totalDistance3(arg1:Number):void
        {
            if (arg1 != _totalDistance3) 
            {
                _totalDistance3 = arg1;
                dispatchEvent(new flash.events.Event("totalDistance3Change"));
            }
            return;
        }

        public function get totalDistance3Max():Number
        {
            return 99999000;
        }

        public function get totalDistance3Min():Number
        {
            return 0;
        }

        public override function resetValues():void
        {
            super.resetValues();
            totalTrainingTime1 = 0;
            totalTrainingTime2 = 0;
            totalTrainingTime3 = 0;
            totalDistance2 = 0;
            totalDistance3 = 0;
            totalClimbMeter1 = 0;
            totalClimbMeter2 = 0;
            totalClimbMeter3 = 0;
            totalTripDistDown1 = 0;
            totalTripDistDown2 = 0;
            totalTripDistDown3 = 0;
            totalTimeDown1 = 0;
            totalTimeDown2 = 0;
            totalTimeDown3 = 0;
            totalTripDistUp1 = 0;
            totalTripDistUp2 = 0;
            totalTripDistUp3 = 0;
            totalCal1 = 0;
            totalCal2 = 0;
            totalCal3 = 0;
            maxAltitude1 = 0;
            maxAltitude2 = 0;
            maxAltitude3 = 0;
            totalDescent1 = 0;
            totalDescent2 = 0;
            totalDescent3 = 0;
            return;
        }

        public function get totalTimeDown1():uint
        {
            return _totalTimeDown1;
        }

        public function set totalTimeDown1(arg1:uint):void
        {
            if (arg1 != _totalTimeDown1) 
            {
                _totalTimeDown1 = arg1;
                dispatchEvent(new flash.events.Event("totalTimeDown1Change"));
            }
            return;
        }

        public function get totalTimeDown1Max():uint
        {
            return 3599999900;
        }

        public override function toString():String
        {
            return "[TotalsROX100 extends TotalsBikeComputer implements ITotalTrainingTime1, ITotalTrainingTime2,...]";
        }

        public function get totalTimeDown2():uint
        {
            return _totalTimeDown2;
        }

        public function set totalTimeDown2(arg1:uint):void
        {
            if (arg1 != _totalTimeDown2) 
            {
                _totalTimeDown2 = arg1;
                dispatchEvent(new flash.events.Event("totalTimeDown2Change"));
            }
            return;
        }

        public function get totalTimeDown2Max():uint
        {
            return 3599999900;
        }

        public function get totalTimeDown3():uint
        {
            return _totalTimeDown3;
        }

        public function set totalTimeDown3(arg1:uint):void
        {
            if (arg1 != _totalTimeDown3) 
            {
                _totalTimeDown3 = arg1;
                dispatchEvent(new flash.events.Event("totalTimeDown3Change"));
            }
            return;
        }

        public function get totalTimeDown3Max():uint
        {
            return 3599999900;
        }

        public function get totalTimeUp1():uint
        {
            return _totalTimeUp1;
        }

        public function set totalTimeUp1(arg1:uint):void
        {
            if (arg1 != _totalTimeUp1) 
            {
                _totalTimeUp1 = arg1;
                dispatchEvent(new flash.events.Event("totalTimeUp1Change"));
            }
            return;
        }

        public function get totalTimeUp1Max():uint
        {
            return 3599999900;
        }

        public function get totalTimeUp2():uint
        {
            return _totalTimeUp2;
        }

        public function set totalTimeUp2(arg1:uint):void
        {
            if (arg1 != _totalTimeUp2) 
            {
                _totalTimeUp2 = arg1;
                dispatchEvent(new flash.events.Event("totalTimeUp2Change"));
            }
            return;
        }

        public function get totalTimeUp2Max():uint
        {
            return 3599999900;
        }

        public function get totalTimeUp3():uint
        {
            return _totalTimeUp3;
        }

        public function set totalTimeUp3(arg1:uint):void
        {
            if (arg1 != _totalTimeUp3) 
            {
                _totalTimeUp3 = arg1;
                dispatchEvent(new flash.events.Event("totalTimeUp3Change"));
            }
            return;
        }

        public function get totalTimeUp3Max():uint
        {
            return 3599999900;
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

        public function get totalTrainingTime1Max():uint
        {
            return 3599999900;
        }

        public function get totalTrainingTime2():uint
        {
            return _totalTrainingTime2;
        }

        public function set totalTrainingTime2(arg1:uint):void
        {
            if (arg1 != _totalTrainingTime2) 
            {
                _totalTrainingTime2 = arg1;
                dispatchEvent(new flash.events.Event("totalTrainingTime2Change"));
            }
            return;
        }

        public function get totalTrainingTime2Max():uint
        {
            return 3599999900;
        }

        public function get totalTrainingTime3():uint
        {
            return _totalTrainingTime3;
        }

        public function set totalTrainingTime3(arg1:uint):void
        {
            if (arg1 != _totalTrainingTime3) 
            {
                _totalTrainingTime3 = arg1;
                dispatchEvent(new flash.events.Event("totalTrainingTime3Change"));
            }
            return;
        }

        public function get totalTrainingTime3Max():uint
        {
            return 3599999900;
        }

        public function get totalTripDistDown1():Number
        {
            return _totalTripDistDown1;
        }

        public function set totalTripDistDown1(arg1:Number):void
        {
            if (arg1 != _totalTripDistDown1) 
            {
                _totalTripDistDown1 = arg1;
                dispatchEvent(new flash.events.Event("totalTripDistDown1Change"));
            }
            return;
        }

        public function get totalTripDistDown1Max():Number
        {
            return 99999000;
        }

        public function get totalTripDistDown1Min():Number
        {
            return 0;
        }

        public function get totalTripDistDown2():Number
        {
            return _totalTripDistDown2;
        }

        public function set totalTripDistDown2(arg1:Number):void
        {
            if (arg1 != _totalTripDistDown2) 
            {
                _totalTripDistDown2 = arg1;
                dispatchEvent(new flash.events.Event("totalTripDistDown2Change"));
            }
            return;
        }

        public function get totalTripDistDown2Max():Number
        {
            return 99999000;
        }

        public function get totalTripDistDown2Min():Number
        {
            return 0;
        }

        public function get totalTripDistDown3():Number
        {
            return _totalTripDistDown3;
        }

        public function set totalTripDistDown3(arg1:Number):void
        {
            if (arg1 != _totalTripDistDown3) 
            {
                _totalTripDistDown3 = arg1;
                dispatchEvent(new flash.events.Event("totalTripDistDown3Change"));
            }
            return;
        }

        public function get totalTripDistDown3Max():Number
        {
            return 99999000;
        }

        public static const TOTAL_KCAL_BIKE_MAX:int=999999;

        public static const MAX_ALTI_FT_MAX:int=16999000;

        public static const MAX_ALTI_FT_MIN:int=-999000;

        public static const MAX_ALTI_M_MAX:int=4999000;

        public static const MAX_ALTI_M_MIN:int=-999000;

        public static const TOTAL_ALTI_MAX:int=999999000;

        public static const TOTAL_ALTI_MIN:int=0;

        public static const TOTAL_ALTI_M_MAX:int=999999000;

        public static const TOTAL_ALTI_M_MIN:int=0;

        public static const TOTAL_KCAL_BIKE_MIN:int=0;

        public static const TOT_DIST_BIKE_M_MAX:int=99999000;

        public static const TOT_DIST_BIKE_M_MIN:int=0;

        public static const TOT_TIME_BIKE_MAX_HOURS:int=9999000;

        internal static const TOT_TIME_BIKE_MAX:uint=3599999900;

        internal var _totalTimeDown1:uint;

        internal var _totalTimeDown2:uint;

        internal var _totalTripDistUp2:Number;

        internal var _totalTripDistDown1:Number;

        internal var _totalTripDistDown3:Number;

        internal var _totalTimeUp2:uint;

        internal var _totalTrainingTime1:uint;

        internal var _totalCal3:int;

        internal var _totalTimeUp3:uint;

        internal var _totalTrainingTime3:uint;

        internal var _totalTripDistUp1:Number;

        internal var _totalTripDistDown2:Number;

        internal var _totalTimeUp1:uint;

        internal var _totalTimeDown3:uint;

        internal var _totalTrainingTime2:uint;

        internal var _maxAltitude1:int;

        internal var _maxAltitude2:int;

        internal var _maxAltitude3:int;

        internal var _totalCal1:int;

        internal var _totalCal2:int;

        internal var _totalClimbMeter1:int;

        internal var _totalClimbMeter2:int;

        internal var _totalClimbMeter3:int;

        internal var _totalTripDistUp3:Number;

        internal var _totalDescent1:int;

        internal var _totalDescent2:int;

        internal var _totalDescent3:int;

        internal var _totalDistance2:Number;

        internal var _totalDistance3:Number;
    }
}


