//class UnitBC516
package core.units 
{
    import core.general.*;
    
    public class UnitBC516 extends core.units.UnitTopline2016
    {
        public function UnitBC516()
        {
            super();
            type = core.general.UnitType.BC516;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


