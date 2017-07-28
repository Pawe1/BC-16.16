//class TotalsBC516
package core.totals 
{
    import core.*;
    import flash.events.*;
    
    public class TotalsBC516 extends core.totals.TotalsBikeComputer
    {
        public function TotalsBC516(arg1:flash.events.IEventDispatcher=null)
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
    }
}


