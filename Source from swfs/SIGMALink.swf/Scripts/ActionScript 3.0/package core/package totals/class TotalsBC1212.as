//class TotalsBC1212
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsBC1212 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalFuelConsumption1
    {
        public function TotalsBC1212(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
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

        public function get totalFuelConsumption1():Number
        {
            return _totalFuelConsumption;
        }

        public function set totalFuelConsumption1(arg1:Number):void
        {
            if (arg1 != _totalFuelConsumption) 
            {
                _totalFuelConsumption = arg1;
                dispatchEvent(new flash.events.Event("totalFuelConsumptionChange"));
            }
            return;
        }

        public function get totalFuelConsumption1Max():Number
        {
            return 9999.9;
        }

        public function get totalFuelConsumption1Min():Number
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
            totalFuelConsumption1 = 0;
            return;
        }

        public override function toString():String
        {
            return "[TotalsBC1212 extends TotalsBikeComputer implements ITotalTrainingTime1, ITotalFuelConsumption]";
        }

        internal var _totalTrainingTime1:uint;

        internal var _totalFuelConsumption:Number=0;
    }
}


