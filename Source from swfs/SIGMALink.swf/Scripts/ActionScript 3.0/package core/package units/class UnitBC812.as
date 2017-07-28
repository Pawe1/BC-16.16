//class UnitBC812
package core.units 
{
    import core.general.*;
    
    public class UnitBC812 extends core.units.UnitTopline2012
    {
        public function UnitBC812()
        {
            super();
            type = core.general.UnitType.BC812;
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
            return "[UnitBC812 extends UnitTopline2012]";
        }
    }
}


