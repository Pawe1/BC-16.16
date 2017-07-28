//class UnitBC1909HR
package core.units 
{
    import core.general.*;
    
    public class UnitBC1909HR extends core.units.UnitTopline2009
    {
        public function UnitBC1909HR()
        {
            super();
            type = core.general.UnitType.BC1909HR;
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
            return "[UnitBC1909HR extends UnitTopline2009]";
        }
    }
}


