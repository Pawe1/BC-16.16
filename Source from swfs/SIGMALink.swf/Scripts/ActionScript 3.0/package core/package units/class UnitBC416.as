//class UnitBC416
package core.units 
{
    import core.general.*;
    
    public class UnitBC416 extends core.units.UnitTopline2016
    {
        public function UnitBC416()
        {
            super();
            type = core.general.UnitType.BC416;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


