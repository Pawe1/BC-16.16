//class TotalsBC1616
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsBC1616 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalDistance2, core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalTrainingTime2, core.totals.interfaces.ITotalFuelConsumption1, core.totals.interfaces.ITotalFuelConsumption2
    {
        public function TotalsBC1616(arg1:flash.events.IEventDispatcher=null)
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

        public function get totalFuelConsumption1():Number
        {
            return _totalFuelConsumption1;
        }

        public function set totalFuelConsumption1(arg1:Number):void
        {
            if (arg1 != _totalFuelConsumption1) 
            {
                _totalFuelConsumption1 = arg1;
                dispatchEvent(new flash.events.Event("totalFuelConsumption1Change"));
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

        public function get totalFuelConsumption2():Number
        {
            return _totalFuelConsumption2;
        }

        public function set totalFuelConsumption2(arg1:Number):void
        {
            if (arg1 != _totalFuelConsumption2) 
            {
                _totalFuelConsumption2 = arg1;
                dispatchEvent(new flash.events.Event("totalFuelConsumption2Change"));
            }
            return;
        }

        public function get totalFuelConsumption2Max():Number
        {
            return 9999.9;
        }

        public function get totalFuelConsumption2Min():Number
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

        internal var _totalDistance2:Number;

        internal var _totalFuelConsumption1:Number=0;

        internal var _totalFuelConsumption2:Number=0;

        internal var _totalTrainingTime1:uint;

        internal var _totalTrainingTime2:uint;
    }
}


