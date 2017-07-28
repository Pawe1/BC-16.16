//class TotalsPC2814
package core.totals 
{
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsPC2814 extends core.totals.TotalsPulseComputer implements core.totals.interfaces.ITotalCal1, core.totals.interfaces.ITotalTrainings, core.totals.interfaces.IResetDate
    {
        public function TotalsPC2814(arg1:flash.events.IEventDispatcher=null)
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
            return 0;
        }

        public function get totalCal1Min():int
        {
            return 0;
        }

        public function get totalTrainings():int
        {
            return _totalTrainings;
        }

        public function set totalTrainings(arg1:int):void
        {
            if (arg1 != _totalTrainings) 
            {
                _totalTrainings = arg1;
                dispatchEvent(new flash.events.Event("totalTrainingsChange"));
            }
            return;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-totalTrainings " + totalTrainings + "\t-totalCalories " + totalCal1;
        }

        public override function resetValues():void
        {
            super.resetValues();
            totalTrainingTime1 = 0;
            totalCal1 = 0;
            totalTrainings = 0;
            resetDate = new Date();
            return;
        }

        public override function toString():String
        {
            return "[TotalsPC2813 extends TotalsPulseComputer implements ITotalCal1, ITotalTrainings, IResetDate]";
        }

        protected var _resetDate:Date;

        protected var _totalCal1:int;

        protected var _totalTrainings:int;
    }
}


