//class UnitRunningComputer
package core.units 
{
    import __AS3__.vec.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitRunningComputer extends core.units.Unit implements core.units.interfaces.ITotalsList
    {
        public function UnitRunningComputer(arg1:flash.events.IEventDispatcher=null)
        {
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super(arg1);
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

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        internal var _currentTotals:core.totals.Totals;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;
    }
}


