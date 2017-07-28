//class TotalsBC1412
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsBC1412 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalClimbMeter1
    {
        public function TotalsBC1412(arg1:flash.events.IEventDispatcher=null)
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
            if (core.MeasurementConfig.distanceFormat == "kilometer") 
            {
                return 99999000;
            }
            return 160932790.656;
        }

        public function get totalClimbMeter1Min():int
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

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-totalTrainingTime1 " + totalTrainingTime1.toString();
        }

        public override function resetValues():void
        {
            super.resetValues();
            totalTrainingTime1 = 0;
            totalClimbMeter1 = 0;
            return;
        }

        public override function toString():String
        {
            return "[TotalsBC1412 extends TotalsBikeComputer implements ITotalTrainingTime1, ITotalClimbMeter1]";
        }

        internal var _totalClimbMeter1:int;

        internal var _totalTrainingTime1:uint;
    }
}


