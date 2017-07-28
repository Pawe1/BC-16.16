//class UnitBC1609
package core.units 
{
    import core.general.*;
    
    public class UnitBC1609 extends core.units.UnitTopline2009
    {
        public function UnitBC1609()
        {
            super();
            type = core.general.UnitType.BC1609;
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
            return "[UnitBC1609 extends UnitTopline2009]";
        }
    }
}


