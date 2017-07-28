//class UnitBC716
package core.units 
{
    import core.general.*;
    
    public class UnitBC716 extends core.units.UnitTopline2016
    {
        public function UnitBC716()
        {
            super();
            type = core.general.UnitType.BC716;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


