//class SettingsRunningComputer
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsRunningComputer extends core.settings.Settings implements core.settings.interfaces.ISpeedUnit, core.settings.interfaces.IClock
    {
        public function SettingsRunningComputer(arg1:flash.events.IEventDispatcher)
        {
            _clock = new Date(new Date().fullYear, 0, 1);
            super(arg1);
            return;
        }

        public function get clock():Date
        {
            return _clock;
        }

        public function set clock(arg1:Date):void
        {
            if (_clock !== arg1) 
            {
                _clock = arg1;
                dispatchEvent(new flash.events.Event("clockChange"));
            }
            return;
        }

        public function get speedUnit():String
        {
            return _speedUnit;
        }

        public function set speedUnit(arg1:String):void
        {
            if (_speedUnit !== arg1) 
            {
                _speedUnit = arg1;
                dispatchEvent(new flash.events.Event("speedUnitChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsRunningComputer extends Settings implements IMeasurement, IClock]";
        }

        internal var _clock:Date;

        internal var _speedUnit:String="kmh";
    }
}


