//class SettingsPulseComputer
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsPulseComputer extends core.settings.Settings implements core.settings.interfaces.IClock, core.settings.interfaces.IClockMode, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit
    {
        public function SettingsPulseComputer(arg1:flash.events.IEventDispatcher=null)
        {
            _clock = new Date(new Date().fullYear, 0, 1);
            super(arg1);
            return;
        }

        public function get bodyWeight():int
        {
            return _bodyWeight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (_bodyWeight !== arg1) 
            {
                _bodyWeight = arg1;
                dispatchEvent(new flash.events.Event("bodyWeightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            return 199000;
        }

        public function get bodyWeightMin():int
        {
            return 20000;
        }

        public function get bodyWeightUnit():String
        {
            return _bodyWeightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (_bodyWeightUnit !== arg1) 
            {
                _bodyWeightUnit = arg1;
                dispatchEvent(new flash.events.Event("bodyWeightUnitChange"));
            }
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

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (_clockMode !== arg1) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsPulseComputer extends Settings]";
        }

        public static const WEIGHT_G_MAX:int=199000;

        public static const WEIGHT_G_MIN:int=20000;

        internal var _bodyWeight:int=75000;

        internal var _bodyWeightUnit:String="kg";

        internal var _clock:Date;

        internal var _clockMode:String="24";
    }
}


