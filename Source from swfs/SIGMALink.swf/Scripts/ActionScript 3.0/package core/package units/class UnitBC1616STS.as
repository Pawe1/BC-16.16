//class UnitBC1616STS
package core.units 
{
    import core.general.*;
    import core.sleepScreen.*;
    import core.units.interfaces.*;
    
    public class UnitBC1616STS extends core.units.UnitTopline2016 implements core.units.interfaces.INFCDeviceInfo, core.units.interfaces.ISleepScreen
    {
        public function UnitBC1616STS()
        {
            super();
            type = core.general.UnitType.BC1616STS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public function get fifoBit():uint
        {
            return 16;
        }

        public function get readBlockDelay():uint
        {
            return 18;
        }

        public function get readDelay():uint
        {
            return 6;
        }

        public function get sleepScreen():core.sleepScreen.SleepScreen
        {
            return _sleepScreen;
        }

        public function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void
        {
            _sleepScreen = arg1;
            return;
        }

        public static const FIFO_BIT:uint=16;

        public static const READ_BLOCK_DELAY:uint=18;

        public static const READ_DELAY:uint=6;

        internal var _sleepScreen:core.sleepScreen.SleepScreen;
    }
}


