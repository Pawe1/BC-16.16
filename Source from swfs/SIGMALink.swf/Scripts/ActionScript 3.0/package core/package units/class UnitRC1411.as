//class UnitRC1411
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class UnitRC1411 extends core.units.UnitRC2011 implements core.units.interfaces.IDSTDeviceInfo, core.units.interfaces.ILogList, core.units.interfaces.IUnitBatteryStatus, core.units.interfaces.IR3TXBatteryStatus, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogTime30Sec, core.units.interfaces.ILogStatus, core.units.interfaces.IIntensityZonesPercentage
    {
        public function UnitRC1411(arg1:flash.events.IEventDispatcher=null)
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            super(arg1);
            type = core.general.UnitType.RC1411;
            return;
        }

        public override function toString():String
        {
            return "[UnitRC1411 extends UnitRC2011 implements ILogList, IUnitBatteryStatus]";
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
            return 0;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function get unitBatteryStatus():Boolean
        {
            return _unitBatteryStatus;
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

        public function set unitBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _unitBatteryStatus) 
            {
                _unitBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("unitBatteryStatusChange"));
            }
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

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
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

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
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

        public function getSamplingRates():Array
        {
            return [_sr5, _sr10, _sr20, _sr30];
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

        public function getSamplingRateIds():Array
        {
            return [5, 10, 20, 30];
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

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (5 === loc2) 
            {
                loc1 = _sr5;
            }
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

        public function get logTime20Sec():int
        {
            return _logTime20Sec;
        }

        public function set logTime20Sec(arg1:int):void
        {
            _logTime20Sec = arg1;
            return;
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

        public function get r3txBatteryStatus():Boolean
        {
            return _r3txBatteryStatus;
        }

        public function set r3txBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _r3txBatteryStatus) 
            {
                _r3txBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("r3txBatteryStatusChange"));
            }
            return;
        }

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _freePackages:int=0;

        internal var _intensityZone1PercentageStart:Number=40;

        internal var _intensityZone2PercentageStart:Number=55;

        internal var _intensityZone3PercentageStart:Number=70;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _intensityZone4PercentageStart:Number=85;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _logTime10Sec:int=0;

        internal var _logTime30Sec:int=0;

        internal var _maxPackages:int=0;

        internal var _sr10:Number=10;

        protected var _unitBatteryStatus:Boolean;

        internal var _sr30:Number=30;

        internal var _sr5:Number=5;

        internal var _logTime5Sec:int=0;

        internal var _logTime20Sec:int=0;

        protected var _r3txBatteryStatus:Boolean;

        internal var _unitLogStatus:Boolean=true;

        internal var _sr20:Number=20;
    }
}


