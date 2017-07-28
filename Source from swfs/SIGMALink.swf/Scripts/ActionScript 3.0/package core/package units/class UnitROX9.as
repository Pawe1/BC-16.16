//class UnitROX9
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class UnitROX9 extends core.units.UnitROX implements core.units.interfaces.ILogList, core.units.interfaces.ILogStatus, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogTime30Sec, core.units.interfaces.IIntensityZonesPercentage
    {
        public function UnitROX9()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            super();
            type = core.general.UnitType.ROX90;
            return;
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
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

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            _intensityZone1PercentageStart = arg1;
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

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1PercentageStart;
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

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2PercentageStart;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            _intensityZone2PercentageStart = arg1;
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
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

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
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

        public override function toString():String
        {
            return "[UnitROX9 extends UnitROX implements ILogList, ILogStatus]";
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

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _intensityZone1PercentageStart:Number=40;

        internal var _freePackages:int=0;

        internal var _intensityZone2PercentageStart:Number=55;

        internal var _intensityZone3PercentageStart:Number=70;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _intensityZone4PercentageStart:Number=85;

        internal var _maxPackages:int=0;

        internal var _logTime20Sec:int=0;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _unitLogStatus:Boolean=true;

        internal var _logTime5Sec:int=0;

        internal var _logTime10Sec:int=0;

        internal var _logTime30Sec:int=0;
    }
}


