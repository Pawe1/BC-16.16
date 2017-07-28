//class SettingsEvent
package utils.events 
{
    import core.settings.*;
    import flash.events.*;
    
    public class SettingsEvent extends flash.events.Event
    {
        public function SettingsEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:core.settings.Settings=null)
        {
            super(arg1, arg2, arg3);
            settings = arg4;
            return;
        }

        public function get settings():core.settings.Settings
        {
            return _settings;
        }

        public function set settings(arg1:core.settings.Settings):void
        {
            _settings = arg1;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new utils.events.SettingsEvent(type, bubbles, cancelable, settings);
        }

        public static const CREATION_COMPLETE:String="creationComplete";

        public var _settings:core.settings.Settings;
    }
}


