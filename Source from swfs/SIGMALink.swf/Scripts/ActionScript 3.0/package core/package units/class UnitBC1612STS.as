//class UnitBC1612STS
package core.units 
{
    import core.general.*;
    
    public class UnitBC1612STS extends core.units.UnitTopline2012
    {
        public function UnitBC1612STS()
        {
            super();
            type = core.general.UnitType.BC1612STS;
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
            return "[UnitBC1612STS extends UnitTopline2012]";
        }
    }
}


