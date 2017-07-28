//class TotalsBC716
package core.totals 
{
    import core.*;
    import core.totals.interfaces.*;
    import flash.events.*;
    
    public class TotalsBC716 extends core.totals.TotalsBikeComputer implements core.totals.interfaces.ITotalTrainingTime1
    {
        public function TotalsBC716(arg1:flash.events.IEventDispatcher=null)
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

        public function get totalTrainingTime1():uint
        {
            return _totalTrainingTime1;
        }

        public function set totalTrainingTime1(arg1:uint):void
        {
            _totalTrainingTime1 = arg1;
            return;
        }

        public function get totalTrainingTime1Max():uint
        {
            return 3599999900;
        }

        internal var _totalTrainingTime1:uint=0;
    }
}


