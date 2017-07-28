//class UnitBC916
package core.units 
{
    import core.general.*;
    
    public class UnitBC916 extends core.units.UnitTopline2016
    {
        public function UnitBC916()
        {
            super();
            type = core.general.UnitType.BC916;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


