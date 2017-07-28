//class TotalsGps10
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsGps10 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalTrainingTime1, core.totals.interfaces.ITotalCal1, core.totals.interfaces.ITotalClimbMeter1, core.totals.interfaces.IResetDate
    {
        public function TotalsGps10(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get resetDate():Date
        {
            return _resetDate;
        }

        public function set resetDate(arg1:Date):void
        {
            if (arg1 != _resetDate) 
            {
                _resetDate = arg1;
                dispatchEvent(new flash.events.Event("resetDateChange"));
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

        protected var _resetDate:Date;

        internal var _totalCal1:int;

        internal var _totalClimbMeter1:int;

        internal var _totalTrainingTime1:uint;
    }
}


