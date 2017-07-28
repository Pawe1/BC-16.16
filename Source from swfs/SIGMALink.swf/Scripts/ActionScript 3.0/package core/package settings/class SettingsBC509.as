//class SettingsBC509
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC509 extends core.settings.SettingsTopline2009 implements core.settings.interfaces.IAutoScan
    {
        public function SettingsBC509(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get scanFlagOn():Boolean
        {
            return _scanFlagOn;
        }

        public function set scanFlagOn(arg1:Boolean):void
        {
            if (arg1 != _scanFlagOn) 
            {
                _scanFlagOn = arg1;
                dispatchEvent(new flash.events.Event("scanFlagOnChange"));
            }
            return;
        }

        internal var _scanFlagOn:Boolean=false;
    }
}


