//class TotalsPulseComputer
package core.totals 
{
    import core.totals.interfaces.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class TotalsPulseComputer extends core.totals.Totals implements core.totals.interfaces.ITotalTrainingTime1
    {
        public function TotalsPulseComputer(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
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
            throw new Error(flash.utils.getQualifiedClassName(this) + ":totalTrainingTime1Max() needs a custom implementation in the derived class.");
            return 0;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-totalTrainingTime1 " + totalTrainingTime1.toString();
        }

        public override function resetValues():void
        {
            super.resetValues();
            totalTrainingTime1 = 0;
            return;
        }

        public override function toString():String
        {
            return "[TotalsPulseComputer extends Totals implements ITotalTrainingTime1]";
        }

        protected var _totalTrainingTime1:uint;
    }
}


