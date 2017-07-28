//class UnitGps10
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.gps.*;
    import core.sleepScreen.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitGps10 extends core.units.UnitBikeComputer implements core.units.interfaces.INFCDeviceInfo, core.units.interfaces.IUSBDeviceInfo, core.units.interfaces.ISleepScreen, core.units.interfaces.ILogList, core.units.interfaces.IDataToDecode, core.units.interfaces.ITotalsList, core.units.interfaces.IAgpsSupported, core.units.interfaces.IFirmwareUpdateSupported, core.units.interfaces.IPointNavigationsList, core.units.interfaces.IOnlyFinishedActivitiesLoadable
    {
        public function UnitGps10(arg1:flash.events.IEventDispatcher=null)
        {
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            _pointNavigationsVector = new __AS3__.vec.Vector.<core.gps.PointNavigation>();
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super(arg1);
            type = core.general.UnitType.GPS10;
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            addEventListener("pointNavigationsChanged", onPointNavigationsChanged, false, 0, true);
            return;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            _tracksToDecode = arg1;
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

        public function firmwareUpdateSupported():Boolean
        {
            return true;
        }

        public function get currentPointNavigation():core.gps.PointNavigation
        {
            return _currentPointNavigation;
        }

        public function set currentPointNavigation(arg1:core.gps.PointNavigation):void
        {
            _currentPointNavigation = arg1;
            return;
        }

        public function bleFirmwareUpdateSupported():Boolean
        {
            return false;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public function get fifoBit():uint
        {
            return 1;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
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

        internal function onPointNavigationsChanged(arg1:flash.events.Event):void
        {
            pointNavigationsVectorList = init.BackendInitializer.getInstance().createVectorList(_pointNavigationsVector);
            return;
        }

        public function get pointNavigationsVector():__AS3__.vec.Vector.<core.gps.PointNavigation>
        {
            return _pointNavigationsVector;
        }

        public function set pointNavigationsVector(arg1:__AS3__.vec.Vector.<core.gps.PointNavigation>):void
        {
            _pointNavigationsVector = arg1;
            return;
        }

        public function get readBlockDelay():uint
        {
            return 18;
        }

        public function get readDelay():uint
        {
            return 18;
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

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return _tracksToDecode;
        }

        public static const FIFO_BIT:uint=1;

        public static const READ_BLOCK_DELAY:uint=18;

        public static const READ_DELAY:uint=18;

        public static const SAMPLING_RATE:uint=5;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _currentPointNavigation:core.gps.PointNavigation;

        internal var _currentTotals:core.totals.Totals;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _pointNavigationsVector:__AS3__.vec.Vector.<core.gps.PointNavigation>;

        internal var _sleepScreen:core.sleepScreen.SleepScreen;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _tracksToDecode:__AS3__.vec.Vector.<core.route.Route>;
    }
}


