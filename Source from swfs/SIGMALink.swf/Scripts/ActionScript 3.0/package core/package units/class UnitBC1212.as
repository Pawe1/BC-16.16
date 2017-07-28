//class UnitBC1212
package core.units 
{
    import core.general.*;
    
    public class UnitBC1212 extends core.units.UnitTopline2012
    {
        public function UnitBC1212()
        {
            super();
            type = core.general.UnitType.BC1212;
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
            return "[UnitBC1212 extends UnitTopline2012]";
        }
    }
}


