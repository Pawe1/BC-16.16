//class SettingsBC1616STS
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1616STS extends core.settings.SettingsBC1616 implements core.settings.interfaces.ICadenceSensor
    {
        public function SettingsBC1616STS(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get cadenceSensorActive():Boolean
        {
            return _cadenceSensorActive;
        }

        public function set cadenceSensorActive(arg1:Boolean):void
        {
            if (arg1 != _cadenceSensorActive) 
            {
                _cadenceSensorActive = arg1;
                dispatchEvent(new flash.events.Event("cadenceSensorActiveChange"));
            }
            return;
        }

        internal var _cadenceSensorActive:Boolean=false;
    }
}


