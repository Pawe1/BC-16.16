//class UnitBC416ATS
package core.units 
{
    import core.general.*;
    
    public class UnitBC416ATS extends core.units.UnitTopline2016
    {
        public function UnitBC416ATS()
        {
            super();
            type = core.general.UnitType.BC416ATS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


