//class MeasurementConfig
package core 
{
    import com.logging.*;
    import configCache.*;
    import flash.events.*;
    import mx.events.*;
    import utils.*;
    
    public class MeasurementConfig extends flash.events.EventDispatcher
    {
        public function MeasurementConfig()
        {
            super();
            return;
        }

        public static function get weightFormat():String
        {
            return MeasurementConfig.weightFormat;
        }

        public static function get altitudeFormat():String
        {
            return MeasurementConfig.altitudeFormat;
        }

        public static function set altitudeFormat(arg1:String):void
        {
            var loc1:*=MeasurementConfig.altitudeFormat;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.altitudeFormat = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "altitudeFormat", loc1, arg1));
                }
            }
            return;
        }

        public static function set weightFormat(arg1:String):void
        {
            var loc1:*=MeasurementConfig.weightFormat;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.weightFormat = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "weightFormat", loc1, arg1));
                }
            }
            return;
        }

        public static function get bodySizeFormat():String
        {
            return MeasurementConfig.bodySizeFormat;
        }

        public static function set bodySizeFormat(arg1:String):void
        {
            var loc1:*=MeasurementConfig.bodySizeFormat;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.bodySizeFormat = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "bodySizeFormat", loc1, arg1));
                }
            }
            return;
        }

        public static function saveToCache():void
        {
            var loc1:*=null;
            try 
            {
                loc1 = utils.BackendUtil.copy(MeasurementConfig);
                configCache.ConfigCache.getInstance().setValue("measurementConfig", loc1);
            }
            catch (e:Error)
            {
                configCache.ConfigCache.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 0, "MeasurementConfig > saveToCache: " + e.message));
            }
            return;
        }

        public static function get clockFormat():String
        {
            return MeasurementConfig.clockFormat;
        }

        public static function set clockFormat(arg1:String):void
        {
            var loc1:*=MeasurementConfig.clockFormat;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.clockFormat = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "clockFormat", loc1, arg1));
                }
            }
            return;
        }

        public static function loadFromCache():void
        {
            var loc1:*=null;
            var loc2:*=null;
            try 
            {
                loc1 = configCache.ConfigCache.getInstance().getValue("measurementConfig", MeasurementConfig);
                loc2 = utils.BackendUtil.copy(loc1);
                mapValuesFromCacheObject(loc2);
            }
            catch (e:Error)
            {
                configCache.ConfigCache.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 0, "MeasurementConfig > loadFromCache: " + e.message));
            }
            return;
        }

        public static function get dateFormat():String
        {
            return MeasurementConfig.dateFormat;
        }

        public static function set dateFormat(arg1:String):void
        {
            var loc1:*=MeasurementConfig.dateFormat;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.dateFormat = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "dateFormat", loc1, arg1));
                }
            }
            return;
        }

        internal static function mapValuesFromCacheObject(arg1:Object):void
        {
            distanceFormat = arg1.distanceFormat;
            altitudeFormat = arg1.altitudeFormat;
            speedFormat = arg1.speedFormat;
            temperatureFormat = arg1.temperatureFormat;
            clockFormat = arg1.clockFormat;
            weightFormat = arg1.weightFormat;
            bodySizeFormat = arg1.bodySizeFormat;
            language = arg1.language;
            dateFormat = arg1.dateFormat;
            fuelEconomyFormat = arg1.fuelEconomyFormat;
            return;
        }

        public static function get distanceFormat():String
        {
            return MeasurementConfig.distanceFormat;
        }

        public static function set distanceFormat(arg1:String):void
        {
            var loc1:*=MeasurementConfig.distanceFormat;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.distanceFormat = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "distanceFormat", loc1, arg1));
                }
            }
            return;
        }

        public static function get staticEventDispatcher():flash.events.IEventDispatcher
        {
            return MeasurementConfig._bindingEventDispatcher;
        }

        public static function get firstDayOfWeek():int
        {
            return MeasurementConfig.firstDayOfWeek;
        }

        public static function set firstDayOfWeek(arg1:int):void
        {
            var loc1:*=MeasurementConfig.firstDayOfWeek;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.firstDayOfWeek = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "firstDayOfWeek", loc1, arg1));
                }
            }
            return;
        }

        
        {
            altitudeFormat = "meter";
            bodySizeFormat = "centimeter";
            clockFormat = "24";
            dateFormat = "eu";
            distanceFormat = "kilometer";
            firstDayOfWeek = 1;
            fuelEconomyFormat = "liter";
            language = "en_US";
            speedFormat = "kmh";
            temperatureFormat = "celsius";
            weightFormat = "kg";
            MeasurementConfig._bindingEventDispatcher = new flash.events.EventDispatcher();
        }

        public static function get fuelEconomyFormat():String
        {
            return MeasurementConfig.fuelEconomyFormat;
        }

        public static function set fuelEconomyFormat(arg1:String):void
        {
            var loc1:*=MeasurementConfig.fuelEconomyFormat;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.fuelEconomyFormat = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "fuelEconomyFormat", loc1, arg1));
                }
            }
            return;
        }

        public static function get language():String
        {
            return MeasurementConfig.language;
        }

        public static function set language(arg1:String):void
        {
            var loc1:*=MeasurementConfig.language;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.language = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "language", loc1, arg1));
                }
            }
            return;
        }

        public static function get speedFormat():String
        {
            return MeasurementConfig.speedFormat;
        }

        public static function set speedFormat(arg1:String):void
        {
            var loc1:*=MeasurementConfig.speedFormat;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.speedFormat = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "speedFormat", loc1, arg1));
                }
            }
            return;
        }

        public static function get temperatureFormat():String
        {
            return MeasurementConfig.temperatureFormat;
        }

        public static function set temperatureFormat(arg1:String):void
        {
            var loc1:*=MeasurementConfig.temperatureFormat;
            if (loc1 !== arg1) 
            {
                MeasurementConfig.temperatureFormat = arg1;
                if (MeasurementConfig._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    MeasurementConfig._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(MeasurementConfig, "temperatureFormat", loc1, arg1));
                }
            }
            return;
        }

        internal static const CONFIG_CACHE_ID:String="measurementConfig";

        internal static var altitudeFormat:String;

        internal static var bodySizeFormat:String;

        internal static var clockFormat:String;

        internal static var dateFormat:String;

        internal static var distanceFormat:String;

        internal static var firstDayOfWeek:int;

        internal static var fuelEconomyFormat:String;

        internal static var speedFormat:String;

        internal static var weightFormat:String;

        internal static var temperatureFormat:String;

        internal static var _bindingEventDispatcher:flash.events.EventDispatcher;

        internal static var language:String;
    }
}


