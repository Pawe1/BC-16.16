//class UnitBC1609STS
package core.units 
{
    import core.general.*;
    
    public class UnitBC1609STS extends core.units.UnitTopline2009
    {
        public function UnitBC1609STS()
        {
            super();
            type = core.general.UnitType.BC1609STS;
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1609STS extends UnitTopline2009]";
        }
    }
}


