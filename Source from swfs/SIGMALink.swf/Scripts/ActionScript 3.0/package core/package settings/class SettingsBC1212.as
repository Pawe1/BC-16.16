//class SettingsBC1212
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1212 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.IContrast, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IFuelConsumption
    {
        public function SettingsBC1212(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get fuelConsumption():Number
        {
            return _fuelConsumption;
        }

        public function set fuelConsumption(arg1:Number):void
        {
            if (arg1 != _fuelConsumption) 
            {
                _fuelConsumption = arg1;
                dispatchEvent(new flash.events.Event("fuelConsumptionChange"));
            }
            return;
        }

        public function get fuelConsumptionMax():Number
        {
            if (speedUnit == "kmh") 
            {
                return 30;
            }
            return 240;
        }

        public function get fuelConsumptionMin():Number
        {
            if (speedUnit == "kmh") 
            {
                return 1;
            }
            return 10;
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
            return "[SettingsBC1212 extends SettingsTopline2012]";
        }

        public static const FUEL_ECONOMY_MAX:Number=9999.99;

        public static const FUEL_ECONOMY_MIN:Number=0;

        internal var _contrast:int=2;

        internal var _fuelConsumption:Number=8.5;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String="N/A";

        internal var _serviceInterval:int=750;

        internal var _serviceStatusOn:Boolean=false;
    }
}


