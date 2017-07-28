//class UnitROX50
package core.units 
{
    import core.general.*;
    
    public class UnitROX50 extends core.units.UnitROX2012
    {
        public function UnitROX50()
        {
            super();
            type = core.general.UnitType.ROX50;
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitROX50 extends UnitROX]";
        }
    }
}


