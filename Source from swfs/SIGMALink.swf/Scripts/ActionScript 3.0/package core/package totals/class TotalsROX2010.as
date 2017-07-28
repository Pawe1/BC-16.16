//class TotalsROX2010
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsROX2010 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalTrainingTime2, core.totals.interfaces.ITotalTripDistDown1, core.totals.interfaces.ITotalTripDistDown2, core.totals.interfaces.ITotalTripDistUp1, core.totals.interfaces.ITotalTripDistUp2, core.totals.interfaces.ITotalTimeDown1, core.totals.interfaces.ITotalTimeDown2, core.totals.interfaces.ITotalTimeUp1, core.totals.interfaces.ITotalTimeUp2, core.totals.interfaces.ITotalCal1, core.totals.interfaces.ITotalCal2, core.totals.interfaces.ITotalDescent1, core.totals.interfaces.ITotalDescent2, core.totals.interfaces.ITotalDistance2, core.totals.interfaces.ITotalClimbMeter1, core.totals.interfaces.ITotalClimbMeter2, core.totals.interfaces.IMaxAltitude1, core.totals.interfaces.IMaxAltitude2
    {
        public function TotalsROX2010(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get totalTripDistUp1Max():Number
        {
            if (core.MeasurementConfig.distanceFormat == "mile") 
            {
                return 160932790.656;
            }
            return 99999000;
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
            if (core.MeasurementConfig.altitudeFormat == "feet") 
            {
                return 3047696;
            }
            return 4999000;
        }

        public function get maxAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "feet") 
            {
                return -304496;
            }
            return -999000;
        }

        public function get totalTripDistUp1Min():Number
        {
            return 0;
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
            if (core.MeasurementConfig.altitudeFormat == "feet") 
            {
                return 3047696;
            }
            return 4999000;
        }

        public function get maxAltitude2Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "feet") 
            {
                return -304496;
            }
            return -999000;
        }

        public function get totalClimbMeter1():int
        {
            return _totalClimbMeter1;
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

        public function get totalTripDistUp2():Number
        {
            return _totalTripDistUp2;
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

        public function set totalTripDistUp2(arg1:Number):void
        {
            if (arg1 != _totalTripDistUp2) 
            {
                _totalTripDistUp2 = arg1;
                dispatchEvent(new flash.events.Event("totalTripDistUp2Change"));
            }
            return;
        }

        public function get totalTripDistUp2Max():Number
        {
            if (core.MeasurementConfig.distanceFormat == "mile") 
            {
                return 160932790.656;
            }
            return 99999000;
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
            if (core.MeasurementConfig.altitudeFormat == "feet") 
            {
                return 304799969;
            }
            return 999999000;
        }

        public function get totalClimbMeter1Min():int
        {
            return 0;
        }

        public function get totalTripDistUp2Min():Number
        {
            return 0;
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
            if (core.MeasurementConfig.altitudeFormat == "feet") 
            {
                return 304799969;
            }
            return 999999000;
        }

        public function get totalClimbMeter2Min():int
        {
            return 0;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-totalTrainingTime1 " + totalTrainingTime1.toString();
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
            if (core.MeasurementConfig.altitudeFormat == "feet") 
            {
                return 304799969;
            }
            return 999999000;
        }

        public function get totalDescent1Min():int
        {
            return 0;
        }

        public function get totalDistance2Min():Number
        {
            return 0;
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
            if (core.MeasurementConfig.altitudeFormat == "feet") 
            {
                return 304799969;
            }
            return 999999000;
        }

        public function get totalDescent2Min():int
        {
            return 0;
        }

        public override function get totalDistance1Max():Number
        {
            if (core.MeasurementConfig.distanceFormat == "mile") 
            {
                return 160932790.656;
            }
            return 99999000;
        }

        public override function get totalDistance1Min():Number
        {
            return 0;
        }

        public override function resetValues():void
        {
            super.resetValues();
            totalTrainingTime1 = 0;
            totalTrainingTime2 = 0;
            totalTripDistDown1 = 0;
            totalTripDistDown2 = 0;
            totalTripDistUp1 = 0;
            totalTripDistUp2 = 0;
            totalTimeDown1 = 0;
            totalTimeDown2 = 0;
            totalTimeUp1 = 0;
            totalTimeUp2 = 0;
            totalCal1 = 0;
            totalCal2 = 0;
            totalDescent1 = 0;
            totalDescent2 = 0;
            totalDistance2 = 0;
            totalClimbMeter1 = 0;
            totalClimbMeter2 = 0;
            maxAltitude1 = 0;
            maxAltitude2 = 0;
            return;
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
            if (core.MeasurementConfig.distanceFormat == "mile") 
            {
                return 160932790.656;
            }
            return 99999000;
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

        public function get totalTimeUp1():uint
        {
            return _totalTimeUp1;
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

        public function get totalTripDistUp1():Number
        {
            return _totalTripDistUp1;
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
            if (core.MeasurementConfig.distanceFormat == "mile") 
            {
                return 160932790.656;
            }
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
            if (core.MeasurementConfig.distanceFormat == "mile") 
            {
                return 160932790.656;
            }
            return 99999000;
        }

        public function get totalTripDistDown2Min():Number
        {
            return 0;
        }

        public override function toString():String
        {
            return "[TotalsROX2010 extends TotalsBikeComputer implements ITotalTrainingTime1, ITotalTrainingTime2,...]";
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

        internal var _maxAltitude1:int;

        internal var _maxAltitude2:int;

        internal var _totalCal2:int;

        internal var _totalClimbMeter1:int;

        internal var _totalCal1:int;

        internal var _totalClimbMeter2:int;

        internal var _totalDescent1:int;

        internal var _totalDistance2:Number;

        internal var _totalTrainingTime2:uint;

        internal var _totalTimeDown2:uint;

        internal var _totalTripDistDown2:Number;

        internal var _totalTripDistUp2:Number;

        internal var _totalDescent2:int;

        internal var _totalTrainingTime1:uint;

        internal var _totalTimeDown1:uint;

        internal var _totalTimeUp2:uint;

        internal var _totalTripDistUp1:Number;

        internal var _totalTimeUp1:uint;

        internal var _totalTripDistDown1:Number;
    }
}


