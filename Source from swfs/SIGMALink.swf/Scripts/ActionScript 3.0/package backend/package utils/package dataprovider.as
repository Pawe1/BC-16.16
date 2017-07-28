//package dataprovider
//  class AlarmModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class AlarmModeDataProvider extends starling.events.EventDispatcher
    {
        public function AlarmModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAlarmModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAlarmModeDataProvider.DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class AltitudeReferenceMarkDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class AltitudeReferenceMarkDataProvider extends Object
    {
        public function AltitudeReferenceMarkDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAltitudeReferenceDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAltitudeReferenceDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class AltitudeUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class AltitudeUnitDataProvider extends starling.events.EventDispatcher
    {
        public function AltitudeUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAltitudeUnitDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonAltitudeUnitDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_SOFTWARE_SETTINGS = new feathers.data.ListCollection(utils.dataprovider.CommonAltitudeUnitDataProvider.V_DATA_PROVIDER_SOFTWARE_SETTINGS);
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARE_SETTINGS():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.AltitudeUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
        }

        public static function set DATA_PROVIDER_SOFTWARE_SETTINGS(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.AltitudeUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.AltitudeUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARE_SETTINGS", loc1, arg1, backend.utils.dataprovider.AltitudeUnitDataProvider);
                loc3 = backend.utils.dataprovider.AltitudeUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        internal static var _876350814DATA_PROVIDER_SOFTWARE_SETTINGS:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class AutoLapDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class AutoLapDataProvider extends starling.events.EventDispatcher
    {
        public function AutoLapDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAutoLapDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAutoLapDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function filter(arg1:Array):feathers.data.ListCollection
        {
            var loc6:*=null;
            var loc1:*=new feathers.data.ListCollection();
            var loc2:*=DATA_PROVIDER.length;
            var loc3:*=arg1.length;
            var loc4:*=0;
            var loc5:*=0;
            while (loc4 < loc2) 
            {
                loc6 = DATA_PROVIDER.getItemAt(loc4);
                if (loc6.hasOwnProperty("data")) 
                {
                    loc5 = 0;
                    while (loc5 < loc3) 
                    {
                        if (loc6.data == arg1[loc5]) 
                        {
                            loc1.push(loc6);
                        }
                        ++loc5;
                    }
                }
                ++loc4;
            }
            return loc1;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class AutoOffTimeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class AutoOffTimeDataProvider extends Object
    {
        public function AutoOffTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAutoOffTimeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAutoOffTimeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class BacklightLevelDataProvider
package backend.utils.dataprovider 
{
    import core.settings.interfaces.*;
    import feathers.data.*;
    
    public class BacklightLevelDataProvider extends Object
    {
        public function BacklightLevelDataProvider()
        {
            super();
            return;
        }

        public static function generateDataProvider(arg1:core.settings.interfaces.IBacklightLevel):feathers.data.ListCollection
        {
            var loc1:*=arg1.backlightLevelMin;
            var loc2:*=arg1.backlightLevelMax;
            var loc3:*=0;
            var loc4:*=new feathers.data.ListCollection();
            loc3 = loc1;
            while (loc3 <= loc2) 
            {
                loc4.addItem({"label":loc3 + "", "data":loc3});
                ++loc3;
            }
            return loc4;
        }
    }
}


//  class BacklightTimeDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class BacklightTimeDataProvider extends Object
    {
        public function BacklightTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonBacklightTimeDataProvider.init();
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonBacklightTimeDataProvider.DATA_PROVIDER_ROX100);
            DATA_PROVIDER_ROX70_ROX110 = new feathers.data.ListCollection(utils.dataprovider.CommonBacklightTimeDataProvider.DATA_PROVIDER_ROX70_ROX110);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitROX100) 
            {
                loc2 = DATA_PROVIDER_ROX100;
            }
            else if (loc1 is core.units.UnitROX70 || loc1 is core.units.UnitROX110) 
            {
                loc2 = DATA_PROVIDER_ROX70_ROX110;
            }
            return loc2;
        }

        public static var DATA_PROVIDER_ROX100:feathers.data.ListCollection;

        public static var DATA_PROVIDER_ROX70_ROX110:feathers.data.ListCollection;
    }
}


//  class BikeTypeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class BikeTypeDataProvider extends Object
    {
        public function BikeTypeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonBikeTypeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonBikeTypeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class ClockFormatDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class ClockFormatDataProvider extends starling.events.EventDispatcher
    {
        public function ClockFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonClockFormatDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonClockFormatDataProvider.V_DATA_PROVIDER);
            AM_PM_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonClockFormatDataProvider.V_AM_PM_PROVIDER);
            return;
        }

        public static function get AM_PM_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.ClockFormatDataProvider._329019808AM_PM_PROVIDER;
        }

        public static function set AM_PM_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.ClockFormatDataProvider._329019808AM_PM_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.ClockFormatDataProvider._329019808AM_PM_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "AM_PM_PROVIDER", loc1, arg1, backend.utils.dataprovider.ClockFormatDataProvider);
                loc3 = backend.utils.dataprovider.ClockFormatDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.ClockFormatDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.ClockFormatDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.ClockFormatDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.ClockFormatDataProvider);
                loc3 = backend.utils.dataprovider.ClockFormatDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _329019808AM_PM_PROVIDER:feathers.data.ListCollection;

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class ContrastDataProvider
package backend.utils.dataprovider 
{
    import core.settings.interfaces.*;
    import feathers.data.*;
    
    public class ContrastDataProvider extends Object
    {
        public function ContrastDataProvider()
        {
            super();
            return;
        }

        public static function generateDataProvider(arg1:core.settings.interfaces.IContrast):feathers.data.ListCollection
        {
            var loc1:*=arg1.contrastMin;
            var loc2:*=arg1.contrastMax;
            var loc3:*=0;
            var loc4:*=new feathers.data.ListCollection();
            loc3 = loc1;
            while (loc3 <= loc2) 
            {
                loc4.addItem({"label":loc3 + "", "data":loc3});
                ++loc3;
            }
            return loc4;
        }
    }
}


//  class DataProviderUtil
package backend.utils.dataprovider 
{
    public class DataProviderUtil extends Object
    {
        public function DataProviderUtil()
        {
            super();
            return;
        }

        public static function initDataProviders():void
        {
            backend.utils.dataprovider.AltitudeReferenceMarkDataProvider.init();
            backend.utils.dataprovider.AltitudeUnitDataProvider.init();
            backend.utils.dataprovider.AlarmModeDataProvider.init();
            backend.utils.dataprovider.AutoLapDataProvider.init();
            backend.utils.dataprovider.AutoOffTimeDataProvider.init();
            backend.utils.dataprovider.BacklightTimeDataProvider.init();
            backend.utils.dataprovider.BikeTypeDataProvider.init();
            backend.utils.dataprovider.ClockFormatDataProvider.init();
            backend.utils.dataprovider.DateFormatDataProvider.init();
            backend.utils.dataprovider.DistanceUnitDataProvider.init();
            backend.utils.dataprovider.FavoritesPC2812DataProvider.init();
            backend.utils.dataprovider.FavoritesRoxDataProvider.init();
            backend.utils.dataprovider.FavoritesRox100DataProvider.init();
            backend.utils.dataprovider.FavoritesRox2010DataProvider.init();
            backend.utils.dataprovider.GenderDataProvider.init();
            backend.utils.dataprovider.GPSFormatDataProvider.init();
            backend.utils.dataprovider.HeightUnitDataProvider.init();
            backend.utils.dataprovider.LanguageDataProvider.init();
            backend.utils.dataprovider.MeasurementDataProvider.init();
            backend.utils.dataprovider.SamplingRateDataProvider.init();
            backend.utils.dataprovider.TemperatureUnitDataProvider.init();
            backend.utils.dataprovider.TimeZoneDataProvider.init();
            backend.utils.dataprovider.TireModeDataProvider.init();
            backend.utils.dataprovider.TrainingZoneDataProvider.init();
            backend.utils.dataprovider.WeightUnitDataProvider.init();
            backend.utils.dataprovider.WheelSizeSelectionModeDataProvider.init();
            backend.utils.dataprovider.RouteOptionsDataProvider.init();
            backend.utils.dataprovider.FuelConsumptionDataProvider.init();
            backend.utils.dataprovider.ETAModeDataProvider.init();
            backend.utils.dataprovider.TrackDirectionDataProvider.init();
            backend.utils.dataprovider.TrackDistanceDataProvider.init();
            return;
        }
    }
}


//  class DateFormatDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class DateFormatDataProvider extends starling.events.EventDispatcher
    {
        public function DateFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonDateFormatDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonDateFormatDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.DateFormatDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.DateFormatDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.DateFormatDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.DateFormatDataProvider);
                loc3 = backend.utils.dataprovider.DateFormatDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class DistanceUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class DistanceUnitDataProvider extends starling.events.EventDispatcher
    {
        public function DistanceUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonDistanceUnitDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonDistanceUnitDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_SOFTWARE_SETTINGS = new feathers.data.ListCollection(utils.dataprovider.CommonDistanceUnitDataProvider.V_DATA_PROVIDER_SOFTWARE_SETTINGS);
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARE_SETTINGS():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.DistanceUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
        }

        public static function set DATA_PROVIDER_SOFTWARE_SETTINGS(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.DistanceUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.DistanceUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARE_SETTINGS", loc1, arg1, backend.utils.dataprovider.DistanceUnitDataProvider);
                loc3 = backend.utils.dataprovider.DistanceUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        internal static var _876350814DATA_PROVIDER_SOFTWARE_SETTINGS:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class ETAModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class ETAModeDataProvider extends Object
    {
        public function ETAModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonETAModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonETAModeDataProvider.DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class FavoritesPC2812DataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesPC2812DataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function FavoritesPC2812DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesPC2812DataProvider.init();
            DATA_PROVIDER_TRIP = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesPC2812DataProvider.V_DATA_PROVIDER_TRIP);
            return;
        }

        public static var DATA_PROVIDER_TRIP:feathers.data.ListCollection;
    }
}


//  class FavoritesRox100DataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesRox100DataProvider extends Object
    {
        public function FavoritesRox100DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesRox100DataProvider.init();
            DATA_PROVIDER_TRIP = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_TRIP);
            DATA_PROVIDER_TRACK_ALTI = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_TRACK_ALTI);
            DATA_PROVIDER_LAP = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_LAP);
            DATA_PROVIDER_PAGE_COUNT = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_PAGE_COUNT);
            DATA_PROVIDER_CUSTOM = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_CUSTOM);
            return;
        }

        public static var DATA_PROVIDER_CUSTOM:feathers.data.ListCollection;

        public static var DATA_PROVIDER_LAP:feathers.data.ListCollection;

        public static var DATA_PROVIDER_PAGE_COUNT:feathers.data.ListCollection;

        public static var DATA_PROVIDER_TRACK_ALTI:feathers.data.ListCollection;

        public static var DATA_PROVIDER_TRIP:feathers.data.ListCollection;
    }
}


//  class FavoritesRox2010DataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesRox2010DataProvider extends Object
    {
        public function FavoritesRox2010DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesRox2010DataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox2010DataProvider.V_DATA_PROVIDER);
            DATA_PROVIDER_ROX8_1 = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox2010DataProvider.V_DATA_PROVIDER_ROX8_1);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;

        public static var DATA_PROVIDER_ROX8_1:feathers.data.ListCollection;
    }
}


//  class FavoritesRoxDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesRoxDataProvider extends Object
    {
        public function FavoritesRoxDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesRoxDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRoxDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class FuelConsumptionDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class FuelConsumptionDataProvider extends starling.events.EventDispatcher
    {
        public function FuelConsumptionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFuelConsumptionDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonFuelConsumptionDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.FuelConsumptionDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.FuelConsumptionDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.FuelConsumptionDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.FuelConsumptionDataProvider);
                loc3 = backend.utils.dataprovider.FuelConsumptionDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class GPSFormatDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class GPSFormatDataProvider extends starling.events.EventDispatcher
    {
        public function GPSFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonGPSFormatDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonGPSFormatDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.GPSFormatDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.GPSFormatDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.GPSFormatDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.GPSFormatDataProvider);
                loc3 = backend.utils.dataprovider.GPSFormatDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class GenderDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class GenderDataProvider extends Object
    {
        public function GenderDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonGenderDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonGenderDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class HeightUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class HeightUnitDataProvider extends starling.events.EventDispatcher
    {
        public function HeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonHeightUnitDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonHeightUnitDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.HeightUnitDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.HeightUnitDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.HeightUnitDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.HeightUnitDataProvider);
                loc3 = backend.utils.dataprovider.HeightUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class LanguageDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class LanguageDataProvider extends starling.events.EventDispatcher
    {
        public function LanguageDataProvider()
        {
            super();
            return;
        }

        public static function get DATA_PROVIDER_ROX70_ROX110():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._192133113DATA_PROVIDER_ROX70_ROX110;
        }

        public static function set DATA_PROVIDER_ROX70_ROX110(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._192133113DATA_PROVIDER_ROX70_ROX110;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._192133113DATA_PROVIDER_ROX70_ROX110 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX70_ROX110", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARESETTINGS_EN():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._102659941DATA_PROVIDER_SOFTWARESETTINGS_EN;
        }

        public static function set DATA_PROVIDER_SOFTWARESETTINGS_EN(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._102659941DATA_PROVIDER_SOFTWARESETTINGS_EN;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._102659941DATA_PROVIDER_SOFTWARESETTINGS_EN = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARESETTINGS_EN", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_RC2011():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._745976312DATA_PROVIDER_RC2011;
        }

        public static function get DATA_PROVIDER_SOFTWARESETTINGS_JA_CH():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH;
        }

        public static function set DATA_PROVIDER_SOFTWARESETTINGS_JA_CH(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARESETTINGS_JA_CH", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_TOPLINE2009():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1500203241DATA_PROVIDER_TOPLINE2009;
        }

        public static function get DATA_PROVIDER_TOPLINE2012():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1500203217DATA_PROVIDER_TOPLINE2012;
        }

        public static function set DATA_PROVIDER_TOPLINE2012(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1500203217DATA_PROVIDER_TOPLINE2012;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1500203217DATA_PROVIDER_TOPLINE2012 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_TOPLINE2012", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static function init():void
        {
            utils.dataprovider.CommonLanguageDataProvider.init();
            DATA_PROVIDER_BETA_TEST = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_BETA_TEST);
            DATA_PROVIDER_GPS10 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_GPS10);
            DATA_PROVIDER_PC2814 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_PC2814);
            DATA_PROVIDER_RC2011 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_RC2011);
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX100);
            DATA_PROVIDER_ROX2008 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX2008);
            DATA_PROVIDER_ROX2010 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX2010);
            DATA_PROVIDER_ROX70_ROX110 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX70_ROX110);
            DATA_PROVIDER_SOFTWARESETTINGS_EN = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_SOFTWARESETTINGS_EN);
            DATA_PROVIDER_SOFTWARESETTINGS_JA_CH = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_SOFTWARESETTINGS_JA_CH);
            DATA_PROVIDER_TOPLINE2009 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_TOPLINE2009);
            DATA_PROVIDER_TOPLINE2012 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_TOPLINE2012);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitROX) 
            {
                loc2 = DATA_PROVIDER_ROX2008;
            }
            else if (loc1 is core.units.UnitROX2010) 
            {
                loc2 = DATA_PROVIDER_ROX2010;
            }
            else if (loc1 is core.units.UnitROX2010) 
            {
                loc2 = DATA_PROVIDER_TOPLINE2009;
            }
            else if (loc1 is core.units.UnitTopline2012 || loc1 is core.units.UnitTopline2016) 
            {
                loc2 = DATA_PROVIDER_TOPLINE2012;
            }
            else if (loc1 is core.units.UnitRC1411) 
            {
                loc2 = DATA_PROVIDER_RC2011;
            }
            else if (loc1 is core.units.UnitROX2012) 
            {
                loc2 = DATA_PROVIDER_TOPLINE2012;
            }
            else if (loc1 is core.units.UnitROX100) 
            {
                loc2 = DATA_PROVIDER_ROX100;
            }
            else if (loc1 is core.units.UnitPC2814) 
            {
                loc2 = DATA_PROVIDER_PC2814;
            }
            else if (loc1 is core.units.UnitROX70 || loc1 is core.units.UnitROX110) 
            {
                loc2 = DATA_PROVIDER_ROX70_ROX110;
            }
            else if (loc1 is core.units.UnitGps10) 
            {
                loc2 = DATA_PROVIDER_GPS10;
            }
            return loc2;
        }

        public static function get DATA_PROVIDER_BETA_TEST():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1761242984DATA_PROVIDER_BETA_TEST;
        }

        public static function set DATA_PROVIDER_BETA_TEST(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1761242984DATA_PROVIDER_BETA_TEST;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1761242984DATA_PROVIDER_BETA_TEST = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_BETA_TEST", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_GPS10():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1557824112DATA_PROVIDER_GPS10;
        }

        public static function set DATA_PROVIDER_GPS10(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1557824112DATA_PROVIDER_GPS10;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1557824112DATA_PROVIDER_GPS10 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_GPS10", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_PC2814():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._803226923DATA_PROVIDER_PC2814;
        }

        public static function set DATA_PROVIDER_PC2814(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._803226923DATA_PROVIDER_PC2814;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._803226923DATA_PROVIDER_PC2814 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_PC2814", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set DATA_PROVIDER_TOPLINE2009(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1500203241DATA_PROVIDER_TOPLINE2009;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1500203241DATA_PROVIDER_TOPLINE2009 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_TOPLINE2009", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set DATA_PROVIDER_RC2011(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._745976312DATA_PROVIDER_RC2011;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._745976312DATA_PROVIDER_RC2011 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_RC2011", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX100():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._733761073DATA_PROVIDER_ROX100;
        }

        public static function set DATA_PROVIDER_ROX100(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._733761073DATA_PROVIDER_ROX100;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._733761073DATA_PROVIDER_ROX100 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX100", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX2008():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1271726936DATA_PROVIDER_ROX2008;
        }

        public static function set DATA_PROVIDER_ROX2008(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1271726936DATA_PROVIDER_ROX2008;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1271726936DATA_PROVIDER_ROX2008 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX2008", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX2010():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1271726913DATA_PROVIDER_ROX2010;
        }

        public static function set DATA_PROVIDER_ROX2010(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1271726913DATA_PROVIDER_ROX2010;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1271726913DATA_PROVIDER_ROX2010 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX2010", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static var _1761242984DATA_PROVIDER_BETA_TEST:feathers.data.ListCollection;

        internal static var _1557824112DATA_PROVIDER_GPS10:feathers.data.ListCollection;

        internal static var _803226923DATA_PROVIDER_PC2814:feathers.data.ListCollection;

        internal static var _745976312DATA_PROVIDER_RC2011:feathers.data.ListCollection;

        internal static var _1271726936DATA_PROVIDER_ROX2008:feathers.data.ListCollection;

        internal static var _1271726913DATA_PROVIDER_ROX2010:feathers.data.ListCollection;

        internal static var _192133113DATA_PROVIDER_ROX70_ROX110:feathers.data.ListCollection;

        internal static var _102659941DATA_PROVIDER_SOFTWARESETTINGS_EN:feathers.data.ListCollection;

        internal static var _329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH:feathers.data.ListCollection;

        internal static var _1500203241DATA_PROVIDER_TOPLINE2009:feathers.data.ListCollection;

        internal static var _1500203217DATA_PROVIDER_TOPLINE2012:feathers.data.ListCollection;

        internal static var _733761073DATA_PROVIDER_ROX100:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class MeasurementDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class MeasurementDataProvider extends Object
    {
        public function MeasurementDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonMeasurementDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonMeasurementDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_RC = new feathers.data.ListCollection(utils.dataprovider.CommonMeasurementDataProvider.V_DATA_PROVIDER_RC);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitBikeComputer) 
            {
                loc2 = DATA_PROVIDER_BC;
            }
            else if (loc1 is core.units.UnitRunningComputer) 
            {
                loc2 = DATA_PROVIDER_RC;
            }
            return loc2;
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        public static var DATA_PROVIDER_RC:feathers.data.ListCollection;
    }
}


//  class RouteOptionsDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class RouteOptionsDataProvider extends Object
    {
        public function RouteOptionsDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonRouteOptionsDataProvider.init();
            _suitableDataProvider = new feathers.data.ListCollection(utils.dataprovider.CommonRouteOptionsDataProvider.V_SUITABLE_DATA_PROVIDER);
            _characteristicsDataProvider = new feathers.data.ListCollection(utils.dataprovider.CommonRouteOptionsDataProvider.V_CHARACTERISTIC_DATA_PROVIDER);
            _typeDataProvider = new feathers.data.ListCollection(utils.dataprovider.CommonRouteOptionsDataProvider.V_TYPE_DATA_PROVIDER);
            return;
        }

        public static function getSuitableDataProvider():feathers.data.ListCollection
        {
            return _suitableDataProvider;
        }

        public static function getCharacteristicsDataProvider():feathers.data.ListCollection
        {
            return _characteristicsDataProvider;
        }

        public static function getTypeDataProvider():feathers.data.ListCollection
        {
            return _typeDataProvider;
        }

        internal static var _characteristicsDataProvider:feathers.data.ListCollection;

        internal static var _suitableDataProvider:feathers.data.ListCollection;

        internal static var _typeDataProvider:feathers.data.ListCollection;
    }
}


//  class SamplingRateDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class SamplingRateDataProvider extends starling.events.EventDispatcher
    {
        public function SamplingRateDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonSamplingRateDataProvider.init();
            DATA_PROVIDER_BC2316 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_BC2316);
            DATA_PROVIDER_PC2814 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_PC2814);
            DATA_PROVIDER_RC1411 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_RC1411);
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_ROX100);
            DATA_PROVIDER_ROX110 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_ROX110);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitBC2316STS) 
            {
                loc2 = DATA_PROVIDER_BC2316;
            }
            else if (loc1 is core.units.UnitPC2814) 
            {
                loc2 = DATA_PROVIDER_PC2814;
            }
            else if (loc1 is core.units.UnitRC1411) 
            {
                loc2 = DATA_PROVIDER_RC1411;
            }
            else if (loc1 is core.units.UnitROX100) 
            {
                loc2 = DATA_PROVIDER_ROX100;
            }
            else if (loc1 is core.units.UnitROX110) 
            {
                loc2 = DATA_PROVIDER_ROX110;
            }
            return loc2;
        }

        public static function get DATA_PROVIDER_BC2316():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._1204039840DATA_PROVIDER_BC2316;
        }

        public static function set DATA_PROVIDER_BC2316(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._1204039840DATA_PROVIDER_BC2316;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._1204039840DATA_PROVIDER_BC2316 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_BC2316", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_PC2814():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._803226923DATA_PROVIDER_PC2814;
        }

        public static function set DATA_PROVIDER_PC2814(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._803226923DATA_PROVIDER_PC2814;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._803226923DATA_PROVIDER_PC2814 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_PC2814", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_RC1411():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._746002259DATA_PROVIDER_RC1411;
        }

        public static function set DATA_PROVIDER_RC1411(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._746002259DATA_PROVIDER_RC1411;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._746002259DATA_PROVIDER_RC1411 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_RC1411", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX100():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._733761073DATA_PROVIDER_ROX100;
        }

        public static function set DATA_PROVIDER_ROX100(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._733761073DATA_PROVIDER_ROX100;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._733761073DATA_PROVIDER_ROX100 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX100", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX110():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._733761042DATA_PROVIDER_ROX110;
        }

        public static function set DATA_PROVIDER_ROX110(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._733761042DATA_PROVIDER_ROX110;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._733761042DATA_PROVIDER_ROX110 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX110", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _1204039840DATA_PROVIDER_BC2316:feathers.data.ListCollection;

        internal static var _803226923DATA_PROVIDER_PC2814:feathers.data.ListCollection;

        internal static var _746002259DATA_PROVIDER_RC1411:feathers.data.ListCollection;

        internal static var _733761073DATA_PROVIDER_ROX100:feathers.data.ListCollection;

        internal static var _733761042DATA_PROVIDER_ROX110:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class TemperatureUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class TemperatureUnitDataProvider extends starling.events.EventDispatcher
    {
        public function TemperatureUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTemperatureUnitDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonTemperatureUnitDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_SOFTWARE_SETTINGS = new feathers.data.ListCollection(utils.dataprovider.CommonTemperatureUnitDataProvider.V_DATA_PROVIDER_SOFTWARE_SETTINGS);
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARE_SETTINGS():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.TemperatureUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
        }

        public static function set DATA_PROVIDER_SOFTWARE_SETTINGS(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.TemperatureUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.TemperatureUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARE_SETTINGS", loc1, arg1, backend.utils.dataprovider.TemperatureUnitDataProvider);
                loc3 = backend.utils.dataprovider.TemperatureUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        internal static var _876350814DATA_PROVIDER_SOFTWARE_SETTINGS:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class TimeZoneDataProvider
package backend.utils.dataprovider 
{
    import core.settings.*;
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TimeZoneDataProvider extends Object
    {
        public function TimeZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTimeZoneDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTimeZoneDataProvider.DATA_PROVIDER);
            DATA_PROVIDER_GPS_10 = new feathers.data.ListCollection(utils.dataprovider.CommonTimeZoneDataProvider.DATA_PROVIDER_GPS_10);
            return;
        }

        public static function getDataProvider(arg1:core.settings.Settings):feathers.data.ListCollection
        {
            if (arg1 is core.settings.SettingsGps10) 
            {
                return DATA_PROVIDER_GPS_10;
            }
            return DATA_PROVIDER;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;

        public static var DATA_PROVIDER_GPS_10:feathers.data.ListCollection;
    }
}


//  class TireModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TireModeDataProvider extends Object
    {
        public function TireModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTireModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTireModeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class TrackDirectionDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TrackDirectionDataProvider extends Object
    {
        public function TrackDirectionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTrackDirectionDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTrackDirectionDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class TrackDistanceDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TrackDistanceDataProvider extends Object
    {
        public function TrackDistanceDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTrackDistanceDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTrackDistanceDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//  class TrainingZoneDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TrainingZoneDataProvider extends Object
    {
        public function TrainingZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTrainingZoneDataProvider.init();
            DATA_PROVIDER_FIT_FAT = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_FIT_FAT);
            DATA_PROVIDER_HEARTRATE_LIMITS = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_HEARTRATE_LIMITS);
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_ROX100);
            DATA_PROVIDER_RCMOVE = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_RCMOVE);
            return;
        }

        public static var DATA_PROVIDER_FIT_FAT:feathers.data.ListCollection;

        public static var DATA_PROVIDER_HEARTRATE_LIMITS:feathers.data.ListCollection;

        public static var DATA_PROVIDER_RCMOVE:feathers.data.ListCollection;

        public static var DATA_PROVIDER_ROX100:feathers.data.ListCollection;
    }
}


//  class UnitsDataProvider
package backend.utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class UnitsDataProvider extends starling.events.EventDispatcher
    {
        public function UnitsDataProvider()
        {
            super();
            return;
        }

        public static function init(arg1:Boolean=true, arg2:Boolean=true, arg3:Boolean=true):void
        {
            var loc2:*=0;
            var loc4:*=null;
            utils.dataprovider.CommonUnitsDataProvider.init();
            var loc1:*=new Vector.<utils.dataprovider.UnitItemRendererData>();
            var loc3:*=utils.dataprovider.CommonUnitsDataProvider.V_DATA_PROVIDER_ALL_DEVICES.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = utils.dataprovider.CommonUnitsDataProvider.V_DATA_PROVIDER_ALL_DEVICES[loc2];
                if (loc4.usb && arg1 || loc4.ble && arg2 || loc4.nfc && arg3) 
                {
                    loc1.push(loc4);
                }
                ++loc2;
            }
            DATA_PROVIDER_ALL_DEVICES = new feathers.data.ListCollection(loc1);
            return;
        }

        public static function isCommunicationAvailable(arg1:core.general.UnitType):Boolean
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=DATA_PROVIDER_ALL_DEVICES.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = (DATA_PROVIDER_ALL_DEVICES.getItemAt(loc1) as utils.dataprovider.UnitItemRendererData).data as core.general.UnitType;
                if (loc3.equals(arg1)) 
                {
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public static function get DATA_PROVIDER_ALL_DEVICES():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.UnitsDataProvider._176373798DATA_PROVIDER_ALL_DEVICES;
        }

        public static function set DATA_PROVIDER_ALL_DEVICES(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.UnitsDataProvider._176373798DATA_PROVIDER_ALL_DEVICES;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.UnitsDataProvider._176373798DATA_PROVIDER_ALL_DEVICES = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ALL_DEVICES", loc1, arg1, backend.utils.dataprovider.UnitsDataProvider);
                loc3 = backend.utils.dataprovider.UnitsDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _176373798DATA_PROVIDER_ALL_DEVICES:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class VolumeDataProvider
package backend.utils.dataprovider 
{
    import __AS3__.vec.*;
    import feathers.data.*;
    import starling.events.*;
    
    public class VolumeDataProvider extends starling.events.EventDispatcher
    {
        public function VolumeDataProvider()
        {
            super();
            return;
        }

        public static const DATA_PROVIDER:feathers.data.ListCollection=new feathers.data.ListCollection(Vector.<Object>([{"label":"1", "data":1}, {"label":"2", "data":2}, {"label":"3", "data":3}, {"label":"4", "data":4}, {"label":"5", "data":5}]));
    }
}


//  class WeightUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class WeightUnitDataProvider extends starling.events.EventDispatcher
    {
        public function WeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonWeightUnitDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonWeightUnitDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.WeightUnitDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.WeightUnitDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.WeightUnitDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.WeightUnitDataProvider);
                loc3 = backend.utils.dataprovider.WeightUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//  class WheelSizeSelectionModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class WheelSizeSelectionModeDataProvider extends Object
    {
        public function WheelSizeSelectionModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonWheelSizeSelectionModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonWheelSizeSelectionModeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


