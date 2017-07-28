//class UnitROX100
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.route.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    import init.interfaces.*;
    
    public class UnitROX100 extends core.units.UnitBikeComputer implements core.units.interfaces.IUSBDeviceInfo, core.units.interfaces.ILogList, core.units.interfaces.ILogTime1Sec, core.units.interfaces.ILogTime2Sec, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogTime30Sec, core.units.interfaces.ILogStatus, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.IDataToDecode, core.units.interfaces.ITrackList, core.units.interfaces.IMemoryMapVersion, core.units.interfaces.IFirmwareUpdateSupported, core.units.interfaces.IPowerZones7, core.units.interfaces.ITotalsList
    {
        public function UnitROX100()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedTracks = init.BackendInitializer.getInstance().createVectorList();
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            _trackList = init.BackendInitializer.getInstance().createVectorList();
            _tracksToDecode = new __AS3__.vec.Vector.<core.route.Route>();
            super();
            type = core.general.UnitType.ROX100;
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public function set logTime30Sec(arg1:int):void
        {
            _logTime30Sec = arg1;
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

        public function get powerZone2Start():int
        {
            return _powerZone2Start;
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
            return 3;
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
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

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function set powerZone2Start(arg1:int):void
        {
            if (_powerZone2Start !== arg1) 
            {
                _powerZone2Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone2StartChange"));
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

        public function set logTime5Sec(arg1:int):void
        {
            _logTime5Sec = arg1;
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

        public function get powerZone1Start():int
        {
            return _powerZone1Start;
        }

        public function get loadedTracks():init.interfaces.IVectorList
        {
            return _loadedTracks;
        }

        public function set loadedTracks(arg1:init.interfaces.IVectorList):void
        {
            if (_loadedTracks !== arg1) 
            {
                _loadedTracks = arg1;
                dispatchEvent(new flash.events.Event("loadedTracksChange"));
            }
            return;
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function get logTime10Sec():int
        {
            return _logTime10Sec;
        }

        public function set logTime10Sec(arg1:int):void
        {
            _logTime10Sec = arg1;
            return;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        public function get logTime1Sec():int
        {
            return _logTime1Sec;
        }

        public function set logTime1Sec(arg1:int):void
        {
            _logTime1Sec = arg1;
            return;
        }

        public function set powerZone1Start(arg1:int):void
        {
            if (_powerZone1Start !== arg1) 
            {
                _powerZone1Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone1StartChange"));
            }
            return;
        }

        public function get logTime20Sec():int
        {
            return _logTime20Sec;
        }

        public function set logTime20Sec(arg1:int):void
        {
            _logTime20Sec = arg1;
            return;
        }

        public function get memoryMapVersion():String
        {
            return _memoryMapVersion;
        }

        public function get logTime2Sec():int
        {
            return _logTime2Sec;
        }

        public function set logTime2Sec(arg1:int):void
        {
            _logTime2Sec = arg1;
            return;
        }

        public function set memoryMapVersion(arg1:String):void
        {
            if (_memoryMapVersion !== arg1) 
            {
                _memoryMapVersion = arg1;
                dispatchEvent(new flash.events.Event("memoryMapVersionChange"));
            }
            return;
        }

        public function get logTime30Sec():int
        {
            return _logTime30Sec;
        }

        public function get powerZone3Start():int
        {
            return _powerZone3Start;
        }

        public function set powerZone3Start(arg1:int):void
        {
            if (_powerZone3Start !== arg1) 
            {
                _powerZone3Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone3StartChange"));
            }
            return;
        }

        public function get powerZone4Start():int
        {
            return _powerZone4Start;
        }

        public function set powerZone4Start(arg1:int):void
        {
            if (_powerZone4Start !== arg1) 
            {
                _powerZone4Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone4StartChange"));
            }
            return;
        }

        public function get powerZone5Start():int
        {
            return _powerZone5Start;
        }

        public function set powerZone5Start(arg1:int):void
        {
            if (_powerZone5Start !== arg1) 
            {
                _powerZone5Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone5StartChange"));
            }
            return;
        }

        public function get powerZone6Start():int
        {
            return _powerZone6Start;
        }

        public function set powerZone6Start(arg1:int):void
        {
            if (_powerZone6Start !== arg1) 
            {
                _powerZone6Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone6StartChange"));
            }
            return;
        }

        public function get powerZone7End():int
        {
            return _powerZone7End;
        }

        public function set powerZone7End(arg1:int):void
        {
            if (_powerZone7End !== arg1) 
            {
                _powerZone7End = arg1;
                dispatchEvent(new flash.events.Event("powerZone7EndChange"));
            }
            return;
        }

        public function get powerZone7Start():int
        {
            return _powerZone7Start;
        }

        public function set powerZone7Start(arg1:int):void
        {
            if (_powerZone7Start !== arg1) 
            {
                _powerZone7Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone7StartChange"));
            }
            return;
        }

        public function get thresholdPower():int
        {
            return _thresholdPower;
        }

        public function set thresholdPower(arg1:int):void
        {
            if (_thresholdPower !== arg1) 
            {
                _thresholdPower = arg1;
                dispatchEvent(new flash.events.Event("thresholdPowerChange"));
            }
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

        public static function getSoftwareRevisionNumber(arg1:String):Number
        {
            var loc1:*=arg1.split("-");
            var loc2:*=loc1[3];
            return loc2;
        }

        public function get trackList():init.interfaces.IVectorList
        {
            return _trackList;
        }

        public function set trackList(arg1:init.interfaces.IVectorList):void
        {
            if (_trackList !== arg1) 
            {
                _trackList = arg1;
                dispatchEvent(new flash.events.Event("trackListChange"));
            }
            return;
        }

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return _tracksToDecode;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            if (_tracksToDecode !== arg1) 
            {
                _tracksToDecode = arg1;
                dispatchEvent(new flash.events.Event("tracksToDecodeChange"));
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

        public function firmwareUpdateSupported():Boolean
        {
            return true;
        }

        public function bleFirmwareUpdateSupported():Boolean
        {
            return false;
        }

        public function getSamplingRates():Array
        {
            return [_sr1, _sr2, _sr5, _sr10, _sr20, _sr30];
        }

        public function getSamplingRateIds():Array
        {
            return [1, 2, 5, 10, 20, 30];
        }

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (1 === loc2) 
            {
                loc1 = _sr1;
            }
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (_sr1 === loc2) 
            {
                loc1 = 1;
            }
        }

        public override function toString():String
        {
            return "[ROX100 extends UnitROX]";
        }

        public function calculatePowerZonesByThreshold():void
        {
            powerZone1Start = 0;
            powerZone2Start = thresholdPower / 100 * 56;
            powerZone3Start = thresholdPower / 100 * 76;
            powerZone4Start = thresholdPower / 100 * 91;
            powerZone5Start = thresholdPower / 100 * 106;
            powerZone6Start = thresholdPower / 100 * 121;
            powerZone7Start = thresholdPower / 100 * 151;
            powerZone7End = 2000;
            return;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        internal var _logTime5Sec:int=0;

        internal var _maxPackages:int=0;

        internal var _thresholdPower:int=253;

        protected var _memoryMapVersion:String="";

        internal var _powerZone1Start:Number=0;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _powerZone2Start:int=141;

        internal var _freePackages:int=0;

        internal var _powerZone3Start:int=191;

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _tracksToDecode:__AS3__.vec.Vector.<core.route.Route>;

        internal var _powerZone4Start:int=231;

        internal var _currentTotals:core.totals.Totals;

        internal var _unitLogStatus:Boolean=true;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _powerZone5Start:int=261;

        internal var _sr1:Number=1;

        internal var _sr10:Number=10;

        internal var _sr2:Number=2;

        internal var _trackList:init.interfaces.IVectorList;

        internal var _sr30:Number=30;

        internal var _sr5:Number=5;

        internal var _loadedTracks:init.interfaces.IVectorList;

        internal var _logTime10Sec:int=0;

        internal var _powerZone6Start:int=301;

        internal var _logTime1Sec:int=0;

        internal var _logTime20Sec:int=0;

        internal var _powerZone7End:int=2000;

        internal var _logTime2Sec:int=0;

        internal var _logTime30Sec:int=0;

        internal var _powerZone7Start:int=367;

        internal var _sr20:Number=20;
    }
}


