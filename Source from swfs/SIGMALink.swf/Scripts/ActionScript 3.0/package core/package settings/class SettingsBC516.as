//class SettingsBC516
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC516 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IAutoScan
    {
        public function SettingsBC516(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get scanFlagOn():Boolean
        {
            return _scanFlagOn;
        }

        public function set scanFlagOn(arg1:Boolean):void
        {
            _scanFlagOn = arg1;
            return;
        }

        internal var _scanFlagOn:Boolean;
    }
}


