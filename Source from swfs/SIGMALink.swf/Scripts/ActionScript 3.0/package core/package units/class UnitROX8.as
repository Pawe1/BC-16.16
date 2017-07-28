//class UnitROX8
package core.units 
{
    import core.general.*;
    
    public class UnitROX8 extends core.units.UnitROX
    {
        public function UnitROX8()
        {
            super();
            type = core.general.UnitType.ROX80;
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitROX8 extends UnitROX]";
        }
    }
}


