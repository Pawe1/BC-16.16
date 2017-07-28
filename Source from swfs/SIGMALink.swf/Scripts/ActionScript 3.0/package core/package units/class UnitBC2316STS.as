//class UnitBC2316STS
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.sleepScreen.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class UnitBC2316STS extends core.units.UnitTopline2016 implements core.units.interfaces.INFCDeviceInfo, core.units.interfaces.ISleepScreen, core.units.interfaces.ILogList, core.units.interfaces.IDataToDecode, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.IGhostRaceSupported
    {
        public function UnitBC2316STS()
        {
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            super();
            type = core.general.UnitType.BC2316STS;
            return;
        }

        public function get activitiesToDecode():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activitiesToDecode;
        }

        public function set activitiesToDecode(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activitiesToDecode !== arg1) 
            {
                _activitiesToDecode = arg1;
                dispatchEvent(new flash.events.Event("activitiesToDecodeChange"));
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public function get fifoBit():uint
        {
            return 16;
        }

        public function get ghostRaceGPSDataRequired():Boolean
        {
            return false;
        }

        public function get ghostRaceSupported():Boolean
        {
            return true;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            _loadedLogs = arg1;
            return;
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

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return null;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            return;
        }

        public function getSamplingRates():Array
        {
            return [_sr5, _sr10, _sr20];
        }

        public function getSamplingRateIds():Array
        {
            return [5, 10, 20];
        }

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (5 === loc2) 
            {
                loc1 = _sr5;
            }
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (_sr5 === loc2) 
            {
                loc1 = 5;
            }
        }

        public static const FIFO_BIT:uint=16;

        public static const READ_BLOCK_DELAY:uint=18;

        public static const READ_DELAY:uint=6;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _sleepScreen:core.sleepScreen.SleepScreen;

        internal var _sr10:Number=10;

        internal var _sr20:Number=20;

        internal var _sr5:Number=5;
    }
}


