//class UnitBC509
package core.units 
{
    import core.general.*;
    
    public class UnitBC509 extends core.units.UnitTopline2009
    {
        public function UnitBC509()
        {
            super();
            type = core.general.UnitType.BC509;
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
            return "[UnitBC509 extends UnitTopline2009]";
        }
    }
}


