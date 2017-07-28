//class SettingsBC812
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC812 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.ILowBatDetectLevel
    {
        public function SettingsBC812(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC812 extends SettingsTopline2012]";
        }

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String="N/A";

        internal var _serviceInterval:int=750;

        internal var _serviceStatusOn:Boolean=false;
    }
}


