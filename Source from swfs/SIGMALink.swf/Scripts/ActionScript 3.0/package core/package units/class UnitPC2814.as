//class UnitPC2814
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.training.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    import init.interfaces.*;
    
    public class UnitPC2814 extends core.units.UnitPulseComputer implements core.units.interfaces.IBLEDeviceInfo, core.units.interfaces.IBLESimplePairing, core.units.interfaces.ILogList, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogTime30Sec, core.units.interfaces.ILogStatus, core.units.interfaces.IIntensityZonesPercentage, core.units.interfaces.IDataToDecode, core.units.interfaces.ITrainingsList
    {
        public function UnitPC2814(arg1:flash.events.IEventDispatcher=null)
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _trainingsOnDeviceList = new __AS3__.vec.Vector.<core.training.Training>();
            _trainingsVectorList = init.BackendInitializer.getInstance().createVectorList();
            _trainings = new __AS3__.vec.Vector.<core.training.Training>();
            super(arg1);
            type = core.general.UnitType.PC2814;
            primaryServiceUUID = "cc141a56-0b20-41f8-9b2b-f92ccc9b555f";
            addEventListener("trainingsChanged", onTrainingListChanged, false, 0, true);
            return;
        }

        public function set trainingsToDelete(arg1:__AS3__.vec.Vector.<core.training.Training>):void
        {
            _trainingsToDelete = arg1;
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

        public function get trainingsVectorList():init.interfaces.IVectorList
        {
            return _trainingsVectorList;
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
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 0;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function get deviceID():String
        {
            return _bleDeviceId;
        }

        public function set deviceID(arg1:String):void
        {
            _bleDeviceId = arg1;
            return;
        }

        public function set trainingsVectorList(arg1:init.interfaces.IVectorList):void
        {
            _trainingsVectorList = arg1;
            return;
        }

        public function get dsHandler():String
        {
            return _dsHandler;
        }

        public function set dsHandler(arg1:String):void
        {
            _dsHandler = arg1;
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
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

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1PercentageStart;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            _intensityZone1PercentageStart = arg1;
            return;
        }

        public function onTrainingListChanged(arg1:flash.events.Event):void
        {
            trainingsVectorList = init.BackendInitializer.getInstance().createVectorList(_trainings);
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2PercentageStart;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            _intensityZone2PercentageStart = arg1;
            return;
        }

        public function getSamplingRates():Array
        {
            return [_sr5, _sr10, _sr20, _sr30];
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3PercentageStart;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            _intensityZone3PercentageStart = arg1;
            return;
        }

        public function getSamplingRateIds():Array
        {
            return [5, 10, 20, 30];
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4PercentageEnd;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            _intensityZone4PercentageEnd = arg1;
            return;
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

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4PercentageStart;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            _intensityZone4PercentageStart = arg1;
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 30;
        }

        public function set logTime20Sec(arg1:int):void
        {
            _logTime20Sec = arg1;
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

        public function get localName():String
        {
            return _bleLocalName;
        }

        public function set localName(arg1:String):void
        {
            _bleLocalName = arg1;
            return;
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

        public function get logTime10Sec():int
        {
            return _logTime10Sec;
        }

        public function set logTime10Sec(arg1:int):void
        {
            _logTime10Sec = arg1;
            return;
        }

        public override function toString():String
        {
            return "[UnitRC1411 extends UnitRC2011 implements ILogList, IUnitBatteryStatus]";
        }

        public function get logTime20Sec():int
        {
            return _logTime20Sec;
        }

        public function get primaryServiceUUID():String
        {
            return _bleServiceUUID;
        }

        public function get logTime30Sec():int
        {
            return _logTime30Sec;
        }

        public function set logTime30Sec(arg1:int):void
        {
            _logTime30Sec = arg1;
            return;
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

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        public function set primaryServiceUUID(arg1:String):void
        {
            _bleServiceUUID = arg1;
            return;
        }

        public function get supportMultipleTrainings():Boolean
        {
            return false;
        }

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return null;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            return;
        }

        public function get trainingsList():__AS3__.vec.Vector.<core.training.Training>
        {
            return _trainings;
        }

        public function set trainingsList(arg1:__AS3__.vec.Vector.<core.training.Training>):void
        {
            if (arg1 != _trainings) 
            {
                _trainings = arg1;
                dispatchEvent(new flash.events.Event("trainingsChanged"));
            }
            return;
        }

        public function get trainingsOnDeviceList():__AS3__.vec.Vector.<core.training.Training>
        {
            return _trainingsOnDeviceList;
        }

        public function set trainingsOnDeviceList(arg1:__AS3__.vec.Vector.<core.training.Training>):void
        {
            _trainingsOnDeviceList = arg1;
            return;
        }

        public function get trainingsToDelete():__AS3__.vec.Vector.<core.training.Training>
        {
            return _trainingsToDelete;
        }

        public static const SEND_CHARACTERISTIC_UUID:String="b789edf9-12d0-412a-b34e-fe0f2998a0ad";

        public static const PRIMARY_SERVICE_UUID:String="cc141a56-0b20-41f8-9b2b-f92ccc9b555f";

        public static const RECEIVE_CHARACTERISTIC_UUID:String="bbeaf5d9-6f57-4dd0-a153-e9f333b1b514";

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _dsHandler:String;

        internal var _freePackages:int=0;

        internal var _intensityZone1PercentageStart:Number=40;

        internal var _intensityZone2PercentageStart:Number=55;

        internal var _intensityZone3PercentageStart:Number=70;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _intensityZone4PercentageStart:Number=85;

        internal var _logTime10Sec:int=0;

        internal var _logTime20Sec:int=0;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _trainingsToDelete:__AS3__.vec.Vector.<core.training.Training>;

        internal var _sr10:Number=10;

        internal var _sr20:Number=20;

        internal var _sr30:Number=30;

        internal var _trainings:__AS3__.vec.Vector.<core.training.Training>;

        internal var _maxPackages:int=0;

        internal var _logTime30Sec:int=0;

        internal var _trainingsVectorList:init.interfaces.IVectorList;

        internal var _trainingsOnDeviceList:__AS3__.vec.Vector.<core.training.Training>;

        internal var _logTime5Sec:int=0;

        internal var _unitLogStatus:Boolean=true;

        internal var _sr5:Number=5;
    }
}


