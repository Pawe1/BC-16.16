//class UnitBC1009STS
package core.units 
{
    import core.general.*;
    
    public class UnitBC1009STS extends core.units.UnitTopline2009
    {
        public function UnitBC1009STS()
        {
            super();
            type = core.general.UnitType.BC1009STS;
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
            return "[UnitBC1009STS extends UnitTopline2009 implements ISpeedTXBatteryStatus]";
        }
    }
}


