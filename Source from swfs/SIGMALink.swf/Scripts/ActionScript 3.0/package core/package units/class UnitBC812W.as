//class UnitBC812W
package core.units 
{
    import core.general.*;
    
    public class UnitBC812W extends core.units.UnitTopline2012
    {
        public function UnitBC812W()
        {
            super();
            type = core.general.UnitType.BC812W;
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
            return "[UnitBC812W extends UnitTopline2012]";
        }
    }
}


