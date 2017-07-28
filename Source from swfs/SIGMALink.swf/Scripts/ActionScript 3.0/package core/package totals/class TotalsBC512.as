//class TotalsBC512
package core.totals 
{
    import core.*;
    import flash.events.*;
    
    public class TotalsBC512 extends core.totals.TotalsBikeComputer
    {
        public function TotalsBC512(arg1:flash.events.IEventDispatcher=null)
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

        public override function toString():String
        {
            return "[TotalsBC512 extends TotalsBikeComputer]";
        }
    }
}


