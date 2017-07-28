//class UnitBC1612
package core.units 
{
    import core.general.*;
    
    public class UnitBC1612 extends core.units.UnitTopline2012
    {
        public function UnitBC1612()
        {
            super();
            type = core.general.UnitType.BC1612;
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function toString():String
        {
            return "[UnitBC1612 extends UnitTopline2012]";
        }
    }
}


