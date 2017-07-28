//class UnitBC716ATS
package core.units 
{
    import core.general.*;
    
    public class UnitBC716ATS extends core.units.UnitTopline2016
    {
        public function UnitBC716ATS()
        {
            super();
            type = core.general.UnitType.BC716ATS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


