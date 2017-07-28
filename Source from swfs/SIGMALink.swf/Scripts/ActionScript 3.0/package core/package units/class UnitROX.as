//class UnitROX
package core.units 
{
    import __AS3__.vec.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitROX extends core.units.UnitBikeComputer implements core.units.interfaces.IDSTDeviceInfo, core.units.interfaces.IUnitBatteryStatus, core.units.interfaces.ISpeedTXBatteryStatus, core.units.interfaces.ICadenceTXBatteryStatus, core.units.interfaces.IHeartrateTXBatteryStatus, core.units.interfaces.IDateCode, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.ITotalsList
    {
        public function UnitROX()
        {
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super();
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
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

        public function get cadenceTXBatteryStatus():Boolean
        {
            return _cadenceTXBatteryStatus;
        }

        public function set cadenceTXBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _cadenceTXBatteryStatus) 
            {
                _cadenceTXBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("cadenceTXBatteryStatusChange"));
            }
            return;
        }

        public function getSamplingRates():Array
        {
            return [_sr5, _sr10, _sr20, _sr30];
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

        public function getSamplingRateIds():Array
        {
            return [5, 10, 20, 30];
        }

        public function get dateCode():Date
        {
            return _dateCode;
        }

        public function set dateCode(arg1:Date):void
        {
            _dateCode = arg1;
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

        public function get heartrateTXBatteryStatus():Boolean
        {
            return _heartrateTXBatteryStatus;
        }

        public function set heartrateTXBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _heartrateTXBatteryStatus) 
            {
                _heartrateTXBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("heartrateTXBatteryStatusChange"));
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

        public function get initialWakeUpInfo():String
        {
            return _initialWakeUpInfo;
        }

        public function set initialWakeUpInfo(arg1:String):void
        {
            _initialWakeUpInfo = arg1;
            return;
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

        public function get maskingCode():String
        {
            return _maskingCode;
        }

        public function set maskingCode(arg1:String):void
        {
            _maskingCode = arg1;
            return;
        }

        public function get speedTXBatteryStatus():Boolean
        {
            return _speedTXBatteryStatus;
        }

        public function set speedTXBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _speedTXBatteryStatus) 
            {
                _speedTXBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("speedTXBatteryStatusChange"));
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

        public function get unitBatteryStatus():Boolean
        {
            return _unitBatteryStatus;
        }

        public const length:Number=128;

        protected var _cadenceTXBatteryStatus:Boolean;

        internal var _currentTotals:core.totals.Totals;

        internal var _dateCode:Date;

        protected var _heartrateTXBatteryStatus:Boolean;

        internal var _initialWakeUpInfo:String;

        internal var _maskingCode:String;

        internal var _sr5:Number=4.5;

        protected var _unitBatteryStatus:Boolean;

        protected var _speedTXBatteryStatus:Boolean;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _sr10:Number=10.125;

        internal var _sr20:Number=20.25;

        internal var _sr30:Number=30.375;
    }
}


