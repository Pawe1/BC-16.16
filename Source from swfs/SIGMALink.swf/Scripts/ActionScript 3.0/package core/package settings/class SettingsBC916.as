//class SettingsBC916
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC916 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.ILanguage
    {
        public function SettingsBC916(arg1:flash.events.IEventDispatcher=null)
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

        internal var _language:String="en";
    }
}


