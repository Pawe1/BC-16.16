//class UnitBC1009
package core.units 
{
    import core.general.*;
    
    public class UnitBC1009 extends core.units.UnitTopline2009
    {
        public function UnitBC1009()
        {
            super();
            type = core.general.UnitType.BC1009;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1009 extends UnitTopline2009]";
        }
    }
}


