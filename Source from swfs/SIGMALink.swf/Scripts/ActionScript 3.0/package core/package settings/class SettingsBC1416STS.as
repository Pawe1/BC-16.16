//class SettingsBC1416STS
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1416STS extends core.settings.SettingsBC1416 implements core.settings.interfaces.ICadenceSensor
    {
        public function SettingsBC1416STS(arg1:flash.events.IEventDispatcher=null)
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


