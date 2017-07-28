//class UnitBC512
package core.units 
{
    import core.general.*;
    
    public class UnitBC512 extends core.units.UnitTopline2012
    {
        public function UnitBC512()
        {
            super();
            type = core.general.UnitType.BC512;
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
            return "[UnitBC512 extends UnitTopline2012]";
        }
    }
}


