//class TotalsRC1411
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsRC1411 extends core.totals.TotalsRunningComputer implements core.totals.interfaces.ITotalCal1
    {
        public function TotalsRC1411(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
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

        public override function get totalTrainingTime1Max():uint
        {
            return 359999900;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-totalCalories " + totalCal1.toString();
        }

        public override function resetValues():void
        {
            super.resetValues();
            totalCal1 = 0;
            return;
        }

        public override function toString():String
        {
            return "[TotalsRC1411 extends TotalsRunningComputer implements ITotalCal1]";
        }

        internal var _totalCal1:int;
    }
}


