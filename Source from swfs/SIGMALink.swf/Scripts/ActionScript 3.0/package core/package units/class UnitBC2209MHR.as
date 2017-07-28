//class UnitBC2209MHR
package core.units 
{
    import core.general.*;
    
    public class UnitBC2209MHR extends core.units.UnitTopline2009
    {
        public function UnitBC2209MHR()
        {
            super();
            type = core.general.UnitType.BC2209MHR;
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
            return "[UnitBC2209MHR extends UnitTopline2009 implements ISpeedTXBatteryStatus, ICadenceTXBatteryStatus, IHeartrateTXBatteryStatus, ITotalDistance1, ITotalDistance2, ITotalTime1, ITotalTime2, ITotalAltitude1, ITotalAltitude2]";
        }
    }
}


