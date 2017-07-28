//class UnitEvent
package handler.event 
{
    import core.units.*;
    import flash.events.*;
    
    public class UnitEvent extends flash.events.Event
    {
        public function UnitEvent(arg1:String, arg2:core.units.Unit, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            unit = arg2;
            return;
        }

        public function get unit():core.units.Unit
        {
            return _unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            _unit = arg1;
            return;
        }

        internal var _unit:core.units.Unit;
    }
}


