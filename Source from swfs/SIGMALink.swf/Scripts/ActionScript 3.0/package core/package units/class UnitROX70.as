//class UnitROX70
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.route.*;
    import core.sportprofiles.*;
    import core.strava.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    import init.interfaces.*;
    
    public class UnitROX70 extends core.units.UnitBikeComputer implements core.units.interfaces.IUSBDeviceInfo, core.units.interfaces.ILogList, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogStatus, core.units.interfaces.IDataToDecode, core.units.interfaces.ITrackList, core.units.interfaces.IMemoryMapVersion, core.units.interfaces.IFirmwareUpdateSupported, core.units.interfaces.IStravaSegmentsSupported, core.units.interfaces.ISportProfiles, core.units.interfaces.ITotalsList
    {
        public function UnitROX70()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedTracks = init.BackendInitializer.getInstance().createVectorList();
            _sportprofilesList = new __AS3__.vec.Vector.<core.sportprofiles.Sportprofile>();
            _sportprofilesVectorlist = init.BackendInitializer.getInstance().createVectorList();
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            _trackList = init.BackendInitializer.getInstance().createVectorList();
            _tracksToDecode = new __AS3__.vec.Vector.<core.route.Route>();
            super();
            type = core.general.UnitType.ROX70;
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            addEventListener("sportprofilesChanged", onSportprofilesChanged, false, 0, true);
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
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

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
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
            return 0;
        }

        public function get trackList():init.interfaces.IVectorList
        {
            return _trackList;
        }

        public function get currentSportProfileIndex():uint
        {
            return _currentSportProfileIndex;
        }

        public function set currentSportProfileIndex(arg1:uint):void
        {
            _currentSportProfileIndex = arg1;
            return;
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

        public function get currentStravaSegment():core.strava.StravaSegment
        {
            return _currentStravaSegment;
        }

        public function set currentStravaSegment(arg1:core.strava.StravaSegment):void
        {
            _currentStravaSegment = arg1;
            return;
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

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return _tracksToDecode;
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

        public static function getSoftwareRevisionNumber(arg1:String):Number
        {
            var loc1:*=arg1.split("-");
            var loc2:*=loc1[3];
            return loc2;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
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

        public function get loadedSportProfiles():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>
        {
            return _loadedSportProfiles;
        }

        public function set loadedSportProfiles(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void
        {
            _loadedSportProfiles = arg1;
            return;
        }

        public function firmwareUpdateSupported():Boolean
        {
            return true;
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

        public function bleFirmwareUpdateSupported():Boolean
        {
            return false;
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
        }

        public function set logTime5Sec(arg1:int):void
        {
            _logTime5Sec = arg1;
            return;
        }

        public function addSportProfile(arg1:core.sportprofiles.Sportprofile):void
        {
            sportprofilesList.push(arg1);
            dispatchEvent(new flash.events.Event("sportprofilesListChange"));
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

        public override function toString():String
        {
            return "[ROX70 extends UnitBikeComputer]";
        }

        public function get memoryMapVersion():String
        {
            return _memoryMapVersion;
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

        public function get powerZone1Start():int
        {
            return _powerZone1Start;
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

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public function get powerZone2Start():int
        {
            return _powerZone2Start;
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

        internal function onSportprofilesChanged(arg1:flash.events.Event):void
        {
            sportprofilesVectorlist = init.BackendInitializer.getInstance().createVectorList(_sportprofilesList);
            return;
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

        public function get sportprofilesList():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>
        {
            return _sportprofilesList;
        }

        public function set sportprofilesList(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void
        {
            if (arg1 != _sportprofilesList) 
            {
                _sportprofilesList = arg1;
                dispatchEvent(new flash.events.Event("sportprofilesListChange"));
            }
            return;
        }

        public function get sportprofilesVectorlist():init.interfaces.IVectorList
        {
            return _sportprofilesVectorlist;
        }

        public function set sportprofilesVectorlist(arg1:init.interfaces.IVectorList):void
        {
            _sportprofilesVectorlist = arg1;
            return;
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

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _currentSportProfileIndex:uint;

        internal var _currentTotals:core.totals.Totals;

        internal var _freePackages:int=0;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _currentStravaSegment:core.strava.StravaSegment;

        internal var _loadedSportProfiles:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        internal var _loadedTracks:init.interfaces.IVectorList;

        internal var _logTime5Sec:int=0;

        internal var _maxPackages:int=0;

        protected var _memoryMapVersion:String="";

        internal var _powerZone1Start:Number=0;

        internal var _powerZone2Start:int=141;

        internal var _powerZone3Start:int=191;

        internal var _sportprofilesList:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        internal var _unitLogStatus:Boolean=true;

        internal var _powerZone6Start:int=301;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _powerZone4Start:int=231;

        internal var _sportprofilesVectorlist:init.interfaces.IVectorList;

        internal var _trackList:init.interfaces.IVectorList;

        internal var _powerZone7Start:int=367;

        internal var _powerZone5Start:int=261;

        internal var _tracksToDecode:__AS3__.vec.Vector.<core.route.Route>;

        internal var _powerZone7End:int=2000;

        internal var _thresholdPower:int=253;
    }
}


