//class UnitTopline2016
package core.units 
{
    import __AS3__.vec.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitTopline2016 extends core.units.UnitBikeComputer implements core.units.interfaces.ITotalsList, core.units.interfaces.IDSTDeviceInfo, core.units.interfaces.IDSFirmwareUpdateSupported
    {
        public function UnitTopline2016()
        {
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super();
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
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

        public override function toString():String
        {
            return "UnitTopline2016";
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public function dockingStationType():String
        {
            return "DS16";
        }

        internal var _currentTotals:core.totals.Totals;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;
    }
}


