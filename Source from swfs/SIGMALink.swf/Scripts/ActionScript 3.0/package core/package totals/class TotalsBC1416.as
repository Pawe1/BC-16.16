//class TotalsBC1416
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsBC1416 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalTrainingTime2, core.totals.interfaces.ITotalDistance2, core.totals.interfaces.ITotalClimbMeter1, core.totals.interfaces.ITotalClimbMeter2
    {
        public function TotalsBC1416(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
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
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 99999000;
            }
            return 160932790.656;
        }

        public function get totalClimbMeter1Min():int
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
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 99999000;
            }
            return 160932790.656;
        }

        public function get totalClimbMeter2Min():int
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

        internal var _totalClimbMeter1:int;

        internal var _totalClimbMeter2:int;

        internal var _totalDistance2:Number;

        internal var _totalTrainingTime1:uint;

        internal var _totalTrainingTime2:uint;
    }
}


