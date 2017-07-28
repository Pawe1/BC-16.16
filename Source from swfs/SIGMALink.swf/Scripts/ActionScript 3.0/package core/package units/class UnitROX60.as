//class UnitROX60
package core.units 
{
    import core.general.*;
    
    public class UnitROX60 extends core.units.UnitROX2012
    {
        public function UnitROX60()
        {
            super();
            type = core.general.UnitType.ROX60;
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitROX60 extends UnitROX]";
        }
    }
}


