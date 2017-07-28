//class TotalsBikeComputer
package core.totals 
{
    import core.totals.interfaces.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class TotalsBikeComputer extends core.totals.Totals implements core.totals.interfaces.ITotalDistance1
    {
        public function TotalsBikeComputer(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get totalDistance1():Number
        {
            return _totalDistance1;
        }

        public function set totalDistance1(arg1:Number):void
        {
            if (arg1 != _totalDistance1) 
            {
                _totalDistance1 = arg1;
                dispatchEvent(new flash.events.Event("totalDistance1Change"));
            }
            return;
        }

        public function get totalDistance1Max():Number
        {
            throw new Error(flash.utils.getQualifiedClassName(this) + ":totalDistance1Max() needs a custom implementation in the derived class.");
            return 0;
        }

        public function get totalDistance1Min():Number
        {
            throw new Error(flash.utils.getQualifiedClassName(this) + ":totalDistance1Min() needs a custom implementation in the derived class.");
            return 0;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-totalDistance1 " + totalDistance1.toString();
        }

        public override function resetValues():void
        {
            super.resetValues();
            totalDistance1 = 0;
            return;
        }

        public override function toString():String
        {
            return "[TotalsBikeComputer extends Totals implements ITotalDistance1]";
        }

        internal var _totalDistance1:Number;
    }
}


