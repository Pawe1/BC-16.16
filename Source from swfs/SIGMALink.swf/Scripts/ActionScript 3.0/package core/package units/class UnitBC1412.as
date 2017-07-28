//class UnitBC1412
package core.units 
{
    import core.general.*;
    
    public class UnitBC1412 extends core.units.UnitTopline2012
    {
        public function UnitBC1412()
        {
            super();
            type = core.general.UnitType.BC1412;
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
            return "[UnitBC1412 extends UnitTopline2012]";
        }
    }
}


