//class SettingsBC716
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC716 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IAutoScan, core.settings.interfaces.ILanguage
    {
        public function SettingsBC716(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            _language = arg1;
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

        internal var _language:String="en";

        internal var _scanFlagOn:Boolean;
    }
}


