//class UnitBC1212STS
package core.units 
{
    import core.general.*;
    
    public class UnitBC1212STS extends core.units.UnitTopline2012
    {
        public function UnitBC1212STS()
        {
            super();
            type = core.general.UnitType.BC1212STS;
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
            return "[UnitBC1212STS extends UnitTopline2012]";
        }
    }
}


