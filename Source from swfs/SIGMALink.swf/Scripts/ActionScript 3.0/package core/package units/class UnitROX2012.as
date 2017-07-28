//class UnitROX2012
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitROX2012 extends core.units.UnitBikeComputer implements core.units.interfaces.IDSTDeviceInfo, core.units.interfaces.ILogList, core.units.interfaces.ILogStatus, core.units.interfaces.IUnitBatteryStatus, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.ITotalsList
    {
        public function UnitROX2012()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super();
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public function get activities():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activities;
        }

        public function set activities(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activities !== arg1) 
            {
                _activities = arg1;
                dispatchEvent(new flash.events.Event("activitiesChange"));
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
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

        public function get freePackages():int
        {
            return _freePackages;
        }

        public function set freePackages(arg1:int):void
        {
            _freePackages = arg1;
            return;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedLogs) 
            {
                _loadedLogs = arg1;
                dispatchEvent(new flash.events.Event("loadedLogsChange"));
            }
            return;
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
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

        public function get unitBatteryStatus():Boolean
        {
            return _unitBatteryStatus;
        }

        public function set unitBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _unitBatteryStatus) 
            {
                _unitBatteryStatus = arg1;
            }
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
        }

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public function getSamplingRates():Array
        {
            return [10];
        }

        public function getSamplingRateIds():Array
        {
            return [10];
        }

        public function getSamplingRate(arg1:Number):Number
        {
            return 10;
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            return 10;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public override function toString():String
        {
            return "[UnitROX extends Unit implements IMemoryList, IUnitBatteryStatus, ISpeedTXBatteryStatus, ICadenceTXBatteryStatus, IHeartrateTXBatteryStatus, IDateCode]";
        }

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _currentTotals:core.totals.Totals;

        internal var _freePackages:int=0;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _maxPackages:int=0;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _unitBatteryStatus:Boolean=false;

        internal var _unitLogStatus:Boolean=true;
    }
}


