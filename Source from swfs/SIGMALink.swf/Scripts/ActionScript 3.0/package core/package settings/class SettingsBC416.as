//class SettingsBC416
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC416 extends core.settings.Settings implements core.settings.interfaces.ISpeedUnit, core.settings.interfaces.IWheelSize1, core.settings.interfaces.IWheelSize1Mode, core.settings.interfaces.ITireSize1
    {
        public function SettingsBC416(arg1:flash.events.IEventDispatcher=null)
        {
            _tireSize = core.general.TireSize.S_16INCH;
            _selectionMode = core.general.WheelSizeSelectionMode.MANUAL;
            super(arg1);
            return;
        }

        public function get speedUnit():String
        {
            return _speedUnit;
        }

        public function set speedUnit(arg1:String):void
        {
            _speedUnit = arg1;
            return;
        }

        public function get tireSize1():core.general.TireSize
        {
            return _tireSize;
        }

        public function set tireSize1(arg1:core.general.TireSize):void
        {
            _tireSize = arg1;
            return;
        }

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public function set wheelSize1(arg1:int):void
        {
            _wheelSize1 = arg1;
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public function get wheelSize1Min():int
        {
            return 500;
        }

        public function get wheelSize1Mode():core.general.WheelSizeSelectionMode
        {
            return _selectionMode;
        }

        public function set wheelSize1Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _selectionMode = arg1;
            return;
        }

        internal var _speedUnit:String="kmh";

        internal var _tireSize:core.general.TireSize;

        internal var _wheelSize1:int=2195;

        internal var _selectionMode:core.general.WheelSizeSelectionMode;
    }
}


