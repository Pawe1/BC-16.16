//class TotalsBC2316STS
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsBC2316STS extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalDistance2, core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalTrainingTime2, core.totals.interfaces.ITotalClimbMeter1, core.totals.interfaces.ITotalClimbMeter2, core.totals.interfaces.ITotalTripDistUp1, core.totals.interfaces.ITotalTripDistUp2, core.totals.interfaces.ITotalDescent1, core.totals.interfaces.ITotalDescent2, core.totals.interfaces.ITotalTripDistDown1, core.totals.interfaces.ITotalTripDistDown2, core.totals.interfaces.ITotalCal1, core.totals.interfaces.ITotalCal2
    {
        public function TotalsBC2316STS(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
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
            return 99999;
        }

        public function get totalCal1Min():int
        {
            return 0;
        }

        public function get totalTripDistUp1Max():Number
        {
            if (core.MeasurementConfig.distanceFormat == "kilometer") 
            {
                return 99999000;
            }
            return 160932790.656;
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
            return 99999;
        }

        public function get totalCal2Min():int
        {
            return 0;
        }

        public override function get totalDistance1Max():Number
        {
            if (core.MeasurementConfig.distanceFormat == "kilometer") 
            {
                return 99999000;
            }
            return 160932790.656;
        }

        public override function get totalDistance1Min():Number
        {
            return 0;
        }

        public function get totalTripDistUp1Min():Number
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
            if (core.MeasurementConfig.distanceFormat == "kilometer") 
            {
                return 99999000;
            }
            return 160932790.656;
        }

        public function get totalDistance2Min():Number
        {
            return 0;
        }

        public function get totalTripDistUp2():Number
        {
            return _totalTripDistUp2;
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

        public function set totalTripDistUp2(arg1:Number):void
        {
            if (arg1 != _totalTripDistUp2) 
            {
                _totalTripDistUp2 = arg1;
                dispatchEvent(new flash.events.Event("totalTripDistUp2Change"));
            }
            return;
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

        public function get totalTripDistUp2Max():Number
        {
            if (core.MeasurementConfig.distanceFormat == "kilometer") 
            {
                return 99999000;
            }
            return 160932790.656;
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
            return 99999000;
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
            return 99999000;
        }

        public function get totalClimbMeter2Min():int
        {
            return 0;
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
            return 99999000;
        }

        public function get totalDescent1Min():int
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
            return 99999000;
        }

        public function get totalDescent2Min():int
        {
            return 0;
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
            if (core.MeasurementConfig.distanceFormat == "kilometer") 
            {
                return 99999000;
            }
            return 160932790.656;
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
            if (core.MeasurementConfig.distanceFormat == "kilometer") 
            {
                return 99999000;
            }
            return 160932790.656;
        }

        public function get totalTripDistDown2Min():Number
        {
            return 0;
        }

        public function get totalTripDistUp1():Number
        {
            return _totalTripDistUp1;
        }

        internal var _totalCal1:int;

        internal var _totalCal2:int;

        internal var _totalDistance2:Number;

        internal var _totalTrainingTime1:uint;

        internal var _totalTrainingTime2:uint;

        internal var _totalClimbMeter1:int;

        internal var _totalClimbMeter2:int;

        internal var _totalTripDistDown2:Number;

        internal var _totalTripDistUp2:Number;

        internal var _totalTripDistUp1:Number;

        internal var _totalDescent2:int;

        internal var _totalTripDistDown1:Number;

        internal var _totalDescent1:int;
    }
}


