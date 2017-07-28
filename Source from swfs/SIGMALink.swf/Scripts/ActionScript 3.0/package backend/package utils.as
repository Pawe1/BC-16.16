//package utils
//  package container
//    class CustomListCollection
package backend.utils.container 
{
    import __AS3__.vec.*;
    import debug.*;
    import flash.events.*;
    import helper.*;
    import init.interfaces.*;
    
    public class CustomListCollection extends flash.events.EventDispatcher implements init.interfaces.IVectorList
    {
        public function CustomListCollection(arg1:*=null)
        {
            super();
            this.source = arg1;
            return;
        }

        public function get length():int
        {
            return this._source.length;
        }

        public function get source():*
        {
            return this._source;
        }

        public function set source(arg1:*):void
        {
            if (arg1 && !helper.Vector_helper.isVector(arg1)) 
            {
                throw new TypeError("The source of a VectorList must be a Vector");
            }
            this._source = arg1 ? arg1 : new Vector.<>();
            return;
        }

        public function addItem(arg1:Object):void
        {
            this._source.push(arg1);
            return;
        }

        public function contains(arg1:Object):Boolean
        {
            return this._source.indexOf(arg1) >= 0;
        }

        public function createVectorList(arg1:*=null):init.interfaces.IVectorList
        {
            this.source = arg1;
            return this;
        }

        public function getItemAt(arg1:int, arg2:int=0):Object
        {
            if (arg2 > 0) 
            {
                debug.Debug.warning("ACHTUNG! Parameter prefetch wird nicht berücksichtigt.");
            }
            return this._source[arg1];
        }

        public function toArray():Array
        {
            return helper.Array_helper.toArray(this._source);
        }

        internal var _source:*;
    }
}


//  package dataprovider
//    class AlarmModeDataProvider
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


//    class AltitudeReferenceMarkDataProvider
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


//    class AltitudeUnitDataProvider
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


//    class AutoLapDataProvider
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


//    class AutoOffTimeDataProvider
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


//    class BacklightLevelDataProvider
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


//    class BacklightTimeDataProvider
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


//    class BikeTypeDataProvider
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


//    class ClockFormatDataProvider
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


//    class ContrastDataProvider
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


//    class DataProviderUtil
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


//    class DateFormatDataProvider
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


//    class DistanceUnitDataProvider
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


//    class ETAModeDataProvider
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


//    class FavoritesPC2812DataProvider
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


//    class FavoritesRox100DataProvider
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


//    class FavoritesRox2010DataProvider
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


//    class FavoritesRoxDataProvider
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


//    class FuelConsumptionDataProvider
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


//    class GPSFormatDataProvider
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


//    class GenderDataProvider
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


//    class HeightUnitDataProvider
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


//    class LanguageDataProvider
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


//    class MeasurementDataProvider
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


//    class RouteOptionsDataProvider
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


//    class SamplingRateDataProvider
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


//    class TemperatureUnitDataProvider
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


//    class TimeZoneDataProvider
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


//    class TireModeDataProvider
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


//    class TrackDirectionDataProvider
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


//    class TrackDistanceDataProvider
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


//    class TrainingZoneDataProvider
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


//    class UnitsDataProvider
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


//    class VolumeDataProvider
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


//    class WeightUnitDataProvider
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


//    class WheelSizeSelectionModeDataProvider
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


//  package dbUtils
//    class DBUtil
package backend.utils.dbUtils 
{
    import backend.database.*;
    import com.logging.*;
    import database.*;
    import debug.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import handler.*;
    import utils.*;
    import worker.*;
    
    public class DBUtil extends flash.events.EventDispatcher
    {
        public function DBUtil(arg1:flash.events.IEventDispatcher=null)
        {
            this._calls = new flash.utils.Dictionary();
            this._multiCalls = new flash.utils.Dictionary();
            super(arg1);
            return;
        }

        internal function get _ignoreWorkerTarget():Boolean
        {
            return !flash.system.Worker.current.isPrimordial;
        }

        public function call(arg1:String, arg2:String, arg3:Function, arg4:Function=null, arg5:flash.utils.ByteArray=null, arg6:Object=null, arg7:Object=null):void
        {
            this._workerTarget = this._ignoreWorkerTarget ? null : arg5;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject();
            loc1.sqlMode = arg1;
            loc1.stmt = arg2;
            loc1.guid = utils.GUID.create();
            loc1.completeCallback = arg3;
            loc1.errorCallback = arg4;
            loc1.data = arg6;
            loc1.parameters = arg7;
            this._calls[loc1.guid] = loc1;
            if (this._workerTarget) 
            {
                this.sendToWorker([worker.DatabaseWorker.EXECUTE_LOAD_STMT, loc1]);
            }
            else 
            {
                new database.DatabaseTransaction(this.executeStatement, [loc1], arg1).commit();
            }
            return;
        }

        public function callMultiple(arg1:String, arg2:Array, arg3:Function, arg4:Function=null, arg5:flash.utils.ByteArray=null, arg6:Object=null):void
        {
            this._workerTarget = this._ignoreWorkerTarget ? null : arg5;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject();
            loc1.sqlMode = arg1;
            loc1.stmts = arg2;
            loc1.guid = utils.GUID.create();
            loc1.completeCallback = arg3;
            loc1.errorCallback = arg4;
            loc1.data = arg6;
            this._calls[loc1.guid] = loc1;
            if (this._workerTarget) 
            {
                this.sendToWorker([worker.DatabaseWorker.EXECUTE_MULTIPLE_STMTS, loc1]);
            }
            else 
            {
                new database.DatabaseTransaction(this.executeMultipleStmts, [loc1], loc1.sqlMode).commit();
            }
            return;
        }

        public function startWorker(arg1:flash.utils.ByteArray):void
        {
            this._workerTarget = arg1;
            this.initWorker();
            return;
        }

        internal function initWorker():void
        {
            var loc1:*;
            if (workerInstance) 
            {
                return;
            }
            workerInstance = flash.system.WorkerDomain.current.createWorker(this._workerTarget, true);
            this._toBGChannel = flash.system.Worker.current.createMessageChannel(workerInstance);
            this._toMainChannel = workerInstance.createMessageChannel(flash.system.Worker.current);
            workerInstance.setSharedProperty(worker.DatabaseWorker.TO_BG_CHANNEL, this._toBGChannel);
            workerInstance.setSharedProperty(worker.DatabaseWorker.TO_MAIN_CHANNEL, this._toMainChannel);
            workerInstance.addEventListener(flash.events.Event.WORKER_STATE, this.onWorkerStateChanged);
            try 
            {
                workerInstance.start();
            }
            catch (error:Error)
            {
                debug.Debug.error("initWorker error: " + error.message);
                return;
            }
            this._toMainChannel.addEventListener(flash.events.Event.CHANNEL_MESSAGE, this.onWorkerChannelMessage);
            return;
        }

        internal function sendToWorker(arg1:Array):void
        {
            var p_array:Array;

            var loc1:*;
            p_array = arg1;
            if (!workerInstance) 
            {
                this.initWorker();
            }
            if (!this._workerInitComplete) 
            {
                flash.utils.setTimeout(this.sendToWorker, 100, p_array);
                return;
            }
            if (workerInstance.state != flash.system.WorkerState.RUNNING) 
            {
                flash.utils.setTimeout(this.sendToWorker, 100, p_array);
                return;
            }
            var loc2:*;
            var loc3:*=((loc2 = this)._currentWorkerRequests + 1);
            loc2._currentWorkerRequests = loc3;
            if (this._currentWorkerRequests > this._maxWorkerRequests) 
            {
                debug.Debug.debug("################# DESTROY WORKER ###############");
                this.destroyWorker();
                flash.utils.setTimeout(this.sendToWorker, 200, p_array);
                return;
            }
            try 
            {
                this._toBGChannel.send(p_array);
            }
            catch (error:Error)
            {
                debug.Debug.error("sendToWorker error: " + error.message);
            }
            return;
        }

        public function destroyWorker():void
        {
            this._currentWorkerRequests = 0;
            if (workerInstance) 
            {
                workerInstance.removeEventListener(flash.events.Event.WORKER_STATE, this.onWorkerStateChanged);
                workerInstance.terminate();
                workerInstance = null;
                this._workerInitComplete = false;
                this._toBGChannel.close();
                this._toMainChannel.close();
            }
            return;
        }

        internal function onWorkerStateChanged(arg1:flash.events.Event):void
        {
            if (arg1.target.state == flash.system.WorkerState.RUNNING) 
            {
                this._toBGChannel.send([worker.DatabaseWorker.INIT_DATABASE, backend.database.DatabaseDefinition.getInstance().currentDatabase.file.nativePath]);
                this._toBGChannel.send([worker.DatabaseWorker.INIT_ERROR_LOGGING, backend.database.DatabaseDefinition.getInstance().currentDatabase.workDirectory.nativePath]);
            }
            return;
        }

        internal function onWorkerChannelMessage(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=this._toMainChannel.receive();
            var loc2:*=loc1[0];
            var loc6:*=loc2;
            switch (loc6) 
            {
                case worker.DatabaseWorker.INIT_DATABASE:
                {
                    this._workerInitComplete = true;
                    break;
                }
                case worker.DatabaseWorker.EXECUTE_LOAD_STMT:
                case worker.DatabaseWorker.EXECUTE_MULTIPLE_STMTS:
                {
                    loc3 = backend.utils.dbUtils.DBUtilObject.fromObject(loc1[2]);
                    loc5 = this._calls[loc3.guid];
                    loc5.result = loc3.result;
                    delete this._calls[loc5.guid];
                    loc4 = new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc5);
                    loc5.completeCallback(loc4);
                    break;
                }
                default:
                {
                    debug.Debug.warning("TODO: no handling for mode: " + loc2);
                }
            }
            return;
        }

        internal function executeStatement(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var p_definitionObj:backend.utils.dbUtils.DBUtilObject;
            var stmt:database.DCSQLStatement;
            var prop:*;

            var loc1:*;
            stmt = null;
            prop = undefined;
            p_definitionObj = arg1;
            stmt = new database.DCSQLStatement();
            stmt.addEventListener(flash.events.SQLEvent.RESULT, this.onExecuteStatementComplete);
            stmt.addEventListener(flash.events.SQLErrorEvent.ERROR, this.onExecuteStatementError);
            stmt.data = p_definitionObj;
            stmt.text = p_definitionObj.stmt;
            if (p_definitionObj.parameters) 
            {
                var loc2:*=0;
                var loc3:*=p_definitionObj.parameters;
                for (prop in loc3) 
                {
                    stmt.parameters[prop] = p_definitionObj.parameters[prop];
                }
            }
            try 
            {
                stmt.execute();
            }
            catch (error:Error)
            {
                stmt.dispatchEvent(new flash.events.SQLErrorEvent(flash.events.SQLErrorEvent.ERROR, false, false, new flash.errors.SQLError("", stmt.text, error.message, error.errorID)));
            }
            return;
        }

        internal function onExecuteStatementComplete(arg1:flash.events.SQLEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.onExecuteStatementComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.onExecuteStatementError);
            var loc2:*=loc1.data as backend.utils.dbUtils.DBUtilObject;
            var loc3:*=loc1.getResult();
            if (loc3) 
            {
                loc2.result = loc3.data;
            }
            loc1.dbHandler.commit();
            var loc4:*=this._calls[loc2.guid];
            loc4.result = loc2.result;
            if (loc3) 
            {
                loc4.lastInsertRowId = loc3.lastInsertRowID;
            }
            delete this._calls[loc4.guid];
            var loc5:*=new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc4);
            loc4.completeCallback(loc5);
            com.logging.ErrorLogging.getInstance().removeTarget(loc1);
            return;
        }

        internal function onExecuteStatementError(arg1:flash.events.SQLErrorEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.onExecuteStatementComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.onExecuteStatementError);
            var loc2:*=loc1.data as backend.utils.dbUtils.DBUtilObject;
            loc1.dbHandler.close();
            var loc3:*=this._calls[loc2.guid];
            loc3.result = loc2.result;
            delete this._calls[loc3.guid];
            var loc4:*=new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, loc3);
            loc4.message = arg1.error.message;
            loc3.errorCallback(loc4);
            com.logging.ErrorLogging.getInstance().removeTarget(loc1);
            return;
        }

        internal function executeMultipleStmts(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var p_definitionObj:backend.utils.dbUtils.DBUtilObject;
            var i:int;
            var len:int;
            var prop:*;
            var nextObj:backend.utils.dbUtils.DBUtilObject;
            var result:Array;
            var definition:backend.utils.dbUtils.DBUtilObject;
            var completeEvent:backend.utils.dbUtils.DBUtilEvent;
            var sqlResult:flash.data.SQLResult;
            var j:int;
            var jLen:int;
            var errorEvent:backend.utils.dbUtils.DBUtilEvent;

            var loc1:*;
            i = 0;
            prop = undefined;
            nextObj = null;
            sqlResult = null;
            j = 0;
            jLen = 0;
            errorEvent = null;
            p_definitionObj = arg1;
            len = p_definitionObj.stmts.length;
            result = new Array();
            i = 0;
            while (i < len) 
            {
                nextObj = p_definitionObj.stmts[i];
                if (p_definitionObj.preparedStmt == null) 
                {
                    p_definitionObj.preparedStmt = new database.DCSQLStatement();
                    p_definitionObj.preparedStmt.data = p_definitionObj;
                }
                p_definitionObj.preparedStmt.text = nextObj.stmt;
                p_definitionObj.preparedStmt.clearParameters();
                if (nextObj.parameters) 
                {
                    var loc2:*=0;
                    var loc3:*=nextObj.parameters;
                    for (prop in loc3) 
                    {
                        p_definitionObj.preparedStmt.parameters[prop] = nextObj.parameters[prop];
                    }
                }
                try 
                {
                    p_definitionObj.preparedStmt.execute();
                    sqlResult = p_definitionObj.preparedStmt.getResult();
                    if (sqlResult && sqlResult.data) 
                    {
                        jLen = sqlResult.data.length;
                        j = 0;
                        while (j < jLen) 
                        {
                            result.push(sqlResult.data[j]);
                            ++j;
                        }
                    }
                }
                catch (error:Error)
                {
                    p_definitionObj.preparedStmt.dispatchEvent(new flash.events.SQLErrorEvent(flash.events.SQLErrorEvent.ERROR, false, false, new flash.errors.SQLError("", p_definitionObj.preparedStmt.text, error.message, error.errorID)));
                    handler.AppDBHandler.getInstance().close();
                    errorEvent = new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, p_definitionObj);
                    errorEvent.message = error.errorID + ": " + error.message;
                    p_definitionObj.errorCallback(errorEvent);
                    delete _calls[p_definitionObj.guid];
                    com.logging.ErrorLogging.getInstance().removeTarget(p_definitionObj.preparedStmt);
                    p_definitionObj = null;
                    return;
                }
                ++i;
            }
            p_definitionObj.result = result;
            handler.AppDBHandler.getInstance().commit();
            com.logging.ErrorLogging.getInstance().removeTarget(p_definitionObj.preparedStmt);
            definition = this._calls[p_definitionObj.guid];
            try 
            {
                if (definition) 
                {
                    definition.result = p_definitionObj.result;
                }
                delete this._calls[p_definitionObj.guid];
            }
            catch (e:Error)
            {
                debug.Debug.error("DBUtilObject existiert nicht mehr");
            }
            completeEvent = new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, p_definitionObj);
            p_definitionObj.completeCallback(completeEvent);
            p_definitionObj = null;
            return;
        }

        public static function getInstance():backend.utils.dbUtils.DBUtil
        {
            if (!_instance) 
            {
                _instance = new DBUtil();
            }
            return _instance;
        }

        internal var _calls:flash.utils.Dictionary;

        internal var _currentWorkerRequests:int=0;

        internal var _maxWorkerRequests:int=100;

        internal var _multiCalls:flash.utils.Dictionary;

        internal var _toBGChannel:flash.system.MessageChannel;

        internal var _toMainChannel:flash.system.MessageChannel;

        internal var _workerInitComplete:Boolean=false;

        internal var _workerTarget:flash.utils.ByteArray;

        internal static var _instance:backend.utils.dbUtils.DBUtil;

        internal static var workerInstance:flash.system.Worker;
    }
}


//    class DBUtilEvent
package backend.utils.dbUtils 
{
    import flash.events.*;
    
    public class DBUtilEvent extends flash.events.Event
    {
        public function DBUtilEvent(arg1:String, arg2:backend.utils.dbUtils.DBUtilObject=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.data = arg2;
            return;
        }

        public function getResult():Array
        {
            return this.data.result is Array ? this.data.result as Array : [];
        }

        public static const COMPLETE:String="executeCompleteEvent";

        public static const ERROR:String="executeErrorEvent";

        public var data:backend.utils.dbUtils.DBUtilObject;

        public var message:String;
    }
}


//    class DBUtilObject
package backend.utils.dbUtils 
{
    import database.*;
    import flash.utils.*;
    
    public class DBUtilObject extends Object
    {
        public function DBUtilObject(arg1:Object=null, arg2:Function=null, arg3:Function=null, arg4:flash.utils.ByteArray=null, arg5:Object=null)
        {
            super();
            this.data = arg1;
            this.completeCallback = arg2;
            this.errorCallback = arg3;
            this.workerTarget = arg4;
            this.parameters = arg5;
            return;
        }

        public static function fromObject(arg1:Object):backend.utils.dbUtils.DBUtilObject
        {
            var loc2:*=undefined;
            var loc1:*=new DBUtilObject();
            var loc3:*=0;
            var loc4:*=arg1;
            for (loc2 in loc4) 
            {
                if (loc2 == "preparedStmt") 
                {
                    loc1[loc2] = arg1[loc2] as database.DCSQLStatement;
                    continue;
                }
                loc1[loc2] = arg1[loc2];
            }
            return loc1;
        }

        public var completeCallback:Function;

        public var data:Object;

        public var errorCallback:Function;

        public var guid:String;

        public var lastInsertRowId:int;

        public var parameters:Object;

        public var preparedStmt:database.DCSQLStatement;

        public var result:Object;

        public var sqlMode:String;

        public var stmt:String;

        public var stmts:Array;

        public var workerTarget:flash.utils.ByteArray;
    }
}


//  package gps
//    class GeoLocationHelper
package backend.utils.gps 
{
    import debug.*;
    import flash.events.*;
    import flash.sensors.*;
    import flash.system.*;
    import starling.events.*;
    
    public class GeoLocationHelper extends starling.events.EventDispatcher
    {
        public function GeoLocationHelper()
        {
            super();
            return;
        }

        public function updateGPSPosition():void
        {
            if (!flash.sensors.Geolocation.isSupported && !flash.system.Capabilities.isDebugger) 
            {
                dispatchEventWith(GPS_DISABLED);
                return;
            }
            if (!this.geo) 
            {
                this.geo = new flash.sensors.Geolocation();
                this.geo.addEventListener(flash.events.StatusEvent.STATUS, this.onGeoStatusChanged);
            }
            this.validateGeoStatus();
            return;
        }

        internal function onGeoStatusChanged(arg1:flash.events.StatusEvent):void
        {
            this.validateGeoStatus();
            return;
        }

        internal function validateGeoStatus():void
        {
            debug.Debug.debug("validateGeoStatus...");
            if (this.geo.muted) 
            {
                dispatchEventWith(GPS_DISABLED);
            }
            else 
            {
                dispatchEventWith(GPS_ENABLED);
                this.geo.addEventListener(flash.events.GeolocationEvent.UPDATE, this.geoUpdateHandler);
            }
            return;
        }

        protected function geoUpdateHandler(arg1:flash.events.GeolocationEvent):void
        {
            this.currentLon = arg1.longitude;
            this.currentLat = arg1.latitude;
            this.geo.removeEventListener(flash.events.GeolocationEvent.UPDATE, this.geoUpdateHandler);
            this.geo.removeEventListener(flash.events.StatusEvent.STATUS, this.onGeoStatusChanged);
            this.geo = null;
            dispatchEventWith(LOCATION_CHANGED);
            return;
        }

        public static function getInstance():backend.utils.gps.GeoLocationHelper
        {
            if (!_instance) 
            {
                _instance = new GeoLocationHelper();
            }
            return _instance;
        }

        public static const GPS_DISABLED:String="gpsDisabledEvent";

        public static const GPS_ENABLED:String="gpsEnabledEvent";

        public static const LOCATION_CHANGED:String="locationChangedEvent";

        public var currentLat:Number=49.45981581;

        public var currentLon:Number=8.16105242;

        public var geo:flash.sensors.Geolocation;

        internal static var _instance:backend.utils.gps.GeoLocationHelper;
    }
}


//  class DataUtils
package backend.utils 
{
    import __AS3__.vec.*;
    import backend.utils.dataprovider.*;
    import configCache.*;
    import core.*;
    import core.general.*;
    import feathers.events.*;
    import frontend.formatter.*;
    import starling.events.*;
    import utils.*;
    import utils.converter.*;
    import utils.format.*;
    import utils.formatter.*;
    import utils.interfaces.*;
    
    public class DataUtils extends starling.events.EventDispatcher
    {
        public function DataUtils()
        {
            super();
            return;
        }

        
        {
            speedTimeConverter = new utils.converter.SpeedTimeConverter();
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static function set unitStringFuelEconomy(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._277633613unitStringFuelEconomy;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._277633613unitStringFuelEconomy = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringFuelEconomy", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function init():void
        {
            backend.utils.dataprovider.DataProviderUtil.initDataProviders();
            updateMeasurementConfig();
            unitStringPercent = utils.LanguageManager.getString("UNIT_PERCENT");
            unitStringTimeHours = utils.LanguageManager.getString("UNIT_HOUR");
            unitStringDistance = utils.LanguageManager.getString("UNIT_KM");
            unitStringSpeed = utils.LanguageManager.getString("UNIT_KMH");
            distanceFormatter = new frontend.formatter.DistanceFormatter();
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                if (core.MeasurementConfig.distanceFormat == utils.format.DistanceFormat.MILE) 
                {
                    unitStringDistance = utils.LanguageManager.getString("UNIT_MI");
                    distanceFormatter.formatString = "K.MM";
                }
            }
            else 
            {
                unitStringDistance = utils.LanguageManager.getString("UNIT_KM");
                distanceFormatter.formatString = "K,MM";
            }
            altitudeLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_ALTITUDE");
            altitudeFormatter = new frontend.formatter.AltitudeFormatter();
            if (core.MeasurementConfig.altitudeFormat != utils.format.AltitudeFormat.METER) 
            {
                if (core.MeasurementConfig.altitudeFormat == utils.format.AltitudeFormat.FEET) 
                {
                    unitStringAltitude = utils.LanguageManager.getString("UNIT_FT");
                    altitudeFormatter.formatString = "M";
                    (altitudeFormatter as frontend.formatter.AltitudeFormatter).outputFeed = true;
                    unitStringRiseRate = utils.LanguageManager.getString("UNIT_FT_MIN");
                }
            }
            else 
            {
                unitStringAltitude = utils.LanguageManager.getString("UNIT_M");
                altitudeFormatter.formatString = "M";
                (altitudeFormatter as frontend.formatter.AltitudeFormatter).outputFeed = false;
                unitStringRiseRate = utils.LanguageManager.getString("UNIT_M_MIN");
            }
            fuelEconomyFormatter = new frontend.formatter.FuelEconomyFormatter();
            fuelEconomyConverter = new utils.converter.FuelEconomyConverter();
            fuelEconomyConverter.inputFormat = utils.format.FuelEconomyFormat.LITER;
            fuelEconomyConverter.outputFormat = core.MeasurementConfig.fuelEconomyFormat;
            if (core.MeasurementConfig.fuelEconomyFormat != utils.format.FuelEconomyFormat.LITER) 
            {
                fuelEconomyFormatter.decimalSeparator = ".";
                unitStringFuelEconomy = utils.LanguageManager.getString("UNIT_GALLON");
            }
            else 
            {
                fuelEconomyFormatter.decimalSeparator = ",";
                unitStringFuelEconomy = utils.LanguageManager.getString("UNIT_LITER");
            }
            fuelEconomyLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_FUEL_ECONOMY");
            altitudeConverter = new utils.converter.AltitudeConverter();
            altitudeConverter.inputFormat = utils.format.AltitudeFormat.MILLIMETER;
            altitudeConverter.outputFormat = core.MeasurementConfig.altitudeFormat;
            caloriesLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_CALORIES");
            caloriesFormatter = new frontend.formatter.CaloriesFormatter();
            unitStringCalories = utils.LanguageManager.getString("UNIT_CALORIE");
            cadenceLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_CADENCE");
            cadenceFormatter = new frontend.formatter.CadenceFormatter();
            unitStringCadence = utils.LanguageManager.getString("UNIT_RPM");
            distanceLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE");
            distanceConverter = new utils.converter.DistanceConverter();
            distanceConverter.inputFormat = utils.format.DistanceFormat.METER;
            distanceConverter.outputFormat = core.MeasurementConfig.distanceFormat;
            distancePlusMinusLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE_UP_DOWN");
            expansionLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_EXPANSION");
            expansionFormatter = new frontend.formatter.ExpansionFormatter();
            if (core.MeasurementConfig.altitudeFormat != utils.format.AltitudeFormat.METER) 
            {
                unitStringExpansion = utils.LanguageManager.getString("UNIT_FTR");
                expansionFormatter.decimalSeparator = ".";
            }
            else 
            {
                unitStringExpansion = utils.LanguageManager.getString("UNIT_MR");
                expansionFormatter.decimalSeparator = ",";
            }
            heartrateLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_HEARTRATE");
            heartrateFormatter = new frontend.formatter.HeartrateFormatter();
            inclineLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_INCLINE");
            unitStringIncline = unitStringPercent;
            inclineFormatter = new frontend.formatter.InclineFormatter();
            powerLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_POWER");
            powerFormatter = new frontend.formatter.PowerFormatter();
            unitStringPower = utils.LanguageManager.getString("UNIT_WATT");
            powerPerKGLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_WATT_PER_KG");
            powerPerKGFormatter = new frontend.formatter.PowerPerKGFormatter();
            if (core.MeasurementConfig.weightFormat != core.general.WeightUnit.KG) 
            {
                unitStringPowerPerKg = utils.LanguageManager.getString("UNIT_WATT_PER_LB");
                powerPerKGFormatter.decimalSeparator = ".";
            }
            else 
            {
                unitStringPowerPerKg = utils.LanguageManager.getString("UNIT_WATT_PER_KG");
                powerPerKGFormatter.decimalSeparator = ",";
            }
            powerPerKGConverter = new utils.converter.PowerPerWeightConverter();
            powerPerKGConverter.inputFormat = core.general.WeightUnit.KG;
            powerPerKGConverter.outputFormat = core.MeasurementConfig.weightFormat;
            unitStringKj = utils.LanguageManager.getString("UNIT_KJ");
            riseRateLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_RISERATE");
            speedLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_SPEED");
            speedFormatter = new frontend.formatter.SpeedFormatter();
            speedConverter = new utils.converter.SpeedConverter();
            speedConverter.inputFormat = utils.format.SpeedFormat.METER_PER_SECOND;
            speedConverter.outputFormat = core.MeasurementConfig.speedFormat;
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                if (core.MeasurementConfig.distanceFormat == utils.format.DistanceFormat.MILE) 
                {
                    unitStringSpeed = utils.LanguageManager.getString("UNIT_MPH");
                    unitStringSpeedTime = utils.LanguageManager.getString("UNIT_MIN_PER_MILE");
                    speedFormatter.decimalSeparator = ".";
                }
            }
            else 
            {
                unitStringSpeed = utils.LanguageManager.getString("UNIT_KMH");
                unitStringSpeedTime = utils.LanguageManager.getString("UNIT_MIN_PER_KM");
                speedFormatter.decimalSeparator = ",";
            }
            temperatureLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TEMPERATURE");
            temperatureFormatter = new frontend.formatter.TemperatureFormatter();
            if (core.MeasurementConfig.temperatureFormat != utils.format.TemperatureFormat.CELSIUS) 
            {
                if (core.MeasurementConfig.temperatureFormat == utils.format.TemperatureFormat.FAHRENHEIT) 
                {
                    unitStringTemperature = utils.LanguageManager.getString("UNIT_FAHRENHEIT");
                    temperatureFormatter.formatString = "B.A";
                    temperatureFormatter.fractionalDigits = 0;
                }
            }
            else 
            {
                unitStringTemperature = utils.LanguageManager.getString("UNIT_CELSIUS");
                temperatureFormatter.formatString = "B,A";
                temperatureFormatter.fractionalDigits = 1;
            }
            timeFormatter = new frontend.formatter.TimeFormatter();
            timeFormatterHHMM = new frontend.formatter.TimeFormatter();
            timeFormatterHHMM.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            timeFormatterHHMM.formatString = "HH:MM";
            timeFormatterHHMMSST = new frontend.formatter.TimeFormatter();
            timeFormatterHHMMSST.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            timeFormatterHHMMSST.formatString = "HH:MM:SS.t";
            unitStringHeartrate = utils.LanguageManager.getString("UNIT_BPM");
            dateFormatter = new utils.formatter.DateFormatterMx();
            if (core.MeasurementConfig.dateFormat != utils.format.DateFormat.EUROPEAN) 
            {
                dateFormatter.formatString = utils.formatter.DateFormatterMx.US_FORMAT;
            }
            else 
            {
                dateFormatter.formatString = utils.formatter.DateFormatterMx.EU_FORMAT;
            }
            dateTimeFormatter = new utils.formatter.DateFormatterMx();
            if (core.MeasurementConfig.clockFormat != utils.format.ClockFormat.CLOCK_12H) 
            {
                dateTimeFormatter.formatString = utils.formatter.DateFormatterMx.CLOCK_24;
                clockFormat = utils.formatter.DateFormatterMx.CLOCK_24;
            }
            else 
            {
                dateTimeFormatter.formatString = utils.formatter.DateFormatterMx.CLOCK_12;
                clockFormat = utils.formatter.DateFormatterMx.CLOCK_12;
            }
            countdownFormatter = new frontend.formatter.TimeFormatter();
            countdownFormatter.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            countdownFormatter.formatString = "H:MM:SS.t";
            autoLapTimeFormatter = new frontend.formatter.TimeFormatter();
            autoLapTimeFormatter.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            autoLapTimeFormatter.formatString = "H:MM:SS";
            timeFormatter_MM_SS = new frontend.formatter.TimeFormatter();
            timeFormatter_MM_SS.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            timeFormatter_MM_SS.formatString = "MM:SS";
            wheelSizeFormatter = new frontend.formatter.WheelSizeFormatter();
            weightConverter = new utils.converter.WeightConverter();
            weightConverter.inputFormat = core.general.WeightUnit.G;
            weightConverter.outputFormat = core.MeasurementConfig.weightFormat;
            weightFormatter = new frontend.formatter.NumberFormatter();
            weightFormatter.decimalSeparator = weightConverter.outputFormat != core.general.WeightUnit.KG ? "." : ",";
            weightFormatter.fractionalDigits = 1;
            if (weightConverter.outputFormat != core.general.WeightUnit.KG) 
            {
                weightFormatter.decimalSeparator = ".";
                unitStringWeight = utils.LanguageManager.getString("UNIT_LB");
            }
            else 
            {
                weightFormatter.decimalSeparator = ",";
                unitStringWeight = utils.LanguageManager.getString("UNIT_KG");
            }
            seaLevelFormatter = new frontend.formatter.SeaLevelFormatter();
            seaLevelFormatter.decimalSeparator = altitudeConverter.outputFormat != utils.format.AltitudeFormat.METER ? "." : ",";
            unitStringSeaLevel = utils.LanguageManager.getString("UNIT_HPA");
            bodySizeConverter = new utils.converter.SizeConverter();
            bodySizeConverter.inputFormat = utils.format.BodySizeFormat.CENTIMETER;
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                bodySizeConverter.outputFormat = utils.format.BodySizeFormat.INCH;
                unitStringBodySize = utils.LanguageManager.getString("UNIT_INCH");
            }
            else 
            {
                bodySizeConverter.outputFormat = utils.format.BodySizeFormat.CENTIMETER;
                unitStringBodySize = utils.LanguageManager.getString("UNIT_CM");
            }
            bodySizeFormatter = new frontend.formatter.NumberFormatter();
            bodySizeFormatter.fractionalDigits = 0;
            validateMonthLabels();
            intensityZonePercentageFormatter = new frontend.formatter.NumberFormatter();
            intensityZonePercentageFormatter.fractionalDigits = 0;
            intensityFactorFormatter = new frontend.formatter.IntensityFactorFormatter();
            intensityFactorFormatter.decimalSeparator = ",";
            tssFormatter = new frontend.formatter.NumberFormatter();
            tssFormatter.decimalSeparator = ",";
            tssFormatter.fractionalDigits = 1;
            percentFormatter = new frontend.formatter.NumberFormatter();
            percentFormatter.fractionalDigits = 0;
            latLonFormatter = new frontend.formatter.NumberFormatter();
            latLonFormatter.decimalSeparator = ".";
            latLonFormatter.fractionalDigits = 6;
            latLonDegreesFormatter = new frontend.formatter.NumberFormatter();
            latLonDegreesFormatter.fractionalDigits = 0;
            latLonMinutesFormatter = new frontend.formatter.NumberFormatter();
            latLonMinutesFormatter.fractionalDigits = 0;
            latLonSecondsFormatter = new frontend.formatter.NumberFormatter();
            latLonSecondsFormatter.decimalSeparator = ".";
            latLonSecondsFormatter.fractionalDigits = 2;
            return;
        }

        internal static function updateMeasurementConfig():void
        {
            core.MeasurementConfig.language = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.LANGUAGE, core.general.LanguageSoftware.DE_DE);
            core.MeasurementConfig.dateFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.DATE_FORMAT, utils.format.DateFormat.EUROPEAN);
            core.MeasurementConfig.clockFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.CLOCK_FORMAT, utils.format.ClockFormat.CLOCK_24H);
            core.MeasurementConfig.distanceFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.DISTANCE_FORMAT, utils.format.DistanceFormat.KILOMETER);
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheAttributeNames.SPEED_FORMAT, core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER ? utils.format.SpeedFormat.MILES_PER_HOUR : utils.format.SpeedFormat.KILOMETER_PER_HOUR);
            core.MeasurementConfig.speedFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.SPEED_FORMAT, utils.format.SpeedFormat.KILOMETER_PER_HOUR);
            core.MeasurementConfig.altitudeFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.ALTITUDE_FORMAT, utils.format.AltitudeFormat.METER);
            core.MeasurementConfig.weightFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.WEIGHT_FORMAT, core.general.WeightUnit.KG);
            core.MeasurementConfig.temperatureFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.TEMPERATURE_FORMAT, utils.format.TemperatureFormat.CELSIUS);
            return;
        }

        internal static function validateMonthLabels():void
        {
            monthLabelsLong = new Vector.<String>();
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_JANUARY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_FEBRUARY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_MARCH_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_APRIL_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_MAY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_JUNE_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_JULY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_AUGUST_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_SEPTEMBER_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_OCTOBER_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_NOVEMBER_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_DECEMBER_LONG"));
            monthLabelsShort = new Vector.<String>();
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_JANUARY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_FEBRUARY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_MARCH"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_APRIL"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_MAY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_JUNE"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_JULY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_AUGUST"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_SEPTEMBER"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_OCTOBER"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_NOVEMBER"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_DECEMBER"));
            return;
        }

        public static function get dateFormatter():utils.interfaces.ICustomFormatter
        {
            return backend.utils.DataUtils._779770692dateFormatter;
        }

        public static function set dateFormatter(arg1:utils.interfaces.ICustomFormatter):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._779770692dateFormatter;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._779770692dateFormatter = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dateFormatter", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get dateTimeFormatter():utils.interfaces.ICustomFormatter
        {
            return backend.utils.DataUtils._483524753dateTimeFormatter;
        }

        public static function set dateTimeFormatter(arg1:utils.interfaces.ICustomFormatter):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._483524753dateTimeFormatter;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._483524753dateTimeFormatter = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dateTimeFormatter", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringAltitude():String
        {
            return backend.utils.DataUtils._1519444873unitStringAltitude;
        }

        public static function set unitStringAltitude(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1519444873unitStringAltitude;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1519444873unitStringAltitude = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringAltitude", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringDistance():String
        {
            return backend.utils.DataUtils._1027431882unitStringDistance;
        }

        public static function set unitStringDistance(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1027431882unitStringDistance;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1027431882unitStringDistance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringDistance", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringFuelEconomy():String
        {
            return backend.utils.DataUtils._277633613unitStringFuelEconomy;
        }

        public static function get unitStringHeartrate():String
        {
            return backend.utils.DataUtils._1634669297unitStringHeartrate;
        }

        public static function set unitStringHeartrate(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1634669297unitStringHeartrate;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1634669297unitStringHeartrate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringHeartrate", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringRiseRate():String
        {
            return backend.utils.DataUtils._357338850unitStringRiseRate;
        }

        public static function set unitStringRiseRate(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._357338850unitStringRiseRate;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._357338850unitStringRiseRate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringRiseRate", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringSpeed():String
        {
            return backend.utils.DataUtils._2005501586unitStringSpeed;
        }

        public static function set unitStringSpeed(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._2005501586unitStringSpeed;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._2005501586unitStringSpeed = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringSpeed", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringSpeedTime():String
        {
            return backend.utils.DataUtils._209210241unitStringSpeedTime;
        }

        public static function set unitStringSpeedTime(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._209210241unitStringSpeedTime;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._209210241unitStringSpeedTime = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringSpeedTime", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringTimeHours():String
        {
            return backend.utils.DataUtils._1448584461unitStringTimeHours;
        }

        public static function set unitStringTimeHours(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1448584461unitStringTimeHours;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1448584461unitStringTimeHours = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringTimeHours", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
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

        public static var inclineFormatter:frontend.formatter.InclineFormatter;

        public static var inclineLabel:String;

        public static var intensityFactorFormatter:frontend.formatter.IntensityFactorFormatter;

        public static var intensityZonePercentageFormatter:frontend.formatter.NumberFormatter;

        public static var latLonDegreesFormatter:frontend.formatter.NumberFormatter;

        public static var latLonFormatter:frontend.formatter.NumberFormatter;

        public static var latLonMinutesFormatter:frontend.formatter.NumberFormatter;

        public static var latLonSecondsFormatter:frontend.formatter.NumberFormatter;

        public static var monthLabelsLong:__AS3__.vec.Vector.<String>;

        public static var monthLabelsShort:__AS3__.vec.Vector.<String>;

        public static var percentFormatter:frontend.formatter.NumberFormatter;

        public static var powerFormatter:frontend.formatter.PowerFormatter;

        public static var powerLabel:String;

        public static var powerPerKGConverter:utils.converter.PowerPerWeightConverter;

        public static var powerPerKGFormatter:frontend.formatter.PowerPerKGFormatter;

        public static var powerPerKGLabel:String;

        public static var riseRateLabel:String;

        public static var seaLevelFormatter:frontend.formatter.SeaLevelFormatter;

        public static var speedConverter:utils.converter.SpeedConverter;

        public static var speedFormatter:frontend.formatter.SpeedFormatter;

        public static var speedLabel:String;

        public static var speedTimeConverter:utils.converter.SpeedTimeConverter;

        public static var temperatureConverter:utils.converter.TemperatureConverter;

        public static var temperatureFormatter:frontend.formatter.TemperatureFormatter;

        public static var temperatureLabel:String;

        public static var timeFormatter:utils.interfaces.ICustomFormatter;

        internal static var _779770692dateFormatter:utils.interfaces.ICustomFormatter;

        public static var timeFormatterHHMMSST:utils.interfaces.ICustomTimeFormatter;

        public static var timeFormatter_MM_SS:frontend.formatter.TimeFormatter;

        public static var tssFormatter:frontend.formatter.NumberFormatter;

        internal static var _1519444873unitStringAltitude:String;

        public static var unitStringBodySize:String;

        public static var unitStringCadence:String;

        public static var unitStringCalories:String;

        internal static var _1027431882unitStringDistance:String;

        public static var unitStringExpansion:String;

        internal static var _277633613unitStringFuelEconomy:String;

        internal static var _1634669297unitStringHeartrate:String;

        public static var unitStringIncline:String;

        public static var unitStringKj:String;

        public static var unitStringPercent:String;

        public static var unitStringPower:String;

        public static var unitStringPowerPerKg:String;

        internal static var _357338850unitStringRiseRate:String;

        public static var unitStringSeaLevel:String;

        internal static var _2005501586unitStringSpeed:String;

        internal static var _209210241unitStringSpeedTime:String;

        public static var unitStringTemperature:String;

        internal static var _1448584461unitStringTimeHours:String;

        public static var unitStringWeight:String;

        public static var weightConverter:utils.converter.WeightConverter;

        public static var weightFormatter:frontend.formatter.NumberFormatter;

        public static var altitudeConverter:utils.converter.IConverter;

        public static var altitudeFormatter:utils.interfaces.ICustomFormatter;

        public static var altitudeLabel:String;

        public static var autoLapTimeFormatter:frontend.formatter.TimeFormatter;

        public static var bodySizeConverter:utils.converter.SizeConverter;

        public static var bodySizeFormatter:frontend.formatter.NumberFormatter;

        public static var cadenceFormatter:frontend.formatter.CadenceFormatter;

        public static var cadenceLabel:String;

        public static var caloriesFormatter:frontend.formatter.CaloriesFormatter;

        public static var caloriesLabel:String;

        public static var clockFormat:String;

        public static var countdownFormatter:frontend.formatter.TimeFormatter;

        internal static var _483524753dateTimeFormatter:utils.interfaces.ICustomFormatter;

        public static var timeFormatterHHMM:utils.interfaces.ICustomTimeFormatter;

        public static var distanceConverter:utils.converter.DistanceConverter;

        public static var distanceFormatter:utils.interfaces.ICustomFormatter;

        public static var distanceLabel:String;

        public static var distancePlusMinusLabel:String;

        public static var expansionFormatter:frontend.formatter.ExpansionFormatter;

        public static var expansionLabel:String;

        public static var fuelEconomyConverter:utils.converter.FuelEconomyConverter;

        public static var fuelEconomyFormatter:frontend.formatter.FuelEconomyFormatter;

        public static var fuelEconomyLabel:String;

        public static var heartrateFormatter:frontend.formatter.HeartrateFormatter;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        public static var heartrateLabel:String;

        public static var wheelSizeFormatter:frontend.formatter.WheelSizeFormatter;
    }
}


