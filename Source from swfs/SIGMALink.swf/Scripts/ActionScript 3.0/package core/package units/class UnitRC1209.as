//class UnitRC1209
package core.units 
{
    import core.general.*;
    import flash.events.*;
    
    public class UnitRC1209 extends core.units.UnitRC2011
    {
        public function UnitRC1209(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            type = core.general.UnitType.RC1209;
            return;
        }

        public override function get bikeCount():int
        {
            return 0;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitRC1209 extends UnitRC2011]";
        }
    }
}


