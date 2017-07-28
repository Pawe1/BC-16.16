//class UnitRC2011
package core.units 
{
    import flash.events.*;
    
    public class UnitRC2011 extends core.units.UnitRunningComputer
    {
        public function UnitRC2011(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get dateCode():Date
        {
            return _dateCode;
        }

        public function set dateCode(arg1:Date):void
        {
            _dateCode = arg1;
            return;
        }

        public override function toString():String
        {
            return "[UnitRC2011 extends UnitRunningComputer implements IMemoryList]";
        }

        internal var _dateCode:Date;
    }
}


