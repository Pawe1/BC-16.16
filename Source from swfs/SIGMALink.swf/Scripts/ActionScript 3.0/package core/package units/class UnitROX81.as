//class UnitROX81
package core.units 
{
    import core.general.*;
    
    public class UnitROX81 extends core.units.UnitROX2010
    {
        public function UnitROX81()
        {
            super();
            type = core.general.UnitType.ROX81;
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
            return "[UnitROX81 extends UnitROX2010]";
        }
    }
}


