//class UnitBC916ATS
package core.units 
{
    import core.general.*;
    
    public class UnitBC916ATS extends core.units.UnitTopline2016
    {
        public function UnitBC916ATS()
        {
            super();
            type = core.general.UnitType.BC916ATS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


